Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F93565FA0
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 01:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiGDXPN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 19:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiGDXPL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 19:15:11 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5998F101D4;
        Mon,  4 Jul 2022 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Br5WlNNviFIy/GyDPGw5BoV/8TxCR0XRwVG74vstYTg=; b=OJehKGWkeFwhw7w7SONgVoHhwM
        q4v+a9IonIgCxktIHz+I5e1T0+Rty5oZloBZrWZhicGetV9rjlw4KtxEFm2kxvr6SGgK++c8jwkn/
        hF3/9M4I3yb8yLR6XmrtFrFCylmyH+0yKV9Ikg+AzO5HAx78bm1q/PdFqqzVrHHhxDkuirPCholkR
        KQ3X33t4oEK7AMHFrYvJ3YFBiCygmU8ppCpEoydfQITd2UCJsIf9NvMeMC8lWRBaN1LsRU9s44mGs
        iAyJvaVptepQ63q9HrVgBgnFLLBUA43sIB57KYqm0nIRlqkrqjiegK0YEDNyCEiQmY4lPXY4sCc8H
        KrNgW4Pg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8VH6-008AX3-3B;
        Mon, 04 Jul 2022 23:14:40 +0000
Date:   Tue, 5 Jul 2022 00:14:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: [PATCH 3/7] namei: stash the sampled ->d_seq into nameidata
Message-ID: <YsN0YFIDaO+/Hr3+@ZenIV>
References: <YsJWCREA5xMfmmqx@ZenIV>
 <CAHk-=wjxqKYHu2-m1Y1EKVpi5bvrD891710mMichfx_EjAjX4A@mail.gmail.com>
 <YsM5XHy4RZUDF8cR@ZenIV>
 <CAHk-=wjeEre7eeWSwCRy2+ZFH8js4u22+3JTm6n+pY-QHdhbYw@mail.gmail.com>
 <YsNFoH0+N+KCt5kg@ZenIV>
 <CAHk-=whp8Npc+vMcgbpM9mrPEXkhV4YnhsPxbPXSu9gfEhKWmA@mail.gmail.com>
 <YsNRsgOl04r/RCNe@ZenIV>
 <CAHk-=wih_JHVPvp1qyW4KNK0ctTc6e+bDj4wdTgNkyND6tuFoQ@mail.gmail.com>
 <YsNVyLxrNRFpufn8@ZenIV>
 <YsN0GURKuaAqXB/e@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsN0GURKuaAqXB/e@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

New field: nd->next_seq.  Set to 0 outside of RCU mode, holds the sampled
value for the next dentry to be considered.  Used instead of an arseload
of local variables, arguments, etc.

step_into() has lost seq argument; nd->next_seq is used, so dentry passed
to it must be the one ->next_seq is about.

There are two requirements for RCU pathwalk:
	1) it should not give a hard failure (other than -ECHILD) unless
non-RCU pathwalk might fail that way given suitable timings.
	2) it should not succeed unless non-RCU pathwalk might succeed
with the same end location given suitable timings.

The use of seq numbers is the way we achieve that.  Invariant we want
to maintain is:
	if RCU pathwalk can reach the state with given nd->path, nd->inode
and nd->seq after having traversed some part of pathname, it must be possible
for non-RCU pathwalk to reach the same nd->path and nd->inode after having
traversed the same part of pathname, and observe the nd->path.dentry->d_seq
equal to what RCU pathwalk has in nd->seq

	For transition from parent to child, we sample child's ->d_seq
and verify that parent's ->d_seq remains unchanged.
	For transitions from child to parent we sample parent's ->d_seq
and verify that child's ->d_seq has not changed.
	For transition from mountpoint to root of mounted we sample
the ->d_seq of root and verify that nobody has touched mount_lock since
the beginning of pathwalk.  That guarantees that mount we'd found had
been there all along, with these mountpoint and root of mounted.
It would be possible for a non-RCU pathwalk to reach the previous state,
find the same mount and observe its root at the moment we'd sampled
->d_seq of that
	For transitions from root of mounted to mountpoint we sample
