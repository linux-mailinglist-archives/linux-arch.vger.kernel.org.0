Return-Path: <linux-arch+bounces-7041-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2659D96CB15
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6ACD1F268B4
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCB518951C;
	Wed,  4 Sep 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X36dfIG0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A818950B;
	Wed,  4 Sep 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493703; cv=none; b=sYDiIueje9DN/QXnug+dSLlSN71uvUXEybXDhh2oMDJXUQC3CJj1Qd1RTRY7DGDt+0kWi31EIs2RqorR9KpCs1eJr09fzzgUOiaW3ZDGw8fYB+dwwzA6Kv+DWPEVY8cqy9edEmcjgf0CNkS+1Wt0z6NQnxbZSGtYpKKDGWKDgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493703; c=relaxed/simple;
	bh=nsKwaA1C+DPeHbXqGcBjvOLIHgXiFg4rrFKZpG8IZuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7isZF91I4KmIEWWeIDByY9L8GIzV1cw8a42MYC2JyIZMjbSoJfSV4cYOQO3KheVMjSZP4uZgiBYtoa1wm3GAHUCXY/ojJ/UlBrUQ2jspbN77Lo/QOA9SIKY1CoyXK2rrFvVB652AFaWSI9nZ/Nyv8W9YDFwduW0vJEvo4crUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X36dfIG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6CDC4CEC2;
	Wed,  4 Sep 2024 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493703;
	bh=nsKwaA1C+DPeHbXqGcBjvOLIHgXiFg4rrFKZpG8IZuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X36dfIG0wtcgWQzkkeDHpAyyy7pGPLtXcd3jbuFGMOXbrfAVNzUobsJqzX/p+sC0Q
	 AbUbU4aws5JbrmphPMcCQ7MYHbG4F4boFFsW+/e/i+qXTMSUjRU4T5aczjlIxJ5Pw4
	 t34G6/LKKvTJvVADNXak2AQF8cQK4NlwOLTxdGz+AhrhppnCiWJ4jsI7ZxQQNvw7fD
	 gAsnyHevuSc63Bwbr0Q/VSIwdAKzcjAeU6dX84uJhzAfhzlTAXAzhg/p7+CklJ0Utp
	 R+UYNm9msmK+XOypnjCuSyfhyqmTPDq2PfN6hPFsL9cn097TWpteabOhfpjZyRNBaf
	 B8Fg46ryR3CeQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 04/15] kbuild: add generic support for built-in boot DTBs
Date: Thu,  5 Sep 2024 08:47:40 +0900
Message-ID: <20240904234803.698424-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904234803.698424-1-masahiroy@kernel.org>
References: <20240904234803.698424-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures embed boot DTBs in vmlinux. A potential issue for
these architectures is a race condition during parallel builds because
Kbuild descends into arch/*/boot/dts/ twice.

One build thread is initiated by the 'dtbs' target, which is a
prerequisite of the 'all' target in the top-level Makefile:

  ifdef CONFIG_OF_EARLY_FLATTREE
  all: dtbs
  endif

For architectures that support the embedded boot dtb, arch/*/boot/dts/
is visited also during the ordinary directory traversal in order to
build obj-y objects that wrap DTBs.

Since these build threads are unaware of each other, they can run
simultaneously during parallel builds.

This commit introduces a generic build rule to scripts/Makefile.vmlinux
to support embedded boot DTBs in a race-free way. Architectures that
want to use this rule need to select CONFIG_GENERIC_BUILTIN_DTB.

