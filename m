Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FAC5BB6BB
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 08:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIQGmn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 02:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIQGmm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 02:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC82E6AC;
        Fri, 16 Sep 2022 23:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B536660F7F;
        Sat, 17 Sep 2022 06:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FA1C433D6;
        Sat, 17 Sep 2022 06:42:37 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 2/2] Input: i8042: Add LoongArch support in i8042-acpipnpio.h
Date:   Sat, 17 Sep 2022 14:40:20 +0800
Message-Id: <20220917064020.1639709-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220917064020.1639709-1-chenhuacai@loongson.cn>
References: <20220917064020.1639709-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LoongArch uses ACPI and nearly the same as X86/IA64 for 8042. So modify
i8042-acpipnpio.h slightly and enable it for LoongArch in i8042.h. Then
i8042 driver can work well under the ACPI firmware with PNP typed key-
board and mouse configured in DSDT.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++--
 drivers/input/serio/i8042.h           | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index d14b9fb59d6c..c22151f180bb 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -2,6 +2,7 @@
 #ifndef _I8042_ACPIPNPIO_H
 #define _I8042_ACPIPNPIO_H
 
+#include <linux/acpi.h>
 
 #ifdef CONFIG_X86
 #include <asm/x86_init.h>
@@ -1449,16 +1450,19 @@ static int __init i8042_pnp_init(void)
 
 	if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
 		i8042_pnp_exit();
+		pr_info("PNP: No PS/2 controller found.\n");
 #if defined(__ia64__)
 		return -ENODEV;
+#elif defined(__loongarch__)
+		if (acpi_disabled == 0)
+			return -ENODEV;
 #else
-		pr_info("PNP: No PS/2 controller found.\n");
 		if (x86_platform.legacy.i8042 !=
 				X86_LEGACY_I8042_EXPECTED_PRESENT)
 			return -ENODEV;
+#endif
 		pr_info("Probing ports directly.\n");
 		return 0;
-#endif
 	}
 
 	if (i8042_pnp_kbd_devices)
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index bf2592fa9a78..adb5173372d3 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -19,7 +19,7 @@
 #include "i8042-snirm.h"
 #elif defined(CONFIG_SPARC)
 #include "i8042-sparcio.h"
-#elif defined(CONFIG_X86) || defined(CONFIG_IA64)
+#elif defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_LOONGARCH)
 #include "i8042-acpipnpio.h"
 #else
 #include "i8042-io.h"
-- 
2.31.1

