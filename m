Return-Path: <linux-arch+bounces-684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A38044BB
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28584280DC1
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5855664;
	Tue,  5 Dec 2023 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="huGMiJ+U"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E1182;
	Mon,  4 Dec 2023 18:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f5aDp+zcGPtujBUoSm7966OQLopOua0j6cltQRU/GSs=; b=huGMiJ+UbiSgiUu5iRmt0TmOMX
	Q/LLkxxzDGHjLMEZ7sWTPcGqlybzbEsXUpvTj6Ok0fOHaaMHcBigPr1MXICsiNOuu/nclmrVIV7Rz
	KhFYLnuoj/bLX/ERVAnCNw9wYKxjWuldQLWmSmxV3/IJsCdNHryK+R3w36TX+wq8xcIymw7n3YLVR
	A004FZd/Yz7s9PaCKjz4trv5MKuaNG5xwrB+uPHnJFcLXUcYs2g9uoEzSv1vECndgpf3jCvRWzwsJ
	+qquY0AfJ4N/MTpVjW/IxAb/f65wD2LUQjyfOgHcw/XlYHg0f66gjwIxiN3TTLLgE1rtlAoQX9Won
	eD0Jj1cg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6k-00793A-08;
	Tue, 05 Dec 2023 02:24:22 +0000
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
Subject: [PATCH v2 9/9] rename(): avoid a deadlock in the case of parents having no common ancestor
Date: Tue,  5 Dec 2023 02:24:09 +0000
Message-Id: <20231205022418.1703007-18-viro@zeniv.linux.org.uk>
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

... and fix the directory locking documentation and proof of correctness.
Holding ->s_vfs_rename_mutex *almost* prevents ->d_parent changes; the
case where we really don't want it is splicing the root of disconnected
tree to somewhere.

In other words, ->s_vfs_rename_mutex is sufficient to stabilize "X is an
ancestor of Y" only if X and Y are already in the same tree.  Otherwise
it can go from false to true, and one can construct a deadlock on that.

Make lock_two_directories() report an error in such case and update the
callers of lock_rename()/lock_rename_child() to handle such errors.

And yes, such conditions are not impossible to create ;-/

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 .../filesystems/directory-locking.rst         | 346 ++++++++++++------
 Documentation/filesystems/porting.rst         |   9 +
 fs/cachefiles/namei.c                         |   2 +
 fs/ecryptfs/inode.c                           |   2 +
 fs/namei.c                                    |  37 +-
 fs/nfsd/vfs.c                                 |   4 +
 fs/overlayfs/copy_up.c                        |   9 +-
 fs/overlayfs/dir.c                            |   4 +
 fs/overlayfs/super.c                          |   6 +-
 fs/overlayfs/util.c                           |   7 +-
 fs/smb/server/vfs.c                           |   5 +
 11 files changed, 313 insertions(+), 118 deletions(-)

diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
index 193c22687851..05ea387bc9fb 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -11,130 +11,268 @@ When taking the i_rwsem on multiple non-directory objects, we
 always acquire the locks in order by increasing address.  We'll call
 that "inode pointer" order in the following.
 
-For our purposes all operations fall in 5 classes:
 
-1) read access.  Locking rules: caller locks directory we are accessing.
-The lock is taken shared.
+Primitives
+==========
 
-2) object creation.  Locking rules: same as above, but the lock is taken
-exclusive.
+For our purposes all operations fall in 6 classes:
 
-3) object removal.  Locking rules: caller locks parent, finds victim,
-locks victim and calls the method.  Locks are exclusive.
+1. read access.  Locking rules:
 
-4) rename() that is _not_ cross-directory.  Locking rules: caller locks
-the parent and finds source and target.  Then we decide which of the
-source and target need to be locked.  Source needs to be locked if it's a
-non-directory; target - if it's a non-directory or about to be removed.
-Take the locks that need to be taken, in inode pointer order if need
-to take both (that can happen only when both source and target are
-non-directories - the source because it wouldn't be locked otherwise
-and the target because mixing directory and non-directory is allowed
-only with RENAME_EXCHANGE, and that won't be removing the target).
-After the locks had been taken, call the method.  All locks are exclusive.
+	* lock the directory we are accessing (shared)
 
-5) link creation.  Locking rules:
+2. object creation.  Locking rules:
 
