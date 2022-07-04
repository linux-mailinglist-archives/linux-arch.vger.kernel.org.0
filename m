Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A448564BE9
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 04:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiGDCyB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Jul 2022 22:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDCyA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2022 22:54:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E8E2C3;
        Sun,  3 Jul 2022 19:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vO9e4FK09OExUNkGvxoa/0O9s2rDe2YLeW0ZmG6+6Kg=; b=a6Wr3eXalqQ1x7Xzq1DJMB980z
        QgVgjoWDXyhE1vfAlsv77O6kJ5yU8hRobZz9zroeVNJVJ7czHKf2GMMT0kXnag3lE3S4CZrRV/uLD
        tB/0kbe8/lARWcluoxdeIDazoZWcbCP6K+DL0RVC8oB+0VhqVRsoOhU/Wvs96MQmvGAYZrShhZJ0Y
        5uEwjJo8fghfu6nUn53dtd3+t4yH+d+XtSHXNdR6dz/2JWMhws29rzznPkLJyl4z/oSTFpSwG9Ido
        8Hp5aAFLodbmqdfSDYAO9YgZn0IXcWcMyy3FiDGtc0IY2HTsyNYNNQQwYWlRDE5WSjxek13qg6TMR
        6XywjS2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8CCn-007r8W-Fz;
        Mon, 04 Jul 2022 02:52:57 +0000
Date:   Mon, 4 Jul 2022 03:52:57 +0100
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
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to
 step_into()
Message-ID: <YsJWCREA5xMfmmqx@ZenIV>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-44-glider@google.com>
 <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 02, 2022 at 10:23:16AM -0700, Linus Torvalds wrote:

> Al - can you please take a quick look?

FWIW, trying to write a coherent documentation had its usual effect...
The thing is, we don't really need to fetch the inode that early.
All we really care about is that in RCU mode ->d_seq gets sampled
before we fetch ->d_inode *and* we don't treat "it looks negative"
as hard -ENOENT in case of ->d_seq mismatch.

Which can be bloody well left to step_into().  So we don't need
to pass it inode argument at all - just dentry and seq.  Makes
a bunch of functions simpler as well...

It does *not* deal with the "uninitialized" seq argument in
!RCU case; I'll handle that in the followup, but that's a separate
story, IMO (and very clearly a false positive).

Cumulative diff follows; splitup is in #work.namei.  Comments?

diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..7f4f61ade9e3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(follow_down);
  * we meet a managed dentry that would need blocking.
  */
 static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
-			       struct inode **inode, unsigned *seqp)
+			       unsigned *seqp)
 {
 	struct dentry *dentry = path->dentry;
 	unsigned int flags = dentry->d_flags;
@@ -1497,13 +1497,6 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 				dentry = path->dentry = mounted->mnt.mnt_root;
 				nd->state |= ND_JUMPED;
 				*seqp = read_seqcount_begin(&dentry->d_seq);
-				*inode = dentry->d_inode;
-				/*
-				 * We don't need to re-check ->d_seq after this
-				 * ->d_inode read - there will be an RCU delay
-				 * between mount hash removal and ->mnt_root
-				 * becoming unpinned.
-				 */
 				flags = dentry->d_flags;
 				continue;
 			}
@@ -1515,8 +1508,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 }
 
 static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
-			  struct path *path, struct inode **inode,
-			  unsigned int *seqp)
+			  struct path *path, unsigned int *seqp)
 {
 	bool jumped;
 	int ret;
@@ -1525,9 +1517,7 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	path->dentry = dentry;
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned int seq = *seqp;
-		if (unlikely(!*inode))
-			return -ENOENT;
-		if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
+		if (likely(__follow_mount_rcu(nd, path, seqp)))
 			return 0;
 		if (!try_to_unlazy_next(nd, dentry, seq))
 			return -ECHILD;
@@ -1547,7 +1537,6 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 		if (path->mnt != nd->path.mnt)
 			mntput(path->mnt);
 	} else {
-		*inode = d_backing_inode(path->dentry);
 		*seqp = 0; /* out of RCU mode, so the value doesn't matter */
 	}
 	return ret;
@@ -1607,9 +1596,7 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	return dentry;
 }
 
-static struct dentry *lookup_fast(struct nameidata *nd,
-				  struct inode **inode,
-			          unsigned *seqp)
+static struct dentry *lookup_fast(struct nameidata *nd, unsigned *seqp)
 {
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
@@ -1628,22 +1615,11 @@ static struct dentry *lookup_fast(struct nameidata *nd,
 			return NULL;
 		}
 
-		/*
-		 * This sequence count validates that the inode matches
-		 * the dentry name information from lookup.
-		 */
-		*inode = d_backing_inode(dentry);
-		if (unlikely(read_seqcount_retry(&dentry->d_seq, seq)))
-			return ERR_PTR(-ECHILD);
-
-		/*
+	        /*
 		 * This sequence count validates that the parent had no
 		 * changes while we did the lookup of the dentry above.
-		 *
-		 * The memory barrier in read_seqcount_begin of child is
-		 *  enough, we can use __read_seqcount_retry here.
 		 */
-		if (unlikely(__read_seqcount_retry(&parent->d_seq, nd->seq)))
+		if (unlikely(read_seqcount_retry(&parent->d_seq, nd->seq)))
 			return ERR_PTR(-ECHILD);
 
 		*seqp = seq;
@@ -1838,13 +1814,21 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
  * for the common case.
  */
 static const char *step_into(struct nameidata *nd, int flags,
-		     struct dentry *dentry, struct inode *inode, unsigned seq)
+		     struct dentry *dentry, unsigned seq)
 {
 	struct path path;
-	int err = handle_mounts(nd, dentry, &path, &inode, &seq);
+	struct inode *inode;
+	int err = handle_mounts(nd, dentry, &path, &seq);
 
 	if (err < 0)
 		return ERR_PTR(err);
+	inode = path.dentry->d_inode;
+	if (unlikely(!inode)) {
+		if ((nd->flags & LOOKUP_RCU) &&
+		    read_seqcount_retry(&path.dentry->d_seq, seq))
+			return ERR_PTR(-ECHILD);
+		return ERR_PTR(-ENOENT);
+	}
 	if (likely(!d_is_symlink(path.dentry)) ||
 	   ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
 	   (flags & WALK_NOFOLLOW)) {
@@ -1870,9 +1854,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, seq, flags);
 }
 