->d_seq of mountpoint and verify that mount_lock had not been touched
since the beginning of pathwalk.  The same reasoning as in the
previous case applies.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 104 ++++++++++++++++++++++++++---------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ecdb9ac21ece..c7c9e88add85 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -567,7 +567,7 @@ struct nameidata {
 	struct path	root;
 	struct inode	*inode; /* path.dentry.d_inode */
 	unsigned int	flags, state;
-	unsigned	seq, m_seq, r_seq;
+	unsigned	seq, next_seq, m_seq, r_seq;
 	int		last_type;
 	unsigned	depth;
 	int		total_link_count;
@@ -772,6 +772,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 		goto out;
 	if (unlikely(!legitimize_root(nd)))
 		goto out;
+	nd->seq = nd->next_seq = 0;
 	rcu_read_unlock();
 	BUG_ON(nd->inode != parent->d_inode);
 	return true;
@@ -780,6 +781,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
 out:
+	nd->seq = nd->next_seq = 0;
 	rcu_read_unlock();
 	return false;
 }
@@ -788,7 +790,6 @@ static bool try_to_unlazy(struct nameidata *nd)
  * try_to_unlazy_next - try to switch to ref-walk mode.
  * @nd: nameidata pathwalk data
  * @dentry: next dentry to step into
- * @seq: seq number to check @dentry against
  * Returns: true on success, false on failure
  *
  * Similar to try_to_unlazy(), but here we have the next dentry already
@@ -797,7 +798,7 @@ static bool try_to_unlazy(struct nameidata *nd)
  * Nothing should touch nameidata between try_to_unlazy_next() failure and
  * terminate_walk().
  */
-static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry, unsigned seq)
+static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 {
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
@@ -818,7 +819,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry, unsi
 	 */
 	if (unlikely(!lockref_get_not_dead(&dentry->d_lockref)))
 		goto out;
-	if (unlikely(read_seqcount_retry(&dentry->d_seq, seq)))
+	if (unlikely(read_seqcount_retry(&dentry->d_seq, nd->next_seq)))
 		goto out_dput;
 	/*
 	 * Sequence counts matched. Now make sure that the root is
@@ -826,6 +827,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry, unsi
 	 */
 	if (unlikely(!legitimize_root(nd)))
 		goto out_dput;
+	nd->seq = nd->next_seq = 0;
 	rcu_read_unlock();
 	return true;
 
@@ -834,9 +836,11 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry, unsi
 out1:
 	nd->path.dentry = NULL;
 out:
+	nd->seq = nd->next_seq = 0;
 	rcu_read_unlock();
 	return false;
 out_dput:
+	nd->seq = nd->next_seq = 0;
 	rcu_read_unlock();
 	dput(dentry);
 	return false;
@@ -1467,7 +1471,7 @@ EXPORT_SYMBOL(follow_down);
  * we meet a managed dentry that would need blocking.
  */
 static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
-			       struct inode **inode, unsigned *seqp)
+			       struct inode **inode)
 {
 	struct dentry *dentry = path->dentry;
 	unsigned int flags = dentry->d_flags;
@@ -1496,7 +1500,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 				path->mnt = &mounted->mnt;
 				dentry = path->dentry = mounted->mnt.mnt_root;
 				nd->state |= ND_JUMPED;
-				*seqp = read_seqcount_begin(&dentry->d_seq);
+				nd->next_seq = read_seqcount_begin(&dentry->d_seq);
 				*inode = dentry->d_inode;
 				/*
 				 * We don't need to re-check ->d_seq after this
@@ -1505,6 +1509,8 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 				 * becoming unpinned.
 				 */
 				flags = dentry->d_flags;
+				// makes sure that non-RCU pathwalk could reach
+				// this state.
 				if (read_seqretry(&mount_lock, nd->m_seq))
 					return false;
 				continue;
@@ -1517,8 +1523,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 }
 
 static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