-	* lock parent
-	* check that source is not a directory
-	* lock source
-	* call the method.
+	* lock the directory we are accessing (exclusive)
 
-All locks are exclusive.
+3. object removal.  Locking rules:
 
-6) cross-directory rename.  The trickiest in the whole bunch.  Locking
-rules:
+	* lock the parent (exclusive)
+	* find the victim
+	* lock the victim (exclusive)
 
-	* lock the filesystem
-	* lock parents in "ancestors first" order. If one is not ancestor of
-	  the other, lock the parent of source first.
-	* find source and target.
-	* if old parent is equal to or is a descendent of target
-	  fail with -ENOTEMPTY
-	* if new parent is equal to or is a descendent of source
-	  fail with -ELOOP
-	* Lock subdirectories involved (source before target).
-	* Lock non-directories involved, in inode pointer order.
-	* call the method.
+4. link creation.  Locking rules:
+
+	* lock the parent (exclusive)
+	* check that the source is not a directory
+	* lock the source (exclusive; probably could be weakened to shared)
 
-All ->i_rwsem are taken exclusive.
+5. rename that is _not_ cross-directory.  Locking rules:
 
-The rules above obviously guarantee that all directories that are going to be
-read, modified or removed by method will be locked by caller.
+	* lock the parent (exclusive)
+	* find the source and target
+	* decide which of the source and target need to be locked.
+	  The source needs to be locked if it's a non-directory, target - if it's
+	  a non-directory or about to be removed.
+	* take the locks that need to be taken (exlusive), in inode pointer order
+	  if need to take both (that can happen only when both source and target
+	  are non-directories - the source because it wouldn't need to be locked
+	  otherwise and the target because mixing directory and non-directory is
+	  allowed only with RENAME_EXCHANGE, and that won't be removing the target).
 
+6. cross-directory rename.  The trickiest in the whole bunch.  Locking rules:
+
+	* lock the filesystem
+	* if the parents don't have a common ancestor, fail the operation.
+	* lock the parents in "ancestors first" order (exclusive). If neither is an
+	  ancestor of the other, lock the parent of source first.
+	* find the source and target.
+	* verify that the source is not a descendent of the target and
+	  target is not a descendent of source; fail the operation otherwise.
+	* lock the subdirectories involved (exclusive), source before target.
+	* lock the non-directories involved (exclusive), in inode pointer order.
+
+The rules above obviously guarantee that all directories that are going
+to be read, modified or removed by method will be locked by the caller.
+
+
+Splicing
+========
+
+There is one more thing to consider - splicing.  It's not an operation
+in its own right; it may happen as part of lookup.  We speak of the
+operations on directory trees, but we obviously do not have the full
+picture of those - especially for network filesystems.  What we have
+is a bunch of subtrees visible in dcache and locking happens on those.
+Trees grow as we do operations; memory pressure prunes them.  Normally
+that's not a problem, but there is a nasty twist - what should we do
+when one growing tree reaches the root of another?  That can happen in
+several scenarios, starting from "somebody mounted two nested subtrees
+from the same NFS4 server and doing lookups in one of them has reached
+the root of another"; there's also open-by-fhandle stuff, and there's a
+possibility that directory we see in one place gets moved by the server
+to another and we run into it when we do a lookup.
+
+For a lot of reasons we want to have the same directory present in dcache
+only once.  Multiple aliases are not allowed.  So when lookup runs into
+a subdirectory that already has an alias, something needs to be done with
+dcache trees.  Lookup is already holding the parent locked.  If alias is
+a root of separate tree, it gets attached to the directory we are doing a
+lookup in, under the name we'd been looking for.  If the alias is already
+a child of the directory we are looking in, it changes name to the one
+we'd been looking for.  No extra locking is involved in these two cases.
+However, if it's a child of some other directory, the things get trickier.
+First of all, we verify that it is *not* an ancestor of our directory
+and fail the lookup if it is.  Then we try to lock the filesystem and the
+current parent of the alias.  If either trylock fails, we fail the lookup.
+If trylocks succeed, we detach the alias from its current parent and
+attach to our directory, under the name we are looking for.
+
+Note that splicing does *not* involve any modification of the filesystem;
+all we change is the view in dcache.  Moreover, holding a directory locked
+exclusive prevents such changes involving its children and holding the
+filesystem lock prevents any changes of tree topology, other than having a
+root of one tree becoming a child of directory in another.  In particular,
+if two dentries have been found to have a common ancestor after taking
+the filesystem lock, their relationship will remain unchanged until
+the lock is dropped.  So from the directory operations' point of view
+splicing is almost irrelevant - the only place where it matters is one
+step in cross-directory renames; we need to be careful when checking if
+parents have a common ancestor.
+
+
+Multiple-filesystem stuff
+=========================
+
+For some filesystems a method can involve a directory operation on
+another filesystem; it may be ecryptfs doing operation in the underlying
+filesystem, overlayfs doing something to the layers, network filesystem
+using a local one as a cache, etc.  In all such cases the operations
+on other filesystems must follow the same locking rules.  Moreover, "a
+directory operation on this filesystem might involve directory operations
+on that filesystem" should be an asymmetric relation (or, if you will,
+it should be possible to rank the filesystems so that directory operation
+on a filesystem could trigger directory operations only on higher-ranked
+ones - in these terms overlayfs ranks lower than its layers, network
+filesystem ranks lower than whatever it caches on, etc.)
+
+
+Deadlock avoidance
+==================
 
 If no directory is its own ancestor, the scheme above is deadlock-free.
 
 Proof:
 
