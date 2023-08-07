Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67F772941
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 17:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjHGPc4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjHGPcv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 11:32:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493A9BD;
        Mon,  7 Aug 2023 08:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB88661E0C;
        Mon,  7 Aug 2023 15:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E9EC433C8;
        Mon,  7 Aug 2023 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691422369;
        bh=/uziKBOz0Ulect0QjG+rpsPYlSVkOGh4loFdVsG0S1c=;
        h=From:To:Cc:Subject:Date:From;
        b=ljupM/8nM4zcDEW6o4Y8mGJFsQGXGTsHjGAQkke9TqY7XilPqnjaDwLzYYMG8OKnE
         pt2Cc5Js/SNNRpYpJnBfcKsWSu0Cvsrkv5Tv/YtfhLuADt06nTCuZwm7qL5LIB0qQL
         +wjD1y5UhsV6+Tk0z91ASmWGj2++Vrvvgq6cVs4M2Z3CHQdPH8r9/lTmiuSazBU8sJ
         1NcLNh1E/PcCMAR1ANazYZTsOCtbZ9dy8dZeF+qhwnwqCuczeRQObuGPUdPzGrGq0l
         IRuZrdpeq2mWR8M6wVc7T9tFDMUmzQmlle1K41YWCWKiF6ASsJiyBoy8wrHud3AXqZ
         hduveCSkZVe+g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] mips: remove unneeded #include <asm/export.h>
Date:   Tue,  8 Aug 2023 00:32:41 +0900
Message-Id: <20230807153243.996262-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

There is no EXPORT_SYMBOL line there, hence #include <asm/export.h>
is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/kernel/octeon_switch.S | 1 -
 arch/mips/kernel/r2300_switch.S  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 9b7c8ab6f08c..447a3ea14aa1 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -11,7 +11,6 @@
  *    written by Carsten Langgaard, carstenl@mips.com
  */
 #include <asm/asm.h>
-#include <asm/export.h>
 #include <asm/asm-offsets.h>
 #include <asm/mipsregs.h>
 #include <asm/regdef.h>
diff --git a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
index 71b1aafae1bb..48e63943e6f7 100644
--- a/arch/mips/kernel/r2300_switch.S
+++ b/arch/mips/kernel/r2300_switch.S
@@ -13,7 +13,6 @@
  */
 #include <asm/asm.h>
 #include <asm/cachectl.h>
-#include <asm/export.h>
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
-- 
2.39.2

