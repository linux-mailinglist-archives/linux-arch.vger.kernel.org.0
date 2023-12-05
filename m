Return-Path: <linux-arch+bounces-675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E618044AE
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514091C20B0B
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922A06AB6;
	Tue,  5 Dec 2023 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gs4/7LJk"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145C111;
	Mon,  4 Dec 2023 18:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XUgMZqPZEPLgKgaUi0hMtataaWNLmT1cmJUZyPdt/lg=; b=Gs4/7LJkSbBEMb3/07JBF3SIdE
	McYUrp3xmiZH3aPOmNtnbrr5Y6FaDXmX2+v+BwdvgPLwhFlqaqWARMw77nfndFM/m6ugQoR8W9ID+
	BpW2pQy/o/SlRCeybbDIL513cE9lXC0ouTsKO8nFr6fz+th/vRNyu7jueee6miyF8YskV5Y9ru2nf
	FjfjACF6RQy8XEDBt5/R+DvcGmCCcDOE9Y75QoTcm559c3FvM9mI7TAj8fUNYRZZGQp08bfXtmZ9F
	+i9/psUU+qgeapqqnrxOzsew/iXQMBRJIbg5ZM93zmwGVzApacGcSHa2g+T5N3P7pGcna4rfn1GQC
	kscdem5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6j-00792o-0j;
	Tue, 05 Dec 2023 02:24:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: gus Gusenleitner Klaus <gus@keba.com>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 7/9] rename(): fix the locking of subdirectories
Date: Tue,  5 Dec 2023 02:24:05 +0000
Message-Id: <20231205022418.1703007-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
References: <20231205022100.GB1674809@ZenIV>
 <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

	We should never lock two subdirectories without having taken
->s_vfs_rename_mutex; inode pointer order or not, the "order" proposed
in 28eceeda130f "fs: Lock moved directories" is not transitive, with
the usual consequences.

	The rationale for locking renamed subdirectory in all cases was
the possibility of race between rename modifying .. in a subdirectory to
reflect the new parent and another thread modifying the same subdirectory.
For a lot of filesystems that's not a problem, but for some it can lead
to trouble (e.g. the case when short directory contents is kept in the
inode, but creating a file in it might push it across the size limit
and copy its contents into separate data block(s)).

	However, we need that only in case when the parent does change -
otherwise ->rename() doesn't need to do anything with .. entry in the
first place.  Some instances are lazy and do a tautological update anyway,
but it's really not hard to avoid.

Amended locking rules for rename():
	find the parent(s) of source and target
	if source and target have the same parent
		lock the common parent
	else
		lock ->s_vfs_rename_mutex
		lock both parents, in ancestor-first order; if neither
		is an ancestor of another, lock the parent of source
		first.
	find the source and target.
	if source and target have the same parent
		if operation is an overwriting rename of a subdirectory
			lock the target subdirectory
	else
		if source is a subdirectory
			lock the source
		if target is a subdirectory
			lock the target
	lock non-directories involved, in inode pointer order if both
	source and target are such.

That way we are guaranteed that parents are locked (for obvious reasons),
that any renamed non-directory is locked (nfsd relies upon that),
that any victim is locked (emptiness check needs that, among other things)
and subdirectory that changes parent is locked (needed to protect the update
of .. entries).  We are also guaranteed that any operation locking more
than one directory either takes ->s_vfs_rename_mutex or locks a parent
followed by its child.

Cc: stable@vger.kernel.org
Fixes: 28eceeda130f "fs: Lock moved directories"
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 .../filesystems/directory-locking.rst         | 29 ++++-----
 Documentation/filesystems/locking.rst         |  5 +-
 Documentation/filesystems/porting.rst         | 18 ++++++
 fs/namei.c                                    | 60 ++++++++++++-------
 4 files changed, 74 insertions(+), 38 deletions(-)

diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
index dccd61c7c5c3..193c22687851 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -22,13 +22,16 @@ exclusive.
 3) object removal.  Locking rules: caller locks parent, finds victim,
 locks victim and calls the method.  Locks are exclusive.
 
