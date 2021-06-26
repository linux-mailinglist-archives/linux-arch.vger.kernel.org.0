Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A584C3B4D5E
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhFZH3c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Jun 2021 03:29:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5434 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhFZH3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jun 2021 03:29:25 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GBljC6Wc4z74VK;
        Sat, 26 Jun 2021 15:23:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:27:01 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:27:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Paul Mackerras" <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 8/9] powerpc/mm: Use is_kernel_text() and is_kernel_inittext() helper
Date:   Sat, 26 Jun 2021 15:34:38 +0800
Message-ID: <20210626073439.150586-9-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use is_kernel_text() and is_kernel_inittext() helper to simplify code,
also drop etext, _stext, _sinittext, _einittext declaration which
already declared in section.h.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/powerpc/mm/pgtable_32.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index dcf5ecca19d9..13c798308c2e 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -33,8 +33,6 @@
 
 #include <mm/mmu_decl.h>
 
-extern char etext[], _stext[], _sinittext[], _einittext[];
-
 static u8 early_fixmap_pagetable[FIXMAP_PTE_SIZE] __page_aligned_data;
 
 notrace void __init early_ioremap_init(void)
@@ -104,14 +102,13 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 {
 	unsigned long v, s;
 	phys_addr_t p;
-	int ktext;
+	bool ktext;
 
 	s = offset;
 	v = PAGE_OFFSET + s;
 	p = memstart_addr + s;
 	for (; s < top; s += PAGE_SIZE) {
-		ktext = ((char *)v >= _stext && (char *)v < etext) ||
-			((char *)v >= _sinittext && (char *)v < _einittext);
+		ktext = (is_kernel_text(v) || is_kernel_inittext(v));
 		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
-- 
2.26.2

