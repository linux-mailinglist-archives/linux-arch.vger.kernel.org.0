Return-Path: <linux-arch+bounces-5156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D8A918E38
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 20:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5283B22292
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640F190674;
	Wed, 26 Jun 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAfVGUDX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B4190482;
	Wed, 26 Jun 2024 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426139; cv=none; b=K75GQi8fJvxJCEScWfJIedp7ArSK3ntxExzes9/Il4OSUEDjtmWYQPqOPt6q5jCeGB8zIqo7CaDjw5+Bx7xM5879A0njmqu4AD04Q/LxSDgpq72e0GjzvykOG9nKP/U2+4FVZn4LtYC1AKTWezbjmo9pXmYW9bQCfaHVOJ9VZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426139; c=relaxed/simple;
	bh=ZgY5oT3WkSBNucNNrsDAYZhHpfyzQpcKIoaL6y48c7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgUQXNII+37JplmwrbtjvCHCWEdU7n5cU1FpMPwxNfjZJ6tuMPjsomatia3oR28mzjqvwcw1+0qcycpk6AL/jDyS4TPAlm9QtjlTaxDNjT6ZmJ5GGn2ckmavd8vt3TkYNeQ7IsVaJGJ7e4BG0lZtm3jwTk0L5qfFCsciBlqPDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAfVGUDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCC1C32782;
	Wed, 26 Jun 2024 18:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426139;
	bh=ZgY5oT3WkSBNucNNrsDAYZhHpfyzQpcKIoaL6y48c7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QAfVGUDXH2qQSSfl3NSFWEb/aiCVjhfncYocWMWUSZQBeA4+tT4kcVOCrFq+EeMKb
	 9LUrL9o8PxhbKXyr36UdzRAWTDw/V7q2S9aLEKK7jsysAqPITitmdfyzxa/JOWVEme
	 8EMRYuJXFeTbSqWWUQ7c7wwbeRA1i6TAEXBmuClJG3YDYB9GcojEOVZ07+MkuS7OFj
	 y706j9atHrYeM455n2UF7tDAIlwiy51xkDHtnOQciFLYBCCMpmvq54/0Y+hdeZGLKl
	 wDsU97Tm4L2VI7DDJCORoQnVjn90i9kDKybeztxmqaoK4Tbp24haEtuZ9IBF3vLAff
	 2VIh8MflnLE6w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/5] treewide: change conditional prompt for choices to 'depends on'
Date: Thu, 27 Jun 2024 03:22:00 +0900
Message-ID: <20240626182212.3758235-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626182212.3758235-1-masahiroy@kernel.org>
References: <20240626182212.3758235-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While Documentation/kbuild/kconfig-language.rst provides a brief
explanation, there are recurring confusions regarding the usage of a
prompt followed by 'if <expr>'. This conditional controls _only_ the
prompt.

A typical usage is as follows:

    menuconfig BLOCK
            bool "Enable the block layer" if EXPERT
            default y

When EXPERT=n, the prompt is hidden, but this config entry is still
active, and BLOCK is set to its default value 'y'. This is reasonable
because you are likely want to enable the block device support. When
EXPERT=y, the prompt is shown, allowing you to toggle BLOCK.

Please note that it is different from 'depends on EXPERT', which would
disable the entire config entry.

However, this conditional prompt has never worked for a choice.

The following two work in the same way: when EXPERT is disabled, the
choice block is entirely disabled.

[Test Code 1]

    choice
            prompt "choose" if EXPERT

    config A
            bool "A"

    config B
            bool "B"

    endchoice

[Test Code 2]

    choice
            prompt "choose"
            depends on EXPERT

    config A
            bool "A"

    config B
            bool "B"

    endchoice

I believe the first case should hide only the prompt, but still produce
the default of the choice block:

   CONFIG_A=y
   # CONFIG_B is not set

The next commit will change (fix) the behavior of the conditional prompt
in choice blocks.

I see several choice blocks wrongly using a conditional prompt, where
'depends on' makes more sense.

To preserve the current behavior, this commit converts such misuses.

I did not touch the following hunk in arch/x86/Kconfig:

    choice
            prompt "Memory split" if EXPERT
            default VMSPLIT_3G

