Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3328648E88D
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jan 2022 11:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiANKue (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jan 2022 05:50:34 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17351 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbiANKud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Jan 2022 05:50:33 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JZyjF4cKjz9sH9;
        Fri, 14 Jan 2022 18:49:21 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 18:50:31 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 18:50:30 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <arnd@arndb.de>, <catalin.marinas@arm.com>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <huangguangbin2@huawei.com>
Subject: [PATCH] asm-generic: Add missing brackets for io_stop_wc macro
Date:   Fri, 14 Jan 2022 18:58:57 +0800
Message-ID: <20220114105857.126300-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

After using io_stop_wc(), drivers reports following compile error when
compiled on X86.

  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c: In function ‘hns3_tx_push_bd’:
  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c:2058:12: error: expected ‘;’ before ‘(’ token
    io_stop_wc();
              ^
It is because I missed to add the brackets after io_stop_wc macro. So
let's add the missing brackets.

Fixes: d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")
Reported-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 include/asm-generic/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 3d503e74037f..fd7e8fbaeef1 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -285,7 +285,7 @@ do {									\
  * write-combining memory accesses before this macro with those after it.
  */
 #ifndef io_stop_wc
-#define io_stop_wc do { } while (0)
+#define io_stop_wc() do { } while (0)
 #endif
 
 #endif /* !__ASSEMBLY__ */
-- 
2.20.1

