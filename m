Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC865AD2E8
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiIEMeD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbiIEMdE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:33:04 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAAA61B00
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:26:58 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso5696025edd.9
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=RV5QTvMygwcM31S/hyrs6MnTkve28DlweGTrQchhxXo=;
        b=UJpdtPzQ4jg2bWxTTvLaBi+Ut8ibPGKpNFhDZh0iWTz3b+amhz6N+AZttgF2UwhDsT
         0LBgQGCXwZMpWRgLy4vET4fOKKKgXxY1KuDJisX2XchJTyi2VCCX2dm68m0DAAvKGjC4
         xIiTur2vx0OwVtk/WuhzSCK0dCMGsAVAL1CUqR69b/4FX/L7L9Ac2f05uDt/2u86QFT3
         sZ1YamUl4cHshGvep6afoqIL2W3pcn/R7pZmOmD+ro7M2AzkNlTp3ADlUIg3hz9E6cPD
         /LU/ibYLRJEjq+u+M10jxNd1fjPNCkgQzBqOq14Kbt19kwHHkgk2aqR1DyBMN6VYb1BR
         uz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=RV5QTvMygwcM31S/hyrs6MnTkve28DlweGTrQchhxXo=;
        b=niir5fW5gnhkLN1EyWiik2+LZUFYcKA+oeG7kr7ENN0gOJgbNa+xOIzRzdnxE7Qcvv
         3Cw/ChUvFRchqcjyVukXzNLj0JmIx1Srd/QJpidLtOFuImoIcbUckG9JUdUacQnIDeW1
         Ay3GDVuSqP4W1owZnnt5X34v2XryViB7VEZ+jteJfplJ/rrsEYWfUHOT5r6m47M9YI8Y
         IC3tpbCzvIiSC0pH3BzVEDOv5yYRrlFqdtegxiEMcKlMJb+XW+WF923JukEijwCjlrHV
         M5xqoqCygDdPUY6jUDqBybNj2o0ADM1sxEOI/R77MBZXdd/aMRS7j7sdSv5rHxsp5y5G
         fbQg==
X-Gm-Message-State: ACgBeo3tWbbSkCZ3zqFfSNqjAcY1Z+SqERGKyiu824rnAXbhcQMB2/JK
        m+H8WEVzhgUW1TwiDE5k8o/bzYSXcfM=
X-Google-Smtp-Source: AA6agR7PXaXryyLZJx+eRIAfaY6wz+72tUpar4Sm/m5k7H+ezMzVzMxUtwtMAFDWbsTMvDkpBpYpems7Myc=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:aa7:cb87:0:b0:43b:e650:6036 with SMTP id
 r7-20020aa7cb87000000b0043be6506036mr44092076edt.350.1662380816223; Mon, 05
 Sep 2022 05:26:56 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:51 +0200
In-Reply-To: <20220905122452.2258262-1-glider@google.com>
Mime-Version: 1.0
References: <20220905122452.2258262-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-44-glider@google.com>
Subject: [PATCH v6 43/44] mm: fs: initialize fsdata passed to
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
2.37.2.789.g6183377224-goog

