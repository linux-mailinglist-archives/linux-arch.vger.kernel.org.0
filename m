Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BEB565FAA
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 01:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiGDXRM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 19:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiGDXRK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 19:17:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDCFD34;
        Mon,  4 Jul 2022 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Krii5I77Jw+hei/sBgWu8KHpDCvwQjbHpsrcFH98j0=; b=uElzEPYgfvz4HqmD+jumc9o+co
        4FBZ1pk6PQNTVkvgkjC3MG/06CMseIjjitUto8/QeQHUXagTnvCAb8W+wHbp1y+0PE25vMAraPymx
        pBAJ4BMdkPHC4yk0lGril6Ldu8tC5JGT0Ml+TECjtL6OilAzpuMUAyPtb9cJUdoUTEvBCQtpjFquv
        0ntqwDI+dNPzFIbuATQVwTTHzP/8gnaQgebhuvBNkx+pXafGftvZA1vS2d0sUaRd03mRrbJ/zdcOl
        A9gsBQXfx0pOAYR+qkLXUUl3bc7YsHFODJwB0eH4w3dZ3PfPoU5deV+z1cNtvWmo/zpxgRyi7OsVt
        1tUxiT6A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8VIs-008AbM-Q3;
        Mon, 04 Jul 2022 23:16:31 +0000
Date:   Tue, 5 Jul 2022 00:16:30 +0100
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
Subject: [PATCH 6/7] lookup_fast(): don't bother with inode
Message-ID: <YsN0zovcB+d26OcT@ZenIV>
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

Note that validation of ->d_seq after ->d_inode fetch is gone, along
with fetching of ->d_inode itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index fe95fe39634c..cdb61d09df79 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1617,8 +1617,7 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	return dentry;
 }
 
-static struct dentry *lookup_fast(struct nameidata *nd,
-				  struct inode **inode)
+static struct dentry *lookup_fast(struct nameidata *nd)
 {
 	struct dentry *dentry, *parent = nd->path.dentry;
 	int status = 1;
@@ -1636,22 +1635,11 @@ static struct dentry *lookup_fast(struct nameidata *nd,
 			return NULL;
 		}
 
-		/*
-		 * This sequence count validates that the inode matches
-		 * the dentry name information from lookup.
-		 */
-		*inode = d_backing_inode(dentry);
-		if (unlikely(read_seqcount_retry(&dentry->d_seq, nd->next_seq)))
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
 
 		status = d_revalidate(dentry, nd->flags);
@@ -1993,7 +1981,6 @@ static const char *handle_dots(struct nameidata *nd, int type)
 static const char *walk_component(struct nameidata *nd, int flags)
 {
 	struct dentry *dentry;
-	struct inode *inode;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
 	 * to be able to know about the current root directory and
@@ -2004,7 +1991,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
 	}
-	dentry = lookup_fast(nd, &inode);
+	dentry = lookup_fast(nd);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry);
 	if (unlikely(!dentry)) {
@@ -3392,7 +3379,6 @@ static const char *open_last_lookups(struct nameidata *nd,
 	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
 	bool got_write = false;
-	struct inode *inode;
 	struct dentry *dentry;
 	const char *res;
 
@@ -3408,7 +3394,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		if (nd->last.name[nd->last.len])
 			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 		/* we _can_ be in RCU mode here */
-		dentry = lookup_fast(nd, &inode);
+		dentry = lookup_fast(nd);
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 		if (likely(dentry))
-- 
2.30.2