-static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
-					struct inode **inodep,
-					unsigned *seqp)
+static struct dentry *follow_dotdot_rcu(struct nameidata *nd, unsigned *seqp)
 {
 	struct dentry *parent, *old;
 
@@ -1895,7 +1877,6 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 	}
 	old = nd->path.dentry;
 	parent = old->d_parent;
-	*inodep = parent->d_inode;
 	*seqp = read_seqcount_begin(&parent->d_seq);
 	if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
 		return ERR_PTR(-ECHILD);
@@ -1910,9 +1891,7 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 	return NULL;
 }
 
-static struct dentry *follow_dotdot(struct nameidata *nd,
-				 struct inode **inodep,
-				 unsigned *seqp)
+static struct dentry *follow_dotdot(struct nameidata *nd, unsigned *seqp)
 {
 	struct dentry *parent;
 
@@ -1937,7 +1916,6 @@ static struct dentry *follow_dotdot(struct nameidata *nd,
 		return ERR_PTR(-ENOENT);
 	}
 	*seqp = 0;
-	*inodep = parent->d_inode;
 	return parent;
 
 in_root:
@@ -1952,7 +1930,6 @@ static const char *handle_dots(struct nameidata *nd, int type)
 	if (type == LAST_DOTDOT) {
 		const char *error = NULL;
 		struct dentry *parent;
-		struct inode *inode;
 		unsigned seq;
 
 		if (!nd->root.mnt) {
@@ -1961,17 +1938,17 @@ static const char *handle_dots(struct nameidata *nd, int type)
 				return error;
 		}
 		if (nd->flags & LOOKUP_RCU)
-			parent = follow_dotdot_rcu(nd, &inode, &seq);
+			parent = follow_dotdot_rcu(nd, &seq);
 		else
-			parent = follow_dotdot(nd, &inode, &seq);
+			parent = follow_dotdot(nd, &seq);
 		if (IS_ERR(parent))
 			return ERR_CAST(parent);
 		if (unlikely(!parent))
 			error = step_into(nd, WALK_NOFOLLOW,
-					 nd->path.dentry, nd->inode, nd->seq);
+					 nd->path.dentry, nd->seq);
 		else
 			error = step_into(nd, WALK_NOFOLLOW,
-					 parent, inode, seq);
+					 parent, seq);
 		if (unlikely(error))
 			return error;
 
@@ -1995,7 +1972,6 @@ static const char *handle_dots(struct nameidata *nd, int type)
 static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
-	struct inode *inode;
 	unsigned seq;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
@@ -2007,7 +1983,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
 	}
-	dentry = lookup_fast(nd, &inode, &seq);
+	dentry = lookup_fast(nd, &seq);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 	if (unlikely(!dentry)) {
@@ -2017,7 +1993,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	}
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
-	return step_into(nd, flags, dentry, inode, seq);
+	return step_into(nd, flags, dentry, seq);
 }
 
 /*
@@ -2473,8 +2449,7 @@ static int handle_lookup_down(struct nameidata *nd)
 {
 	if (!(nd->flags & LOOKUP_RCU))
 		dget(nd->path.dentry);
-	return PTR_ERR(step_into(nd, WALK_NOFOLLOW,
-			nd->path.dentry, nd->inode, nd->seq));
+	return PTR_ERR(step_into(nd, WALK_NOFOLLOW, nd->path.dentry, nd->seq));
 }
 
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
@@ -3394,7 +3369,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 	int open_flag = op->open_flag;
 	bool got_write = false;
 	unsigned seq;
-	struct inode *inode;
 	struct dentry *dentry;
 	const char *res;
 
@@ -3410,7 +3384,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		if (nd->last.name[nd->last.len])
 			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 		/* we _can_ be in RCU mode here */
-		dentry = lookup_fast(nd, &inode, &seq);
+		dentry = lookup_fast(nd, &seq);
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 		if (likely(dentry))
@@ -3464,7 +3438,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 finish_lookup:
 	if (nd->depth)
 		put_link(nd);
-	res = step_into(nd, WALK_TRAILING, dentry, inode, seq);
+	res = step_into(nd, WALK_TRAILING, dentry, seq);
 	if (unlikely(res))
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
 	return res;
