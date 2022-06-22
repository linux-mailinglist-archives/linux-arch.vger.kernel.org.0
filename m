Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD80E555026
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jun 2022 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358291AbiFVPyM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jun 2022 11:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359182AbiFVPxC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2022 11:53:02 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA642F037;
        Wed, 22 Jun 2022 08:52:49 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LSnsW0Lrvz1KC5C;
        Wed, 22 Jun 2022 23:50:39 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:46 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 23:52:46 +0800
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
        <madvenka@linux.microsoft.com>, <christophe.leroy@csgroup.eu>
Subject: [PATCH v5 23/33] arm64: head: Mark constants as data
Date:   Wed, 22 Jun 2022 23:49:10 +0800
Message-ID: <20220622154920.95075-24-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220622154920.95075-1-chenzhongjin@huawei.com>
References: <20220622154920.95075-1-chenzhongjin@huawei.com>
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

Add data annotations to constants part of the image header.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm64/kernel/head.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2a66d18091eb..71580eb1fd51 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -63,10 +63,11 @@
 	/*
 	 * DO NOT MODIFY. Image header expected by Linux boot-loaders.
 	 */
-	efi_signature_nop			// special NOP to identity as PE/COFF executable
+SYM_DATA_LOCAL(efi_nop, efi_signature_nop)	// special NOP to identity as PE/COFF executable
 	UNWIND_HINT_EMPTY
 	b	primary_entry			// branch to kernel start, magic
-	.quad	0				// Image load offset from start of RAM, little-endian
+SYM_DATA_LOCAL(_zero_reserved, .quad	0)	// Image load offset from start of RAM, little-endian
+SYM_DATA_START_LOCAL(_arm64_common_header)
 	le64sym	_kernel_size_le			// Effective size of kernel image, little-endian
 	le64sym	_kernel_flags_le		// Informative flags, little-endian
 	.quad	0				// reserved
@@ -74,6 +75,7 @@
 	.quad	0				// reserved
 	.ascii	ARM64_IMAGE_MAGIC		// Magic number
 	.long	.Lpe_header_offset		// Offset to the PE header.
+SYM_DATA_END(_arm64_common_header)
 
 	__EFI_PE_HEADER
 
-- 
2.17.1

