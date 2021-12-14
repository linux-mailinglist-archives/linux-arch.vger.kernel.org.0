Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059F14747AF
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhLNQWq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbhLNQWb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:22:31 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36719C061757
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:30 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id q7-20020adff507000000b0017d160d35a8so4852123wro.4
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GdDeleqLQ5zJ/B8ZGsG4G+WeJyFxizBURfvIO90L+BA=;
        b=kF2VtMfaNQ0VNPcEcS8aivUWwnDvw2kZYtiPFn7NOHksQW6cuRBK8DI+MW+gn5yo9O
         XRLaYffQnkKurb9JtQj348/hHQ0MDFBlQjaNrD7kvd1e6DQ43zwgbNRnUxXIkEKB7vaZ
         5v4Yeuo/x+wItqVvwe+bmBs1Sj3nt0rYsK9wfR3vgBG2322pTxOrmNYZa53okeQTzlU2
         vKjY4dgo/O7gBuJfJ3N6JMOUfM0zvo8vNS+Fq4hSlRQT2ybqHiySX67eJn0EkZ+pvywU
         7Yh0kIvTtHPc3yPLZd6sNVhGvkCtFiMTg11/03szUWnupeCiA9RFGXX8UJSIWxpxymmt
         hHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GdDeleqLQ5zJ/B8ZGsG4G+WeJyFxizBURfvIO90L+BA=;
        b=ZjFQv5Cwt1vou1P9XJynNxT1tPwHSMtTWNJiJEo52T0fWtlhhgkTWYXsdj1gbc+N6s
         d/o2fcvFpiQJX6soiMnqB6WRQe5oPaX6ZJ7aS1Qwr4nnle5D4SnNcUNShh+MkKb2z6da
         A7B6Uj4waoexkq1KDGYfc7cca5PC32dSITTIih4J8WNho245RVSN3wDZad24bpGGTF7T
         MCBfKHmNa6EbejAbWjco6v7mr2IBNm5WMg7jDL2MjA18Px9XqUUNSB/IiS1ApQsVmd5p
         enivV6CaKQ5UNJifEKWIeQzi5O62q+omWAgNuJeHGpxEz/nssPwDeUwcZLjGDNZwixCK
         CnIQ==
X-Gm-Message-State: AOAM533NQ5I50zRWCR8QHCBvtwg/2WuOwJzMwRFfIw/DPDXTB0h4CKzb
        0XhyOqns03S/3NPhsQVApC8E5+Q37/8=
X-Google-Smtp-Source: ABdhPJyqRJvDZz7d4NuEwx8Pl1IG3FwbEQjLq1KRRnOTzBy9P9QqdjYDBOcwOcSmBZCiVi66lxCVelhNvmw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a5d:66cb:: with SMTP id k11mr7059807wrw.253.1639498948793;
 Tue, 14 Dec 2021 08:22:28 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:20 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-14-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 13/43] kmsan: add KMSAN runtime core
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds the core parts of KMSAN runtime and associated files:

  - include/linux/kmsan-checks.h: user API to poison/unpoison/check
    the kernel memory;
  - include/linux/kmsan.h: declarations of KMSAN hooks to be referenced
    outside of KMSAN runtime;
  - lib/Kconfig.kmsan: CONFIG_KMSAN and related declarations;
  - Makefile, mm/Makefile, mm/kmsan/Makefile: boilerplate Makefile code;
  - mm/kmsan/annotations.c: non-inlineable implementation of KMSAN_INIT();
  - mm/kmsan/core.c: core functions that operate with shadow and origin
    memory and perform checks, utility functions;
  - mm/kmsan/hooks.c: KMSAN hooks for kernel subsystems;
  - mm/kmsan/init.c: KMSAN initialization routines;
  - mm/kmsan/instrumentation.c: functions called by KMSAN instrumentation;
  - mm/kmsan/kmsan.h: internal KMSAN declarations;
  - mm/kmsan/shadow.c: routines that encapsulate metadata creation and
    addressing;
  - scripts/Makefile.kmsan: CFLAGS_KMSAN
  - scripts/Makefile.lib: KMSAN_SANITIZE and KMSAN_ENABLE_CHECKS macros

The patch also adds the necessary bookkeeping bits to struct page and
struct task_struct:
 - each struct page now contains pointers to two struct pages holding
   KMSAN metadata (shadow and origins) for the original struct page;
 - each task_struct contains a struct kmsan_task_state used to track
   the metadata of function parameters and return values for that task.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I9b71bfe3425466c97159f9de0062e5e8e4fec866
---
 Makefile                     |   1 +
 include/linux/kmsan-checks.h | 123 ++++++++++
 include/linux/kmsan.h        | 365 ++++++++++++++++++++++++++++++
 include/linux/mm_types.h     |  12 +
 include/linux/sched.h        |   5 +
 lib/Kconfig.debug            |   1 +
 lib/Kconfig.kmsan            |  18 ++
 mm/Makefile                  |   1 +
 mm/kmsan/Makefile            |  22 ++
 mm/kmsan/annotations.c       |  28 +++
 mm/kmsan/core.c              | 427 +++++++++++++++++++++++++++++++++++
 mm/kmsan/hooks.c             | 400 ++++++++++++++++++++++++++++++++
 mm/kmsan/init.c              | 238 +++++++++++++++++++
 mm/kmsan/instrumentation.c   | 233 +++++++++++++++++++
 mm/kmsan/kmsan.h             | 197 ++++++++++++++++
 mm/kmsan/report.c            | 210 +++++++++++++++++
 mm/kmsan/shadow.c            | 332 +++++++++++++++++++++++++++
 scripts/Makefile.kmsan       |   1 +
 scripts/Makefile.lib         |   9 +
 19 files changed, 2623 insertions(+)
 create mode 100644 include/linux/kmsan-checks.h
 create mode 100644 include/linux/kmsan.h
 create mode 100644 lib/Kconfig.kmsan
 create mode 100644 mm/kmsan/Makefile
 create mode 100644 mm/kmsan/annotations.c
 create mode 100644 mm/kmsan/core.c
 create mode 100644 mm/kmsan/hooks.c
 create mode 100644 mm/kmsan/init.c
 create mode 100644 mm/kmsan/instrumentation.c
 create mode 100644 mm/kmsan/kmsan.h
 create mode 100644 mm/kmsan/report.c
 create mode 100644 mm/kmsan/shadow.c
 create mode 100644 scripts/Makefile.kmsan

diff --git a/Makefile b/Makefile
index 765115c99655f..7af3edfb2d0de 100644
--- a/Makefile
+++ b/Makefile
@@ -1012,6 +1012,7 @@ include-y			:= scripts/Makefile.extrawarn
 include-$(CONFIG_DEBUG_INFO)	+= scripts/Makefile.debug
 include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
 include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
+include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
 include-$(CONFIG_UBSAN)		+= scripts/Makefile.ubsan
 include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
 include-$(CONFIG_GCC_PLUGINS)	+= scripts/Makefile.gcc-plugins
