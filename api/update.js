import fs from 'fs';
import path from 'path';

export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Método não permitido' });
  }

  const { conteudo } = req.body;

  if (!conteudo) {
    return res.status(400).json({ message: 'Conteúdo obrigatório.' });
  }

  const filePath = path.resolve('./public/arquivos', 'PoisonHub');

  try {
    fs.writeFileSync(filePath, conteudo);
    return res.status(200).json({ message: 'Arquivo PoisonHub atualizado com sucesso!' });
  } catch (error) {
    return res.status(500).json({ message: 'Erro ao atualizar o arquivo.', error: error.message });
  }
}
