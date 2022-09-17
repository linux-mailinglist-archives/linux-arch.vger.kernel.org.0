Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0F5BB6B4
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 08:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIQGlf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQGle (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 02:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939206553;
        Fri, 16 Sep 2022 23:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D86960F7F;
        Sat, 17 Sep 2022 06:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ED6C433C1;
        Sat, 17 Sep 2022 06:41:29 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/2] Input: i8042: Rename i8042-x86ia64io.h to i8042-acpipnpio.h
Date:   Sat, 17 Sep 2022 14:40:19 +0800
Message-Id: <20220917064020.1639709-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
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

Now i8042-x86ia64io.h is shared by X86 and IA64, but it can be shared
by more platforms (such as LoongArch) with ACPI firmware on which PNP
typed keyboard and mouse is configured in DSDT. So rename it to i8042-
acpipnpio.h.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../input/serio/{i8042-x86ia64io.h => i8042-acpipnpio.h}    | 6 +++---
 drivers/input/serio/i8042.h                                 | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/input/serio/{i8042-x86ia64io.h => i8042-acpipnpio.h} (99%)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-acpipnpio.h
similarity index 99%
rename from drivers/input/serio/i8042-x86ia64io.h
rename to drivers/input/serio/i8042-acpipnpio.h
index 4fbec7bbecca..d14b9fb59d6c 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _I8042_X86IA64IO_H
-#define _I8042_X86IA64IO_H
+#ifndef _I8042_ACPIPNPIO_H
+#define _I8042_ACPIPNPIO_H
 
 
 #ifdef CONFIG_X86
@@ -1665,4 +1665,4 @@ static inline void i8042_platform_exit(void)
 	i8042_pnp_exit();
 }
 
-#endif /* _I8042_X86IA64IO_H */
+#endif /* _I8042_ACPIPNPIO_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index 55381783dc82..bf2592fa9a78 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -20,7 +20,7 @@
 #elif defined(CONFIG_SPARC)
 #include "i8042-sparcio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
-#include "i8042-x86ia64io.h"
+#include "i8042-acpipnpio.h"
 #else
 #include "i8042-io.h"
 #endif
-- 
2.31.1

