class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CloudNotCreateNoteException extends CloudStorageException{}

class CouldNotGetAllNotesException extends CloudStorageException {}

class CouldNotUpdateNotesException extends CloudStorageException {}

class CouldNotDeleteNotesException extends CloudStorageException {}