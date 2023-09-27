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