This is truly the correct use of the conditional prompt; when EXPERT=n,
this choice block should silently select the reasonable VMSPLIT_3G,
although the resulting PAGE_OFFSET will not be affected anyway.

Presumably, the one in fs/jffs2/Kconfig is also correct, but I converted
it to 'depends on' to avoid any potential behavioral change.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/Kconfig     | 6 ++++--
 arch/arm64/Kconfig   | 3 ++-
 arch/mips/Kconfig    | 6 ++++--
 arch/powerpc/Kconfig | 3 ++-
 arch/riscv/Kconfig   | 3 ++-
 fs/jffs2/Kconfig     | 3 ++-
 6 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ee5115252aac..a5bf65b06c53 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1482,7 +1482,8 @@ config ARM_ATAG_DTB_COMPAT
 	  from the ATAG list and store it at run time into the appended DTB.
 
 choice
-	prompt "Kernel command line type" if ARM_ATAG_DTB_COMPAT
+	prompt "Kernel command line type"
+	depends on ARM_ATAG_DTB_COMPAT
 	default ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER
 
 config ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER
@@ -1511,7 +1512,8 @@ config CMDLINE
 	  memory size and the root device (e.g., mem=64M root=/dev/nfs).
 
 choice
-	prompt "Kernel command line type" if CMDLINE != ""
+	prompt "Kernel command line type"
+	depends on CMDLINE != ""
 	default CMDLINE_FROM_BOOTLOADER
 
 config CMDLINE_FROM_BOOTLOADER
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b5..c87d16b12e9b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2302,7 +2302,8 @@ config CMDLINE
 	  root device (e.g. root=/dev/nfs).
 
 choice
-	prompt "Kernel command line type" if CMDLINE != ""
+	prompt "Kernel command line type"
+	depends on CMDLINE != ""
 	default CMDLINE_FROM_BOOTLOADER
 	help
 	  Choose how the kernel will handle the provided default kernel
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f1aa1bf11166..8cbc23f0c1a7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2924,7 +2924,8 @@ config BUILTIN_DTB
 	bool
 
 choice
-	prompt "Kernel appended dtb support" if USE_OF
+	prompt "Kernel appended dtb support"
+	depends on USE_OF
 	default MIPS_NO_APPENDED_DTB
 
 	config MIPS_NO_APPENDED_DTB
@@ -2965,7 +2966,8 @@ choice
 endchoice
 
 choice
-	prompt "Kernel command line type" if !CMDLINE_OVERRIDE
+	prompt "Kernel command line type"
+	depends on !CMDLINE_OVERRIDE
 	default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATH79 && !MACH_INGENIC && \
 					 !MACH_LOONGSON64 && !MIPS_MALTA && \
 					 !CAVIUM_OCTEON_SOC
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c88c6d46a5bc..68e35b33e123 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -965,7 +965,8 @@ config CMDLINE
 	  most cases you will need to specify the root device here.
 
 choice
-	prompt "Kernel command line type" if CMDLINE != ""
+	prompt "Kernel command line type"
+	depends on CMDLINE != ""
 	default CMDLINE_FROM_BOOTLOADER
 
 config CMDLINE_FROM_BOOTLOADER
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..48b7faf62d0b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -914,7 +914,8 @@ config CMDLINE
 	  line here and choose how the kernel should use it later on.
 
 choice
-	prompt "Built-in command line usage" if CMDLINE != ""
+	prompt "Built-in command line usage"
+	depends on CMDLINE != ""
 	default CMDLINE_FALLBACK
 	help
 	  Choose how the kernel will handle the provided built-in command
diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index 7c96bc107218..560187d61562 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -151,8 +151,9 @@ config JFFS2_RUBIN
 	  RUBINMIPS and DYNRUBIN compressors. Say 'N' if unsure.
 
 choice
-	prompt "JFFS2 default compression mode" if JFFS2_COMPRESSION_OPTIONS
+	prompt "JFFS2 default compression mode"
 	default JFFS2_CMODE_PRIORITY
+	depends on JFFS2_COMPRESSION_OPTIONS
 	depends on JFFS2_FS
 	help
 	  You can set here the default compression mode of JFFS2 from
-- 
2.43.0