-[XXX: will be updated once we are done massaging the lock_rename()]
-	First of all, at any moment we have a linear ordering of the
-	objects - A < B iff (A is an ancestor of B) or (B is not an ancestor
-        of A and ptr(A) < ptr(B)).
-
-	That ordering can change.  However, the following is true:
-
-(1) if object removal or non-cross-directory rename holds lock on A and
-    attempts to acquire lock on B, A will remain the parent of B until we
-    acquire the lock on B.  (Proof: only cross-directory rename can change
-    the parent of object and it would have to lock the parent).
-
-(2) if cross-directory rename holds the lock on filesystem, order will not
-    change until rename acquires all locks.  (Proof: other cross-directory
-    renames will be blocked on filesystem lock and we don't start changing
-    the order until we had acquired all locks).
-
-(3) locks on non-directory objects are acquired only after locks on
-    directory objects, and are acquired in inode pointer order.
-    (Proof: all operations but renames take lock on at most one
-    non-directory object, except renames, which take locks on source and
-    target in inode pointer order in the case they are not directories.)
-
-Now consider the minimal deadlock.  Each process is blocked on
-attempt to acquire some lock and already holds at least one lock.  Let's
-consider the set of contended locks.  First of all, filesystem lock is
-not contended, since any process blocked on it is not holding any locks.
-Thus all processes are blocked on ->i_rwsem.
-
-By (3), any process holding a non-directory lock can only be
-waiting on another non-directory lock with a larger address.  Therefore
-the process holding the "largest" such lock can always make progress, and
-non-directory objects are not included in the set of contended locks.
-
-Thus link creation can't be a part of deadlock - it can't be
-blocked on source and it means that it doesn't hold any locks.
-
-Any contended object is either held by cross-directory rename or
-has a child that is also contended.  Indeed, suppose that it is held by
-operation other than cross-directory rename.  Then the lock this operation
-is blocked on belongs to child of that object due to (1).
-
-It means that one of the operations is cross-directory rename.
-Otherwise the set of contended objects would be infinite - each of them
-would have a contended child and we had assumed that no object is its
-own descendent.  Moreover, there is exactly one cross-directory rename
-(see above).
-
-Consider the object blocking the cross-directory rename.  One
-of its descendents is locked by cross-directory rename (otherwise we
-would again have an infinite set of contended objects).  But that
-means that cross-directory rename is taking locks out of order.  Due
-to (2) the order hadn't changed since we had acquired filesystem lock.
-But locking rules for cross-directory rename guarantee that we do not
-try to acquire lock on descendent before the lock on ancestor.
-Contradiction.  I.e.  deadlock is impossible.  Q.E.D.
-
+There is a ranking on the locks, such that all primitives take
+them in order of non-decreasing rank.  Namely,
+
+  * rank ->i_rwsem of non-directories on given filesystem in inode pointer
+    order.
+  * put ->i_rwsem of all directories on a filesystem at the same rank,
+    lower than ->i_rwsem of any non-directory on the same filesystem.
+  * put ->s_vfs_rename_mutex at rank lower than that of any ->i_rwsem
+    on the same filesystem.
+  * among the locks on different filesystems use the relative
+    rank of those filesystems.
+
+For example, if we have NFS filesystem caching on a local one, we have
+
+  1. ->s_vfs_rename_mutex of NFS filesystem
+  2. ->i_rwsem of directories on that NFS filesystem, same rank for all
+  3. ->i_rwsem of non-directories on that filesystem, in order of
+     increasing address of inode
+  4. ->s_vfs_rename_mutex of local filesystem
+  5. ->i_rwsem of directories on the local filesystem, same rank for all
+  6. ->i_rwsem of non-directories on local filesystem, in order of
+     increasing address of inode.
+
+It's easy to verify that operations never take a lock with rank
+lower than that of an already held lock.
+
+Suppose deadlocks are possible.  Consider the minimal deadlocked
+set of threads.  It is a cycle of several threads, each blocked on a lock
+held by the next thread in the cycle.
+
+Since the locking order is consistent with the ranking, all
+contended locks in the minimal deadlock will be of the same rank,
+i.e. they all will be ->i_rwsem of directories on the same filesystem.
+Moreover, without loss of generality we can assume that all operations
+are done directly to that filesystem and none of them has actually
+reached the method call.
+
+In other words, we have a cycle of threads, T1,..., Tn,
+and the same number of directories (D1,...,Dn) such that
+
+	T1 is blocked on D1 which is held by T2
+
+	T2 is blocked on D2 which is held by T3
+
+	...
+
+	Tn is blocked on Dn which is held by T1.
+
+Each operation in the minimal cycle must have locked at least
+one directory and blocked on attempt to lock another.  That leaves
+only 3 possible operations: directory removal (locks parent, then
+child), same-directory rename killing a subdirectory (ditto) and
+cross-directory rename of some sort.
+
+There must be a cross-directory rename in the set; indeed,
+if all operations had been of the "lock parent, then child" sort
+we would have Dn a parent of D1, which is a parent of D2, which is
+a parent of D3, ..., which is a parent of Dn.  Relationships couldn't
+have changed since the moment directory locks had been acquired,
+so they would all hold simultaneously at the deadlock time and
+we would have a loop.
+
+Since all operations are on the same filesystem, there can't be
+more than one cross-directory rename among them.  Without loss of
+generality we can assume that T1 is the one doing a cross-directory
+rename and everything else is of the "lock parent, then child" sort.
+
+In other words, we have a cross-directory rename that locked
+Dn and blocked on attempt to lock D1, which is a parent of D2, which is
+a parent of D3, ..., which is a parent of Dn.  Relationships between
+D1,...,Dn all hold simultaneously at the deadlock time.  Moreover,
+cross-directory rename does not get to locking any directories until it
+has acquired filesystem lock and verified that directories involved have
+a common ancestor, which guarantees that ancestry relationships between
+all of them had been stable.
+
+Consider the order in which directories are locked by the
+cross-directory rename; parents first, then possibly their children.
+Dn and D1 would have to be among those, with Dn locked before D1.
+Which pair could it be?
+
+It can't be the parents - indeed, since D1 is an ancestor of Dn,
+it would be the first parent to be locked.  Therefore at least one of the
+children must be involved and thus neither of them could be a descendent
+of another - otherwise the operation would not have progressed past
+locking the parents.
+
+It can't be a parent and its child; otherwise we would've had
+a loop, since the parents are locked before the children, so the parent
+would have to be a descendent of its child.
+
+It can't be a parent and a child of another parent either.
+Otherwise the child of the parent in question would've been a descendent
+of another child.
+
+That leaves only one possibility - namely, both Dn and D1 are
+among the children, in some order.  But that is also impossible, since
+neither of the children is a descendent of another.
+
+That concludes the proof, since the set of operations with the
+properties requiered for a minimal deadlock can not exist.
+
+Note that the check for having a common ancestor in cross-directory
+rename is crucial - without it a deadlock would be possible.  Indeed,
+suppose the parents are initially in different trees; we would lock the
+parent of source, then try to lock the parent of target, only to have
+an unrelated lookup splice a distant ancestor of source to some distant
+descendent of the parent of target.   At that point we have cross-directory
+rename holding the lock on parent of source and trying to lock its
+distant ancestor.  Add a bunch of rmdir() attempts on all directories
+in between (all of those would fail with -ENOTEMPTY, had they ever gotten
+the locks) and voila - we have a deadlock.
+
+Loop avoidance
+==============
 
 These operations are guaranteed to avoid loop creation.  Indeed,
 the only operation that could introduce loops is cross-directory rename.
