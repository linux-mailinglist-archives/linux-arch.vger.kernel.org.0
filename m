Return-Path: <linux-arch+bounces-7174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4ED972EC8
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 11:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242322874DF
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 09:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEFC191F88;
	Tue, 10 Sep 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISv8Cxy1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044D191F6D;
	Tue, 10 Sep 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961514; cv=none; b=kVYlFlZDQCzysbLMghnx9m+Jm8EDKGBPRy8i1J8bSedkIUsVe0G3xPAz/C9VVy4edett2yWA8Es+vH/pgE39zNW3B6S1rZY9PiFWhMQc0dplEjYRMVDzomVlLnqVta1+kHVbTH66j51NufTrXLnn7sk6wCtaz/TMNq4KKdQhDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961514; c=relaxed/simple;
	bh=gvKBAg1idsIAWBBS/6ppwAn7+Bj/sxEvS29rAZARmsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROulMpa86T5PkEUjt8w9W/CzuItYSMkLm561cuVt6dhcJtmEKQPBw7JtYkH8GRZTm2PgusE+ooHNb0/JWmAgB4VnbJlS3ASByyozYvVbaObnhf17tEMf5RUqwzC37JqYdyvlsvTJDFY1hb9xeqB8EDnWFtoFehTm6WajRZppL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISv8Cxy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BC0C4CEC6;
	Tue, 10 Sep 2024 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725961514;
	bh=gvKBAg1idsIAWBBS/6ppwAn7+Bj/sxEvS29rAZARmsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISv8Cxy1oXcxvqT5br2BRjC8O/ibc3g304QJCli9ENQ/Insvjhso9OqSkNQCUhFBd
	 uF/Bq8tJj4djzig0cPMehFzkCx7gbqQ045Jqq1Gno+xCC+5kHoaHHLW5aW/jhwP+dw
	 KsCZ8nDAWNgA4jfmbqKAhUknTQzipEycHeTuj5mBFDfD142EFb1w30aqUqyKP31k/r
	 xZwm7usn50Wb0zGCGwOuDYziFuPgWkigzwzmF2rmZV02IXOQrDOSLyBm4+h9/tFNZd
	 ZAT6ttpI+t99sAmiiEUQL2dtoH2LdEcUPb3PIF7kuyTJS9bixLclusXox4EYhriCiA
	 +OJv+tESIbqTA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] kbuild: move non-boot builtin DTBs to .init.rodata section
Date: Tue, 10 Sep 2024 18:44:53 +0900
Message-ID: <20240910094459.352572-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910094459.352572-1-masahiroy@kernel.org>
References: <20240910094459.352572-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures support embedding boot DTB(s) in vmlinux. These
architectures, except MIPS and MicroBlaze, expect a single DTB in
the .dtb.init.rodata section. MIPS embeds multiple DTBs in vmlinux.
MicroBlaze embeds a DTB in its own __fdt_blob section instead of the
.dtb.init.rodata section.

For example, RISC-V previously allowed embedding multiple DTBs, but
only the first DTB in the .dtb.init.rodata section was used. Commit
2672031b20f6 ("riscv: dts: Move BUILTIN_DTB_SOURCE to common Kconfig")
ensured only one boot DTB is embedded.

Meanwhile, commit 7b937cc243e5 ("of: Create of_root if no dtb provided
by firmware") introduced another DTB into the .dtb.init.rodata section.

The symbol dump (sorted by address) for ARCH=riscv nommu_k210_defconfig
is now as follows:

    00000000801290e0 D __dtb_start
    00000000801290e0 D __dtb_k210_generic_begin
    000000008012b571 D __dtb_k210_generic_end
    000000008012b580 D __dtb_empty_root_begin
    000000008012b5c8 D __dtb_empty_root_end
    000000008012b5e0 D __dtb_end

The .dtb.init.rodata section contains the following two DTB files:

    arch/riscv/boot/dts/canaan/k210_generic.dtb
    drivers/of/empty_root.dtb

This is not an immediate problem because the boot code chooses the
first DTB, k210_generic.dtb. The second one, empty_root.dtb is ignored.
However, relying on the link order (i.e., the order in Makefiles) is
fragile.

Only the boot DTB should be placed in the .dtb.init.rodata because the
arch boot code generally does not know the DT name, thus it uses the
__dtb_start symbol to find it.

empty_root.dtb is looked up by name, so it can be moved to the generic
.init.rodata section.

When CONFIG_OF_UNITTEST is enabled, more unittest DTBOs are embedded in
the .dtb.init.rodata section. These are also looked up by name, so can
be moved to the .init.rodata section.

The implementation is kind of cheesy; the section is .dtb.init.rodata
under the arch/ directory, and .init.rodata section otherwise. This will
be refactored later.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

Changes in v2:
  - Split __initdata annotation to 1/3

 scripts/Makefile.dtbs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.dtbs b/scripts/Makefile.dtbs
index 46009d5f1486..55998b878e54 100644
--- a/scripts/Makefile.dtbs
+++ b/scripts/Makefile.dtbs
@@ -34,12 +34,14 @@ $(obj)/dtbs-list: $(dtb-y) FORCE
 # Assembly file to wrap dtb(o)
 # ---------------------------------------------------------------------------
 
+builtin-dtb-section = $(if $(filter arch/%, $(obj)),.dtb.init.rodata,.init.rodata)
+
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_wrap_S_dtb = WRAP    $@
       cmd_wrap_S_dtb = {								\
 		symbase=__$(patsubst .%,%,$(suffix $<))_$(subst -,_,$(notdir $*));	\
 		echo '\#include <asm-generic/vmlinux.lds.h>';				\
-		echo '.section .dtb.init.rodata,"a"';					\
+		echo '.section $(builtin-dtb-section),"a"';				\
 		echo '.balign STRUCT_ALIGNMENT';					\
 		echo ".global $${symbase}_begin";					\
 		echo "$${symbase}_begin:";						\
-- 
2.43.0


