Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3312F4DD519
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 08:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiCRHNV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 03:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiCRHNU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 03:13:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A072B8811;
        Fri, 18 Mar 2022 00:12:01 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KKZpx3fwrz9snJ;
        Fri, 18 Mar 2022 15:08:09 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 15:11:58 +0800
Received: from huawei.com (10.67.174.205) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 15:11:58 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <arnd@arndb.de>, <ebiederm@xmission.com>, <sam@ravnborg.org>,
        <shorne@gmail.com>, <dinguyen@kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] uaccess: fix __access_ok limit setup in compat mode
Date:   Fri, 18 Mar 2022 15:11:30 +0800
Message-ID: <20220318071130.163942-1-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In __access_ok, TASK_SIZE_MAX is used to check if a memory access
is in user address space, but some cases may get omitted in compat
mode.

For example, a 32-bit testcase calling pread64(fd, buf, -1, 1)
and running in x86-64 kernel, the obviously illegal size "-1" will
get ignored by __access_ok. Since from the kernel point of view,
32-bit userspace 0xffffffff is within the limit of 64-bit
TASK_SIZE_MAX.

Replacing the limit TASK_SIZE_MAX with TASK_SIZE in __access_ok
will fix the problem above.

Fixes: 967747bbc084 ("uaccess: remove CONFIG_SET_FS")
Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
---
 include/asm-generic/access_ok.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/access_ok.h b/include/asm-generic/access_ok.h
index 2866ae61b1cd..824a6bf1c32f 100644
--- a/include/asm-generic/access_ok.h
+++ b/include/asm-generic/access_ok.h
@@ -30,7 +30,7 @@
  */
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
-	unsigned long limit = TASK_SIZE_MAX;
+	unsigned long limit = TASK_SIZE;
 	unsigned long addr = (unsigned long)ptr;
 
 	if (IS_ENABLED(CONFIG_ALTERNATE_USER_ADDRESS_SPACE) ||
-- 
2.31.1

