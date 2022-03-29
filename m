Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299CD4EAD41
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiC2MmY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiC2MmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:42:19 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32D20289A
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:34 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id c22-20020a50f616000000b004196649d144so10955671edn.10
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8AKHIAUMGhsnollvhsjHBd8Sk5jMCuogkkUw2fq2mio=;
        b=XcHMPrIunHEB7bnidvOWVqGkL2poJnCfl3iM5yKiBsKR6gSu8Wixo56EriIryx1DRp
         ygH60Tu95F9/meUZw/hUVe5ooSEvV4DUyL+AnjgINrfQqz23fqsQ/Urcza7iRtW9piEV
         THlnQvDWO68UWi/+f1lgxFSyUR51bTc8P/jVxtWV8kXPBWeM+/Vw42NYvsdPHbIvLwKl
         BtRHlbH4A6DhSIcH+duqkqgGkt1gIGp9zkGZLXy9w5ZW5bKRdMPnBS9mX2KVQ6Pv+KK4
         P1gagNsItDlHvWIoB7ysOglwXcmuxg7hOzImH2QfoKH5JQ//E60JCop3/Ya58UM8UMrt
         o7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8AKHIAUMGhsnollvhsjHBd8Sk5jMCuogkkUw2fq2mio=;
        b=KeXsxN7bz1aDLz1/4AQy7sqDAl/i4H4loDs1JmMD/flSwBwrwxTo0FRBDwEdr9+u7H
         VriOfqss0H08ZsoR0JP6OKuNG0M/FEI1xbNf6wtYwEXa0GHxvavNa+sgun4jmdR3Txbv
         YlLUJa92eFkMwh30RyN0c0SFHc1EBYUCLvmQ2A8J6jJFCfE9GSc7mCPqEFJG1JSVHzdu
         qOcjxPhwq6M+eBvab/Jlg9UT7FwW5CR1EadSVwW/OAT5n+0ZCwX+EWQ1E8NfwZS/3d/L
         Mgzx6W16uFxWFheWhHTBZTVQKqQWbwRLgT0CLvyqKnC3f6gnYnXNb7K05pXzAVDJTpIQ
         droA==
X-Gm-Message-State: AOAM532QQrUjzwGOvP6d4pjV8ylQrTCxy+SSqjzYh7ESw3OTxmjUTf4H
        ffeeMNlG9svxEt1paT4CTNguD2/q4WY=
X-Google-Smtp-Source: ABdhPJwvUW8uBcv5kN+9WJ7X27ALOaTkbkLM5E0yAmcoJPh2fi12GxrbHP+7afPcQ2MGB4Oun8BxCd/6FeU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:5d03:b0:6df:a042:d6d5 with SMTP id
 g3-20020a1709065d0300b006dfa042d6d5mr33258222ejt.678.1648557633185; Tue, 29
 Mar 2022 05:40:33 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:31 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-3-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 02/48] stackdepot: reserve 5 extra bits in depot_stack_handle_t
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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

Some users (currently only KMSAN) may want to use spare bits in
depot_stack_handle_t. Let them do so by adding @extra_bits to
__stack_depot_save() to store arbitrary flags, and providing
stack_depot_get_extra_bits() to retrieve those flags.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I0587f6c777667864768daf07821d594bce6d8ff9
---
 include/linux/stackdepot.h |  8 ++++++++
 lib/stackdepot.c           | 29 ++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 17f992fe6355b..fd641d266bead 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -14,9 +14,15 @@
 #include <linux/gfp.h>
 
 typedef u32 depot_stack_handle_t;
