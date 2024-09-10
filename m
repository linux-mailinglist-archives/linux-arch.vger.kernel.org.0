Return-Path: <linux-arch+bounces-7173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A2C972EC5
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 11:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FDB1F25C40
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 09:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692E118C32B;
	Tue, 10 Sep 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+K9Ya0e"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385ED18661A;
	Tue, 10 Sep 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961512; cv=none; b=Kxkkl4Ia4KMzo6jmI10SdNS8XOMTLINgB45h2idjzHY4d5OnQfHRqxsWWRGt5lY8cjnjMy4ERRiF+CB1EdbX/9F7BIIRGZUFR/4Pibrp6yPPO731dWrU6CHRLHida9PrJHL5R/Gui17nMk5VdUv30HE/BPrpLtdwL/KdPR8ogWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961512; c=relaxed/simple;
	bh=lCWVRWkkjMOZnP3OsnMxYh+cKOVH3q4vcAD89l0t4O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2v5MBXp+rN1UWEfzTBd7AK1PP6R3KsudYCm7xijKluU2FAd9rYGUWWeZsP4kFmrbz8I+vFveHq7Sq/kfBYRTWZ7Lnw1FGVgGGSBqb1v3u2kVGCoF5nUngaYYF2zX2LRuremczQq9D6DOAOj8PDoMKKzgwwBWMBt8u0LpahCuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+K9Ya0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D35FC4CEC3;
	Tue, 10 Sep 2024 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725961512;
	bh=lCWVRWkkjMOZnP3OsnMxYh+cKOVH3q4vcAD89l0t4O0=;
	h=From:To:Cc:Subject:Date:From;
	b=g+K9Ya0eBYvNvorGbNvMSgOCgI9RztICd4kTxaZMzKNx1rZNlOanrC0vBiyZb1bQp
	 T2c+gCnDSx+/GjKYp9TQVXg/YO1lWBCtIF33jvWLyxIGsZa4EKjDLZrbO3A9LnzNLZ
	 h29TNGafNPNXZHXIHK0Q/3eJ2p5a+Lz1Fg/WopGHt7VH3KOPv+C2U7qRXJ2F/OBfRF
	 FTVNfKIrnql5Ep+yMax+5j3DLOfmjbqGKGa7CmLwmTDWS57M/LYBGti8XoiWx7yRXx
	 VxRtPHkIdnYKmUNSV1XAGA84DDMt7FXsRbIhODL2ZO30TeK9BKHQQ4osNHzaEHk2JY
	 491RbUJ2v2G3Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/3] modpost: check section mismatch in reference to .dtb.init.rodata
Date: Tue, 10 Sep 2024 18:44:52 +0900
Message-ID: <20240910094459.352572-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Built-in DTB files are discarded because KERNEL_DTB() is a part of
INIT_DATA, as defined in include/asm-generic/vmlinux.lds.h.

Currently, modpost warns about mismatched section references to init
data only when the destination section is prefixed with ".init.".
However, ".dtb.init.rodata" is also discarded.

This commit has revealed some missing annotations.

overlays[] references builtin DTBs, which become dangling pointers
after early boot.

testdrv_probe() is not an __init function, yet it holds a reference to
overlays[]. The assumption is that this function is executed only at
the boot time even though it remains in memory. I annotated it as __ref
because otherwise I do not know how to suppress the modpost warning.

I marked the dtb_start as __initdata in the Xtensa boot code, although
modpost does not warn about it because __dtb_start is not yet defined
at the time of modpost.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 arch/xtensa/kernel/setup.c | 2 +-
 drivers/of/unittest.c      | 5 +++--
 scripts/mod/modpost.c      | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index bdec4a773af0..d9f290cf726e 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -55,7 +55,7 @@ extern int initrd_below_start_ok;
 #endif
 
 #ifdef CONFIG_USE_OF
-void *dtb_start = __dtb_start;
+static __initdata void *dtb_start = __dtb_start;
 #endif
 
 extern unsigned long loops_per_jiffy;
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index fd8cb931b1cc..56516bf4171d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3585,7 +3585,7 @@ OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 OVERLAY_INFO_EXTERN(overlay_bad_unresolved);
 
 /* entries found by name */
-static struct overlay_info overlays[] = {
+static __initdata struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_base, -9999, 0),
 	OVERLAY_INFO(overlay, 0, 0),
 	OVERLAY_INFO(overlay_0, 0, 0),
@@ -4054,7 +4054,8 @@ static const struct pci_device_id testdrv_pci_ids[] = {
 	{ 0, }
 };
 
-static int testdrv_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+/* testdrv_probe() references overlays[], which is discarded data  */
+static int __ref testdrv_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct overlay_info *info;
 	struct device_node *dn;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 107393a8c48a..2e4b0816fdc1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -776,7 +776,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 	".pci_fixup_enable", ".pci_fixup_resume", \
 	".pci_fixup_resume_early", ".pci_fixup_suspend"
 
-#define ALL_INIT_SECTIONS ".init.*"
+#define ALL_INIT_SECTIONS ".init.*", ".dtb.init.rodata"
 #define ALL_EXIT_SECTIONS ".exit.*"
 
 #define DATA_SECTIONS ".data", ".data.rel"
-- 
2.43.0


