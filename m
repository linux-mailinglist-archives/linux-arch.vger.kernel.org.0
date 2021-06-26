Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D33B4D62
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhFZH3f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Jun 2021 03:29:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5435 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhFZH32 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jun 2021 03:29:28 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GBljC6cDfz74V6;
        Sat, 26 Jun 2021 15:23:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:27:01 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:27:00 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>
Subject: [PATCH 7/9] s390: kprobes: Use is_kernel() helper
Date:   Sat, 26 Jun 2021 15:34:37 +0800
Message-ID: <20210626073439.150586-8-wangkefeng.wang@huawei.com>
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

Use is_kernel() helper instead of is_kernel_addr().

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/s390/kernel/kprobes.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 528bb31815c3..7e7a8d5219bb 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -92,11 +92,6 @@ static void copy_instruction(struct kprobe *p)
 }
 NOKPROBE_SYMBOL(copy_instruction);
 
-static inline int is_kernel_addr(void *addr)
-{
-	return addr < (void *)_end;
-}
-
 static int s390_get_insn_slot(struct kprobe *p)
 {
 	/*
@@ -105,7 +100,7 @@ static int s390_get_insn_slot(struct kprobe *p)
 	 * field can be patched and executed within the insn slot.
 	 */
 	p->ainsn.insn = NULL;
-	if (is_kernel_addr(p->addr))
+	if (is_kernel(p->addr))
 		p->ainsn.insn = get_s390_insn_slot();
 	else if (is_module_addr(p->addr))
 		p->ainsn.insn = get_insn_slot();
@@ -117,7 +112,7 @@ static void s390_free_insn_slot(struct kprobe *p)
 {
 	if (!p->ainsn.insn)
 		return;
-	if (is_kernel_addr(p->addr))
+	if (is_kernel(p->addr))
 		free_s390_insn_slot(p->ainsn.insn, 0);
 	else
 		free_insn_slot(p->ainsn.insn, 0);
-- 
2.26.2

