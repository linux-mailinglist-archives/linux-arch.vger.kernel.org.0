Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B67772986
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjHGPnK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjHGPnD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 11:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEC0BD;
        Mon,  7 Aug 2023 08:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8576165E;
        Mon,  7 Aug 2023 15:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB7AC433CB;
        Mon,  7 Aug 2023 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691422981;
        bh=OtMYjEpo0UJCnbN5a1Kl1O+JGx2yqsNm3tCe/nTJnhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFhX0OM11ppGRAjT5kvPvm9ZeEbPJQSq/lAyqaZUHsAU3jj1p+vS7ivQhLdrm7ypC
         9vNqR9X+MbnUChpkwJrd0W2hvlTv9tkuDEkiCaiUXeP6xqQU+qldf1ec0OmHhmBPtx
         MPSPncicMtpi8nqs14ET/AlpUVIX+O/VkYO+DEuW8EiW5ke9ORW8D7b4fBsE/EOn9A
         ALFlw6Itbq2nCQt9AkFYurN9Ucjm1uzVOugqP4YvCLurJyET9EA7Uz+OWactbR7bJp
         32HDfsE1IbNNRiG0Q0d854itvqbcB+3tQQzpmzCDGyEE71WJQ2KAUrTXfXd6ij2vlA
         1ZbqFV8hdnW3A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] loongarch: replace #include <asm/export.h> with #include <linux/export.h>
Date:   Tue,  8 Aug 2023 00:42:49 +0900
Message-Id: <20230807154250.998765-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807154250.998765-1-masahiroy@kernel.org>
References: <20230807154250.998765-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.

Replace #include <asm/export.h> with #include <linux/export.h>.

After all the <asm/export.h> lines are converted, <asm/export.h> and
<asm-generic/export.h> will be removed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/loongarch/kernel/fpu.S     | 2 +-
 arch/loongarch/kernel/mcount.S  | 2 +-
 arch/loongarch/lib/clear_user.S | 2 +-
 arch/loongarch/lib/copy_user.S  | 2 +-
 arch/loongarch/lib/memcpy.S     | 2 +-
 arch/loongarch/lib/memmove.S    | 2 +-
 arch/loongarch/lib/memset.S     | 2 +-
 arch/loongarch/mm/page.S        | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index 59f1572aa523..b4032deb8e3b 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -6,12 +6,12 @@
  *
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include <linux/export.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/asm-extable.h>
 #include <asm/asm-offsets.h>
 #include <asm/errno.h>
-#include <asm/export.h>
 #include <asm/fpregdef.h>
 #include <asm/loongarch.h>
 #include <asm/regdef.h>
diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
index cb8e5803de4b..3015896016a0 100644
--- a/arch/loongarch/kernel/mcount.S
+++ b/arch/loongarch/kernel/mcount.S
@@ -5,7 +5,7 @@
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 #include <asm/ftrace.h>
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
index 9dcf71719387..0790eadce166 100644
--- a/arch/loongarch/lib/clear_user.S
+++ b/arch/loongarch/lib/clear_user.S
@@ -3,12 +3,12 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
+#include <linux/export.h>
 #include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/asm-extable.h>
 #include <asm/cpu.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 .irp to, 0, 1, 2, 3, 4, 5, 6, 7
diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_user.S
index fecd08cad702..bfe3d2793d00 100644
--- a/arch/loongarch/lib/copy_user.S
+++ b/arch/loongarch/lib/copy_user.S
@@ -3,12 +3,12 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
+#include <linux/export.h>
 #include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/asm-extable.h>
 #include <asm/cpu.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 .irp to, 0, 1, 2, 3, 4, 5, 6, 7
diff --git a/arch/loongarch/lib/memcpy.S b/arch/loongarch/lib/memcpy.S
index f5d4c3e65264..fa1148878d2b 100644
--- a/arch/loongarch/lib/memcpy.S
+++ b/arch/loongarch/lib/memcpy.S
@@ -3,11 +3,11 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
+#include <linux/export.h>
 #include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/cpu.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 .section .noinstr.text, "ax"
diff --git a/arch/loongarch/lib/memmove.S b/arch/loongarch/lib/memmove.S
index 71b81d271c73..82dae062fec8 100644
--- a/arch/loongarch/lib/memmove.S
+++ b/arch/loongarch/lib/memmove.S
@@ -3,11 +3,11 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
+#include <linux/export.h>
 #include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/cpu.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 .section .noinstr.text, "ax"
diff --git a/arch/loongarch/lib/memset.S b/arch/loongarch/lib/memset.S
index a45f6f92ee3b..06d3ca54cbfe 100644
--- a/arch/loongarch/lib/memset.S
+++ b/arch/loongarch/lib/memset.S
@@ -3,11 +3,11 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
+#include <linux/export.h>
 #include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/cpu.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 .macro fill_to_64 r0
diff --git a/arch/loongarch/mm/page.S b/arch/loongarch/mm/page.S
index 4c874a7af0ad..7ad76551d313 100644
--- a/arch/loongarch/mm/page.S
+++ b/arch/loongarch/mm/page.S
@@ -2,9 +2,9 @@
 /*
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 #include <asm/page.h>
 #include <asm/regdef.h>
 
-- 
2.39.2

