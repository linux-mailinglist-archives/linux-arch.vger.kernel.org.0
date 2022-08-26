Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65F45A2AE4
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbiHZPQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbiHZPPj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:15:39 -0400
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C543A4AF
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:16 -0700 (PDT)
Received: by mail-lj1-x249.google.com with SMTP id d4-20020a2e9284000000b0025e0f56d216so664836ljh.7
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=dGjdyFKcPZ8AZlzw9ep1EXgYBHGgW0m7GguSz7kBI6Q=;
        b=DZGsI9l3W9MQLA+ou9XdSB4IZE46ComuEd6rS14iWZ0xSDfAJ+BWwB8A7M05fO5zjT
         Wh7mYAH6WAAzh+FI/uVm5Ljcf9NEeu2Z9UZM+4qfZzFoj+6Fh/tecr4Yol7TBl6MiU/L
         tCTqBg9m2iJte3DzNqf8V7ws94Br5Wtp68vVWk7plrk6xmxEjPcPZVSvIrk/LnFF/INL
         93xvlWF5Ha1xHXpbxLntxctwzalog3vxzBxrVMuGDkqbsYK5RzyESy+/nuRwFZ41sSYu
         t2owLKhR+yzd+pCanHFbrVCWUmN1zsn8mhRcH/6ROVVHuRMuA9Jhn32qCWbGf06hi10p
         XV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=dGjdyFKcPZ8AZlzw9ep1EXgYBHGgW0m7GguSz7kBI6Q=;
        b=cqIugL/KXvKBQo6BOUlnjJvJbhrz/2wgwcIjWjk4ZQe5bVR6ldy+wFRok+uHA9lnPP
         2sOdFa2qrEq+Ac8+QOxHLtSS4ydyiTmDypUVvM6e2pl4ulaObcOjp7oAOzt9y6hTh4yX
         TWIU/O6AHaG99TAUZb2fVrT8qRfYvxvkdpRUZKANsP89+mNpLW/57ZOcj7QDWeYBjTxC
         +l6b7V4YgtedgVLhet95DV3oZBaOjDS8+9gjtwRAS0rdT4Tq7ue+G1N9yhwT+wScYr/y
         S79YUywK8EB+HUFSac2wgnP6MBxume62n5f4DrKW2rLw71qH9hc7q1ZVaBka2gQuO1MC
         CEqQ==
X-Gm-Message-State: ACgBeo1CBBSHqS9NOpHH0egQuo0D+29fJ5OSPojaQZ6+UxfVI5X2mksg
        EgnfpqdHPc9cHAPvnlHZQBpMCjqZ/Ts=
X-Google-Smtp-Source: AA6agR5+Ww/s7u4XD1azUk5I5ZYmSipZxiExxoopJysRcyPZ8zjk++GJnOf429p9ygUYKujEBktJ1Rf+Pzg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a05:6512:3054:b0:48a:f489:1d68 with SMTP id
 b20-20020a056512305400b0048af4891d68mr2401202lfb.260.1661526613226; Fri, 26
 Aug 2022 08:10:13 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:08:06 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-44-glider@google.com>
Subject: [PATCH v5 43/44] mm: fs: initialize fsdata passed to
 write_begin/write_end interface
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Functions implementing the a_ops->write_end() interface accept the
`void *fsdata` parameter that is supposed to be initialized by the
corresponding a_ops->write_begin() (which accepts `void **fsdata`).

However not all a_ops->write_begin() implementations initialize `fsdata`
unconditionally, so it may get passed uninitialized to a_ops->write_end(),
resulting in undefined behavior.

Fix this by initializing fsdata with NULL before the call to
write_begin(), rather than doing so in all possible a_ops
implementations.

This patch covers only the following cases found by running x86 KMSAN
under syzkaller:

 - generic_perform_write()
 - cont_expand_zero() and generic_cont_expand_simple()
 - page_symlink()

Other cases of passing uninitialized fsdata may persist in the codebase.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/Ie300c21bbe9dea69a730745bd3c6d2720953bf41
---
 fs/buffer.c  | 4 ++--
 fs/namei.c   | 2 +-
 mm/filemap.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 55e762a58eb65..e1198f4b28c8f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2352,7 +2352,7 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	struct address_space *mapping = inode->i_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
-	void *fsdata;
+	void *fsdata = NULL;
 	int err;
 
 	err = inode_newsize_ok(inode, size);
@@ -2378,7 +2378,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 	const struct address_space_operations *aops = mapping->a_ops;
 	unsigned int blocksize = i_blocksize(inode);
 	struct page *page;
-	void *fsdata;
+	void *fsdata = NULL;
 	pgoff_t index, curidx;
 	loff_t curpos;
 	unsigned zerofrom, offset, len;
diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db23..076ae96ca0b14 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5088,7 +5088,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 	const struct address_space_operations *aops = mapping->a_ops;
 	bool nofs = !mapping_gfp_constraint(mapping, __GFP_FS);
 	struct page *page;
-	void *fsdata;
+	void *fsdata = NULL;
 	int err;
 	unsigned int flags;
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b3..ada25b9f45ad1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3712,7 +3712,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
-		void *fsdata;
+		void *fsdata = NULL;
 
 		offset = (pos & (PAGE_SIZE - 1));
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
-- 
2.37.2.672.g94769d06f0-goog

