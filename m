Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B98C20C261
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 16:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgF0OgG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 10:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgF0OgG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jun 2020 10:36:06 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0EC207FC;
        Sat, 27 Jun 2020 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593268565;
        bh=c/eMZI3jQgAi5SoZSPf0xO2BFRL8cRrF8f5daihy1NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tavnjC0OxMDJoIlyDxFikqduze2IUaa0AgGq0rxYqYJlFONRgjoXyQz2IHmDHLbJ9
         BzFf/ighE7YqPkBb3l3Iq1iklT/uak8w0WeCI9qhOuodXq20/x69FsxHo0DOq6l+eS
         UkDvWiqOG/pqcuds69Lm/5lx91K+fpPqfOXqoW7s=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 7/8] mm: move lib/ioremap.c to mm/
Date:   Sat, 27 Jun 2020 17:34:52 +0300
Message-Id: <20200627143453.31835-8-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The functionality in lib/ioremap.c deals with pagetables, vmalloc and
caches, so it naturally belongs to mm/
Moving it there will also allow declaring p?d_alloc_track functions in an
header file inside mm/ rather than having those declarations in
include/linux/mm.h

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 lib/Makefile          | 1 -
 mm/Makefile           | 2 +-
 {lib => mm}/ioremap.c | 0
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename {lib => mm}/ioremap.c (100%)

diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..5f9384adde9c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -37,7 +37,6 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
-lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
 
 lib-y	+= kobject.o klist.o
diff --git a/mm/Makefile b/mm/Makefile
index 6e9d46b2efc9..d5649f1c12c0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -38,7 +38,7 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o
+			   pgtable-generic.o rmap.o vmalloc.o ioremap.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/lib/ioremap.c b/mm/ioremap.c
similarity index 100%
rename from lib/ioremap.c
rename to mm/ioremap.c
-- 
2.26.2

