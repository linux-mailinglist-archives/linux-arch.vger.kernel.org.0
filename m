Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D75389D3
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 04:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbiEaCKM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 22:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbiEaCKG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 22:10:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804BC880E9;
        Mon, 30 May 2022 19:10:05 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LBwdG3F9szQkRX;
        Tue, 31 May 2022 10:06:58 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 10:09:33 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 10:09:33 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
CC:     <jpoimboe@redhat.com>, <peterz@infradead.org>,
        <madvenka@linux.microsoft.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <arnd@arndb.de>, <akpm@linux-foundation.org>,
        <andreyknvl@gmail.com>, <wangkefeng.wang@huawei.com>,
        <andrealmeid@collabora.com>, <mhiramat@kernel.org>,
        <mcgrof@kernel.org>, <christophe.leroy@csgroup.eu>,
        <dmitry.torokhov@gmail.com>, <yangtiezhu@loongson.cn>,
        <dave.hansen@linux.intel.com>
Subject: [PATCH 4/4] objtool: Specify host-arch for making LIBSUBCMD
Date:   Tue, 31 May 2022 10:07:44 +0800
Message-ID: <20220531020744.236970-5-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220531020744.236970-1-chenzhongjin@huawei.com>
References: <20220531020744.236970-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When singly cross-compiling objtool, LIBSUBCMD MAKE uses target-arch and
failed to LD with other object files.

Explicitly specify host-arch for LIBSUBCMD so it can be correctly
cross-compiled.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index e66d717c245d..2b97720ab608 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -58,7 +58,7 @@ $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
 
 
 $(LIBSUBCMD): fixdep FORCE
-	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT)
+	$(Q)$(MAKE) -C $(SUBCMD_SRCDIR) OUTPUT=$(LIBSUBCMD_OUTPUT) AR=$(AR) CC=$(CC) LD=$(LD)
 
 clean:
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
-- 
2.17.1

