Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030E562006
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2019 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfGHOER (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jul 2019 10:04:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46345 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfGHOER (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jul 2019 10:04:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so15904322qtn.13
        for <linux-arch@vger.kernel.org>; Mon, 08 Jul 2019 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EHMefmzmm9Mbm1HdA6t6Th6pkkLYZ7z1lPsMohb4ueM=;
        b=sIMNHEGp0F8JWetNQVr0B/ZurO66AY4SY48xUOqEiY3Mr0gFu2HT/whDnZV9gpcE+l
         FIRC+JSa3ygobtRT2tARLeqpLK3FdG/8FVaqdfZldNBLqRYZknx2pFZT5Ngkw8ys4H2Z
         MoWnrIlRaGBXC+xw444UM2xHYkT8zPS58TFq0HnqKNV2wI36DOdApW5E/WLOv0vmq/7f
         Xw0IO95KZHDUhOA2Z1vTxRKfPNQPAaRTi/6OmBjEwPI2rEc0kAYPgp7W+3YV8EghqrXn
         qB5pJFTyOZ7i+futkA2tlnVlS6oF10YvrYgRRD5saB1DwNnpppy3FAVhVC4AyiJhr4h8
         gYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EHMefmzmm9Mbm1HdA6t6Th6pkkLYZ7z1lPsMohb4ueM=;
        b=gJGDRbQmcvTfFEYXIOCwAYnD9QBE+7L1XgQyDU0EkqpF6GLvR1P9l+02X3VqB2WLNW
         dyqmradsuY8WGpoSYJQkyYwhH7Ru2rimisDv0CaKuAFJGfSpT9VZrFPf5QHG81XayElF
         VYFVhc13cMFJg6DhULWHs5EJUrsFCVDRCNkXnkV3jywVvRQnGrESJOI9jGpZ2FXHvSgx
         d2dlnhHyMaWcEijEEkr6yNxs/HDZxahu3xTxh+hfAhDDSzI4+h2VACcd68FN8wbuCF2h
         8OzhdhIPeXOF7GONz6lUWDoSQBT1BH0oixGSZd+OF47u/23UP19RfZ1cR6KkVVLgV+3v
         L03g==
X-Gm-Message-State: APjAAAUwzoaHNaQkoPcA0d3UJeiy5l6kVAm55s8vX4XMijlU8k+tdE+c
        Wo+h5Z7HwXbmNTi0w+GHlDUl8w==
X-Google-Smtp-Source: APXvYqyYQMNJjuJrYx3+8PsGGNhA2EyLCKUdg8G3q5avS9pE3nucMlQ8xf/yvGiKg533KkANUoLhpw==
X-Received: by 2002:aed:3c44:: with SMTP id u4mr14107988qte.73.1562594656451;
        Mon, 08 Jul 2019 07:04:16 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a11sm7182473qkn.26.2019.07.08.07.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:04:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] asm-generic: fix a compilation warning
Date:   Mon,  8 Jul 2019 10:03:12 -0400
Message-Id: <1562594592-15228-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix this compilation warning on x86 by making flush_cache_vmap() inline.

lib/ioremap.c: In function 'ioremap_page_range':
lib/ioremap.c:214:16: warning: variable 'start' set but not used
[-Wunused-but-set-variable]
  unsigned long start;
                ^~~~~

While at it, convert all other similar functions to inline for
consistency.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/asm-generic/cacheflush.h | 74 ++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 0dd47a6db2cf..a950a22c4890 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -5,24 +5,70 @@
 /* Keep includes the same across arches.  */
 #include <linux/mm.h>
 
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+
 /*
  * The cache doesn't need to be flushed when TLB entries change when
  * the cache is mapped to physical memory, not virtual memory
  */
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_dup_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do { } while (0)
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-#define flush_icache_range(start, end)		do { } while (0)
-#define flush_icache_page(vma,pg)		do { } while (0)
-#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
-#define flush_cache_vmap(start, end)		do { } while (0)
-#define flush_cache_vunmap(start, end)		do { } while (0)
+static inline void flush_cache_all(void)
+{
+}
+
+static inline void flush_cache_mm(struct mm_struct *mm)
+{
+}
+
+static inline void flush_cache_dup_mm(struct mm_struct *mm)
+{
+}
+
+static inline void flush_cache_range(struct vm_area_struct *vma,
+				     unsigned long start,
+				     unsigned long end)
+{
+}
+
+static inline void flush_cache_page(struct vm_area_struct *vma,
+				    unsigned long vmaddr,
+				    unsigned long pfn)
+{
+}
+
+static inline void flush_dcache_page(struct page *page)
+{
+}
+
+static inline void flush_dcache_mmap_lock(struct address_space *mapping)
+{
+}
+
+static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
+{
+}
+
+static inline void flush_icache_range(unsigned long start, unsigned long end)
+{
+}
+
+static inline void flush_icache_page(struct vm_area_struct *vma,
+				     struct page *page)
+{
+}
+
+static inline void flush_icache_user_range(struct vm_area_struct *vma,
+					   struct page *page,
+					   unsigned long addr, int len)
+{
+}
+
+static inline void flush_cache_vmap(unsigned long start, unsigned long end)
+{
+}
+
+static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
+{
+}
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 	do { \
-- 
1.8.3.1

