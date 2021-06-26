Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC93B4D54
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFZH3Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Jun 2021 03:29:24 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8306 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFZH3W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jun 2021 03:29:22 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GBlfw6SS8z1BS2c;
        Sat, 26 Jun 2021 15:21:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:26:58 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 15:26:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/9] kallsyms: Fix address-checks for kernel related range
Date:   Sat, 26 Jun 2021 15:34:32 +0800
Message-ID: <20210626073439.150586-3-wangkefeng.wang@huawei.com>
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

The is_kernel_inittext/is_kernel_text/is_kernel function should not
include the end address(the labels _einittext, _etext and _end) when
check the address range.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Fixes: 04b8eb7a4ccd ("symbol lookup: introduce dereference_symbol_descriptor()")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/kallsyms.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index d773732cc8eb..c44c26977805 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -26,21 +26,21 @@ struct module;
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

