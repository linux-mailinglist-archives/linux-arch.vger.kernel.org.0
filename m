Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A431B41D40A
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348595AbhI3HLP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 03:11:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:27939 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348554AbhI3HLJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 03:11:09 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HKklR0RdKzbn02;
        Thu, 30 Sep 2021 15:05:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 15:09:21 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 15:09:21 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <ryabinin.a.a@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <bpf@vger.kernel.org>,
        <linux-alpha@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v4 10/11] microblaze: Use is_kernel_text() helper
Date:   Thu, 30 Sep 2021 15:11:42 +0800
Message-ID: <20210930071143.63410-11-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210930071143.63410-1-wangkefeng.wang@huawei.com>
References: <20210930071143.63410-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use is_kernel_text() helper to simplify code.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/microblaze/mm/pgtable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
index c1833b159d3b..9f73265aad4e 100644
--- a/arch/microblaze/mm/pgtable.c
+++ b/arch/microblaze/mm/pgtable.c
@@ -34,6 +34,7 @@
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
 #include <linux/memblock.h>
+#include <linux/kallsyms.h>
 
 #include <asm/pgalloc.h>
 #include <linux/io.h>
@@ -171,7 +172,7 @@ void __init mapin_ram(void)
 	for (s = 0; s < lowmem_size; s += PAGE_SIZE) {
 		f = _PAGE_PRESENT | _PAGE_ACCESSED |
 				_PAGE_SHARED | _PAGE_HWEXEC;
-		if ((char *) v < _stext || (char *) v >= _etext)
+		if (!is_kernel_text(v))
 			f |= _PAGE_WRENABLE;
 		else
 			/* On the MicroBlaze, no user access
-- 
2.26.2