+/*
+ * Number of bits in the handle that stack depot doesn't use. Users may store
+ * information in them.
+ */
+#define STACK_DEPOT_EXTRA_BITS 5
 
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
+					unsigned int extra_bits,
 					gfp_t gfp_flags, bool can_alloc);
 
 /*
@@ -41,6 +47,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
+unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle);
+
 int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 		       int spaces);
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index bf5ba9af05009..6dc11a3b7b88e 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -42,7 +42,8 @@
 #define STACK_ALLOC_OFFSET_BITS (STACK_ALLOC_ORDER + PAGE_SHIFT - \
 					STACK_ALLOC_ALIGN)
 #define STACK_ALLOC_INDEX_BITS (DEPOT_STACK_BITS - \
-		STACK_ALLOC_NULL_PROTECTION_BITS - STACK_ALLOC_OFFSET_BITS)
+		STACK_ALLOC_NULL_PROTECTION_BITS - \
+		STACK_ALLOC_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
 #define STACK_ALLOC_SLABS_CAP 8192
 #define STACK_ALLOC_MAX_SLABS \
 	(((1LL << (STACK_ALLOC_INDEX_BITS)) < STACK_ALLOC_SLABS_CAP) ? \
@@ -55,6 +56,7 @@ union handle_parts {
 		u32 slabindex : STACK_ALLOC_INDEX_BITS;
 		u32 offset : STACK_ALLOC_OFFSET_BITS;
 		u32 valid : STACK_ALLOC_NULL_PROTECTION_BITS;
+		u32 extra : STACK_DEPOT_EXTRA_BITS;
 	};
 };
 
@@ -73,6 +75,14 @@ static int next_slab_inited;
 static size_t depot_offset;
 static DEFINE_RAW_SPINLOCK(depot_lock);
 
+unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
+{
+	union handle_parts parts = { .handle = handle };
+
+	return parts.extra;
+}
+EXPORT_SYMBOL(stack_depot_get_extra_bits);
+
 static bool init_stack_slab(void **prealloc)
 {
 	if (!*prealloc)
@@ -136,6 +146,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->handle.slabindex = depot_index;
 	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
 	stack->handle.valid = 1;
+	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	depot_offset += required_size;
 
@@ -320,6 +331,7 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
  *
  * @entries:		Pointer to storage array
  * @nr_entries:		Size of the storage array
+ * @extra_bits:		Flags to store in unused bits of depot_stack_handle_t
  * @alloc_flags:	Allocation gfp flags
  * @can_alloc:		Allocate stack slabs (increased chance of failure if false)
  *
@@ -331,6 +343,10 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
  * If the stack trace in @entries is from an interrupt, only the portion up to
  * interrupt entry is saved.
  *
+ * Additional opaque flags can be passed in @extra_bits, stored in the unused
+ * bits of the stack handle, and retrieved using stack_depot_get_extra_bits()
+ * without calling stack_depot_fetch().
+ *
  * Context: Any context, but setting @can_alloc to %false is required if
  *          alloc_pages() cannot be used from the current context. Currently
  *          this is the case from contexts where neither %GFP_ATOMIC nor
@@ -340,10 +356,11 @@ EXPORT_SYMBOL_GPL(stack_depot_fetch);
  */
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
+					unsigned int extra_bits,
 					gfp_t alloc_flags, bool can_alloc)
 {
 	struct stack_record *found = NULL, **bucket;
-	depot_stack_handle_t retval = 0;
+	union handle_parts retval = { .handle = 0 };
 	struct page *page = NULL;
 	void *prealloc = NULL;
 	unsigned long flags;
@@ -427,9 +444,11 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		free_pages((unsigned long)prealloc, STACK_ALLOC_ORDER);
 	}
 	if (found)
-		retval = found->handle.handle;
+		retval.handle = found->handle.handle;
 fast_exit:
-	return retval;
+	retval.extra = extra_bits;
+
+	return retval.handle;
 }
 EXPORT_SYMBOL_GPL(__stack_depot_save);
 
@@ -449,6 +468,6 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries,
 				      gfp_t alloc_flags)
 {
-	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
+	return __stack_depot_save(entries, nr_entries, 0, alloc_flags, true);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
-- 
2.35.1.1021.g381101b075-goog

