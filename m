Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486A355896
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 22:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFYUQM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 16:16:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40912 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFYUQM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2019 16:16:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id c70so13714042qkg.7
        for <linux-arch@vger.kernel.org>; Tue, 25 Jun 2019 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EHMefmzmm9Mbm1HdA6t6Th6pkkLYZ7z1lPsMohb4ueM=;
        b=jQEW/T2ioqSIqEH27/wZQTyrqpiEYcNggCDHviY4u9btaR8yZoYlXSWPrKMFn7apE8
         PBuyIreqmpc+Lf7NumD1HggoEi0F4hYdinjaGIhvBfDTYmQotHCEvoXkcceFfz8/7zBL
         u2A9hF+PYo+U+dtqOFkj4I5dvF2XBnfu6RGHfyXFysDfJ1nObukECX6GkskYYU8B+Fqz
         3Oq6PkIiN3SS2mapgeNeub+SvBZUFBRR7y7EnlDj3japM2CUxAl9ARftjB0jnv4iGmjW
         2Au7woSG5+Zu9ax6vjJTmKSryKe8dwOYoQTBV5kumsqeg6//0DKTG3FDwt3iQaxGmEqR
         w5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EHMefmzmm9Mbm1HdA6t6Th6pkkLYZ7z1lPsMohb4ueM=;
        b=rlI498W+sl5XHaW2j/9tiHru0uGnKcelZyEyxunvu7lFJEXtpFQmxgB3NDAjS938UI
         hrbo4PIIt8cwWWmeNUVxeIVPMG0/AXmZoNWY0PZspxXGYencLKE1x13CrGRGF0JkApQF
         m5l64ti7fmZ5vTRpLjAI87ogMohreqAM+VTc/eXBlJI1YI7SPG9ymrLCx3QsjF4usnVP
         Jo1ZPLyP7Li204YAuWXmbaZgvNNmzSjV69aNU/ZxQnMmhn7axoJuPiwvQp/mZtYRWdJ+
         s9g0aWiF4u+W8uFttLGGqbiaKLLT8VVM1eG/361mxNWrgVlL3fu7O6hMZJj/7zG/ou3t
         DwUw==
X-Gm-Message-State: APjAAAXgCMXPSlUd/EnPegHogMAZOlMTpYV4Evp+d4x7QA2qoamALo88
        EwbD7wjFibMvMnNbGNmpjbUgeCNjVYc=
X-Google-Smtp-Source: APXvYqx3MPsUMRt5L9qn0ZkLk78knyCrOQppj49qrRRC6+2rbLzmvuLW9r6dOWuSjAah5DvgrMzlrg==
X-Received: by 2002:a37:ac0a:: with SMTP id e10mr558920qkm.168.1561493771373;
        Tue, 25 Jun 2019 13:16:11 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u1sm9600931qth.21.2019.06.25.13.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 13:16:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] asm-generic: fix a compilation warning
Date:   Tue, 25 Jun 2019 16:15:53 -0400
Message-Id: <1561493753-3860-1-git-send-email-cai@lca.pw>
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

