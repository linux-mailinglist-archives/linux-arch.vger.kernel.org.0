Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA559AACB
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 04:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiHTC6N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 22:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiHTC6L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 22:58:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364DC4826;
        Fri, 19 Aug 2022 19:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DABFB828A4;
        Sat, 20 Aug 2022 02:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0ECC433C1;
        Sat, 20 Aug 2022 02:58:04 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] LoongArch: Select PCI_QUIRKS to avoid build error
Date:   Sat, 20 Aug 2022 10:57:55 +0800
Message-Id: <20220820025755.3110083-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PCI_LOONGSON is a mandatory for LoongArch and it is selected in Kconfig
unconditionally, but its dependency PCI_QUIRKS is missing and may cause
a build error when "make randconfig":

   arch/loongarch/pci/acpi.c: In function 'pci_acpi_setup_ecam_mapping':
>> arch/loongarch/pci/acpi.c:103:29: error: 'loongson_pci_ecam_ops' undeclared (first use in this function)
     103 |                 ecam_ops = &loongson_pci_ecam_ops;
         |                             ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/pci/acpi.c:103:29: note: each undeclared identifier is reported only once for each function it appears in

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PCI_LOONGSON
   Depends on [n]: PCI [=y] && (MACH_LOONGSON64 [=y] || COMPILE_TEST [=y]) && (OF [=y] || ACPI [=y]) && PCI_QUIRKS [=n]
   Selected by [y]:
   - LOONGARCH [=y]

Fix it by selecting PCI_QUIRKS unconditionally, too.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 4abc9a28aba4..26aeb1408e56 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -111,6 +111,7 @@ config LOONGARCH
 	select PCI_ECAM if ACPI
 	select PCI_LOONGSON
 	select PCI_MSI_ARCH_FALLBACKS
+	select PCI_QUIRKS
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SMP
-- 
2.31.1

