Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0CE565F9D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 01:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiGDXOq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 19:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiGDXOq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 19:14:46 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A8FF5A2;
        Mon,  4 Jul 2022 16:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yVde6OT5Ehv5tuk0crezw61+e6oS2AMOyyAHAkO3zT4=; b=sWOTLQXmpJ5PfJPX0D6RfCVV8H
        y3xvhrfTU2W/13c3jKVExU64lREaPCNI3kLc87vy8xbN53d6RWOm7HLmvowNV6yO9umwHHEAxLltY
        g2fm+8ci7srGfVRTbgBwK/yZQXOgy3zEFEDvsGtjfdWGQoLQwIOshkKMw/1Kl9PU/RVxAYHUiWxNZ
        Mr9lfga8Boj5cohoAiN5fnfAx/unPr6CJUFNRlggKGbOWN085O604eoaLlqaIXnbM5inZ36arEOnz
        hbuh9jANU1BzNfmrKbsuK7nALZC7ZsGGbtXshIOeCy/+I8XqbB9DmkUwjfoHo6GSSZPD/NgZip9rM
        leAOLVMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o8VGd-008AW9-Ka;
        Mon, 04 Jul 2022 23:14:11 +0000
Date:   Tue, 5 Jul 2022 00:14:11 +0100
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
Subject: [PATCH 2/7] follow_dotdot{,_rcu}(): change calling conventions
Message-ID: <YsN0Qy5d69q6YWhS@ZenIV>
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

Instead of returning NULL when we are in root, just make it return
the current position (and set *seqp and *inodep accordingly).
That collapses the calls of step_into() in handle_dots()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4dbf55b37ec6..ecdb9ac21ece 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1909,7 +1909,9 @@ static struct dentry *follow_dotdot_rcu(struct nameidata *nd,
 		return ERR_PTR(-ECHILD);
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
 		return ERR_PTR(-ECHILD);
-	return NULL;
+	*seqp = nd->seq;
+	*inodep = nd->path.dentry->d_inode;
+	return nd->path.dentry;
 }
 
 static struct dentry *follow_dotdot(struct nameidata *nd,
@@ -1945,8 +1947,9 @@ static struct dentry *follow_dotdot(struct nameidata *nd,
 in_root:
 	if (unlikely(nd->flags & LOOKUP_BENEATH))
 		return ERR_PTR(-EXDEV);
-	dget(nd->path.dentry);
-	return NULL;
+	*seqp = 0;
+	*inodep = nd->path.dentry->d_inode;
+	return dget(nd->path.dentry);
 }
 
 static const char *handle_dots(struct nameidata *nd, int type)
@@ -1968,12 +1971,7 @@ static const char *handle_dots(struct nameidata *nd, int type)
 			parent = follow_dotdot(nd, &inode, &seq);
 		if (IS_ERR(parent))
 			return ERR_CAST(parent);
-		if (unlikely(!parent))
-			error = step_into(nd, WALK_NOFOLLOW,
-					 nd->path.dentry, nd->inode, nd->seq);
-		else
-			error = step_into(nd, WALK_NOFOLLOW,
-					 parent, inode, seq);
+		error = step_into(nd, WALK_NOFOLLOW, parent, inode, seq);
 		if (unlikely(error))
 			return error;
 
-- 
2.30.2

