# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lmother <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/07 15:28:34 by lmother           #+#    #+#              #
#    Updated: 2021/06/06 15:42:00 by lmother          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


SRC_LIB		=	./Libft
LIBFT		=	libft.a
INC			=	./includes/minitalk.h

NAME_S		=	server
NAME_C		=	client

NAME_S_B	=	server_bonus
NAME_C_B	=	client_bonus

SRCS_S		=	server.c
SRCS_C		=	client.c

SRCS_S_B	=	server_bonus.c
SRCS_C_B	=	client_bonus.c

OBJS_S		=	$(SRCS_S:.c=.o)
OBJS_C		=	$(SRCS_C:.c=.o)
OBJS_S_B	=	$(SRCS_S_B:.c=.o)
OBJS_C_B	=	$(SRCS_C_B:.c=.o)

%.0:%.c
			$(CC) $(CFLAGS) -c -o $@ $<

CC			=	gcc

RM			=	rm -rf

CFLAGS		=	-Wall -Wextra -Werror -g -include $(INC)

all:		$(NAME_S) $(NAME_C)

bonus:		$(NAME_C_B) $(NAME_S_B)

$(NAME_S):	$(OBJS_S)
			$(MAKE) -C $(SRC_LIB)
			$(CC) $(CFLAGS) -c $(SRCS_S)
			$(CC) $(CFLAGS) -o $(NAME_S) $(OBJS_S) $(SRC_LIB)/$(LIBFT)

$(NAME_C):	$(OBJS_C)
			$(CC) $(CFLAGS) -c $(SRCS_C)
			$(CC) $(CFLAGS) -o $(NAME_C) $(OBJS_C) $(SRC_LIB)/$(LIBFT)

$(NAME_C_B):$(OBJS_C_B)
			$(MAKE) -C $(SRC_LIB)
			$(CC) $(CFLAGS) -c $(SRCS_C_B)
			$(CC) $(CFLAGS) -o $(NAME_C_B) $(OBJS_C_B) $(SRC_LIB)/$(LIBFT)

$(NAME_S_B):$(OBJS_S_B)
			$(CC) $(CFLAGS) -c $(SRCS_S_B)
			$(CC) $(CFLAGS) -o $(NAME_S_B) $(OBJS_S_B) $(SRC_LIB)/$(LIBFT)		
clean:
			$(MAKE) clean -C $(SRC_LIB)
			$(RM) $(OBJS_S) $(OBJS_C) $(OBJS_C_B) $(OBJS_S_B)

fclean:		clean
			$(MAKE) clean -C $(SRC_LIB)
			$(RM) $(NAME_S) $(NAME_C) $(NAME_C_B) $(NAME_S_B)

re :		fclean all

.PHONY:	all clean fclean re bonus
