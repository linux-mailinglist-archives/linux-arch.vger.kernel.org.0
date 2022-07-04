Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACFB565FA3
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 01:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiGDXP6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 19:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiGDXP5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 19:15:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0198EE2E;
        Mon,  4 Jul 2022 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=phosGs0ReDXhvjah48sBo0KCwl+d1jcc+HCEqeu58tc=; b=OwdNXG7l7nBZtBBbjR/cEwIL4N
        J37eUfI1FdldQ2JpF8o2dJ2JHAuu3g5AX9ZcC1ukryfycNUEebrOsH9bjzn5Ms14CE5CNkbnEFGqs
        MYAVKAe6mUxmINf7gP+SuhmQ5NOKLLqGiIJPJwezFX+CUPngnBDRuMi5xYoptjm99AXdxw+ozX7dd
        RUdGasO87hSmy74nZJTIKnsrM8O5sp4QAVlELB8ReYdLKpNELFQf2zgYT8cv6WZMmQox9iK66Kq9n
        TgHphg+f7OxwqwIe3eA3NnlxLV5SbKhPv91SC5i4ZlWxYcAa8/WRiJWOWIk4fkjPr0mRjx2KC0bk9
        25vU+zrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8VHc-008AYW-Qq;
        Mon, 04 Jul 2022 23:15:12 +0000
Date:   Tue, 5 Jul 2022 00:15:12 +0100
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
Subject: [PATCH 4/7] step_into(): lose inode argument
Message-ID: <YsN0gGIUtmYHYXYB@ZenIV>
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

make handle_mounts() always fetch it.  This is just the first step -
the callers of step_into() will stop trying to calculate the sucker,
etc.

The passed value should be equal to dentry->d_inode in all cases;
in RCU mode - fetched after we'd sampled ->d_seq.  Might as well
fetch it here.  We do need to validate ->d_seq, which duplicates
the check currently done in lookup_fast(); that duplication will
go away shortly.

After that change handle_mounts() always ignores the initial value of
*inode and always sets it on success.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7c9e88add85..dddbebf92b48 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1532,6 +1532,11 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	path->dentry = dentry;
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned int seq = nd->next_seq;
+		*inode = dentry->d_inode;
+		if (read_seqcount_retry(&dentry->d_seq, seq))
+			return -ECHILD;
+		if (unlikely(!*inode))
+			return -ENOENT;
 		if (likely(__follow_mount_rcu(nd, path, inode)))
 			return 0;
 		// *path and nd->next_seq might've been clobbered
@@ -1842,9 +1847,10 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
  * NOTE: dentry must be what nd->next_seq had been sampled from.
  */
 static const char *step_into(struct nameidata *nd, int flags,
-		     struct dentry *dentry, struct inode *inode)
+		     struct dentry *dentry)
 {
 	struct path path;
+	struct inode *inode;
 	int err = handle_mounts(nd, dentry, &path, &inode);
 
 	if (err < 0)
@@ -1970,7 +1976,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
 			parent = follow_dotdot(nd, &inode);
 		if (IS_ERR(parent))
 			return ERR_CAST(parent);
-		error = step_into(nd, WALK_NOFOLLOW, parent, inode);
+		error = step_into(nd, WALK_NOFOLLOW, parent);
 		if (unlikely(error))
 			return error;
 
@@ -2015,7 +2021,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	}
 	if (!(flags & WALK_MORE) && nd->depth)
 		put_link(nd);
-	return step_into(nd, flags, dentry, inode);
+	return step_into(nd, flags, dentry);
 }
 
 /*
@@ -2474,8 +2480,7 @@ static int handle_lookup_down(struct nameidata *nd)
 	if (!(nd->flags & LOOKUP_RCU))
 		dget(nd->path.dentry);
 	nd->next_seq = nd->seq;
-	return PTR_ERR(step_into(nd, WALK_NOFOLLOW,
-			nd->path.dentry, nd->inode));
+	return PTR_ERR(step_into(nd, WALK_NOFOLLOW, nd->path.dentry));
 }
 
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
@@ -3464,7 +3469,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 finish_lookup:
 	if (nd->depth)
 		put_link(nd);
-	res = step_into(nd, WALK_TRAILING, dentry, inode);
+	res = step_into(nd, WALK_TRAILING, dentry);
 	if (unlikely(res))
 		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
 	return res;
-- 
2.30.2

