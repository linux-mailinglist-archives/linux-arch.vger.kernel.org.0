Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7439C4186EC
	for <lists+linux-arch@lfdr.de>; Sun, 26 Sep 2021 09:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhIZHTr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Sep 2021 03:19:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:19366 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhIZHTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Sep 2021 03:19:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HHH7P3s2rzRW6s;
        Sun, 26 Sep 2021 15:13:53 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sun, 26 Sep 2021 15:18:08 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sun, 26 Sep 2021 15:18:07 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <ryabinin.a.a@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <bpf@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 2/9] kallsyms: Fix address-checks for kernel related range
Date:   Sun, 26 Sep 2021 15:20:41 +0800
Message-ID: <20210926072048.190336-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210926072048.190336-1-wangkefeng.wang@huawei.com>
References: <20210926072048.190336-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The is_kernel_inittext/is_kernel_text/is_kernel function should not
include the end address(the labels _einittext, _etext and _end) when
check the address range, the issue exists since Linux v2.6.12.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/kallsyms.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 2a241e3f063f..b016c62f30a6 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -27,21 +27,21 @@ struct module;
 static inline int is_kernel_inittext(unsigned long addr)
 {
 	if (addr >= (unsigned long)_sinittext
-	    && addr <= (unsigned long)_einittext)
+	    && addr < (unsigned long)_einittext)
 		return 1;
 	return 0;
 }
 
 static inline int is_kernel_text(unsigned long addr)
 {
-	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext))
+	if ((addr >= (unsigned long)_stext && addr < (unsigned long)_etext))
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
 
 static inline int is_kernel(unsigned long addr)
 {
-	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
+	if (addr >= (unsigned long)_stext && addr < (unsigned long)_end)
 		return 1;
 	return in_gate_area_no_mm(addr);
 }
-- 
2.26.2