-4) rename() that is _not_ cross-directory.  Locking rules: caller locks the
-parent and finds source and target.  We lock both (provided they exist).  If we
-need to lock two inodes of different type (dir vs non-dir), we lock directory
-first.  If we need to lock two inodes of the same type, lock them in inode
-pointer order.  Then call the method.  All locks are exclusive.
-NB: we might get away with locking the source (and target in exchange
-case) shared.
+4) rename() that is _not_ cross-directory.  Locking rules: caller locks
+the parent and finds source and target.  Then we decide which of the
+source and target need to be locked.  Source needs to be locked if it's a
+non-directory; target - if it's a non-directory or about to be removed.
+Take the locks that need to be taken, in inode pointer order if need
+to take both (that can happen only when both source and target are
+non-directories - the source because it wouldn't be locked otherwise
+and the target because mixing directory and non-directory is allowed
+only with RENAME_EXCHANGE, and that won't be removing the target).
+After the locks had been taken, call the method.  All locks are exclusive.
 
 5) link creation.  Locking rules:
 
@@ -44,20 +47,17 @@ rules:
 
 	* lock the filesystem
 	* lock parents in "ancestors first" order. If one is not ancestor of
-	  the other, lock them in inode pointer order.
+	  the other, lock the parent of source first.
 	* find source and target.
 	* if old parent is equal to or is a descendent of target
 	  fail with -ENOTEMPTY
 	* if new parent is equal to or is a descendent of source
 	  fail with -ELOOP
-	* Lock both the source and the target provided they exist. If we
-	  need to lock two inodes of different type (dir vs non-dir), we lock
-	  the directory first. If we need to lock two inodes of the same type,
-	  lock them in inode pointer order.
+	* Lock subdirectories involved (source before target).
+	* Lock non-directories involved, in inode pointer order.
 	* call the method.
 
-All ->i_rwsem are taken exclusive.  Again, we might get away with locking
-the source (and target in exchange case) shared.
+All ->i_rwsem are taken exclusive.
 
 The rules above obviously guarantee that all directories that are going to be
 read, modified or removed by method will be locked by caller.
@@ -67,6 +67,7 @@ If no directory is its own ancestor, the scheme above is deadlock-free.
 
 Proof:
 
+[XXX: will be updated once we are done massaging the lock_rename()]
 	First of all, at any moment we have a linear ordering of the
 	objects - A < B iff (A is an ancestor of B) or (B is not an ancestor
         of A and ptr(A) < ptr(B)).
diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 7be2900806c8..bd12f2f850ad 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -101,7 +101,7 @@ symlink:	exclusive
 mkdir:		exclusive
 unlink:		exclusive (both)
 rmdir:		exclusive (both)(see below)
-rename:		exclusive (all)	(see below)
+rename:		exclusive (both parents, some children)	(see below)
 readlink:	no
 get_link:	no
 setattr:	exclusive
@@ -123,6 +123,9 @@ get_offset_ctx  no
 	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_rwsem
 	exclusive on victim.
 	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
+	->unlink() and ->rename() have ->i_rwsem exclusive on all non-directories
+	involved.
+	->rename() has ->i_rwsem exclusive on any subdirectory that changes parent.
 
 See Documentation/filesystems/directory-locking.rst for more detailed discussion
 of the locking scheme for directory operations.
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 878e72b2f8b7..9100969e7de6 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1061,3 +1061,21 @@ export_operations ->encode_fh() no longer has a default implementation to
 encode FILEID_INO32_GEN* file handles.
 Filesystems that used the default implementation may use the generic helper
 generic_encode_ino32_fh() explicitly.
+
+---
+
+**mandatory**
+
+If ->rename() update of .. on cross-directory move needs an exclusion with
+directory modifications, do *not* lock the subdirectory in question in your
+->rename() - it's done by the caller now [that item should've been added in
+28eceeda130f "fs: Lock moved directories"].
+
+---
+
+**mandatory**
+
+On same-directory ->rename() the (tautological) update of .. is not protected
+by any locks; just don't do it if the old parent is the same as the new one.
+We really can't lock two subdirectories in same-directory rename - not without
+deadlocks.
diff --git a/fs/namei.c b/fs/namei.c
index 71c13b2990b4..29bafbdb44ca 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3021,20 +3021,14 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 	p = d_ancestor(p2, p1);
 	if (p) {
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
-		inode_lock_nested(p1->d_inode, I_MUTEX_CHILD);
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT2);
 		return p;
 	}
 
 	p = d_ancestor(p1, p2);
