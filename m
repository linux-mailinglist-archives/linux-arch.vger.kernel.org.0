Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E8A6D0EA
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 17:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGRPTW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jul 2019 11:19:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44229 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfGRPTW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 11:19:22 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so51924657iob.11
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2019 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Tbdphi8CrHqxWHaUURv6oHYNP9deEDGvOFqbwoY/Y0A=;
        b=Whrg4ctJ0WfkjGBYTaCrG+D6OUBE6Tnw2Q7NONAXv+ZDC7WaJk7O/zUK8LXgq2k3Ug
         +qTt5c8636LeXcgwlJEcjTHzHptqGk1UqFvxsyI6zIN+THsqZBsdSVj8LzsXyKyCIHRL
         0USaC0X5nlwytiSP2kYkwdGcBwd73zv3lfOCjv12guAZ3v/OBTP3oDgvutNdUS5L4K6J
         0qkHT1cN+JskUi2h+eLROZtGK4Cr4BxwokYvj2FD2q1566I6cyMJmiPLHO6BgLyvxFox
         IJkRT/G6wFPPC7XKT9TUQzPO6gRdtKQSeOVhIRwjy+FLmyG5B0MzDr31eEE9A+s15B+r
         v5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Tbdphi8CrHqxWHaUURv6oHYNP9deEDGvOFqbwoY/Y0A=;
        b=i08yWfRa/SuFQ+mK8353/hF4Icfs8u9LkE3n1DXWfkV/S3bgaG4rV4HIsPiUGUWdzX
         /GMadHOCBOLRyT8wsrmkPEK8kYH9gK09tcyKroZroBj+Zub9ma9QOP/YR2Ev6mLGJtQH
         LAg9R6G5HVfZyvg8KPczwwSjlhgCjYArTCXQ1nLG2ZEF5UF1LD6uxjCmmYYHSIbrKs8T
         q5P+DQZ3Q33tPX02ggYHQasYF+zKmbx6S3VJz+JiHS+kalAJLPU1zy/rLu8V6kxiM3cv
         pPW2jGwaPvg+IOZke1vnMGSS33gNskrV6z4ncviEGoim0z9oIlDTEiD56iUqxQeFZgfA
         seGA==
X-Gm-Message-State: APjAAAX2H8b27u5xlZoJ9EicLF0aZtA3/HH07rlsPer+RnKiDIVsReMJ
        agBZ5C3EvVlzaanO2EkrInd6ViWj6i4=
X-Google-Smtp-Source: APXvYqzvbLr4vBoZPuts04IwgqzTfGI1ll4gN2+jq8yvFshv6/nee/WwlsDHKhSf/3Vy1rhbpwZ+ug==
X-Received: by 2002:a5d:8e08:: with SMTP id e8mr46043389iod.139.1563463161307;
        Thu, 18 Jul 2019 08:19:21 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id n7sm20848114ioo.79.2019.07.18.08.19.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 08:19:20 -0700 (PDT)
Date:   Thu, 18 Jul 2019 08:19:19 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     cai@lca.pw, arnd@arndb.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH] riscv: fix build break after macro-to-function conversion
 in generic cacheflush.h
Message-ID: <alpine.DEB.2.21.9999.1907180800440.18568@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Commit c296d4dc13ae ("asm-generic: fix a compilation warning")
converted the various flush_*cache_* macros in
asm-generic/cacheflush.h to static inline functions.  This breaks
RISC-V builds, since RISC-V's cacheflush.h includes the generic
cacheflush.h and then undefines the macros to be overridden.

Fix by copying the subset of the no-op functions that are reused from
the generic cacheflush.h into the RISC-V cacheflush.h, and dropping
the include of the generic cacheflush.h.

Fixes: c296d4dc13ae ("asm-generic: fix a compilation warning")
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Queued with the other arch/riscv patches for the 5.3 merge window.

 arch/riscv/include/asm/cacheflush.h | 63 +++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index ad8678f1b54a..555b20b11dc3 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -6,11 +6,66 @@
 #ifndef _ASM_RISCV_CACHEFLUSH_H
 #define _ASM_RISCV_CACHEFLUSH_H
 
-#include <asm-generic/cacheflush.h>
+#include <linux/mm.h>
 
-#undef flush_icache_range
-#undef flush_icache_user_range
-#undef flush_dcache_page
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
+
+/*
+ * The cache doesn't need to be flushed when TLB entries change when
+ * the cache is mapped to physical memory, not virtual memory
+ */
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
+static inline void flush_dcache_mmap_lock(struct address_space *mapping)
+{
+}
+
+static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
+{
+}
+
+static inline void flush_icache_page(struct vm_area_struct *vma,
+				     struct page *page)
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
+
+#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
+	do { \
+		memcpy(dst, src, len); \
+		flush_icache_user_range(vma, page, vaddr, len); \
+	} while (0)
+#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
+	memcpy(dst, src, len)
 
 static inline void local_flush_icache_all(void)
 {
-- 
2.22.0