diff --git a/include/linux/kmsan-checks.h b/include/linux/kmsan-checks.h
new file mode 100644
index 0000000000000..d41868c723d1e
--- /dev/null
+++ b/include/linux/kmsan-checks.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KMSAN checks to be used for one-off annotations in subsystems.
+ *
+ * Copyright (C) 2017-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#ifndef _LINUX_KMSAN_CHECKS_H
+#define _LINUX_KMSAN_CHECKS_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_KMSAN
+
+/*
+ * Helper functions that mark the return value initialized.
+ * See mm/kmsan/annotations.c.
+ */
+u8 kmsan_init_1(u8 value);
+u16 kmsan_init_2(u16 value);
+u32 kmsan_init_4(u32 value);
+u64 kmsan_init_8(u64 value);
+
+static inline void *kmsan_init_ptr(void *ptr)
+{
+	return (void *)kmsan_init_8((u64)ptr);
+}
+
+static inline char kmsan_init_char(char value)
+{
+	return (u8)kmsan_init_1((u8)value);
+}
+
+#define __decl_kmsan_init_type(type, fn) unsigned type : fn, signed type : fn
+
+/**
+ * kmsan_init - Make the value initialized.
+ * @val: 1-, 2-, 4- or 8-byte integer that may be treated as uninitialized by
+ *       KMSAN.
+ *
+ * Return: value of @val that KMSAN treats as initialized.
+ */
+#define kmsan_init(val)                                                        \
+	(							\
+	(typeof(val))(_Generic((val),				\
+		__decl_kmsan_init_type(char, kmsan_init_1),	\
+		__decl_kmsan_init_type(short, kmsan_init_2),	\
+		__decl_kmsan_init_type(int, kmsan_init_4),	\
+		__decl_kmsan_init_type(long, kmsan_init_8),	\
+		char : kmsan_init_char,				\
+		void * : kmsan_init_ptr)(val)))
+
+/**
+ * kmsan_poison_memory() - Mark the memory range as uninitialized.
+ * @address: address to start with.
+ * @size:    size of buffer to poison.
+ * @flags:   GFP flags for allocations done by this function.
+ *
+ * Until other data is written to this range, KMSAN will treat it as
+ * uninitialized. Error reports for this memory will reference the call site of
+ * kmsan_poison_memory() as origin.
+ */
+void kmsan_poison_memory(const void *address, size_t size, gfp_t flags);
+
+/**
+ * kmsan_unpoison_memory() -  Mark the memory range as initialized.
+ * @address: address to start with.
+ * @size:    size of buffer to unpoison.
+ *
+ * Until other data is written to this range, KMSAN will treat it as
+ * initialized.
+ */
+void kmsan_unpoison_memory(const void *address, size_t size);
+
+/**
+ * kmsan_check_memory() - Check the memory range for being initialized.
+ * @address: address to start with.
+ * @size:    size of buffer to check.
+ *
+ * If any piece of the given range is marked as uninitialized, KMSAN will report
+ * an error.
+ */
+void kmsan_check_memory(const void *address, size_t size);
+
+/**
+ * kmsan_copy_to_user() - Notify KMSAN about a data transfer to userspace.
+ * @to:      destination address in the userspace.
+ * @from:    source address in the kernel.
+ * @to_copy: number of bytes to copy.
+ * @left:    number of bytes not copied.
+ *
+ * If this is a real userspace data transfer, KMSAN checks the bytes that were
+ * actually copied to ensure there was no information leak. If @to belongs to
+ * the kernel space (which is possible for compat syscalls), KMSAN just copies
+ * the metadata.
+ */
+void kmsan_copy_to_user(const void *to, const void *from, size_t to_copy,
+			size_t left);
+
+#else
+
+#define kmsan_init(value) (value)
+
+static inline void kmsan_poison_memory(const void *address, size_t size,
+				       gfp_t flags)
+{
+}
+static inline void kmsan_unpoison_memory(const void *address, size_t size)
+{
+}
+static inline void kmsan_check_memory(const void *address, size_t size)
+{
+}
+static inline void kmsan_copy_to_user(const void *to, const void *from,
+				      size_t to_copy, size_t left)
+{
+}
+
+#endif
+
+#endif /* _LINUX_KMSAN_CHECKS_H */
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
new file mode 100644
index 0000000000000..f17bc9ded7b97
--- /dev/null
+++ b/include/linux/kmsan.h
@@ -0,0 +1,365 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KMSAN API for subsystems.
+ *
+ * Copyright (C) 2017-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+#ifndef _LINUX_KMSAN_H
+#define _LINUX_KMSAN_H
+
+#include <linux/dma-direction.h>
+#include <linux/gfp.h>
+#include <linux/kmsan-checks.h>
+#include <linux/stackdepot.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+
+struct page;
+struct kmem_cache;
+struct task_struct;
+struct scatterlist;
+struct urb;
+
+#ifdef CONFIG_KMSAN
+
+/* These constants are defined in the MSan LLVM instrumentation pass. */
+#define KMSAN_RETVAL_SIZE 800
+#define KMSAN_PARAM_SIZE 800
+
+struct kmsan_context_state {
+	char param_tls[KMSAN_PARAM_SIZE];
+	char retval_tls[KMSAN_RETVAL_SIZE];
+	char va_arg_tls[KMSAN_PARAM_SIZE];
+	char va_arg_origin_tls[KMSAN_PARAM_SIZE];
+	u64 va_arg_overflow_size_tls;
+	char param_origin_tls[KMSAN_PARAM_SIZE];
+	depot_stack_handle_t retval_origin_tls;
+};
+
+#undef KMSAN_PARAM_SIZE
+#undef KMSAN_RETVAL_SIZE
+
+struct kmsan_ctx {
+	struct kmsan_context_state cstate;
+	int kmsan_in_runtime;
+	bool allow_reporting;
+};
+
+/**
+ * kmsan_init_shadow() - Initialize KMSAN shadow at boot time.
+ *
+ * Allocate and initialize KMSAN metadata for early allocations.
+ */
+void __init kmsan_init_shadow(void);
+
+/**
+ * kmsan_init_runtime() - Initialize KMSAN state and enable KMSAN.
+ */
+void __init kmsan_init_runtime(void);
+
+/**
+ * kmsan_memblock_free_pages() - handle freeing of memblock pages.
+ * @page:	struct page to free.
+ * @order:	order of @page.
+ *
+ * Freed pages are either returned to buddy allocator or held back to be used
+ * as metadata pages.
+ */
+bool __init kmsan_memblock_free_pages(struct page *page, unsigned int order);
+
+/**
+ * kmsan_task_create() - Initialize KMSAN state for the task.
+ * @task: task to initialize.
+ */
+void kmsan_task_create(struct task_struct *task);
+
+/**
+ * kmsan_task_exit() - Notify KMSAN that a task has exited.
+ * @task: task about to finish.
+ */
+void kmsan_task_exit(struct task_struct *task);
+
+/**
+ * kmsan_alloc_page() - Notify KMSAN about an alloc_pages() call.
+ * @page:  struct page pointer returned by alloc_pages().
+ * @order: order of allocated struct page.
+ * @flags: GFP flags used by alloc_pages()
+ *
+ * KMSAN marks 1<<@order pages starting at @page as uninitialized, unless
+ * @flags contain __GFP_ZERO.
+ */
+void kmsan_alloc_page(struct page *page, unsigned int order, gfp_t flags);
+
+/**
+ * kmsan_free_page() - Notify KMSAN about a free_pages() call.
+ * @page:  struct page pointer passed to free_pages().
+ * @order: order of deallocated struct page.
+ *
+ * KMSAN marks freed memory as uninitialized.
+ */
+void kmsan_free_page(struct page *page, unsigned int order);
+
+/**
+ * kmsan_copy_page_meta() - Copy KMSAN metadata between two pages.
+ * @dst: destination page.
+ * @src: source page.
+ *
+ * KMSAN copies the contents of metadata pages for @src into the metadata pages
+ * for @dst. If @dst has no associated metadata pages, nothing happens.
+ * If @src has no associated metadata pages, @dst metadata pages are unpoisoned.
+ */
+void kmsan_copy_page_meta(struct page *dst, struct page *src);
+
+/**
+ * kmsan_gup_pgd_range() - Notify KMSAN about a gup_pgd_range() call.
+ * @pages: array of struct page pointers.
+ * @nr:    array size.
+ *
+ * gup_pgd_range() creates new pages, some of which may belong to the userspace
+ * memory. In that case KMSAN marks them as initialized.
+ */
+void kmsan_gup_pgd_range(struct page **pages, int nr);
+
+/**
+ * kmsan_slab_alloc() - Notify KMSAN about a slab allocation.
+ * @s:      slab cache the object belongs to.
+ * @object: object pointer.
+ * @flags:  GFP flags passed to the allocator.
+ *
+ * Depending on cache flags and GFP flags, KMSAN sets up the metadata of the
+ * newly created object, marking it as initialized or uninitialized.
+ */
+void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
+
+/**
+ * kmsan_slab_free() - Notify KMSAN about a slab deallocation.
+ * @s:      slab cache the object belongs to.
+ * @object: object pointer.
+ *
+ * KMSAN marks the freed object as uninitialized.
+ */
+void kmsan_slab_free(struct kmem_cache *s, void *object);
+
+/**
+ * kmsan_kmalloc_large() - Notify KMSAN about a large slab allocation.
+ * @ptr:   object pointer.
+ * @size:  object size.
+ * @flags: GFP flags passed to the allocator.
+ *
+ * Similar to kmsan_slab_alloc(), but for large allocations.
+ */
+void kmsan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
+
+/**
+ * kmsan_kfree_large() - Notify KMSAN about a large slab deallocation.
+ * @ptr: object pointer.
+ *
+ * Similar to kmsan_slab_free(), but for large allocations.
+ */
+void kmsan_kfree_large(const void *ptr);
+
+/**
+ * kmsan_map_kernel_range_noflush() - Notify KMSAN about a vmap.
+ * @start:	start of vmapped range.
+ * @end:	end of vmapped range.
+ * @prot:	page protection flags used for vmap.
+ * @pages:	array of pages.
+ * @page_shift:	page_shift passed to vmap_range_noflush().
+ *
+ * KMSAN maps shadow and origin pages of @pages into contiguous ranges in
+ * vmalloc metadata address range.
+ */
+void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
+				    pgprot_t prot, struct page **pages,
+				    unsigned int page_shift);
+
+/**
+ * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
+ * @start: start of vunmapped range.
+ * @end:   end of vunmapped range.
+ *
+ * KMSAN unmaps the contiguous metadata ranges created by
+ * kmsan_map_kernel_range_noflush().
+ */
+void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
+
+/**
+ * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_range() call.
+ * @addr:	range start.
+ * @end:	range end.
+ * @phys_addr:	physical range start.
+ * @prot:	page protection flags used for ioremap_page_range().
+ * @page_shift:	page_shift argument passed to vmap_range_noflush().
+ *
+ * KMSAN creates new metadata pages for the physical pages mapped into the
+ * virtual memory.
+ */
+void kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
+			      phys_addr_t phys_addr, pgprot_t prot,
+			      unsigned int page_shift);
+
+/**
+ * kmsan_iounmap_page_range() - Notify KMSAN about a iounmap_page_range() call.
+ * @start: range start.
+ * @end:   range end.
+ *
+ * KMSAN unmaps the metadata pages for the given range and, unlike for
+ * vunmap_page_range(), also deallocates them.
+ */
+void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
+
+/**
+ * kmsan_handle_dma() - Handle a DMA data transfer.
+ * @page:   first page of the buffer.
+ * @offset: offset of the buffer within the first page.
+ * @size:   buffer size.
+ * @dir:    one of possible dma_data_direction values.
+ *
+ * Depending on @direction, KMSAN:
+ * * checks the buffer, if it is copied to device;
+ * * initializes the buffer, if it is copied from device;
+ * * does both, if this is a DMA_BIDIRECTIONAL transfer.
+ */
+void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
+		      enum dma_data_direction dir);
+
+/**
+ * kmsan_handle_dma_sg() - Handle a DMA transfer using scatterlist.
+ * @sg:    scatterlist holding DMA buffers.
+ * @nents: number of scatterlist entries.
+ * @dir:   one of possible dma_data_direction values.
+ *
+ * Depending on @direction, KMSAN:
+ * * checks the buffers in the scatterlist, if they are copied to device;
+ * * initializes the buffers, if they are copied from device;
+ * * does both, if this is a DMA_BIDIRECTIONAL transfer.
+ */
+void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
+			 enum dma_data_direction dir);
+
+/**
+ * kmsan_handle_urb() - Handle a USB data transfer.
+ * @urb:    struct urb pointer.
+ * @is_out: data transfer direction (true means output to hardware).
+ *
+ * If @is_out is true, KMSAN checks the transfer buffer of @urb. Otherwise,
+ * KMSAN initializes the transfer buffer.
+ */
+void kmsan_handle_urb(const struct urb *urb, bool is_out);
+
+/**
+ * kmsan_instrumentation_begin() - handle instrumentation_begin().
+ * @regs: pointer to struct pt_regs that non-instrumented code passes to
+ *        instrumented code.
+ */
+void kmsan_instrumentation_begin(struct pt_regs *regs);
+
+#else
+
+static inline void kmsan_init_shadow(void)
+{
+}
+
+static inline void kmsan_init_runtime(void)
+{
+}
+
+static inline bool kmsan_memblock_free_pages(struct page *page,
+					     unsigned int order)
+{
+	return true;
+}
+
+static inline void kmsan_task_create(struct task_struct *task)
+{
+}
+
+static inline void kmsan_task_exit(struct task_struct *task)
+{
+}
+
+static inline int kmsan_alloc_page(struct page *page, unsigned int order,
+				   gfp_t flags)
+{
+	return 0;
+}
+
+static inline void kmsan_free_page(struct page *page, unsigned int order)
+{
+}
+
+static inline void kmsan_copy_page_meta(struct page *dst, struct page *src)
+{
+}
+
+static inline void kmsan_gup_pgd_range(struct page **pages, int nr)
+{
+}
+
+static inline void kmsan_slab_alloc(struct kmem_cache *s, void *object,
+				    gfp_t flags)
+{
+}
+
+static inline void kmsan_slab_free(struct kmem_cache *s, void *object)
+{
+}
+
+static inline void kmsan_kmalloc_large(const void *ptr, size_t size,
+				       gfp_t flags)
+{
+}
+
+static inline void kmsan_kfree_large(const void *ptr)
+{
+}
+
+static inline void kmsan_vmap_pages_range_noflush(unsigned long start,
+						  unsigned long end,
+						  pgprot_t prot,
+						  struct page **pages,
+						  unsigned int page_shift)
+{
+}
+
+static inline void kmsan_vunmap_range_noflush(unsigned long start,
+					      unsigned long end)
+{
+}
+
+static inline void kmsan_ioremap_page_range(unsigned long start,
+					    unsigned long end,
+					    phys_addr_t phys_addr,
+					    pgprot_t prot,
+					    unsigned int page_shift)
+{
+}
+
+static inline void kmsan_iounmap_page_range(unsigned long start,
+					    unsigned long end)
+{
+}
+
+static inline void kmsan_handle_dma(struct page *page, size_t offset,
+				    size_t size, enum dma_data_direction dir)
+{
+}
+
+static inline void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
+				       enum dma_data_direction dir)
+{
+}
+
+static inline void kmsan_handle_urb(const struct urb *urb, bool is_out)
+{
+}
+
+static inline void kmsan_instrumentation_begin(struct pt_regs *regs)
+{
+}
+
+#endif
+
+#endif /* _LINUX_KMSAN_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c3a6e62096006..bdbe4b39b826d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -233,6 +233,18 @@ struct page {
 					   not kmapped, ie. highmem) */
 #endif /* WANT_PAGE_VIRTUAL */
 
+#ifdef CONFIG_KMSAN
+	/*
+	 * KMSAN metadata for this page:
+	 *  - shadow page: every bit indicates whether the corresponding
+	 *    bit of the original page is initialized (0) or not (1);
+	 *  - origin page: every 4 bytes contain an id of the stack trace
+	 *    where the uninitialized value was created.
+	 */
+	struct page *kmsan_shadow;
+	struct page *kmsan_origin;
+#endif
+
 #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
 	int _last_cpupid;
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec6..8d076f82d5072 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -14,6 +14,7 @@
 #include <linux/pid.h>
 #include <linux/sem.h>
 #include <linux/shm.h>
+#include <linux/kmsan.h>
 #include <linux/mutex.h>
 #include <linux/plist.h>
 #include <linux/hrtimer.h>