-	if (p) {
-		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-		inode_lock_nested(p2->d_inode, I_MUTEX_CHILD);
-		return p;
-	}
-
-	lock_two_inodes(p1->d_inode, p2->d_inode,
-			I_MUTEX_PARENT, I_MUTEX_PARENT2);
-	return NULL;
+	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+	return p;
 }
 
 /*
@@ -4716,11 +4710,12 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *
  *	a) we can get into loop creation.
  *	b) race potential - two innocent renames can create a loop together.
- *	   That's where 4.4 screws up. Current fix: serialization on
+ *	   That's where 4.4BSD screws up. Current fix: serialization on
  *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
  *	   story.
- *	c) we have to lock _four_ objects - parents and victim (if it exists),
- *	   and source.
+ *	c) we may have to lock up to _four_ objects - parents and victim (if it exists),
+ *	   and source (if it's a non-directory or a subdirectory that moves to
+ *	   different parent).
  *	   And that - after we got ->i_mutex on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
@@ -4752,6 +4747,7 @@ int vfs_rename(struct renamedata *rd)
 	bool new_is_dir = false;
 	unsigned max_links = new_dir->i_sb->s_max_links;
 	struct name_snapshot old_name;
+	bool lock_old_subdir, lock_new_subdir;
 
 	if (source == target)
 		return 0;
@@ -4805,15 +4801,32 @@ int vfs_rename(struct renamedata *rd)
 	take_dentry_name_snapshot(&old_name, old_dentry);
 	dget(new_dentry);
 	/*
-	 * Lock all moved children. Moved directories may need to change parent
-	 * pointer so they need the lock to prevent against concurrent
-	 * directory changes moving parent pointer. For regular files we've
-	 * historically always done this. The lockdep locking subclasses are
-	 * somewhat arbitrary but RENAME_EXCHANGE in particular can swap
-	 * regular files and directories so it's difficult to tell which
-	 * subclasses to use.
+	 * Lock children.
+	 * The source subdirectory needs to be locked on cross-directory
+	 * rename or cross-directory exchange since its parent changes.
+	 * The target subdirectory needs to be locked on cross-directory
+	 * exchange due to parent change and on any rename due to becoming
+	 * a victim.
+	 * Non-directories need locking in all cases (for NFS reasons);
+	 * they get locked after any subdirectories (in inode address order).
+	 *
+	 * NOTE: WE ONLY LOCK UNRELATED DIRECTORIES IN CROSS-DIRECTORY CASE.
+	 * NEVER, EVER DO THAT WITHOUT ->s_vfs_rename_mutex.
 	 */
-	lock_two_inodes(source, target, I_MUTEX_NORMAL, I_MUTEX_NONDIR2);
+	lock_old_subdir = new_dir != old_dir;
+	lock_new_subdir = new_dir != old_dir || !(flags & RENAME_EXCHANGE);
+	if (is_dir) {
+		if (lock_old_subdir)
+			inode_lock_nested(source, I_MUTEX_CHILD);
+		if (target && (!new_is_dir || lock_new_subdir))
+			inode_lock(target);
+	} else if (new_is_dir) {
+		if (lock_new_subdir)
+			inode_lock_nested(target, I_MUTEX_CHILD);
+		inode_lock(source);
+	} else {
+		lock_two_nondirectories(source, target);
+	}
 
 	error = -EPERM;
 	if (IS_SWAPFILE(source) || (target && IS_SWAPFILE(target)))
@@ -4861,8 +4874,9 @@ int vfs_rename(struct renamedata *rd)
 			d_exchange(old_dentry, new_dentry);
 	}
 out:
-	inode_unlock(source);
-	if (target)
+	if (!is_dir || lock_old_subdir)
+		inode_unlock(source);
+	if (target && (!new_is_dir || lock_new_subdir))
 		inode_unlock(target);
 	dput(new_dentry);
 	if (!error) {
-- 
2.39.2


