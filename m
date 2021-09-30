Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4431D41D400
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 09:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbhI3HLJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 03:11:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13862 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348536AbhI3HLH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Sep 2021 03:11:07 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HKkkz4m1rz8yxW;
        Thu, 30 Sep 2021 15:04:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 15:09:22 +0800
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
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4 11/11] alpha: Use is_kernel_text() helper
Date:   Thu, 30 Sep 2021 15:11:43 +0800
Message-ID: <20210930071143.63410-12-wangkefeng.wang@huawei.com>
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

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/alpha/kernel/traps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index e805106409f7..2ae34702456c 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -129,9 +129,7 @@ dik_show_trace(unsigned long *sp, const char *loglvl)
 		extern char _stext[], _etext[];
 		unsigned long tmp = *sp;
 		sp++;
-		if (tmp < (unsigned long) &_stext)
-			continue;
-		if (tmp >= (unsigned long) &_etext)
+		if (!is_kernel_text(tmp))
 			continue;
 		printk("%s[<%lx>] %pSR\n", loglvl, tmp, (void *)tmp);
 		if (i > 40) {
-- 
2.26.2