@@ -1341,6 +1342,10 @@ struct task_struct {
 #endif
 #endif
 
+#ifdef CONFIG_KMSAN
+	struct kmsan_ctx		kmsan_ctx;
+#endif
+
 #if IS_ENABLED(CONFIG_KUNIT)
 	struct kunit			*kunit_test;
 #endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5e14e32056add..304374f2c300a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -963,6 +963,7 @@ config DEBUG_STACKOVERFLOW
 
 source "lib/Kconfig.kasan"
 source "lib/Kconfig.kfence"
+source "lib/Kconfig.kmsan"
 
 endmenu # "Memory Debugging"
 
diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
new file mode 100644
index 0000000000000..02fd6db792b1f
--- /dev/null
+++ b/lib/Kconfig.kmsan
@@ -0,0 +1,18 @@
+config HAVE_ARCH_KMSAN
+	bool
+
+config HAVE_KMSAN_COMPILER
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-memory -mllvm -msan-disable-checks=1))
+
+config KMSAN
+	bool "KMSAN: detector of uninitialized values use"
+	depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
+	depends on SLUB && !KASAN && !KCSAN
+	depends on CC_IS_CLANG && CLANG_VERSION >= 140000
+	select STACKDEPOT
+	help
+	  KernelMemorySanitizer (KMSAN) is a dynamic detector of uses of
+	  uninitialized values in the kernel. It is based on compiler
+	  instrumentation provided by Clang and thus requires Clang to build.
+
+	  See <file:Documentation/dev-tools/kmsan.rst> for more details.
diff --git a/mm/Makefile b/mm/Makefile
index d6c0042e3aa0d..8e9319a9affea 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_SLUB) += slub.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
+obj-$(CONFIG_KMSAN)	+= kmsan/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
diff --git a/mm/kmsan/Makefile b/mm/kmsan/Makefile
new file mode 100644
index 0000000000000..f57a956cb1c8b
--- /dev/null
+++ b/mm/kmsan/Makefile
@@ -0,0 +1,22 @@
+obj-y := core.o instrumentation.o init.o hooks.o report.o shadow.o annotations.o
+
+KMSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+UBSAN_SANITIZE := n
+
+KMSAN_SANITIZE_kmsan_annotations.o := y
+
+# Disable instrumentation of KMSAN runtime with other tools.
+CC_FLAGS_KMSAN_RUNTIME := -fno-stack-protector
+CC_FLAGS_KMSAN_RUNTIME += $(call cc-option,-fno-conserve-stack)
+CC_FLAGS_KMSAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
+
+CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)
+
+CFLAGS_annotations.o := $(CC_FLAGS_KMSAN_RUNTIME)
+CFLAGS_core.o := $(CC_FLAGS_KMSAN_RUNTIME)
+CFLAGS_hooks.o := $(CC_FLAGS_KMSAN_RUNTIME)
+CFLAGS_init.o := $(CC_FLAGS_KMSAN_RUNTIME)
+CFLAGS_instrumentation.o := $(CC_FLAGS_KMSAN_RUNTIME)
+CFLAGS_report.o := $(CC_FLAGS_KMSAN_RUNTIME)
+CFLAGS_shadow.o := $(CC_FLAGS_KMSAN_RUNTIME)
diff --git a/mm/kmsan/annotations.c b/mm/kmsan/annotations.c
new file mode 100644
index 0000000000000..037468d1840f2
--- /dev/null
+++ b/mm/kmsan/annotations.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KMSAN annotations.
+ *
+ * The kmsan_init_SIZE functions reside in a separate translation unit to
+ * prevent inlining them. Clang may inline functions marked with
+ * __no_sanitize_memory attribute into functions without it, which effectively
+ * results in ignoring the attribute.
+ *
+ * Copyright (C) 2017-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include <linux/export.h>
+#include <linux/kmsan-checks.h>
+
+#define DECLARE_KMSAN_INIT(size, t)                                            \
+	__no_sanitize_memory t kmsan_init_##size(t value)                      \
+	{                                                                      \
+		return value;                                                  \
+	}                                                                      \
+	EXPORT_SYMBOL(kmsan_init_##size)
+
+DECLARE_KMSAN_INIT(1, u8);
+DECLARE_KMSAN_INIT(2, u16);
+DECLARE_KMSAN_INIT(4, u32);
+DECLARE_KMSAN_INIT(8, u64);
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
new file mode 100644
index 0000000000000..b2bb25a8013e4
--- /dev/null
+++ b/mm/kmsan/core.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KMSAN runtime library.
+ *
+ * Copyright (C) 2017-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include <asm/page.h>
+#include <linux/compiler.h>
+#include <linux/export.h>
+#include <linux/highmem.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/kmsan.h>
+#include <linux/memory.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/mmzone.h>
+#include <linux/percpu-defs.h>
+#include <linux/preempt.h>
+#include <linux/slab.h>
+#include <linux/stackdepot.h>
+#include <linux/stacktrace.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+
+#include "../slab.h"
+#include "kmsan.h"
+
+/*
+ * Avoid creating too long origin chains, these are unlikely to participate in
+ * real reports.
+ */
+#define MAX_CHAIN_DEPTH 7
+#define NUM_SKIPPED_TO_WARN 10000
+
+bool kmsan_enabled __read_mostly;
+
+/*
+ * Per-CPU KMSAN context to be used in interrupts, where current->kmsan is
+ * unavaliable.
+ */
+DEFINE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
+
+void kmsan_internal_task_create(struct task_struct *task)
+{
+	struct kmsan_ctx *ctx = &task->kmsan_ctx;
+
+	__memset(ctx, 0, sizeof(struct kmsan_ctx));
+	ctx->allow_reporting = true;
+	kmsan_internal_unpoison_memory(current_thread_info(),
+				       sizeof(struct thread_info), false);
+}
+
+void kmsan_internal_poison_memory(void *address, size_t size, gfp_t flags,
+				  unsigned int poison_flags)
+{
+	u32 extra_bits =
+		kmsan_extra_bits(/*depth*/ 0, poison_flags & KMSAN_POISON_FREE);
+	bool checked = poison_flags & KMSAN_POISON_CHECK;
+	depot_stack_handle_t handle;
+
+	handle = kmsan_save_stack_with_flags(flags, extra_bits);
+	kmsan_internal_set_shadow_origin(address, size, -1, handle, checked);
+}
+
+void kmsan_internal_unpoison_memory(void *address, size_t size, bool checked)
+{
+	kmsan_internal_set_shadow_origin(address, size, 0, 0, checked);
+}
+
+depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
+						 unsigned int extra)
+{
+	unsigned long entries[KMSAN_STACK_DEPTH];
+	unsigned int nr_entries;
+
+	nr_entries = stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
+	nr_entries = filter_irq_stacks(entries, nr_entries);
+
+	/* Don't sleep (see might_sleep_if() in __alloc_pages_nodemask()). */
+	flags &= ~__GFP_DIRECT_RECLAIM;
+
+	return __stack_depot_save(entries, nr_entries, extra, flags, true);
+}
+
+/* Copy the metadata following the memmove() behavior. */
+void kmsan_internal_memmove_metadata(void *dst, void *src, size_t n)
+{
+	depot_stack_handle_t old_origin = 0, chain_origin, new_origin = 0;
+	int src_slots, dst_slots, i, iter, step, skip_bits;
+	depot_stack_handle_t *origin_src, *origin_dst;
+	void *shadow_src, *shadow_dst;
+	u32 *align_shadow_src, shadow;
+	bool backwards;
+
+	shadow_dst = kmsan_get_metadata(dst, KMSAN_META_SHADOW);
+	if (!shadow_dst)
+		return;
+	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(dst, n));
+
+	shadow_src = kmsan_get_metadata(src, KMSAN_META_SHADOW);
+	if (!shadow_src) {
+		/*
+		 * |src| is untracked: zero out destination shadow, ignore the
+		 * origins, we're done.
+		 */
+		__memset(shadow_dst, 0, n);
+		return;
+	}
+	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(src, n));
+
+	__memmove(shadow_dst, shadow_src, n);
+
+	origin_dst = kmsan_get_metadata(dst, KMSAN_META_ORIGIN);
+	origin_src = kmsan_get_metadata(src, KMSAN_META_ORIGIN);
+	KMSAN_WARN_ON(!origin_dst || !origin_src);
+	src_slots = (ALIGN((u64)src + n, KMSAN_ORIGIN_SIZE) -
+		     ALIGN_DOWN((u64)src, KMSAN_ORIGIN_SIZE)) /
+		    KMSAN_ORIGIN_SIZE;
+	dst_slots = (ALIGN((u64)dst + n, KMSAN_ORIGIN_SIZE) -
+		     ALIGN_DOWN((u64)dst, KMSAN_ORIGIN_SIZE)) /
+		    KMSAN_ORIGIN_SIZE;
+	KMSAN_WARN_ON(!src_slots || !dst_slots);
+	KMSAN_WARN_ON((src_slots < 1) || (dst_slots < 1));
+	KMSAN_WARN_ON((src_slots - dst_slots > 1) ||
+		      (dst_slots - src_slots < -1));
+
+	backwards = dst > src;
+	i = backwards ? min(src_slots, dst_slots) - 1 : 0;
+	iter = backwards ? -1 : 1;
+
+	align_shadow_src =
+		(u32 *)ALIGN_DOWN((u64)shadow_src, KMSAN_ORIGIN_SIZE);
+	for (step = 0; step < min(src_slots, dst_slots); step++, i += iter) {
+		KMSAN_WARN_ON(i < 0);
+		shadow = align_shadow_src[i];
+		if (i == 0) {
+			/*
+			 * If |src| isn't aligned on KMSAN_ORIGIN_SIZE, don't
+			 * look at the first |src % KMSAN_ORIGIN_SIZE| bytes
+			 * of the first shadow slot.
+			 */
+			skip_bits = ((u64)src % KMSAN_ORIGIN_SIZE) * 8;
+			shadow = (shadow << skip_bits) >> skip_bits;
+		}
+		if (i == src_slots - 1) {
+			/*
+			 * If |src + n| isn't aligned on
+			 * KMSAN_ORIGIN_SIZE, don't look at the last
+			 * |(src + n) % KMSAN_ORIGIN_SIZE| bytes of the
+			 * last shadow slot.
+			 */
+			skip_bits = (((u64)src + n) % KMSAN_ORIGIN_SIZE) * 8;
+			shadow = (shadow >> skip_bits) << skip_bits;
+		}
+		/*
+		 * Overwrite the origin only if the corresponding
+		 * shadow is nonempty.
+		 */
+		if (origin_src[i] && (origin_src[i] != old_origin) && shadow) {
+			old_origin = origin_src[i];
+			chain_origin = kmsan_internal_chain_origin(old_origin);
+			/*
+			 * kmsan_internal_chain_origin() may return
+			 * NULL, but we don't want to lose the previous
+			 * origin value.
+			 */
+			if (chain_origin)
+				new_origin = chain_origin;
+			else
+				new_origin = old_origin;
+		}
+		if (shadow)
+			origin_dst[i] = new_origin;
+		else
+			origin_dst[i] = 0;
+	}
+}
+
+depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id)
+{
+	unsigned long entries[3];
+	u32 extra_bits;
+	int depth;
+	bool uaf;
+
+	if (!id)
+		return id;
+	/*
+	 * Make sure we have enough spare bits in |id| to hold the UAF bit and
+	 * the chain depth.
+	 */
+	BUILD_BUG_ON((1 << STACK_DEPOT_EXTRA_BITS) <= (MAX_CHAIN_DEPTH << 1));
+
+	extra_bits = stack_depot_get_extra_bits(id);
+	depth = kmsan_depth_from_eb(extra_bits);
+	uaf = kmsan_uaf_from_eb(extra_bits);
+
+	if (depth >= MAX_CHAIN_DEPTH) {
+		static atomic_long_t kmsan_skipped_origins;
+		long skipped = atomic_long_inc_return(&kmsan_skipped_origins);
+
+		if (skipped % NUM_SKIPPED_TO_WARN == 0) {
+			pr_warn("not chained %d origins\n", skipped);
+			dump_stack();
+			kmsan_print_origin(id);
+		}
+		return id;
+	}
+	depth++;
+	extra_bits = kmsan_extra_bits(depth, uaf);
+
+	entries[0] = KMSAN_CHAIN_MAGIC_ORIGIN;
+	entries[1] = kmsan_save_stack_with_flags(GFP_ATOMIC, 0);
+	entries[2] = id;
+	return __stack_depot_save(entries, ARRAY_SIZE(entries), extra_bits,
+				  GFP_ATOMIC, true);
+}
+
+void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
+				      u32 origin, bool checked)
+{
+	u64 address = (u64)addr;
+	void *shadow_start;
+	u32 *origin_start;
+	size_t pad = 0;
+	int i;
+
+	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
+	shadow_start = kmsan_get_metadata(addr, KMSAN_META_SHADOW);
+	if (!shadow_start) {
+		/*
+		 * kmsan_metadata_is_contiguous() is true, so either all shadow
+		 * and origin pages are NULL, or all are non-NULL.
+		 */
+		if (checked) {
+			pr_err("%s: not memsetting %d bytes starting at %px, because the shadow is NULL\n",
+			       __func__, size, addr);
+			BUG();
+		}
+		return;
+	}
+	__memset(shadow_start, b, size);
+
+	if (!IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
+		pad = address % KMSAN_ORIGIN_SIZE;
+		address -= pad;
+		size += pad;
+	}
+	size = ALIGN(size, KMSAN_ORIGIN_SIZE);
+	origin_start =
+		(u32 *)kmsan_get_metadata((void *)address, KMSAN_META_ORIGIN);
+
+	for (i = 0; i < size / KMSAN_ORIGIN_SIZE; i++)
+		origin_start[i] = origin;
+}
+
+struct page *kmsan_vmalloc_to_page_or_null(void *vaddr)
+{
+	struct page *page;
+
+	if (!kmsan_internal_is_vmalloc_addr(vaddr) &&
+	    !kmsan_internal_is_module_addr(vaddr))
+		return NULL;
+	page = vmalloc_to_page(vaddr);
+	if (pfn_valid(page_to_pfn(page)))
+		return page;
+	else
+		return NULL;
+}
+
+void kmsan_internal_check_memory(void *addr, size_t size, const void *user_addr,
+				 int reason)
+{
+	depot_stack_handle_t cur_origin = 0, new_origin = 0;
+	unsigned long addr64 = (unsigned long)addr;
+	depot_stack_handle_t *origin = NULL;
+	unsigned char *shadow = NULL;
+	int cur_off_start = -1;
+	int i, chunk_size;
+	size_t pos = 0;
+
+	if (!size)
+		return;
+	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
+	while (pos < size) {
+		chunk_size = min(size - pos,
+				 PAGE_SIZE - ((addr64 + pos) % PAGE_SIZE));
+		shadow = kmsan_get_metadata((void *)(addr64 + pos),
+					    KMSAN_META_SHADOW);
+		if (!shadow) {
+			/*
+			 * This page is untracked. If there were uninitialized
+			 * bytes before, report them.
+			 */
+			if (cur_origin) {
+				kmsan_enter_runtime();
+				kmsan_report(cur_origin, addr, size,
+					     cur_off_start, pos - 1, user_addr,
+					     reason);
+				kmsan_leave_runtime();
+			}
+			cur_origin = 0;
+			cur_off_start = -1;
+			pos += chunk_size;
+			continue;
+		}
+		for (i = 0; i < chunk_size; i++) {
+			if (!shadow[i]) {
+				/*
+				 * This byte is unpoisoned. If there were
+				 * poisoned bytes before, report them.
+				 */
+				if (cur_origin) {
+					kmsan_enter_runtime();
+					kmsan_report(cur_origin, addr, size,
+						     cur_off_start, pos + i - 1,
+						     user_addr, reason);
+					kmsan_leave_runtime();
+				}
+				cur_origin = 0;
+				cur_off_start = -1;
+				continue;
+			}
+			origin = kmsan_get_metadata((void *)(addr64 + pos + i),
+						    KMSAN_META_ORIGIN);
+			KMSAN_WARN_ON(!origin);
+			new_origin = *origin;
+			/*
+			 * Encountered new origin - report the previous
+			 * uninitialized range.
+			 */
+			if (cur_origin != new_origin) {
+				if (cur_origin) {
+					kmsan_enter_runtime();
+					kmsan_report(cur_origin, addr, size,
+						     cur_off_start, pos + i - 1,
+						     user_addr, reason);
+					kmsan_leave_runtime();
+				}
+				cur_origin = new_origin;
+				cur_off_start = pos + i;
+			}
+		}
+		pos += chunk_size;
+	}
+	KMSAN_WARN_ON(pos != size);
+	if (cur_origin) {
+		kmsan_enter_runtime();
+		kmsan_report(cur_origin, addr, size, cur_off_start, pos - 1,
+			     user_addr, reason);
+		kmsan_leave_runtime();
+	}
+}
+
+bool kmsan_metadata_is_contiguous(void *addr, size_t size)
+{
+	char *cur_shadow = NULL, *next_shadow = NULL, *cur_origin = NULL,
+	     *next_origin = NULL;
+	u64 cur_addr = (u64)addr, next_addr = cur_addr + PAGE_SIZE;
+	depot_stack_handle_t *origin_p;
+	bool all_untracked = false;
+
+	if (!size)
+		return true;
+
+	/* The whole range belongs to the same page. */
+	if (ALIGN_DOWN(cur_addr + size - 1, PAGE_SIZE) ==
+	    ALIGN_DOWN(cur_addr, PAGE_SIZE))
+		return true;
+
+	cur_shadow = kmsan_get_metadata((void *)cur_addr, /*is_origin*/ false);
+	if (!cur_shadow)
+		all_untracked = true;
+	cur_origin = kmsan_get_metadata((void *)cur_addr, /*is_origin*/ true);
+	if (all_untracked && cur_origin)
+		goto report;
+
+	for (; next_addr < (u64)addr + size;
+	     cur_addr = next_addr, cur_shadow = next_shadow,
+	     cur_origin = next_origin, next_addr += PAGE_SIZE) {
+		next_shadow = kmsan_get_metadata((void *)next_addr, false);
+		next_origin = kmsan_get_metadata((void *)next_addr, true);
+		if (all_untracked) {
+			if (next_shadow || next_origin)
+				goto report;
+			if (!next_shadow && !next_origin)
+				continue;
+		}
+		if (((u64)cur_shadow == ((u64)next_shadow - PAGE_SIZE)) &&
+		    ((u64)cur_origin == ((u64)next_origin - PAGE_SIZE)))
+			continue;
+		goto report;
+	}
+	return true;
+
+report:
+	pr_err("%s: attempting to access two shadow page ranges.\n", __func__);
+	pr_err("Access of size %d at %px.\n", size, addr);
+	pr_err("Addresses belonging to different ranges: %px and %px\n",
+	       cur_addr, next_addr);
+	pr_err("page[0].shadow: %px, page[1].shadow: %px\n", cur_shadow,
+	       next_shadow);
+	pr_err("page[0].origin: %px, page[1].origin: %px\n", cur_origin,
+	       next_origin);
+	origin_p = kmsan_get_metadata(addr, KMSAN_META_ORIGIN);
+	if (origin_p) {
+		pr_err("Origin: %08x\n", *origin_p);
+		kmsan_print_origin(*origin_p);
+	} else {
+		pr_err("Origin: unavailable\n");
+	}
+	return false;
+}
+
+bool kmsan_internal_is_module_addr(void *vaddr)
+{
+	return ((u64)vaddr >= MODULES_VADDR) && ((u64)vaddr < MODULES_END);
+}
+
+bool kmsan_internal_is_vmalloc_addr(void *addr)
+{
+	return ((u64)addr >= VMALLOC_START) && ((u64)addr < VMALLOC_END);
+}
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
new file mode 100644
index 0000000000000..4012d7a4adb53
--- /dev/null
+++ b/mm/kmsan/hooks.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KMSAN hooks for kernel subsystems.
+ *
+ * These functions handle creation of KMSAN metadata for memory allocations.
+ *
+ * Copyright (C) 2018-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include <linux/cacheflush.h>
+#include <linux/dma-direction.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+
+#include "../slab.h"
+#include "kmsan.h"
+
+/*
+ * Instrumented functions shouldn't be called under
+ * kmsan_enter_runtime()/kmsan_leave_runtime(), because this will lead to
+ * skipping effects of functions like memset() inside instrumented code.
+ */
+
+void kmsan_task_create(struct task_struct *task)
+{
+	kmsan_enter_runtime();
+	kmsan_internal_task_create(task);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_task_create);
+
+void kmsan_task_exit(struct task_struct *task)
+{
+	struct kmsan_ctx *ctx = &task->kmsan_ctx;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	ctx->allow_reporting = false;
+}
+EXPORT_SYMBOL(kmsan_task_exit);
+
+void kmsan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags)
+{
+	if (unlikely(object == NULL))
+		return;
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	/*
+	 * There's a ctor or this is an RCU cache - do nothing. The memory
+	 * status hasn't changed since last use.
+	 */
+	if (s->ctor || (s->flags & SLAB_TYPESAFE_BY_RCU))
+		return;
+
+	kmsan_enter_runtime();
+	if (flags & __GFP_ZERO)
+		kmsan_internal_unpoison_memory(object, s->object_size,
+					       KMSAN_POISON_CHECK);
+	else
+		kmsan_internal_poison_memory(object, s->object_size, flags,
+					     KMSAN_POISON_CHECK);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_slab_alloc);
+
+void kmsan_slab_free(struct kmem_cache *s, void *object)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	/* RCU slabs could be legally used after free within the RCU period */
+	if (unlikely(s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)))
+		return;
+	/*
+	 * If there's a constructor, freed memory must remain in the same state
+	 * until the next allocation. We cannot save its state to detect
+	 * use-after-free bugs, instead we just keep it unpoisoned.
+	 */
+	if (s->ctor)
+		return;
+	kmsan_enter_runtime();
+	kmsan_internal_poison_memory(object, s->object_size, GFP_KERNEL,
+				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_slab_free);
+
+void kmsan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
+{
+	if (unlikely(ptr == NULL))
+		return;
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	kmsan_enter_runtime();
+	if (flags & __GFP_ZERO)
+		kmsan_internal_unpoison_memory((void *)ptr, size,
+					       /*checked*/ true);
+	else
+		kmsan_internal_poison_memory((void *)ptr, size, flags,
+					     KMSAN_POISON_CHECK);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_kmalloc_large);
+
+void kmsan_kfree_large(const void *ptr)
+{
+	struct page *page;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	kmsan_enter_runtime();
+	page = virt_to_head_page((void *)ptr);
+	KMSAN_WARN_ON(ptr != page_address(page));
+	kmsan_internal_poison_memory((void *)ptr,
+				     PAGE_SIZE << compound_order(page),
+				     GFP_KERNEL,
+				     KMSAN_POISON_CHECK | KMSAN_POISON_FREE);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_kfree_large);
+
+static unsigned long vmalloc_shadow(unsigned long addr)
+{
+	return (unsigned long)kmsan_get_metadata((void *)addr,
+						 KMSAN_META_SHADOW);
+}
+
+static unsigned long vmalloc_origin(unsigned long addr)
+{
+	return (unsigned long)kmsan_get_metadata((void *)addr,
+						 KMSAN_META_ORIGIN);
+}
+
+void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
+{
+	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
+	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
+	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
+	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
+}
+EXPORT_SYMBOL(kmsan_vunmap_range_noflush);
+
+/*
+ * This function creates new shadow/origin pages for the physical pages mapped
+ * into the virtual memory. If those physical pages already had shadow/origin,
+ * those are ignored.
+ */
+void kmsan_ioremap_page_range(unsigned long start, unsigned long end,
+			      phys_addr_t phys_addr, pgprot_t prot,
+			      unsigned int page_shift)
+{
+	gfp_t gfp_mask = GFP_KERNEL | __GFP_ZERO;
+	struct page *shadow, *origin;
+	unsigned long off = 0;
+	int i, nr;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	nr = (end - start) / PAGE_SIZE;
+	kmsan_enter_runtime();
+	for (i = 0; i < nr; i++, off += PAGE_SIZE) {
+		shadow = alloc_pages(gfp_mask, 1);
+		origin = alloc_pages(gfp_mask, 1);
+		__vmap_pages_range_noflush(
+			vmalloc_shadow(start + off),
+			vmalloc_shadow(start + off + PAGE_SIZE), prot, &shadow,
+			page_shift);
+		__vmap_pages_range_noflush(
+			vmalloc_origin(start + off),
+			vmalloc_origin(start + off + PAGE_SIZE), prot, &origin,
+			page_shift);
+	}
+	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
+	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_ioremap_page_range);
+
+void kmsan_iounmap_page_range(unsigned long start, unsigned long end)
+{
+	unsigned long v_shadow, v_origin;
+	struct page *shadow, *origin;
+	int i, nr;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	nr = (end - start) / PAGE_SIZE;
+	kmsan_enter_runtime();
+	v_shadow = (unsigned long)vmalloc_shadow(start);
+	v_origin = (unsigned long)vmalloc_origin(start);
+	for (i = 0; i < nr; i++, v_shadow += PAGE_SIZE, v_origin += PAGE_SIZE) {
+		shadow = kmsan_vmalloc_to_page_or_null((void *)v_shadow);
+		origin = kmsan_vmalloc_to_page_or_null((void *)v_origin);
+		__vunmap_range_noflush(v_shadow, vmalloc_shadow(end));
+		__vunmap_range_noflush(v_origin, vmalloc_origin(end));
+		if (shadow)
+			__free_pages(shadow, 1);
+		if (origin)
+			__free_pages(origin, 1);
+	}
+	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
+	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_iounmap_page_range);
+
+void kmsan_copy_to_user(const void *to, const void *from, size_t to_copy,
+			size_t left)
+{
+	unsigned long ua_flags;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	/*
+	 * At this point we've copied the memory already. It's hard to check it
+	 * before copying, as the size of actually copied buffer is unknown.
+	 */
+
+	/* copy_to_user() may copy zero bytes. No need to check. */
+	if (!to_copy)
+		return;
+	/* Or maybe copy_to_user() failed to copy anything. */
+	if (to_copy <= left)
+		return;
+
+	ua_flags = user_access_save();
+	if ((u64)to < TASK_SIZE) {
+		/* This is a user memory access, check it. */
+		kmsan_internal_check_memory((void *)from, to_copy - left, to,
+					    REASON_COPY_TO_USER);
+		user_access_restore(ua_flags);
+		return;
+	}
+	/* Otherwise this is a kernel memory access. This happens when a compat
+	 * syscall passes an argument allocated on the kernel stack to a real
+	 * syscall.
+	 * Don't check anything, just copy the shadow of the copied bytes.
+	 */
+	kmsan_internal_memmove_metadata((void *)to, (void *)from,
+					to_copy - left);
+	user_access_restore(ua_flags);
+}
+EXPORT_SYMBOL(kmsan_copy_to_user);
+
+/* Helper function to check an URB. */
+void kmsan_handle_urb(const struct urb *urb, bool is_out)
+{
+	if (!urb)
+		return;
+	if (is_out)
+		kmsan_internal_check_memory(urb->transfer_buffer,
+					    urb->transfer_buffer_length,
+					    /*user_addr*/ 0, REASON_SUBMIT_URB);
+	else
+		kmsan_internal_unpoison_memory(urb->transfer_buffer,
+					       urb->transfer_buffer_length,
+					       /*checked*/ false);
+}
+EXPORT_SYMBOL(kmsan_handle_urb);
+
+static void kmsan_handle_dma_page(const void *addr, size_t size,
+				  enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_BIDIRECTIONAL:
+		kmsan_internal_check_memory((void *)addr, size, /*user_addr*/ 0,
+					    REASON_ANY);
+		kmsan_internal_unpoison_memory((void *)addr, size,
+					       /*checked*/ false);
+		break;
+	case DMA_TO_DEVICE:
+		kmsan_internal_check_memory((void *)addr, size, /*user_addr*/ 0,
+					    REASON_ANY);
+		break;
+	case DMA_FROM_DEVICE:
+		kmsan_internal_unpoison_memory((void *)addr, size,
+					       /*checked*/ false);
+		break;
+	case DMA_NONE:
+		break;
+	}
+}
+
+/* Helper function to handle DMA data transfers. */
+void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
+		      enum dma_data_direction dir)
+{
+	u64 page_offset, to_go, addr;
+
+	if (PageHighMem(page))
+		return;
+	addr = (u64)page_address(page) + offset;
+	/*
+	 * The kernel may occasionally give us adjacent DMA pages not belonging
+	 * to the same allocation. Process them separately to avoid triggering
+	 * internal KMSAN checks.
+	 */
+	while (size > 0) {
+		page_offset = addr % PAGE_SIZE;
+		to_go = min(PAGE_SIZE - page_offset, (u64)size);
+		kmsan_handle_dma_page((void *)addr, to_go, dir);
+		addr += to_go;
+		size -= to_go;
+	}
+}
+EXPORT_SYMBOL(kmsan_handle_dma);
+
+void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
+			 enum dma_data_direction dir)
+{
+	struct scatterlist *item;
+	int i;
+
+	for_each_sg(sg, item, nents, i)
+		kmsan_handle_dma(sg_page(item), item->offset, item->length,
+				 dir);
+}
+EXPORT_SYMBOL(kmsan_handle_dma_sg);
+
+/* Functions from kmsan-checks.h follow. */
+void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	kmsan_enter_runtime();
+	/* The users may want to poison/unpoison random memory. */
+	kmsan_internal_poison_memory((void *)address, size, flags,
+				     KMSAN_POISON_NOCHECK);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(kmsan_poison_memory);
+
+void kmsan_unpoison_memory(const void *address, size_t size)
+{
+	unsigned long ua_flags;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	ua_flags = user_access_save();
+	kmsan_enter_runtime();
+	/* The users may want to poison/unpoison random memory. */
+	kmsan_internal_unpoison_memory((void *)address, size,
+				       KMSAN_POISON_NOCHECK);
+	kmsan_leave_runtime();
+	user_access_restore(ua_flags);
+}
+EXPORT_SYMBOL(kmsan_unpoison_memory);
+
+void kmsan_gup_pgd_range(struct page **pages, int nr)
+{
+	void *page_addr;
+	int i;
+
+	/*
+	 * gup_pgd_range() has just created a number of new pages that KMSAN
+	 * treats as uninitialized. In the case they belong to the userspace
+	 * memory, unpoison the corresponding kernel pages.
+	 */
+	for (i = 0; i < nr; i++) {
+		if (PageHighMem(pages[i]))
+			continue;
+		page_addr = page_address(pages[i]);
+		if (((u64)page_addr < TASK_SIZE) &&
+		    ((u64)page_addr + PAGE_SIZE < TASK_SIZE))
+			kmsan_unpoison_memory(page_addr, PAGE_SIZE);
+	}
+}
+EXPORT_SYMBOL(kmsan_gup_pgd_range);
+
+void kmsan_check_memory(const void *addr, size_t size)
+{
+	if (!kmsan_enabled)
+		return;
+	return kmsan_internal_check_memory((void *)addr, size, /*user_addr*/ 0,
+					   REASON_ANY);
+}
+EXPORT_SYMBOL(kmsan_check_memory);
+
+void kmsan_instrumentation_begin(struct pt_regs *regs)
+{
+	struct kmsan_context_state *state = &kmsan_get_context()->cstate;
+
+	if (state)
+		__memset(state, 0, sizeof(struct kmsan_context_state));
+	if (!kmsan_enabled || !regs)
+		return;
+	kmsan_internal_unpoison_memory(regs, sizeof(*regs), /*checked*/ true);
+}
+EXPORT_SYMBOL(kmsan_instrumentation_begin);
diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
new file mode 100644
index 0000000000000..49ab06cde082a
--- /dev/null
+++ b/mm/kmsan/init.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KMSAN initialization routines.
+ *
+ * Copyright (C) 2017-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include "kmsan.h"
+
+#include <asm/sections.h>
+#include <linux/mm.h>
+#include <linux/memblock.h>
+
+#define NUM_FUTURE_RANGES 128
+struct start_end_pair {
+	u64 start, end;
+};
+
+static struct start_end_pair start_end_pairs[NUM_FUTURE_RANGES] __initdata;
+static int future_index __initdata;
+
+/*
+ * Record a range of memory for which the metadata pages will be created once
+ * the page allocator becomes available.
+ */
+static void __init kmsan_record_future_shadow_range(void *start, void *end)
+{
+	u64 nstart = (u64)start, nend = (u64)end, cstart, cend;
+	bool merged = false;
+	int i;
+
+	KMSAN_WARN_ON(future_index == NUM_FUTURE_RANGES);
+	KMSAN_WARN_ON((nstart >= nend) || !nstart || !nend);
+	nstart = ALIGN_DOWN(nstart, PAGE_SIZE);
+	nend = ALIGN(nend, PAGE_SIZE);
+
+	/*
+	 * Scan the existing ranges to see if any of them overlaps with
+	 * [start, end). In that case, merge the two ranges instead of
+	 * creating a new one.
+	 * The number of ranges is less than 20, so there is no need to organize
+	 * them into a more intelligent data structure.
+	 */
+	for (i = 0; i < future_index; i++) {
+		cstart = start_end_pairs[i].start;
+		cend = start_end_pairs[i].end;
+		if ((cstart < nstart && cend < nstart) ||
+		    (cstart > nend && cend > nend))
+			/* ranges are disjoint - do not merge */
+			continue;
+		start_end_pairs[i].start = min(nstart, cstart);
+		start_end_pairs[i].end = max(nend, cend);
+		merged = true;
+		break;
+	}
+	if (merged)
+		return;
+	start_end_pairs[future_index].start = nstart;
+	start_end_pairs[future_index].end = nend;
+	future_index++;
+}
+
+/*
+ * Initialize the shadow for existing mappings during kernel initialization.
+ * These include kernel text/data sections, NODE_DATA and future ranges
+ * registered while creating other data (e.g. percpu).
+ *
+ * Allocations via memblock can be only done before slab is initialized.
+ */
+void __init kmsan_init_shadow(void)
+{
+	const size_t nd_size = roundup(sizeof(pg_data_t), PAGE_SIZE);
+	phys_addr_t p_start, p_end;
+	int nid;
+	u64 i;
+
+	for_each_reserved_mem_range(i, &p_start, &p_end)
+		kmsan_record_future_shadow_range(phys_to_virt(p_start),
+						 phys_to_virt(p_end));
+	/* Allocate shadow for .data */
+	kmsan_record_future_shadow_range(_sdata, _edata);
+
+	for_each_online_node(nid)
+		kmsan_record_future_shadow_range(
+			NODE_DATA(nid), (char *)NODE_DATA(nid) + nd_size);
+
+	for (i = 0; i < future_index; i++)
+		kmsan_init_alloc_meta_for_range(
+			(void *)start_end_pairs[i].start,
+			(void *)start_end_pairs[i].end);
+}
+EXPORT_SYMBOL(kmsan_init_shadow);
+
+struct page_pair {
+	struct page *shadow, *origin;
+};
+static struct page_pair held_back[MAX_ORDER] __initdata;
+
+/*
+ * Eager metadata allocation. When the memblock allocator is freeing pages to
+ * pagealloc, we use 2/3 of them as metadata for the remaining 1/3.
+ * We store the pointers to the returned blocks of pages in held_back[] grouped
+ * by their order: when kmsan_memblock_free_pages() is called for the first
+ * time with a certain order, it is reserved as a shadow block, for the second
+ * time - as an origin block. On the third time the incoming block receives its
+ * shadow and origin ranges from the previously saved shadow and origin blocks,
+ * after which held_back[order] can be used again.
+ *
+ * At the very end there may be leftover blocks in held_back[]. They are
+ * collected later by kmsan_memblock_discard().
+ */
+bool kmsan_memblock_free_pages(struct page *page, unsigned int order)
+{
+	struct page *shadow, *origin;
+
+	if (!held_back[order].shadow) {
+		held_back[order].shadow = page;
+		return false;
+	}
+	if (!held_back[order].origin) {
+		held_back[order].origin = page;
+		return false;
+	}
+	shadow = held_back[order].shadow;
+	origin = held_back[order].origin;
+	kmsan_setup_meta(page, shadow, origin, order);
+
+	held_back[order].shadow = NULL;
+	held_back[order].origin = NULL;
+	return true;
+}
+
+#define MAX_BLOCKS 8
+struct smallstack {
+	struct page *items[MAX_BLOCKS];
+	int index;
+	int order;
+};
+
+struct smallstack collect = {
+	.index = 0,
+	.order = MAX_ORDER,
+};
+
+static void smallstack_push(struct smallstack *stack, struct page *pages)
+{
+	KMSAN_WARN_ON(stack->index == MAX_BLOCKS);
+	stack->items[stack->index] = pages;
+	stack->index++;
+}
+#undef MAX_BLOCKS
+
+static struct page *smallstack_pop(struct smallstack *stack)
+{
+	struct page *ret;
+
+	KMSAN_WARN_ON(stack->index == 0);
+	stack->index--;
+	ret = stack->items[stack->index];
+	stack->items[stack->index] = NULL;
+	return ret;
+}
+
+static void do_collection(void)
+{
+	struct page *page, *shadow, *origin;
+
+	while (collect.index >= 3) {
+		page = smallstack_pop(&collect);
+		shadow = smallstack_pop(&collect);
+		origin = smallstack_pop(&collect);
+		kmsan_setup_meta(page, shadow, origin, collect.order);
+		__free_pages_core(page, collect.order);
+	}
+}
+
+static void collect_split(void)
+{
+	struct smallstack tmp = {
+		.order = collect.order - 1,
+		.index = 0,
+	};
+	struct page *page;
+
+	if (!collect.order)
+		return;
+	while (collect.index) {
+		page = smallstack_pop(&collect);
+		smallstack_push(&tmp, &page[0]);
+		smallstack_push(&tmp, &page[1 << tmp.order]);
+	}
+	__memcpy(&collect, &tmp, sizeof(struct smallstack));
+}
+
+/*
+ * Memblock is about to go away. Split the page blocks left over in held_back[]
+ * and return 1/3 of that memory to the system.
+ */
+static void kmsan_memblock_discard(void)
+{
+	int i;
+
+	/*
+	 * For each order=N:
+	 *  - push held_back[N].shadow and .origin to |collect|;
+	 *  - while there are >= 3 elements in |collect|, do garbage collection:
+	 *    - pop 3 ranges from |collect|;
+	 *    - use two of them as shadow and origin for the third one;
+	 *    - repeat;
+	 *  - split each remaining element from |collect| into 2 ranges of
+	 *    order=N-1,
+	 *  - repeat.
+	 */
+	collect.order = MAX_ORDER - 1;
+	for (i = MAX_ORDER - 1; i >= 0; i--) {
+		if (held_back[i].shadow)
+			smallstack_push(&collect, held_back[i].shadow);
+		if (held_back[i].origin)
+			smallstack_push(&collect, held_back[i].origin);
+		held_back[i].shadow = NULL;
+		held_back[i].origin = NULL;
+		do_collection();
+		collect_split();
+	}
+}
+
+void __init kmsan_init_runtime(void)
+{
+	/* Assuming current is init_task */
+	kmsan_internal_task_create(current);
+	kmsan_memblock_discard();
+	pr_info("vmalloc area at: %px\n", VMALLOC_START);
+	pr_info("Starting KernelMemorySanitizer\n");
+	kmsan_enabled = true;
+}
+EXPORT_SYMBOL(kmsan_init_runtime);
diff --git a/mm/kmsan/instrumentation.c b/mm/kmsan/instrumentation.c
new file mode 100644
index 0000000000000..1eb2d64aa39a6
--- /dev/null
+++ b/mm/kmsan/instrumentation.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KMSAN compiler API.
+ *
+ * Copyright (C) 2017-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include "kmsan.h"
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+
+static inline bool is_bad_asm_addr(void *addr, uintptr_t size, bool is_store)
+{
+	if ((u64)addr < TASK_SIZE)
+		return true;
+	if (!kmsan_get_metadata(addr, KMSAN_META_SHADOW))
+		return true;
+	return false;
+}
+
+static inline struct shadow_origin_ptr
+get_shadow_origin_ptr(void *addr, u64 size, bool store)
+{
+	unsigned long ua_flags = user_access_save();
+	struct shadow_origin_ptr ret;
+
+	ret = kmsan_get_shadow_origin_ptr(addr, size, store);
+	user_access_restore(ua_flags);
+	return ret;
+}
+
+struct shadow_origin_ptr __msan_metadata_ptr_for_load_n(void *addr,
+							uintptr_t size)
+{
+	return get_shadow_origin_ptr(addr, size, /*store*/ false);
+}
+EXPORT_SYMBOL(__msan_metadata_ptr_for_load_n);
+
+struct shadow_origin_ptr __msan_metadata_ptr_for_store_n(void *addr,
+							 uintptr_t size)
+{
+	return get_shadow_origin_ptr(addr, size, /*store*/ true);
+}
+EXPORT_SYMBOL(__msan_metadata_ptr_for_store_n);
+
+#define DECLARE_METADATA_PTR_GETTER(size)                                      \
+	struct shadow_origin_ptr __msan_metadata_ptr_for_load_##size(          \
+		void *addr)                                                    \
+	{                                                                      \
+		return get_shadow_origin_ptr(addr, size, /*store*/ false);     \
+	}                                                                      \
+	EXPORT_SYMBOL(__msan_metadata_ptr_for_load_##size);                    \
+	struct shadow_origin_ptr __msan_metadata_ptr_for_store_##size(         \
+		void *addr)                                                    \
+	{                                                                      \
+		return get_shadow_origin_ptr(addr, size, /*store*/ true);      \
+	}                                                                      \
+	EXPORT_SYMBOL(__msan_metadata_ptr_for_store_##size)
+
+DECLARE_METADATA_PTR_GETTER(1);
+DECLARE_METADATA_PTR_GETTER(2);
+DECLARE_METADATA_PTR_GETTER(4);
+DECLARE_METADATA_PTR_GETTER(8);
+
+void __msan_instrument_asm_store(void *addr, uintptr_t size)
+{
+	unsigned long ua_flags;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	ua_flags = user_access_save();
+	/*
+	 * Most of the accesses are below 32 bytes. The two exceptions so far
+	 * are clwb() (64 bytes) and FPU state (512 bytes).
+	 * It's unlikely that the assembly will touch more than 512 bytes.
+	 */
+	if (size > 512) {
+		WARN_ONCE(1, "assembly store size too big: %d\n", size);
+		size = 8;
+	}
+	if (is_bad_asm_addr(addr, size, /*is_store*/ true)) {
+		user_access_restore(ua_flags);
+		return;
+	}
+	kmsan_enter_runtime();
+	/* Unpoisoning the memory on best effort. */
+	kmsan_internal_unpoison_memory(addr, size, /*checked*/ false);
+	kmsan_leave_runtime();
+	user_access_restore(ua_flags);
+}
+EXPORT_SYMBOL(__msan_instrument_asm_store);
+
+void *__msan_memmove(void *dst, const void *src, uintptr_t n)
+{
+	void *result;
+
+	result = __memmove(dst, src, n);
+	if (!n)
+		/* Some people call memmove() with zero length. */
+		return result;
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return result;
+
+	kmsan_internal_memmove_metadata(dst, (void *)src, n);
+
+	return result;
+}
+EXPORT_SYMBOL(__msan_memmove);
+
+void *__msan_memcpy(void *dst, const void *src, uintptr_t n)
+{
+	void *result;
+
+	result = __memcpy(dst, src, n);
+	if (!n)
+		/* Some people call memcpy() with zero length. */
+		return result;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return result;
+
+	/* Using memmove instead of memcpy doesn't affect correctness. */
+	kmsan_internal_memmove_metadata(dst, (void *)src, n);
+
+	return result;
+}
+EXPORT_SYMBOL(__msan_memcpy);
+
+void *__msan_memset(void *dst, int c, uintptr_t n)
+{
+	void *result;
+
+	result = __memset(dst, c, n);
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return result;
+
+	kmsan_enter_runtime();
+	/*
+	 * Clang doesn't pass parameter metadata here, so it is impossible to
+	 * use shadow of @c to set up the shadow for @dst.
+	 */
+	kmsan_internal_unpoison_memory(dst, n, /*checked*/ false);
+	kmsan_leave_runtime();
+
+	return result;
+}
+EXPORT_SYMBOL(__msan_memset);
+
+depot_stack_handle_t __msan_chain_origin(depot_stack_handle_t origin)
+{
+	depot_stack_handle_t ret = 0;
+	unsigned long ua_flags;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return ret;
+
+	ua_flags = user_access_save();
+
+	/* Creating new origins may allocate memory. */
+	kmsan_enter_runtime();
+	ret = kmsan_internal_chain_origin(origin);
+	kmsan_leave_runtime();
+	user_access_restore(ua_flags);
+	return ret;
+}
+EXPORT_SYMBOL(__msan_chain_origin);
+
+void __msan_poison_alloca(void *address, uintptr_t size, char *descr)
+{
+	depot_stack_handle_t handle;
+	unsigned long entries[4];
+	unsigned long ua_flags;
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	ua_flags = user_access_save();
+	entries[0] = KMSAN_ALLOCA_MAGIC_ORIGIN;
+	entries[1] = (u64)descr;
+	entries[2] = (u64)__builtin_return_address(0);
+	/*
+	 * With frame pointers enabled, it is possible to quickly fetch the
+	 * second frame of the caller stack without calling the unwinder.
+	 * Without them, simply do not bother.
+	 */
+	if (IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER))
+		entries[3] = (u64)__builtin_return_address(1);
+	else
+		entries[3] = 0;
+
+	/* stack_depot_save() may allocate memory. */
+	kmsan_enter_runtime();
+	handle = stack_depot_save(entries, ARRAY_SIZE(entries), GFP_ATOMIC);
+	kmsan_leave_runtime();
+
+	kmsan_internal_set_shadow_origin(address, size, -1, handle,
+					 /*checked*/ true);
+	user_access_restore(ua_flags);
+}
+EXPORT_SYMBOL(__msan_poison_alloca);
+
+void __msan_unpoison_alloca(void *address, uintptr_t size)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+
+	kmsan_enter_runtime();
+	kmsan_internal_unpoison_memory(address, size, /*checked*/ true);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(__msan_unpoison_alloca);
+
+void __msan_warning(u32 origin)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	kmsan_enter_runtime();
+	kmsan_report(origin, /*address*/ 0, /*size*/ 0,
+		     /*off_first*/ 0, /*off_last*/ 0, /*user_addr*/ 0,
+		     REASON_ANY);
+	kmsan_leave_runtime();
+}
+EXPORT_SYMBOL(__msan_warning);
+
+struct kmsan_context_state *__msan_get_context_state(void)
+{
+	return &kmsan_get_context()->cstate;
+}
+EXPORT_SYMBOL(__msan_get_context_state);
diff --git a/mm/kmsan/kmsan.h b/mm/kmsan/kmsan.h
new file mode 100644
index 0000000000000..29c91b6e28799
--- /dev/null
+++ b/mm/kmsan/kmsan.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Functions used by the KMSAN runtime.
+ *
+ * Copyright (C) 2017-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#ifndef __MM_KMSAN_KMSAN_H
+#define __MM_KMSAN_KMSAN_H
+
+#include <asm/pgtable_64_types.h>
+#include <linux/irqflags.h>
+#include <linux/sched.h>
+#include <linux/stackdepot.h>
+#include <linux/stacktrace.h>
+#include <linux/nmi.h>
+#include <linux/mm.h>
+#include <linux/printk.h>
+
+#define KMSAN_ALLOCA_MAGIC_ORIGIN 0xabcd0100
+#define KMSAN_CHAIN_MAGIC_ORIGIN 0xabcd0200
+
+#define KMSAN_POISON_NOCHECK 0x0
+#define KMSAN_POISON_CHECK 0x1
+#define KMSAN_POISON_FREE 0x2
+
+#define KMSAN_ORIGIN_SIZE 4
+
+#define KMSAN_STACK_DEPTH 64
+
+#define KMSAN_META_SHADOW (false)
+#define KMSAN_META_ORIGIN (true)
+
+extern bool kmsan_enabled;
+extern int panic_on_kmsan;
+
+/*
+ * KMSAN performs a lot of consistency checks that are currently enabled by
+ * default. BUG_ON is normally discouraged in the kernel, unless used for
+ * debugging, but KMSAN itself is a debugging tool, so it makes little sense to
+ * recover if something goes wrong.
+ */
+#define KMSAN_WARN_ON(cond)                                                    \
+	({                                                                     \
+		const bool __cond = WARN_ON(cond);                             \
+		if (unlikely(__cond)) {                                        \
+			WRITE_ONCE(kmsan_enabled, false);                      \
+			if (panic_on_kmsan) {                                  \
+				/* Can't call panic() here because */          \
+				/* of uaccess checks.*/                        \
+				BUG();                                         \
+			}                                                      \
+		}                                                              \
+		__cond;                                                        \
+	})
+
+/*
+ * A pair of metadata pointers to be returned by the instrumentation functions.
+ */
+struct shadow_origin_ptr {
+	void *shadow, *origin;
+};
+
+struct shadow_origin_ptr kmsan_get_shadow_origin_ptr(void *addr, u64 size,
+						     bool store);
+void *kmsan_get_metadata(void *addr, bool is_origin);
+void __init kmsan_init_alloc_meta_for_range(void *start, void *end);
+
+enum kmsan_bug_reason {
+	REASON_ANY,
+	REASON_COPY_TO_USER,
+	REASON_SUBMIT_URB,
+};
+
+void kmsan_print_origin(depot_stack_handle_t origin);
+
+/**
+ * kmsan_report() - Report a use of uninitialized value.
+ * @origin:    Stack ID of the uninitialized value.
+ * @address:   Address at which the memory access happens.
+ * @size:      Memory access size.
+ * @off_first: Offset (from @address) of the first byte to be reported.
+ * @off_last:  Offset (from @address) of the last byte to be reported.
+ * @user_addr: When non-NULL, denotes the userspace address to which the kernel
+ *             is leaking data.
+ * @reason:    Error type from enum kmsan_bug_reason.
+ *
+ * kmsan_report() prints an error message for a consequent group of bytes
+ * sharing the same origin. If an uninitialized value is used in a comparison,
+ * this function is called once without specifying the addresses. When checking
+ * a memory range, KMSAN may call kmsan_report() multiple times with the same
+ * @address, @size, @user_addr and @reason, but different @off_first and
+ * @off_last corresponding to different @origin values.
+ */
+void kmsan_report(depot_stack_handle_t origin, void *address, int size,
+		  int off_first, int off_last, const void *user_addr,
+		  enum kmsan_bug_reason reason);
+
+DECLARE_PER_CPU(struct kmsan_ctx, kmsan_percpu_ctx);
+
+static __always_inline struct kmsan_ctx *kmsan_get_context(void)
+{
+	return in_task() ? &current->kmsan_ctx : raw_cpu_ptr(&kmsan_percpu_ctx);
+}
+
+/*
+ * When a compiler hook is invoked, it may make a call to instrumented code
+ * and eventually call itself recursively. To avoid that, we protect the
+ * runtime entry points with kmsan_enter_runtime()/kmsan_leave_runtime() and
+ * exit the hook if kmsan_in_runtime() is true.
+ */
+
+static __always_inline bool kmsan_in_runtime(void)
+{
+	if ((hardirq_count() >> HARDIRQ_SHIFT) > 1)
+		return true;
+	return kmsan_get_context()->kmsan_in_runtime;
+}
+
+static __always_inline void kmsan_enter_runtime(void)
+{
+	struct kmsan_ctx *ctx;
+
+	ctx = kmsan_get_context();
+	KMSAN_WARN_ON(ctx->kmsan_in_runtime++);
+}
+
+static __always_inline void kmsan_leave_runtime(void)
+{
+	struct kmsan_ctx *ctx = kmsan_get_context();
+
+	KMSAN_WARN_ON(--ctx->kmsan_in_runtime);
+}
+
+depot_stack_handle_t kmsan_save_stack(void);
+depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
+						 unsigned int extra_bits);
+
+/*
+ * Pack and unpack the origin chain depth and UAF flag to/from the extra bits
+ * provided by the stack depot.
+ * The UAF flag is stored in the lowest bit, followed by the depth in the upper
+ * bits.
+ * set_dsh_extra_bits() is responsible for clamping the value.
+ */
+static __always_inline unsigned int kmsan_extra_bits(unsigned int depth,
+						     bool uaf)
+{
+	return (depth << 1) | uaf;
+}
+
+static __always_inline bool kmsan_uaf_from_eb(unsigned int extra_bits)
+{
+	return extra_bits & 1;
+}
+
+static __always_inline unsigned int kmsan_depth_from_eb(unsigned int extra_bits)
+{
+	return extra_bits >> 1;
+}
+
+/*
+ * kmsan_internal_ functions are supposed to be very simple and not require the
+ * kmsan_in_runtime() checks.
+ */
+void kmsan_internal_memmove_metadata(void *dst, void *src, size_t n);
+void kmsan_internal_poison_memory(void *address, size_t size, gfp_t flags,
+				  unsigned int poison_flags);
+void kmsan_internal_unpoison_memory(void *address, size_t size, bool checked);
+void kmsan_internal_set_shadow_origin(void *address, size_t size, int b,
+				      u32 origin, bool checked);
+depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id);
+
+void kmsan_internal_task_create(struct task_struct *task);
+
+bool kmsan_metadata_is_contiguous(void *addr, size_t size);
+void kmsan_internal_check_memory(void *addr, size_t size, const void *user_addr,
+				 int reason);
+bool kmsan_internal_is_module_addr(void *vaddr);
+bool kmsan_internal_is_vmalloc_addr(void *addr);
+
+struct page *kmsan_vmalloc_to_page_or_null(void *vaddr);
+void kmsan_setup_meta(struct page *page, struct page *shadow,
+		      struct page *origin, int order);
+
+/* Declared in mm/vmalloc.c */
+void __vunmap_range_noflush(unsigned long start, unsigned long end);
+int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
+			       pgprot_t prot, struct page **pages,
+			       unsigned int page_shift);
+
+/* Declared in mm/internal.h */
+void __free_pages_core(struct page *page, unsigned int order);
+
+#endif /* __MM_KMSAN_KMSAN_H */
diff --git a/mm/kmsan/report.c b/mm/kmsan/report.c
new file mode 100644
index 0000000000000..d539fe1129fb9
--- /dev/null
+++ b/mm/kmsan/report.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KMSAN error reporting routines.
+ *
+ * Copyright (C) 2019-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include <linux/console.h>
+#include <linux/moduleparam.h>
+#include <linux/stackdepot.h>
+#include <linux/stacktrace.h>
+#include <linux/uaccess.h>
+
+#include "kmsan.h"
+
+static DEFINE_SPINLOCK(kmsan_report_lock);
+#define DESCR_SIZE 128
+/* Protected by kmsan_report_lock */
+static char report_local_descr[DESCR_SIZE];
+int panic_on_kmsan __read_mostly;
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "kmsan."
+module_param_named(panic, panic_on_kmsan, int, 0);
+
+/*
+ * Skip internal KMSAN frames.
+ */
+static int get_stack_skipnr(const unsigned long stack_entries[],
+			    int num_entries)
+{
+	int len, skip;
+	char buf[64];
+
+	for (skip = 0; skip < num_entries; ++skip) {
+		len = scnprintf(buf, sizeof(buf), "%ps",
+				(void *)stack_entries[skip]);
+
+		/* Never show __msan_* or kmsan_* functions. */
+		if ((strnstr(buf, "__msan_", len) == buf) ||
+		    (strnstr(buf, "kmsan_", len) == buf))
+			continue;
+
+		/*
+		 * No match for runtime functions -- @skip entries to skip to
+		 * get to first frame of interest.
+		 */
+		break;
+	}
+
+	return skip;
+}
+
+/*
+ * Currently the descriptions of locals generated by Clang look as follows:
+ *   ----local_name@function_name
+ * We want to print only the name of the local, as other information in that
+ * description can be confusing.
+ * The meaningful part of the description is copied to a global buffer to avoid
+ * allocating memory.
+ */
+static char *pretty_descr(char *descr)
+{
+	int i, pos = 0, len = strlen(descr);
+
+	for (i = 0; i < len; i++) {
+		if (descr[i] == '@')
+			break;
+		if (descr[i] == '-')
+			continue;
+		report_local_descr[pos] = descr[i];
+		if (pos + 1 == DESCR_SIZE)
+			break;
+		pos++;
+	}
+	report_local_descr[pos] = 0;
+	return report_local_descr;
+}
+
+void kmsan_print_origin(depot_stack_handle_t origin)
+{
+	unsigned long *entries = NULL, *chained_entries = NULL;
+	unsigned int nr_entries, chained_nr_entries, skipnr;
+	void *pc1 = NULL, *pc2 = NULL;
+	depot_stack_handle_t head;
+	unsigned long magic;
+	char *descr = NULL;
+
+	if (!origin)
+		return;
+
+	while (true) {
+		nr_entries = stack_depot_fetch(origin, &entries);
+		magic = nr_entries ? entries[0] : 0;
+		if ((nr_entries == 4) && (magic == KMSAN_ALLOCA_MAGIC_ORIGIN)) {
+			descr = (char *)entries[1];
+			pc1 = (void *)entries[2];
+			pc2 = (void *)entries[3];
+			pr_err("Local variable %s created at:\n",
+			       pretty_descr(descr));
+			if (pc1)
+				pr_err(" %pS\n", pc1);
+			if (pc2)
+				pr_err(" %pS\n", pc2);
+			break;
+		}
+		if ((nr_entries == 3) && (magic == KMSAN_CHAIN_MAGIC_ORIGIN)) {
+			head = entries[1];
+			origin = entries[2];
+			pr_err("Uninit was stored to memory at:\n");
+			chained_nr_entries =
+				stack_depot_fetch(head, &chained_entries);
+			kmsan_internal_unpoison_memory(
+				chained_entries,
+				chained_nr_entries * sizeof(*chained_entries),
+				/*checked*/ false);
+			skipnr = get_stack_skipnr(chained_entries,
+						  chained_nr_entries);
+			stack_trace_print(chained_entries + skipnr,
+					  chained_nr_entries - skipnr, 0);
+			pr_err("\n");
+			continue;
+		}
+		pr_err("Uninit was created at:\n");
+		if (nr_entries) {
+			skipnr = get_stack_skipnr(entries, nr_entries);
+			stack_trace_print(entries + skipnr, nr_entries - skipnr,
+					  0);
+		} else {
+			pr_err("(stack is not available)\n");
+		}
+		break;
+	}
+}
+
+void kmsan_report(depot_stack_handle_t origin, void *address, int size,
+		  int off_first, int off_last, const void *user_addr,
+		  enum kmsan_bug_reason reason)
+{
+	unsigned long stack_entries[KMSAN_STACK_DEPTH];
+	int num_stack_entries, skipnr;
+	char *bug_type = NULL;
+	unsigned long flags, ua_flags;
+	bool is_uaf;
+
+	if (!kmsan_enabled)
+		return;
+	if (!current->kmsan_ctx.allow_reporting)
+		return;
+	if (!origin)
+		return;
+
+	current->kmsan_ctx.allow_reporting = false;
+	ua_flags = user_access_save();
+	spin_lock_irqsave(&kmsan_report_lock, flags);
+	pr_err("=====================================================\n");
+	is_uaf = kmsan_uaf_from_eb(stack_depot_get_extra_bits(origin));
+	switch (reason) {
+	case REASON_ANY:
+		bug_type = is_uaf ? "use-after-free" : "uninit-value";
+		break;
+	case REASON_COPY_TO_USER:
+		bug_type = is_uaf ? "kernel-infoleak-after-free" :
+					  "kernel-infoleak";
+		break;
+	case REASON_SUBMIT_URB:
+		bug_type = is_uaf ? "kernel-usb-infoleak-after-free" :
+					  "kernel-usb-infoleak";
+		break;
+	}
+
+	num_stack_entries =
+		stack_trace_save(stack_entries, KMSAN_STACK_DEPTH, 1);
+	skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
+
+	pr_err("BUG: KMSAN: %s in %pS\n", bug_type, stack_entries[skipnr]);
+	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
+			  0);
+	pr_err("\n");
+
+	kmsan_print_origin(origin);
+
+	if (size) {
+		pr_err("\n");
+		if (off_first == off_last)
+			pr_err("Byte %d of %d is uninitialized\n", off_first,
+			       size);
+		else
+			pr_err("Bytes %d-%d of %d are uninitialized\n",
+			       off_first, off_last, size);
+	}
+	if (address)
+		pr_err("Memory access of size %d starts at %px\n", size,
+		       address);
+	if (user_addr && reason == REASON_COPY_TO_USER)
+		pr_err("Data copied to user address %px\n", user_addr);
+	pr_err("\n");
+	dump_stack_print_info(KERN_ERR);
+	pr_err("=====================================================\n");
+	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+	spin_unlock_irqrestore(&kmsan_report_lock, flags);
+	if (panic_on_kmsan)
+		panic("kmsan.panic set ...\n");
+	user_access_restore(ua_flags);
+	current->kmsan_ctx.allow_reporting = true;
+}
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
new file mode 100644
index 0000000000000..c71b0ce19ea6d
--- /dev/null
+++ b/mm/kmsan/shadow.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KMSAN shadow implementation.
+ *
+ * Copyright (C) 2017-2021 Google LLC
+ * Author: Alexander Potapenko <glider@google.com>
+ *
+ */
+
+#include <asm/page.h>
+#include <asm/pgtable_64_types.h>
+#include <asm/tlbflush.h>
+#include <linux/cacheflush.h>
+#include <linux/memblock.h>
+#include <linux/mm_types.h>
+#include <linux/percpu-defs.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
+
+#include "kmsan.h"
+
+#define shadow_page_for(page) ((page)->kmsan_shadow)
+
+#define origin_page_for(page) ((page)->kmsan_origin)
+
+static void *shadow_ptr_for(struct page *page)
+{
+	return page_address(shadow_page_for(page));
+}
+
+static void *origin_ptr_for(struct page *page)
+{
+	return page_address(origin_page_for(page));
+}
+
+static bool page_has_metadata(struct page *page)
+{
+	return shadow_page_for(page) && origin_page_for(page);
+}
+
+static void set_no_shadow_origin_page(struct page *page)
+{
+	shadow_page_for(page) = NULL;
+	origin_page_for(page) = NULL;
+}
+
+/*
+ * Dummy load and store pages to be used when the real metadata is unavailable.
+ * There are separate pages for loads and stores, so that every load returns a
+ * zero, and every store doesn't affect other loads.
+ */
+static char dummy_load_page[PAGE_SIZE] __aligned(PAGE_SIZE);
+static char dummy_store_page[PAGE_SIZE] __aligned(PAGE_SIZE);
+
+/*
+ * Taken from arch/x86/mm/physaddr.h to avoid using an instrumented version.
+ */
+static int kmsan_phys_addr_valid(unsigned long addr)
+{
+	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
+		return !(addr >> boot_cpu_data.x86_phys_bits);
+	else
+		return 1;
+}
+
+/*
+ * Taken from arch/x86/mm/physaddr.c to avoid using an instrumented version.
+ */
+static bool kmsan_virt_addr_valid(void *addr)
+{
+	unsigned long x = (unsigned long)addr;
+	unsigned long y = x - __START_KERNEL_map;
+
+	/* use the carry flag to determine if x was < __START_KERNEL_map */
+	if (unlikely(x > y)) {
+		x = y + phys_base;
+
+		if (y >= KERNEL_IMAGE_SIZE)
+			return false;
+	} else {
+		x = y + (__START_KERNEL_map - PAGE_OFFSET);
+
+		/* carry flag will be set if starting x was >= PAGE_OFFSET */
+		if ((x > y) || !kmsan_phys_addr_valid(x))
+			return false;
+	}
+
+	return pfn_valid(x >> PAGE_SHIFT);
+}
+
+static unsigned long vmalloc_meta(void *addr, bool is_origin)
+{
+	unsigned long addr64 = (unsigned long)addr, off;
+
+	KMSAN_WARN_ON(is_origin && !IS_ALIGNED(addr64, KMSAN_ORIGIN_SIZE));
+	if (kmsan_internal_is_vmalloc_addr(addr)) {
+		off = addr64 - VMALLOC_START;
+		return off + (is_origin ? KMSAN_VMALLOC_ORIGIN_START :
+						KMSAN_VMALLOC_SHADOW_START);
+	}
+	if (kmsan_internal_is_module_addr(addr)) {
+		off = addr64 - MODULES_VADDR;
+		return off + (is_origin ? KMSAN_MODULES_ORIGIN_START :
+						KMSAN_MODULES_SHADOW_START);
+	}
+	return 0;
+}
+
+static struct page *virt_to_page_or_null(void *vaddr)
+{
+	if (kmsan_virt_addr_valid(vaddr))
+		return virt_to_page(vaddr);
+	else
+		return NULL;
+}
+
+struct shadow_origin_ptr kmsan_get_shadow_origin_ptr(void *address, u64 size,
+						     bool store)
+{
+	struct shadow_origin_ptr ret;
+	void *shadow;
+
+	/*
+	 * Even if we redirect this memory access to the dummy page, it will
+	 * go out of bounds.
+	 */
+	KMSAN_WARN_ON(size > PAGE_SIZE);
+
+	if (!kmsan_enabled || kmsan_in_runtime())
+		goto return_dummy;
+
+	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(address, size));
+	shadow = kmsan_get_metadata(address, KMSAN_META_SHADOW);
+	if (!shadow)
+		goto return_dummy;
+
+	ret.shadow = shadow;
+	ret.origin = kmsan_get_metadata(address, KMSAN_META_ORIGIN);
+	return ret;
+
+return_dummy:
+	if (store) {
+		/* Ignore this store. */
+		ret.shadow = dummy_store_page;
+		ret.origin = dummy_store_page;
+	} else {
+		/* This load will return zero. */
+		ret.shadow = dummy_load_page;
+		ret.origin = dummy_load_page;
+	}
+	return ret;
+}
+
+/*
+ * Obtain the shadow or origin pointer for the given address, or NULL if there's
+ * none. The caller must check the return value for being non-NULL if needed.
+ * The return value of this function should not depend on whether we're in the
+ * runtime or not.
+ */
+void *kmsan_get_metadata(void *address, bool is_origin)
+{
+	u64 addr = (u64)address, pad, off;
+	struct page *page;
+	void *ret;
+
+	if (is_origin && !IS_ALIGNED(addr, KMSAN_ORIGIN_SIZE)) {
+		pad = addr % KMSAN_ORIGIN_SIZE;
+		addr -= pad;
+	}
+	address = (void *)addr;
+	if (kmsan_internal_is_vmalloc_addr(address) ||
+	    kmsan_internal_is_module_addr(address))
+		return (void *)vmalloc_meta(address, is_origin);
+
+	page = virt_to_page_or_null(address);
+	if (!page)
+		return NULL;
+	if (!page_has_metadata(page))
+		return NULL;
+	off = addr % PAGE_SIZE;
+
+	ret = (is_origin ? origin_ptr_for(page) : shadow_ptr_for(page)) + off;
+	return ret;
+}
+
+/* Allocate metadata for pages allocated at boot time. */
+void __init kmsan_init_alloc_meta_for_range(void *start, void *end)
+{
+	struct page *shadow_p, *origin_p;
+	void *shadow, *origin;
+	struct page *page;
+	u64 addr, size;
+
+	start = (void *)ALIGN_DOWN((u64)start, PAGE_SIZE);
+	size = ALIGN((u64)end - (u64)start, PAGE_SIZE);
+	shadow = memblock_alloc(size, PAGE_SIZE);
+	origin = memblock_alloc(size, PAGE_SIZE);
+	for (addr = 0; addr < size; addr += PAGE_SIZE) {
+		page = virt_to_page_or_null((char *)start + addr);
+		shadow_p = virt_to_page_or_null((char *)shadow + addr);
+		set_no_shadow_origin_page(shadow_p);
+		shadow_page_for(page) = shadow_p;
+		origin_p = virt_to_page_or_null((char *)origin + addr);
+		set_no_shadow_origin_page(origin_p);
+		origin_page_for(page) = origin_p;
+	}
+}
+
+/* Called from mm/memory.c */
+void kmsan_copy_page_meta(struct page *dst, struct page *src)
+{
+	if (!kmsan_enabled || kmsan_in_runtime())
+		return;
+	if (!dst || !page_has_metadata(dst))
+		return;
+	if (!src || !page_has_metadata(src)) {
+		kmsan_internal_unpoison_memory(page_address(dst), PAGE_SIZE,
+					       /*checked*/ false);
+		return;
+	}
+
+	kmsan_enter_runtime();
+	__memcpy(shadow_ptr_for(dst), shadow_ptr_for(src), PAGE_SIZE);
+	__memcpy(origin_ptr_for(dst), origin_ptr_for(src), PAGE_SIZE);
+	kmsan_leave_runtime();
+}
+
+/* Called from mm/page_alloc.c */
+void kmsan_alloc_page(struct page *page, unsigned int order, gfp_t flags)
+{
+	bool initialized = (flags & __GFP_ZERO) || !kmsan_enabled;
+	struct page *shadow, *origin;
+	depot_stack_handle_t handle;
+	int pages = 1 << order;
+	int i;
+
+	if (!page)
+		return;
+
+	shadow = shadow_page_for(page);
+	origin = origin_page_for(page);
+
+	if (initialized) {
+		__memset(page_address(shadow), 0, PAGE_SIZE * pages);
+		__memset(page_address(origin), 0, PAGE_SIZE * pages);
+		return;
+	}
+
+	/* Zero pages allocated by the runtime should also be initialized. */
+	if (kmsan_in_runtime())
+		return;
+
+	__memset(page_address(shadow), -1, PAGE_SIZE * pages);
+	kmsan_enter_runtime();
+	handle = kmsan_save_stack_with_flags(flags, /*extra_bits*/ 0);
+	kmsan_leave_runtime();
+	/*
+	 * Addresses are page-aligned, pages are contiguous, so it's ok
+	 * to just fill the origin pages with |handle|.
+	 */
+	for (i = 0; i < PAGE_SIZE * pages / sizeof(handle); i++)
+		((depot_stack_handle_t *)page_address(origin))[i] = handle;
+}
+
+/* Called from mm/page_alloc.c */
+void kmsan_free_page(struct page *page, unsigned int order)
+{
+	return; // really nothing to do here. Could rewrite shadow instead.
+}
+
+/* Called from mm/vmalloc.c */
+void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
+				    pgprot_t prot, struct page **pages,
+				    unsigned int page_shift)
+{
+	unsigned long shadow_start, origin_start, shadow_end, origin_end;
+	struct page **s_pages, **o_pages;
+	int nr, i, mapped;
+
+	if (!kmsan_enabled)
+		return;
+
+	shadow_start = vmalloc_meta((void *)start, KMSAN_META_SHADOW);
+	shadow_end = vmalloc_meta((void *)end, KMSAN_META_SHADOW);
+	if (!shadow_start)
+		return;
+
+	nr = (end - start) / PAGE_SIZE;
+	s_pages = kcalloc(nr, sizeof(struct page *), GFP_KERNEL);
+	o_pages = kcalloc(nr, sizeof(struct page *), GFP_KERNEL);
+	if (!s_pages || !o_pages)
+		goto ret;
+	for (i = 0; i < nr; i++) {
+		s_pages[i] = shadow_page_for(pages[i]);
+		o_pages[i] = origin_page_for(pages[i]);
+	}
+	prot = __pgprot(pgprot_val(prot) | _PAGE_NX);
+	prot = PAGE_KERNEL;
+
+	origin_start = vmalloc_meta((void *)start, KMSAN_META_ORIGIN);
+	origin_end = vmalloc_meta((void *)end, KMSAN_META_ORIGIN);
+	kmsan_enter_runtime();
+	mapped = __vmap_pages_range_noflush(shadow_start, shadow_end, prot,
+					    s_pages, page_shift);
+	KMSAN_WARN_ON(mapped);
+	mapped = __vmap_pages_range_noflush(origin_start, origin_end, prot,
+					    o_pages, page_shift);
+	KMSAN_WARN_ON(mapped);
+	kmsan_leave_runtime();
+	flush_tlb_kernel_range(shadow_start, shadow_end);
+	flush_tlb_kernel_range(origin_start, origin_end);
+	flush_cache_vmap(shadow_start, shadow_end);
+	flush_cache_vmap(origin_start, origin_end);
+
+ret:
+	kfree(s_pages);
+	kfree(o_pages);
+}
+
+void kmsan_setup_meta(struct page *page, struct page *shadow,
+		      struct page *origin, int order)
+{
+	int i;
+
+	for (i = 0; i < (1 << order); i++) {
+		set_no_shadow_origin_page(&shadow[i]);
+		set_no_shadow_origin_page(&origin[i]);
+		shadow_page_for(&page[i]) = &shadow[i];
+		origin_page_for(&page[i]) = &origin[i];
+	}
+}
diff --git a/scripts/Makefile.kmsan b/scripts/Makefile.kmsan
new file mode 100644
index 0000000000000..9793591f9855c
--- /dev/null
+++ b/scripts/Makefile.kmsan
@@ -0,0 +1 @@
+export CFLAGS_KMSAN := -fsanitize=kernel-memory
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d1f865b8c0cba..3a0dbcea51d01 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -162,6 +162,15 @@ _c_flags += $(if $(patsubst n%,, \
 endif
 endif
 
+ifeq ($(CONFIG_KMSAN),y)
+_c_flags += $(if $(patsubst n%,, \
+		$(KMSAN_SANITIZE_$(basetarget).o)$(KMSAN_SANITIZE)y), \
+		$(CFLAGS_KMSAN))
+_c_flags += $(if $(patsubst n%,, \
+		$(KMSAN_ENABLE_CHECKS_$(basetarget).o)$(KMSAN_ENABLE_CHECKS)y), \
+		, -mllvm -msan-disable-checks=1)
+endif
+
 ifeq ($(CONFIG_UBSAN),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)$(CONFIG_UBSAN_SANITIZE_ALL)), \
-- 
2.34.1.173.g76aa8bc2d0-goog