-Since the only new (parent, child) pair added by rename() is (new parent,
-source), such loop would have to contain these objects and the rest of it
-would have to exist before rename().  I.e. at the moment of loop creation
-rename() responsible for that would be holding filesystem lock and new parent
-would have to be equal to or a descendent of source.  But that means that
-new parent had been equal to or a descendent of source since the moment when
-we had acquired filesystem lock and rename() would fail with -ELOOP in that
-case.
+Suppose after the operation there is a loop; since there hadn't been such
+loops before the operation, at least on of the nodes in that loop must've
+had its parent changed.  In other words, the loop must be passing through
+the source or, in case of exchange, possibly the target.
+
+Since the operation has succeeded, neither source nor target could have
+been ancestors of each other.  Therefore the chain of ancestors starting
+in the parent of source could not have passed through the target and
+vice versa.  On the other hand, the chain of ancestors of any node could
+not have passed through the node itself, or we would've had a loop before
+the operation.  But everything other than source and target has kept
+the parent after the operation, so the operation does not change the
+chains of ancestors of (ex-)parents of source and target.  In particular,
+those chains must end after a finite number of steps.
+
+Now consider the loop created by the operation.  It passes through either
+source or target; the next node in the loop would be the ex-parent of
+target or source resp.  After that the loop would follow the chain of
+ancestors of that parent.  But as we have just shown, that chain must
+end after a finite number of steps, which means that it can't be a part
+of any loop.  Q.E.D.
 
 While this locking scheme works for arbitrary DAGs, it relies on
 ability to check that directory is a descendent of another object.  Current
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 9100969e7de6..33cd56e2ca1a 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1079,3 +1079,12 @@ On same-directory ->rename() the (tautological) update of .. is not protected
 by any locks; just don't do it if the old parent is the same as the new one.
 We really can't lock two subdirectories in same-directory rename - not without
 deadlocks.
