Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52314F242C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Apr 2022 09:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiDEHRG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 03:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiDEHQT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 03:16:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB8CDFD8;
        Tue,  5 Apr 2022 00:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2828615F2;
        Tue,  5 Apr 2022 07:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C693C34110;
        Tue,  5 Apr 2022 07:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649142836;
        bh=hq9Ro/6wNi6Bjr9TXkTjcr4R5bOTWBzCrcnIPIywIr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLLifNES58YAya08PsQCLUQ7pqPzfzz9WtyBHjwuWWLImu27zg/rZ2BjQgpW9zeoT
         q50zE/PJKFrU5ABhVUnlWatCs+NZ0IUf91CKYP9AxDuY/tG5tO8CZjPEH6AVLf+xXm
         E3741Qn+xWrHdc8T31lrgNUzkTF2PZjlGqwH0bbweHv/bfMSfmB2uxsXitKbxHzICN
         LFG66MH1akvM+4N62lLUJpc5RRQPNiaficg9zP4Y8GdnV2LkCNJVdFkUN2CnzweA1k
         8ofpFOnAbn42fDesJ16PmeHGa4WR3ze0qpavoV8lyd3aTkeRa0BB7ZAyVgY4yej0mx
         csOMzAS+1N77Q==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de, nathan@kernel.org,
        naresh.kamboju@linaro.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH V12 04/20] arch: Add SYSVIPC_COMPAT for all architectures
Date:   Tue,  5 Apr 2022 15:12:58 +0800
Message-Id: <20220405071314.3225832-5-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405071314.3225832-1-guoren@kernel.org>
References: <20220405071314.3225832-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The existing per-arch definitions are pretty much historic cruft.
Move SYSVIPC_COMPAT into init/Kconfig.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Helge Deller <deller@gmx.de>  # parisc
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/arm64/Kconfig   | 4 ----
 arch/mips/Kconfig    | 5 -----
 arch/parisc/Kconfig  | 4 ----
 arch/powerpc/Kconfig | 5 -----
 arch/s390/Kconfig    | 3 ---
 arch/sparc/Kconfig   | 5 -----
 arch/x86/Kconfig     | 4 ----
 init/Kconfig         | 4 ++++
 8 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 57c4c995965f..ff674808681a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2122,10 +2122,6 @@ config DMI
 
 endmenu
 
-config SYSVIPC_COMPAT
-	def_bool y
-	depends on COMPAT && SYSVIPC
-
 menu "Power management options"
 
 source "kernel/power/Kconfig"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index de3b32a507d2..0055482cd20f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3198,16 +3198,12 @@ config MIPS32_COMPAT
 config COMPAT
 	bool
 
-config SYSVIPC_COMPAT
-	bool
-
 config MIPS32_O32
 	bool "Kernel support for o32 binaries"
 	depends on 64BIT
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT
 	select MIPS32_COMPAT
-	select SYSVIPC_COMPAT if SYSVIPC
 	help
 	  Select this option if you want to run o32 binaries.  These are pure
 	  32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
@@ -3221,7 +3217,6 @@ config MIPS32_N32
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select COMPAT
 	select MIPS32_COMPAT
-	select SYSVIPC_COMPAT if SYSVIPC
 	help
 	  Select this option if you want to run n32 binaries.  These are
 	  64-bit binaries using 32-bit quantities for addressing and certain
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 52e550b45692..93cb07a4446f 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -331,10 +331,6 @@ config COMPAT
 	def_bool y
 	depends on 64BIT
 
-config SYSVIPC_COMPAT
-	def_bool y
-	depends on COMPAT && SYSVIPC
-
 config AUDIT_ARCH
 	def_bool y
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 174edabb74fa..6edb294a34ef 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -298,11 +298,6 @@ config COMPAT
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
 
-config SYSVIPC_COMPAT
-	bool
-	depends on COMPAT && SYSVIPC
-	default y
-
 config SCHED_OMIT_FRAME_POINTER
 	bool
 	default y
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 77b5a03de13a..555b7ea5ecf5 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -399,9 +399,6 @@ config COMPAT
 	  (and some other stuff like libraries and such) is needed for
 	  executing 31 bit applications.  It is safe to say "Y".
 
-config SYSVIPC_COMPAT
-	def_bool y if COMPAT && SYSVIPC
-
 config SMP
 	def_bool y
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 9200bc04701c..9c1cce74953a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -488,9 +488,4 @@ config COMPAT
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
 
-config SYSVIPC_COMPAT
-	bool
-	depends on COMPAT && SYSVIPC
-	default y
-
 source "drivers/sbus/char/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..65690b950f5f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2872,10 +2872,6 @@ config COMPAT
 if COMPAT
 config COMPAT_FOR_U64_ALIGNMENT
 	def_bool y
-
-config SYSVIPC_COMPAT
-	def_bool y
-	depends on SYSVIPC
 endif
 
 endmenu
diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..9fa3ee6bf12a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -390,6 +390,10 @@ config SYSVIPC_SYSCTL
 	depends on SYSCTL
 	default y
 
+config SYSVIPC_COMPAT
+	def_bool y
+	depends on COMPAT && SYSVIPC
+
 config POSIX_MQUEUE
 	bool "POSIX Message Queues"
 	depends on NET
-- 
2.25.1