-			  struct path *path, struct inode **inode,
-			  unsigned int *seqp)
+			  struct path *path, struct inode **inode)
 {
 	bool jumped;
 	int ret;
@@ -1526,16 +1531,15 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	path->mnt = nd->path.mnt;
 	path->dentry = dentry;
 	if (nd->flags & LOOKUP_RCU) {
-		unsigned int seq = *seqp;
-		if (unlikely(!*inode))
-			return -ENOENT;
-		if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
+		unsigned int seq = nd->next_seq;
+		if (likely(__follow_mount_rcu(nd, path, inode)))
 			return 0;
-		if (!try_to_unlazy_next(nd, dentry, seq))
-			return -ECHILD;
-		// *path might've been clobbered by __follow_mount_rcu()
+		// *path and nd->next_seq might've been clobbered
 		path->mnt = nd->path.mnt;
 		path->dentry = dentry;
+		nd->next_seq = seq;
+		if (!try_to_unlazy_next(nd, dentry))
+			return -ECHILD;
 	}
 	ret = traverse_mounts(path, &jumped, &nd->total_link_count, nd->flags);
 	if (jumped) {
@@ -1550,7 +1554,6 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 			mntput(path->mnt);
 	} else {
 		*inode = d_backing_inode(path->dentry);
-		*seqp = 0; /* out of RCU mode, so the value doesn't matter */
 	}
 	return ret;
 }