+
+---
+
+**mandatory**
+
+lock_rename() and lock_rename_child() may fail in cross-directory case, if
+their arguments do not have a common ancestor.  In that case ERR_PTR(-EXDEV)
+is returned, with no locks taken.  In-tree users updated; out-of-tree ones
+would need to do so.
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 7bf7a5fcc045..7ade836beb58 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -305,6 +305,8 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 	/* do the multiway lock magic */
 	trap = lock_rename(cache->graveyard, dir);
+	if (IS_ERR(trap))
+		return PTR_ERR(trap);
 
 	/* do some checks before getting the grave dentry */
 	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index a25dd3d20008..8efd20dc902b 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -599,6 +599,8 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	target_inode = d_inode(new_dentry);
 
 	trap = lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	if (IS_ERR(trap))
+		return PTR_ERR(trap);
 	dget(lower_new_dentry);
 	rc = -EINVAL;
 	if (lower_old_dentry->d_parent != lower_old_dir_dentry)
diff --git a/fs/namei.c b/fs/namei.c
index 29bafbdb44ca..6b0302ac80d1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3014,21 +3014,37 @@ static inline int may_create(struct mnt_idmap *idmap,
 	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 }
 
+// p1 != p2, both are on the same filesystem, ->s_vfs_rename_mutex is held
 static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 {
-	struct dentry *p;
+	struct dentry *p = p1, *q = p2, *r;
 
-	p = d_ancestor(p2, p1);
-	if (p) {
+	while ((r = p->d_parent) != p2 && r != p)
+		p = r;
+	if (r == p2) {
+		// p is a child of p2 and an ancestor of p1 or p1 itself
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
 		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT2);
 		return p;
 	}
-
-	p = d_ancestor(p1, p2);
-	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
-	return p;
+	// p is the root of connected component that contains p1
+	// p2 does not occur on the path from p to p1
+	while ((r = q->d_parent) != p1 && r != p && r != q)
+		q = r;
+	if (r == p1) {
+		// q is a child of p1 and an ancestor of p2 or p2 itself
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+		return q;
+	} else if (likely(r == p)) {
+		// both p2 and p1 are descendents of p
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+		return NULL;
+	} else { // no common ancestor at the time we'd been called
+		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
+		return ERR_PTR(-EXDEV);
+	}
 }
 
 /*
@@ -4947,6 +4963,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 
 retry_deleg:
 	trap = lock_rename(new_path.dentry, old_path.dentry);
+	if (IS_ERR(trap)) {
+		error = PTR_ERR(trap);
+		goto exit_lock_rename;
+	}
 
 	old_dentry = lookup_one_qstr_excl(&old_last, old_path.dentry,
 					  lookup_flags);
@@ -5014,6 +5034,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	dput(old_dentry);
 exit3:
 	unlock_rename(new_path.dentry, old_path.dentry);
+exit_lock_rename:
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fbbea7498f02..a99260c3f9bc 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1813,6 +1813,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	}
 
 	trap = lock_rename(tdentry, fdentry);
+	if (IS_ERR(trap)) {
+		err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+		goto out;
+	}
 	err = fh_fill_pre_attrs(ffhp);
 	if (err != nfs_ok)
 		goto out_unlock;
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4382881b0709..e44dc5f66161 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -722,7 +722,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	struct inode *inode;
 	struct inode *udir = d_inode(c->destdir), *wdir = d_inode(c->workdir);
 	struct path path = { .mnt = ovl_upper_mnt(ofs) };
-	struct dentry *temp, *upper;
+	struct dentry *temp, *upper, *trap;
 	struct ovl_cu_creds cc;
 	int err;
 	struct ovl_cattr cattr = {
@@ -760,9 +760,11 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * If temp was moved, abort without the cleanup.
 	 */
 	ovl_start_write(c->dentry);