After the migration, Makefiles under arch/*/boot/dts/ will be visited
only once to build only *.dtb files.

This change also aims to unify the CONFIG options used for embedded DTBs
support. Currently, different architectures use different CONFIG options
for the same purposes.

The CONFIG options are unified as follows:

 - CONFIG_GENERIC_BUILTIN_DTB

   This enables the generic rule for embedded boot DTBs. This will be
   renamed to CONFIG_BUILTIN_DTB after all architectures migrate to the
   generic rule.

 - CONFIG_BUILTIN_DTB_NAME

   This specifies the path to the embedded DTB.
   (relative to arch/*/boot/dts/)

 - CONFIG_BUILTIN_DTB_ALL

   If this is enabled, all DTB files compiled under arch/*/boot/dts/ are
   embedded into vmlinux. Only used by MIPS.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 |  7 ++++++-
 drivers/of/Kconfig       |  6 ++++++
 scripts/Makefile.vmlinux | 44 ++++++++++++++++++++++++++++++++++++++++
 scripts/link-vmlinux.sh  |  4 ++++
 4 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 145112bf281a..1c765c12ab9e 100644
--- a/Makefile
+++ b/Makefile
@@ -1417,6 +1417,10 @@ ifdef CONFIG_OF_EARLY_FLATTREE
 all: dtbs
 endif
 
+ifdef CONFIG_GENERIC_BUILTIN_DTB
+vmlinux: dtbs
+endif
+
 endif
 
 PHONY += scripts_dtc
@@ -1483,7 +1487,8 @@ endif # CONFIG_MODULES
 CLEAN_FILES += vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
 	       compile_commands.json rust/test \
-	       rust-project.json .vmlinux.objs .vmlinux.export.c
+	       rust-project.json .vmlinux.objs .vmlinux.export.c \
+               .builtin-dtbs-list .builtin-dtb.S
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES += include/config include/generated          \
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index dd726c7056bf..5142e7d7fef8 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -2,6 +2,12 @@
 config DTC
 	bool
 
+config GENERIC_BUILTIN_DTB
+	bool
+
+config BUILTIN_DTB_ALL
+	bool
+
 menuconfig OF
 	bool "Device Tree and Open Firmware support"
 	help
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 5ceecbed31eb..4626b472da49 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -17,6 +17,50 @@ quiet_cmd_cc_o_c = CC      $@
 %.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
+quiet_cmd_as_o_S = AS      $@
+      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
+
+%.o: %.S FORCE
+	$(call if_changed_dep,as_o_S)
+
+# Built-in dtb
+# ---------------------------------------------------------------------------
+
+quiet_cmd_wrap_dtbs = WRAP    $@
+      cmd_wrap_dtbs = {							\
+	echo '\#include <asm-generic/vmlinux.lds.h>';			\
+	echo '.section .dtb.init.rodata,"a"';				\
+	while read dtb; do						\
+		symbase=__dtb_$$(basename -s .dtb "$${dtb}" | tr - _);	\
+		echo '.balign STRUCT_ALIGNMENT';			\
+		echo ".global $${symbase}_begin";			\
+		echo "$${symbase}_begin:";				\
+		echo '.incbin "'$$dtb'" ';				\
+		echo ".global $${symbase}_end";				\
+		echo "$${symbase}_end:";				\
+	done < $<;							\
+	} > $@
+
+.builtin-dtbs.S: .builtin-dtbs-list FORCE
+	$(call if_changed,wrap_dtbs)
+
+quiet_cmd_gen_dtbs_list = GEN     $@
+      cmd_gen_dtbs_list = \
+	$(if $(CONFIG_BUILTIN_DTB_NAME), echo "arch/$(SRCARCH)/boot/dts/$(CONFIG_BUILTIN_DTB_NAME).dtb",:) > $@
+
+.builtin-dtbs-list: arch/$(SRCARCH)/boot/dts/dtbs-list FORCE
+	$(call if_changed,$(if $(CONFIG_BUILTIN_DTB_ALL),copy,gen_dtbs_list))
+
+targets += .builtin-dtbs-list
+
+ifdef CONFIG_GENERIC_BUILTIN_DTB
+targets += .builtin-dtbs.S .builtin-dtbs.o
+vmlinux: .builtin-dtbs.o
+endif
+
+# vmlinux
+# ---------------------------------------------------------------------------
+
 ifdef CONFIG_MODULES
 targets += .vmlinux.export.o
 vmlinux: .vmlinux.export.o
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c27b4e969f20..bd196944e350 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -68,6 +68,10 @@ vmlinux_link()
 		libs="${KBUILD_VMLINUX_LIBS}"
 	fi
 
+	if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
+		objs="${objs} .builtin-dtbs.o"
+	fi
+
 	if is_enabled CONFIG_MODULES; then
 		objs="${objs} .vmlinux.export.o"
 	fi
-- 
2.43.0


