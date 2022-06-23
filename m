Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E710557078
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 03:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378034AbiFWBxP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 21:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377427AbiFWBwH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 21:52:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B94643AEE;
        Wed, 22 Jun 2022 18:51:52 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LT39D2XFtzkWVf;
        Thu, 23 Jun 2022 09:50:08 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:50 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 09:51:50 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kbuild@vger.kernel.org>, <live-patching@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <peterz@infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>, <mark.rutland@arm.com>,
        <pasha.tatashin@soleen.com>, <broonie@kernel.org>,
        <chenzhongjin@huawei.com>, <rmk+kernel@armlinux.org.uk>,
        <madvenka@linux.microsoft.com>, <christophe.leroy@csgroup.eu>,
        <daniel.thompson@linaro.org>
Subject: [PATCH v6 22/33] arm64: efi-header: Mark efi header as data
Date:   Thu, 23 Jun 2022 09:49:06 +0800
Message-ID: <20220623014917.199563-23-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220623014917.199563-1-chenzhongjin@huawei.com>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

This file only contains a set of constants forming the efi header.

Make the constants part of a data symbol.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/kernel/efi-header.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
index 28d8a5dca5f1..3eacd27ab761 100644
--- a/arch/arm64/kernel/efi-header.S
+++ b/arch/arm64/kernel/efi-header.S
@@ -28,6 +28,7 @@
 	.macro	__EFI_PE_HEADER
 #ifdef CONFIG_EFI
 	.set	.Lpe_header_offset, . - .L_head
+SYM_DATA_START_LOCAL(arm64_efi_header)
 	.long	PE_MAGIC
 	.short	IMAGE_FILE_MACHINE_ARM64		// Machine
 	.short	.Lsection_count				// NumberOfSections
@@ -160,6 +161,7 @@
 
 	.balign	SEGMENT_ALIGN
 .Lefi_header_end:
+SYM_DATA_END_LABEL(arm64_efi_header, SYM_L_LOCAL, efi_header_end)
 #else
 	.set	.Lpe_header_offset, 0x0
 #endif
-- 
2.17.1

