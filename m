Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6578D56358D
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiGAOaY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiGAO3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:29:25 -0400
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200726D55F
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:25:24 -0700 (PDT)
Received: by mail-lf1-x14a.google.com with SMTP id b2-20020a0565120b8200b00477a4532448so1188440lfv.22
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iGvD4mfjvjSWX+nv6535woTSPAyHTTcU/sEMimyHpxI=;
        b=P7QKDp3hV6WoKSuU7RWtHYNnUzKsYPMuoVFYGC5CAEPmJ0nl1tQiRY+9OYfXLY42wB
         nFSOJB8BBflVDmdDuWSkOCm55g6bwX9dQkpXj4xCR6s6JCEls/jHSMNPkv+lVDZh5nKs
         hUARMca5KeTe+Ir0fpc6ZOi4Uq5KQZl/WLZTZOatCEOeYcao1NRgQlKKrm6iBVPu3X1Z
         JYhJ2HBgIVmRPYmPgcVuYdtvK/4rJXCJLuWe7FZ63qgHZC3DxwnGi+wOpBYOkbuzJh/f
         yrpShYElychLxpVWGpPbFszkIP0ovqs29G1ENpHftNUWpa2XkYBhGLzu4Zi+nYeVFrno
         cQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iGvD4mfjvjSWX+nv6535woTSPAyHTTcU/sEMimyHpxI=;
        b=W/bjruO9GyPHAoriEqzLSAeOyIgkU3u/QfxtTa6LnbKq6af25iSU+aYqqfV3fM3jfg
         jQ9jKXbyjU2k7oOUcpFpe7Tm1PZqYn9UmdMUmvTXUJVYIalZsZJHbDdhkJKdKblXE/Gd
         58OWO5p4GFYwrJ5D5lic+JbvNSuyqk8EV1VGuy4MAEm+QMg+sOdHOZONLcLHfKuwva0a
         ggc+VL4cLMp44tkxwIPdVP30ox4r74fXrU9M7t+Gdn40IGOle/uv+Se2T+t7WVizdWWX
         Tbmx5CsAOD6/s9JjseN2WgQGNFJwIkHBxOmPAY5It109iwL3QMQ5cWFEmLHxYiWCW5VK
         ZtOA==
X-Gm-Message-State: AJIora8EuEgrdaD8SLp+QzlgSIK6yKy+ixmRt04wCRB2hoC1WHodVEoL
        mQBDn5nRftZE5RYj7dfkuxOaEtjplyQ=
X-Google-Smtp-Source: AGRyM1s7QtTcOviesKYVgedtf1csh4E3jTJYd2DFNUsU1Lb1euL9e2M1gyfvpy9SPS5aVSID3ksrqFaDH6I=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6512:4c3:b0:47f:6f6e:a7e7 with SMTP id
 w3-20020a05651204c300b0047f6f6ea7e7mr9859006lfq.674.1656685518270; Fri, 01
 Jul 2022 07:25:18 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:09 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-45-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 44/45] mm: fs: initialize fsdata passed to
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
        autolearn=ham autolearn_force=no version=3.4.6
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
Link: https://linux-review.googlesource.com/id/I414f0ee3a164c9c335d91d82ce4558f6f2841471
---
 fs/buffer.c  | 4 ++--
 fs/namei.c   | 2 +-
 mm/filemap.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 898c7f301b1b9..d014009cff941 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2349,7 +2349,7 @@ int generic_cont_expand_simple(struct inode *inode, loff_t size)
 	struct address_space *mapping = inode->i_mapping;
 	const struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
-	void *fsdata;
+	void *fsdata = NULL;
 	int err;
 
 	err = inode_newsize_ok(inode, size);
@@ -2375,7 +2375,7 @@ static int cont_expand_zero(struct file *file, struct address_space *mapping,
 	const struct address_space_operations *aops = mapping->a_ops;
 	unsigned int blocksize = i_blocksize(inode);
 	struct page *page;
-	void *fsdata;
+	void *fsdata = NULL;
 	pgoff_t index, curidx;
 	loff_t curpos;
 	unsigned zerofrom, offset, len;
diff --git a/fs/namei.c b/fs/namei.c
index 6b39dfd3b41bc..5e3ff9d65f502 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5051,7 +5051,7 @@ int page_symlink(struct inode *inode, const char *symname, int len)
 	const struct address_space_operations *aops = mapping->a_ops;
 	bool nofs = !mapping_gfp_constraint(mapping, __GFP_FS);
 	struct page *page;
-	void *fsdata;
+	void *fsdata = NULL;
 	int err;
 	unsigned int flags;
 
diff --git a/mm/filemap.c b/mm/filemap.c
index ffdfbc8b0e3ca..72467f00f1916 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3753,7 +3753,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
 		unsigned long offset;	/* Offset into pagecache page */
 		unsigned long bytes;	/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
-		void *fsdata;
+		void *fsdata = NULL;
 
 		offset = (pos & (PAGE_SIZE - 1));
 		bytes = min_t(unsigned long, PAGE_SIZE - offset,
-- 
2.37.0.rc0.161.g10f37bed90-goog

