Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC9565FB1
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 01:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiGDXSH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 19:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiGDXRm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 19:17:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB0B10577;
        Mon,  4 Jul 2022 16:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NqVApc9I2DDH/ifQWSRH221HRDI5UWBJClZrnVtHcvg=; b=XMq6en3D1K42NPJrNPt3lNiGHU
        6m4VZEYHJsKw2KJ8FEER0qK8oNGCVOWcuDgjwh8WQDSnCv3uQR6L+1i3enPxKWoWnbVOH3z6CEie3
        nAp9cJJDd2p+yBlssUPpEpXlwKJbc2p27ShaRo5hao7QkcNFe3prUfJ6W5u0gQWZQnbKrS5pR1Tdf
        egeY54C3ZyVr7W9Zdixd+0O1ckAB19QGVGrBNLoZWZcqmBVvuhjabPDBCUO+bxM+6STEGYDHx9FyS
        toKCReTROXqjfeOSHKWpf/dSfOftFLkoYOpfUHq4w3tP7uXrpyQGmCSK5nAd/yJzARh/75JRzMNP4
        bDBFQeCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8VJP-008AcR-HB;
        Mon, 04 Jul 2022 23:17:03 +0000
Date:   Tue, 5 Jul 2022 00:17:03 +0100
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
Subject: [PATCH 7/7] step_into(): move fetching ->d_inode past handle_mounts()
Message-ID: <YsN07/fVcHSbDDlm@ZenIV>
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

... and lose messing with it in __follow_mount_rcu()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index cdb61d09df79..f2c99e75b578 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1470,8 +1470,7 @@ EXPORT_SYMBOL(follow_down);
  * Try to skip to top of mountpoint pile in rcuwalk mode.  Fail if
  * we meet a managed dentry that would need blocking.
  */
-static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
-			       struct inode **inode)
+static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
 {
 	struct dentry *dentry = path->dentry;
 	unsigned int flags = dentry->d_flags;
@@ -1501,13 +1500,6 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 				dentry = path->dentry = mounted->mnt.mnt_root;
 				nd->state |= ND_JUMPED;
 				nd->next_seq = read_seqcount_begin(&dentry->d_seq);
-				*inode = dentry->d_inode;
-				/*
-				 * We don't need to re-check ->d_seq after this
-				 * ->d_inode read - there will be an RCU delay
-				 * between mount hash removal and ->mnt_root
-				 * becoming unpinned.
-				 */
 				flags = dentry->d_flags;
 				// makes sure that non-RCU pathwalk could reach
 				// this state.
@@ -1523,7 +1515,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 }
 
 static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
-			  struct path *path, struct inode **inode)
+			  struct path *path)
 {
 	bool jumped;
 	int ret;
@@ -1532,12 +1524,7 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	path->dentry = dentry;
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned int seq = nd->next_seq;
-		*inode = dentry->d_inode;
-		if (read_seqcount_retry(&dentry->d_seq, seq))
-			return -ECHILD;
-		if (unlikely(!*inode))
-			return -ENOENT;
-		if (likely(__follow_mount_rcu(nd, path, inode)))
+		if (likely(__follow_mount_rcu(nd, path)))
 			return 0;
 		// *path and nd->next_seq might've been clobbered
 		path->mnt = nd->path.mnt;
@@ -1557,8 +1544,6 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 		dput(path->dentry);
 		if (path->mnt != nd->path.mnt)
 			mntput(path->mnt);
-	} else {
-		*inode = d_backing_inode(path->dentry);
 	}
 	return ret;
 }
@@ -1839,15 +1824,21 @@ static const char *step_into(struct nameidata *nd, int flags,
 {
 	struct path path;
 	struct inode *inode;
-	int err = handle_mounts(nd, dentry, &path, &inode);
+	int err = handle_mounts(nd, dentry, &path);
 
 	if (err < 0)
 		return ERR_PTR(err);
+	inode = path.dentry->d_inode;
 	if (likely(!d_is_symlink(path.dentry)) ||
 	   ((flags & WALK_TRAILING) && !(nd->flags & LOOKUP_FOLLOW)) ||
 	   (flags & WALK_NOFOLLOW)) {
 		/* not a symlink or should not follow */
-		if (!(nd->flags & LOOKUP_RCU)) {
+		if (nd->flags & LOOKUP_RCU) {
+			if (read_seqcount_retry(&path.dentry->d_seq, nd->next_seq))
+				return ERR_PTR(-ECHILD);
+			if (unlikely(!inode))
+				return ERR_PTR(-ENOENT);
+		} else {
 			dput(nd->path.dentry);
 			if (nd->path.mnt != path.mnt)
 				mntput(nd->path.mnt);
-- 
2.30.2