-	if (lock_rename(c->workdir, c->destdir) != NULL ||
-	    temp->d_parent != c->workdir) {
+	trap = lock_rename(c->workdir, c->destdir);
+	if (trap || temp->d_parent != c->workdir) {
 		err = -EIO;
+		if (IS_ERR(trap))
+			goto out;
 		goto unlock;
 	} else if (err) {
 		goto cleanup;
@@ -803,6 +805,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		ovl_set_flag(OVL_WHITEOUTS, inode);
 unlock:
 	unlock_rename(c->workdir, c->destdir);
+out:
 	ovl_end_write(c->dentry);
 
 	return err;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index aab3f5d93556..0f8b4a719237 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1180,6 +1180,10 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	}
 
 	trap = lock_rename(new_upperdir, old_upperdir);
+	if (IS_ERR(trap)) {
+		err = PTR_ERR(trap);
+		goto out_revert_creds;
+	}
 
 	olddentry = ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
 				     old->d_name.len);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a0967bb25003..fc3a6ff648bd 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -439,8 +439,10 @@ static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperdir)
 	bool ok = false;
 
 	if (workdir != upperdir) {
-		ok = (lock_rename(workdir, upperdir) == NULL);
-		unlock_rename(workdir, upperdir);
+		struct dentry *trap = lock_rename(workdir, upperdir);
+		if (!IS_ERR(trap))
+			unlock_rename(workdir, upperdir);
+		ok = (trap == NULL);
 	}
 	return ok;
 }
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 50a201e9cd39..7b667345e673 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1198,12 +1198,17 @@ void ovl_nlink_end(struct dentry *dentry)
 
 int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
 {
+	struct dentry *trap;
+
 	/* Workdir should not be the same as upperdir */
 	if (workdir == upperdir)
 		goto err;
 
 	/* Workdir should not be subdir of upperdir and vice versa */
-	if (lock_rename(workdir, upperdir) != NULL)
+	trap = lock_rename(workdir, upperdir);
+	if (IS_ERR(trap))
+		goto err;
+	if (trap)
 		goto err_unlock;
 
 	return 0;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index c53dea5598fc..4cf8523ad038 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -708,6 +708,10 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		goto out2;
 
 	trap = lock_rename_child(old_child, new_path.dentry);
+	if (IS_ERR(trap)) {
+		err = PTR_ERR(trap);
+		goto out_drop_write;
+	}
 
 	old_parent = dget(old_child->d_parent);
 	if (d_unhashed(old_child)) {
@@ -770,6 +774,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 out3:
 	dput(old_parent);
 	unlock_rename(old_parent, new_path.dentry);
+out_drop_write:
 	mnt_drop_write(old_path->mnt);
 out2:
 	path_put(&new_path);
-- 
2.39.2


