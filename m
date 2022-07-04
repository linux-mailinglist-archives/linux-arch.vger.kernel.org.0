Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678C5565FA8
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 01:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiGDXQS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 19:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiGDXQR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 19:16:17 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B9CEE2E;
        Mon,  4 Jul 2022 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pcS1G1OlD4As8AY5pL4+nnYUmzJ1Ij+cKL5OnlOGDmU=; b=cKBVkMzKga1zgdYpuIgEZr2KWm
        zjdiJ7f7CS9ldtxwhWWtw4sihmhQKxN5emZRaBS9jz9oA3R3eb4Fkn0a0W33nox7HdYLnDlUNr/6G
        Psnqt1jJ8P5QR61stJ3JMV8J8BK6v09kWn53QEem/iwCdtQiK8SOAE0JzlGgKcZhUucgh27Oiu7lz
        aEeRATnReUfEXNbJCvaw+b5VGNUQFSxoZFQlWyltWhQes+GKvAzBug15ufyERHzOHgL+7gmZiv59Z
        2NWA0siXYeeg03JY0lQiaEsGbaLecHbXYmxqaMIr48HJBBZzYvvCg2gGkGNKVjtlMc1NlrTtY5p/c
        WxOle0Wg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8VI2-008AZ2-Rt;
        Mon, 04 Jul 2022 23:15:38 +0000
Date:   Tue, 5 Jul 2022 00:15:38 +0100
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
Subject: [PATCH 5/7] follow_dotdot{,_rcu}(): don't bother with inode
Message-ID: <YsN0mtY5ecwW7MS3@ZenIV>
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

step_into() will fetch it, TYVM.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index dddbebf92b48..fe95fe39634c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1880,8 +1880,7 @@ static const char *step_into(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, flags);
 }
 
-static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
-					struct inode **inodep)
+static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
 {
 	struct dentry *parent, *old;
 
@@ -1905,7 +1904,6 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 	}
 	old = nd->path.dentry;
 	parent = old->d_parent;
-	*inodep = parent->d_inode;
 	nd->next_seq = read_seqcount_begin(&parent->d_seq);
 	// makes sure that non-RCU pathwalk could reach this state
 	if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
@@ -1919,12 +1917,10 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
 		return ERR_PTR(-ECHILD);
 	nd->next_seq = nd->seq;
-	*inodep = nd->path.dentry->d_inode;
 	return nd->path.dentry;
 }
 
-static struct dentry *follow_dotdot(struct nameidata *nd,
-				 struct inode **inodep)
+static struct dentry *follow_dotdot(struct nameidata *nd)
 {
 	struct dentry *parent;
 
@@ -1948,13 +1944,11 @@ static struct dentry *follow_dotdot(struct nameidata *nd,
 		dput(parent);
 		return ERR_PTR(-ENOENT);
 	}
-	*inodep = parent->d_inode;
 	return parent;
 
 in_root:
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
 		return ERR_PTR(-EXDEV);
-	*inodep = nd->path.dentry->d_inode;
 	return dget(nd->path.dentry);
 }
 
@@ -1963,7 +1957,6 @@ static const char *handle_dots(struct nameidata *nd, int type)
 	if (type == LAST_DOTDOT) {
 		const char *error = NULL;
 		struct dentry *parent;
-		struct inode *inode;
 
 		if (!nd->root.mnt) {
 			error = ERR_PTR(set_root(nd));
@@ -1971,9 +1964,9 @@ static const char *handle_dots(struct nameidata *nd, int type)
 				return error;
 		}
 		if (nd->flags & LOOKUP_RCU)
-			parent = follow_dotdot_rcu(nd, &inode);
+			parent = follow_dotdot_rcu(nd);
 		else
-			parent = follow_dotdot(nd, &inode);
+			parent = follow_dotdot(nd);
 		if (IS_ERR(parent))
 			return ERR_CAST(parent);
 		error = step_into(nd, WALK_NOFOLLOW, parent);
-- 
2.30.2

