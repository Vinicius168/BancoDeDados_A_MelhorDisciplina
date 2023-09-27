--exercicio 1
DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;
END;
//


--exercicio 2
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo, Autor.Nome, Autor.Sobrenome
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    INNER JOIN Autor_Livro ON Livro.Livro_ID = Autor_Livro.Livro_ID
    INNER JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID
    WHERE Categoria.Nome = categoriaNome;
END;
//

--exercicio 3
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoriaNome VARCHAR(100), OUT totalLivros INT)
BEGIN
    SELECT COUNT(*) INTO totalLivros
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END;
//

-- Exercicio 4
delimiter //
create procedure sp_VerificarLivrosCategoria(in categoria_nome varchar(255), out possui_livros bit)
begin
    declare total_livros int;
    
    select count(*) into total_livros
    from Livro
    inner join Categoria on Livro.Categoria_ID = Categoria.Categoria_ID
    where Categoria.Nome = categoria_nome;
    
    if total_livros > 0 then
        set possui_livros = 1;
    else
        set possui_livros = 0;
    end if;
end;
//
delimiter ;

call sp_VerificarLivrosCategoria('História', @possui_livros);
select @possui_livros;
drop procedure sp_VerificarLivrosCategoria;

--exercicio 5
CREATE PROCEDURE sp_LivrosAteAno(IN anoPublicacao INT)
BEGIN
    SELECT Livro.Titulo, Livro.Ano_Publicacao, Autor.Nome, Autor.Sobrenome
    FROM Livro
    INNER JOIN Autor_Livro ON Livro.Livro_ID = Autor_Livro.Livro_ID
    INNER JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID
    WHERE Livro.Ano_Publicacao <= anoPublicacao;
END;

//

--exercicio 6
CREATE PROCEDURE sp_TitulosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END;

//

-- Exercicio7
delimiter //
create procedure sp_AdicionarLivro(	
	in p_Titulo varchar(255),
    in p_Editora_ID INT,
    in p_Ano_Publicacao int,
    in p_Numero_Paginas int,
    in p_Categoria_ID int
)

begin
    declare v_Contagem int;

    select count(*) into v_Contagem from Livro where Titulo = p_Titulo;

    if v_Contagem > 0 then
        signal sqlstate '45000'
        set message_text = 'Livro com este título já existe na tabela.';
    else
        insert into Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
        values (p_Titulo, p_Editora_ID, p_Ano_Publicacao, p_Numero_Paginas, p_Categoria_ID);
    end if;
end;
//
delimiter ;

call sp_AdicionarLivro('Os males do vilão', 2, 2023, 320, 4);
