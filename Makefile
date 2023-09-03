NAME = lines
CC = cc
# CFLAGS = -Wall -Wextra -Werror
HEADER = ./src/stuff.h
CFLAGS ?=
MLXLIB = libmlx42.a
MLXFLAGS = -lglfw3 -framework Cocoa -framework OpenGL -framework IOKit

SRC = $(shell find ./src -iname "*.c")
OBJ = $(SRC:./src/%.c=./obj/%.o)
OBJDIR = obj

all: $(NAME)

$(OBJDIR):
	mkdir $(OBJDIR)

$(MLXLIB):
	cd ./MLX42 && cmake -B build && make -C build -j4
	cd ./MLX42/build && cp libmlx42.a ../../

$(OBJDIR)/%.o: src/%.c
	$(CC) $(CFLAGS) -c $(CFLAGS) -o $@ $^

$(NAME): $(MLXLIB) $(OBJDIR) $(OBJ)
	$(CC) $(CFLAGS) $(MLXFLAGS) $(MLXLIB) $(OBJ) -o $(NAME)

clean:
	rm -rf $(OBJDIR)

fclean: clean
	cd ./MLX42 && rm -rf build
	rm -rf $(MLXLIB)
	rm -rf $(NAME)

re: fclean all

.PHONY: all clean fclean re