@@ -1610,8 +1613,7 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 }
 
 static struct dentry *lookup_fast(struct nameidata *nd,
-				  struct inode **inode,
-			          unsigned *seqp)
+				  struct inode **inode)
 {
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
@@ -1622,8 +1624,7 @@ static struct dentry *lookup_fast(struct nameidata *nd,
 	 * going to fall back to non-racy lookup.
 	 */
 	if (nd->flags & LOOKUP_RCU) {
-		unsigned seq;
-		dentry = __d_lookup_rcu(parent, &nd->last, &seq);
+		dentry = __d_lookup_rcu(parent, &nd->last, &nd->next_seq);
 		if (unlikely(!dentry)) {
 			if (!try_to_unlazy(nd))
 				return ERR_PTR(-ECHILD);
@@ -1635,7 +1636,7 @@ static struct dentry *lookup_fast(struct nameidata *nd,
 		 * the dentry name information from lookup.
 		 */
 		*inode = d_backing_inode(dentry);
-		if (unlikely(read_seqcount_retry(&dentry->d_seq, seq)))
+		if (unlikely(read_seqcount_retry(&dentry->d_seq, nd->next_seq)))
 			return ERR_PTR(-ECHILD);
 
 		/*
@@ -1648,11 +1649,10 @@ static struct dentry *lookup_fast(struct nameidata *nd,
 		if (unlikely(__read_seqcount_retry(&parent->d_seq, nd->seq)))
 			return ERR_PTR(-ECHILD);
 
-		*seqp = seq;
 		status = d_revalidate(dentry, nd->flags);
 		if (likely(status > 0))
 			return dentry;
-		if (!try_to_unlazy_next(nd, dentry, seq))
+		if (!try_to_unlazy_next(nd, dentry))
 			return ERR_PTR(-ECHILD);
 		if (status == -ECHILD)
 			/* we'd been told to redo it in non-rcu mode */
@@ -1733,7 +1733,7 @@ static inline int may_lookup(struct user_namespace *mnt_userns,
 	return inode_permission(mnt_userns, nd->inode, MAY_EXEC);
 }
 
-static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
+static int reserve_stack(struct nameidata *nd, struct path *link)
 {
 	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS))
 		return -ELOOP;
@@ -1748,7 +1748,7 @@ static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 	if (nd->flags & LOOKUP_RCU) {
 		// we need to grab link before we do unlazy.  And we can't skip
 		// unlazy even if we fail to grab the link - cleanup needs it
-		bool grabbed_link = legitimize_path(nd, link, seq);
+		bool grabbed_link = legitimize_path(nd, link, nd->next_seq);
 
 		if (!try_to_unlazy(nd) || !grabbed_link)
 			return -ECHILD;
@@ -1762,11 +1762,11 @@ static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
 enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
 static const char *pick_link(struct nameidata *nd, struct path *link,
-		     struct inode *inode, unsigned seq, int flags)
+		     struct inode *inode, int flags)
 {
 	struct saved *last;
 	const char *res;
-	int error = reserve_stack(nd, link, seq);
+	int error = reserve_stack(nd, link);
 
 	if (unlikely(error)) {
 		if (!(nd->flags & LOOKUP_RCU))
@@ -1776,7 +1776,7 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	last = nd->stack + nd->depth++;
 	last->link = *link;
 	clear_delayed_call(&last->done);
-	last->seq = seq;
+	last->seq = nd->next_seq;
 
 	if (flags & WALK_TRAILING) {
 		error = may_follow_link(nd, inode);
@@ -1838,12 +1838,14 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
  * to do this check without having to look at inode->i_op,
  * so we keep a cache of "no, this doesn't need follow_link"
  * for the common case.
+ *
+ * NOTE: dentry must be what nd->next_seq had been sampled from.
  */
 static const char *step_into(struct nameidata *nd, int flags,
-		     struct dentry *dentry, struct inode *inode, unsigned seq)
+		     struct dentry *dentry, struct inode *inode)
 {
 	struct path path;
-	int err = handle_mounts(nd, dentry, &path, &inode, &seq);
+	int err = handle_mounts(nd, dentry, &path, &inode);
 
 	if (err < 0)
 		return ERR_PTR(err);
@@ -1858,23 +1860,22 @@ static const char *step_into(struct nameidata *nd, int flags,
 		}
 		nd->path = path;
 		nd->inode = inode;
-		nd->seq = seq;
+		nd->seq = nd->next_seq;
 		return NULL;
 	}
 	if (nd->flags & LOOKUP_RCU) {
 		/* make sure that d_is_symlink above matches inode */
-		if (read_seqcount_retry(&path.dentry->d_seq, seq))
+		if (read_seqcount_retry(&path.dentry->d_seq, nd->next_seq))
 			return ERR_PTR(-ECHILD);
 	} else {
 		if (path.mnt == nd->path.mnt)
 			mntget(path.mnt);
 	}
-	return pick_link(nd, &path, inode, seq, flags);
+	return pick_link(nd, &path, inode, flags);
 }
 
 static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
-					struct inode **inodep,
-					unsigned *seqp)
+					struct inode **inodep)
 {
 	struct dentry *parent, *old;
 
@@ -1891,6 +1892,7 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 		nd->path = path;
 		nd->inode = path.dentry->d_inode;
 		nd->seq = seq;
+		// makes sure that non-RCU pathwalk could reach this state
 		if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
 			return ERR_PTR(-ECHILD);
 		/* we know that mountpoint was pinned */
@@ -1898,7 +1900,8 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 	old = nd->path.dentry;
 	parent = old->d_parent;
 	*inodep = parent->d_inode;
-	*seqp = read_seqcount_begin(&parent->d_seq);
+	nd->next_seq = read_seqcount_begin(&parent->d_seq);
+	// makes sure that non-RCU pathwalk could reach this state
 	if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
 		return ERR_PTR(-ECHILD);
 	if (unlikely(!path_connected(nd->path.mnt, parent)))
@@ -1909,14 +1912,13 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 		return ERR_PTR(-ECHILD);
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
 		return ERR_PTR(-ECHILD);
-	*seqp = nd->seq;
+	nd->next_seq = nd->seq;
 	*inodep = nd->path.dentry->d_inode;
 	return nd->path.dentry;
 }
 
 static struct dentry *follow_dotdot(struct nameidata *nd,
-				 struct inode **inodep,
-				 unsigned *seqp)
+				 struct inode **inodep)
 {
 	struct dentry *parent;
 
@@ -1940,14 +1942,12 @@ static struct dentry *follow_dotdot(struct nameidata *nd,
 		dput(parent);
 		return ERR_PTR(-ENOENT);
 	}
-	*seqp = 0;
 	*inodep = parent->d_inode;
 	return parent;
 
 in_root:
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
 		return ERR_PTR(-EXDEV);
-	*seqp = 0;
 	*inodep = nd->path.dentry->d_inode;
 	return dget(nd->path.dentry);
 }
@@ -1958,7 +1958,6 @@ static const char *handle_dots(struct nameidata *nd, int type)
 		const char *error = NULL;
 		struct dentry *parent;
 		struct inode *inode;
-		unsigned seq;
 
 		if (!nd->root.mnt) {
 			error = ERR_PTR(set_root(nd));
@@ -1966,12 +1965,12 @@ static const char *handle_dots(struct nameidata *nd, int type)
 				return error;
 		}
 		if (nd->flags & LOOKUP_RCU)
-			parent = follow_dotdot_rcu(nd, &inode, &seq);
+			parent = follow_dotdot_rcu(nd, &inode);
 		else
-			parent = follow_dotdot(nd, &inode, &seq);
+			parent = follow_dotdot(nd, &inode);
 		if (IS_ERR(parent))
 			return ERR_CAST(parent);
-		error = step_into(nd, WALK_NOFOLLOW, parent, inode, seq);
+		error = step_into(nd, WALK_NOFOLLOW, parent, inode);
 		if (unlikely(error))
 			return error;
 
@@ -1996,7 +1995,6 @@ static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
 	struct inode *inode;
-	unsigned seq;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
 	 * to be able to know about the current root directory and
@@ -2007,7 +2005,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
 	}
-	dentry = lookup_fast(nd, &inode, &seq);
+	dentry = lookup_fast(nd, &inode);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 	if (unlikely(!dentry)) {
@@ -2017,7 +2015,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	}
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
-	return step_into(nd, flags, dentry, inode, seq);
+	return step_into(nd, flags, dentry, inode);
 }
 
 /*
@@ -2372,6 +2370,8 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		flags &= ~LOOKUP_RCU;
 	if (flags & LOOKUP_RCU)
 		rcu_read_lock();
+	else
+		nd->seq = nd->next_seq = 0;
 
 	nd->flags = flags;
 	nd->state |= ND_JUMPED;
@@ -2473,8 +2473,9 @@ static int handle_lookup_down(struct nameidata *nd)
 {
 	if (!(nd->flags & LOOKUP_RCU))
 		dget(nd->path.dentry);
+	nd->next_seq = nd->seq;
 	return PTR_ERR(step_into(nd, WALK_NOFOLLOW,
-			nd->path.dentry, nd->inode, nd->seq));
+			nd->path.dentry, nd->inode));
 }
 
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
@@ -3393,7 +3394,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
 	bool got_write = false;
-	unsigned seq;
 	struct inode *inode;
 	struct dentry *dentry;
 	const char *res;
@@ -3410,7 +3410,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		if (nd->last.name[nd->last.len])
 			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 		/* we _can_ be in RCU mode here */
-		dentry = lookup_fast(nd, &inode, &seq);
+		dentry = lookup_fast(nd, &inode);
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 		if (likely(dentry))
@@ -3464,7 +3464,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 finish_lookup:
 	if (nd->depth)
 		put_link(nd);
-	res = step_into(nd, WALK_TRAILING, dentry, inode, seq);
+	res = step_into(nd, WALK_TRAILING, dentry, inode);
 	if (unlikely(res))
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
 	return res;
-- 
2.30.2

