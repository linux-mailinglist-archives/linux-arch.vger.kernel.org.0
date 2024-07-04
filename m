Return-Path: <linux-arch+bounces-5253-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F6E9278B0
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9E01C226D4
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A41B0123;
	Thu,  4 Jul 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlfPJF9j"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E61A070D;
	Thu,  4 Jul 2024 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103846; cv=none; b=jArQgjSU+rQD8mhefc2Aan5bGXRIcHUdlzdD2053X4AMMed5FBRZ8n+9YiWDmHS0WzAMLfY13mOFfSsYI0nYILrJ7eZTg8eeEtkAbtopZfC63ykfoXJFyO86JNfvNc72OVJNxrZEksAo5SHd5ZuBsytyh72MC6E0vBXbKSC21do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103846; c=relaxed/simple;
	bh=eYRnMrgEiqmr9x4OL4GeJRCEJB6f+mKZwTlWQYaRhhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSMlsmCNr49fYARNwEIwb3B/nzzD4kdi57j/u5I8XGgTcMWUZaPVaR4BjZW9ffKgL3yZx3dVT9P4+dUpFFAjt2rprLVL4kZfb2iJcwZw7U+h6e7zn3gBvcB7vuKUMsXat02BbhVXtKxJhOlH+L4ZXwDADlYT0viZvqSpFPzD1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlfPJF9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E68C4AF13;
	Thu,  4 Jul 2024 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103845;
	bh=eYRnMrgEiqmr9x4OL4GeJRCEJB6f+mKZwTlWQYaRhhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlfPJF9jQu7bSlARQ31/jUXuJCBvJoEqY3/YYk1Zwxu4K5mOJeOrxHVgPyCCtWjSE
	 QqEKn7KhNJyzP3qpLo6S2TuRBntnZL78uYdLxX71NOyWW4NTx/MxSie4lXfm0NTjjq
	 sKdYJv/7zsDwCY3fmqduiQOyklB/GVpM6WzKu1VfaWIfB6MYJfbi7UH23h1Fi1afHU
	 mGdM99TzxMI4kUfdqykX1AdDwcC7hWQo17n0QsvmtJfafxMsSYKb4NytqnKuWV8A7k
	 rvNhrqJ4Z7hWg/RZ5oHZv768JapUtsyOhuLRXCLDZIrrKRTOF6FQk1WZtF63Lb75ND
	 xcAcr48Xjyq0A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 06/17] kbuild: add syscall table generation to scripts/Makefile.asm-headers
Date: Thu,  4 Jul 2024 16:36:00 +0200
Message-Id: <20240704143611.2979589-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704143611.2979589-1-arnd@kernel.org>
References: <20240704143611.2979589-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There are 11 copies of arch/*/kernel/syscalls/Makefile that all implement
the same basic logic in a somewhat awkward way.

I tried out various ways of unifying the existing copies and ended up
with something that hooks into the logic for generating the redirections
to asm-generic headers. This gives a nicer syntax of being able to list
the generated files in $(syscall-y) inside of arch/*/include/asm/Kbuild
instead of both $(generated-y) in that place and also in another
Makefile.

The configuration for which syscall.tbl file to use and which ABIs to
enable is now done in arch/*/kernel/Makefile.syscalls. I have done
patches for all architectures and made sure that the new generic
rules implement a superset of all the architecture specific corner
cases.

ince the header file is not specific to asm-generic/*.h redirects
now, I ended up renaming the file to scripts/Makefile.asm-headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Makefile                     |  2 +-
 scripts/Makefile.asm-generic | 58 ---------------------
 scripts/Makefile.asm-headers | 98 ++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 59 deletions(-)
 delete mode 100644 scripts/Makefile.asm-generic
 create mode 100644 scripts/Makefile.asm-headers

diff --git a/Makefile b/Makefile
index 06aa6402b385..d62ef2b2c102 100644
--- a/Makefile
+++ b/Makefile
@@ -1219,7 +1219,7 @@ remove-stale-files:
 	$(Q)$(srctree)/scripts/remove-stale-files
 
 # Support for using generic headers in asm-generic
-asm-generic := -f $(srctree)/scripts/Makefile.asm-generic obj
+asm-generic := -f $(srctree)/scripts/Makefile.asm-headers obj
 
 PHONY += asm-generic uapi-asm-generic
 asm-generic: uapi-asm-generic
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
deleted file mode 100644
index 69434908930e..000000000000
--- a/scripts/Makefile.asm-generic
+++ /dev/null
@@ -1,58 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# include/asm-generic contains a lot of files that are used
-# verbatim by several architectures.
-#
-# This Makefile reads the file arch/$(SRCARCH)/include/(uapi/)/asm/Kbuild
-# and for each file listed in this file with generic-y creates
-# a small wrapper file in arch/$(SRCARCH)/include/generated/(uapi/)/asm.
-
-PHONY := all
-all:
-
-src := $(srctree)/$(subst /generated,,$(obj))
-
-include $(srctree)/scripts/Kbuild.include
--include $(kbuild-file)
-
-# $(generic)/Kbuild lists mandatory-y. Exclude um since it is a special case.
-ifneq ($(SRCARCH),um)
-include $(srctree)/$(generic)/Kbuild
-endif
-
-redundant := $(filter $(mandatory-y) $(generated-y), $(generic-y))
-redundant += $(foreach f, $(generic-y), $(if $(wildcard $(src)/$(f)),$(f)))
-redundant := $(sort $(redundant))
-$(if $(redundant),\
-	$(warning redundant generic-y found in $(src)/Kbuild: $(redundant)))
-
-# If arch does not implement mandatory headers, fallback to asm-generic ones.
-mandatory-y := $(filter-out $(generated-y), $(mandatory-y))
-generic-y   += $(foreach f, $(mandatory-y), $(if $(wildcard $(src)/$(f)),,$(f)))
-
-generic-y   := $(addprefix $(obj)/, $(generic-y))
-generated-y := $(addprefix $(obj)/, $(generated-y))
-
-# Remove stale wrappers when the corresponding files are removed from generic-y
-old-headers := $(wildcard $(obj)/*.h)
-unwanted    := $(filter-out $(generic-y) $(generated-y),$(old-headers))
-
-quiet_cmd_wrap = WRAP    $@
-      cmd_wrap = echo "\#include <asm-generic/$*.h>" > $@
-
-quiet_cmd_remove = REMOVE  $(unwanted)
-      cmd_remove = rm -f $(unwanted)
-
-all: $(generic-y)
-	$(if $(unwanted),$(call cmd,remove))
-	@:
-
-$(obj)/%.h: $(srctree)/$(generic)/%.h
-	$(call cmd,wrap)
-
-# Create output directory. Skip it if at least one old header exists
-# since we know the output directory already exists.
-ifeq ($(old-headers),)
-$(shell mkdir -p $(obj))
-endif
-
-.PHONY: $(PHONY)
diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
new file mode 100644
index 000000000000..6b8e8318e810
--- /dev/null
+++ b/scripts/Makefile.asm-headers
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0
+# include/asm-generic contains a lot of files that are used
+# verbatim by several architectures.
+#
+# This Makefile generates arch/$(SRCARCH)/include/generated/(uapi/)/asm
+# headers from multiple sources:
+#  - a small wrapper to include the corresponding asm-generic/*.h
+#    is generated for each file listed as generic-y
+#  - uapi/asm/unistd_*.h files listed as syscalls-y are generated from
+#    syscall.tbl with the __NR_* macros
+#  - Corresponding asm/syscall_table_*.h are generated from the same input
+
+PHONY := all
+all:
+
+src := $(srctree)/$(subst /generated,,$(obj))
+
+syscall_abis_32  += common,32
+syscall_abis_64  += common,64
+syscalltbl := $(srctree)/scripts/syscall.tbl
+syshdr-args := --emit-nr
+
+# let architectures override $(syscall_abis_%) and $(syscalltbl)
+-include $(srctree)/arch/$(SRCARCH)/kernel/Makefile.syscalls
+include $(srctree)/scripts/Kbuild.include
+-include $(kbuild-file)
+
+syshdr := $(srctree)/scripts/syscallhdr.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
+
+# $(generic)/Kbuild lists mandatory-y. Exclude um since it is a special case.
+ifneq ($(SRCARCH),um)
+include $(srctree)/$(generic)/Kbuild
+endif
+
+redundant := $(filter $(mandatory-y) $(generated-y), $(generic-y))
+redundant += $(foreach f, $(generic-y), $(if $(wildcard $(src)/$(f)),$(f)))
+redundant := $(sort $(redundant))
+$(if $(redundant),\
+	$(warning redundant generic-y found in $(src)/Kbuild: $(redundant)))
+
+# If arch does not implement mandatory headers, fallback to asm-generic ones.
+mandatory-y := $(filter-out $(generated-y), $(mandatory-y))
+generic-y   += $(foreach f, $(mandatory-y), $(if $(wildcard $(src)/$(f)),,$(f)))
+
+generic-y   := $(addprefix $(obj)/, $(generic-y))
+syscall-y   := $(addprefix $(obj)/, $(syscall-y))
+generated-y := $(addprefix $(obj)/, $(generated-y))
+
+# Remove stale wrappers when the corresponding files are removed from generic-y
+old-headers := $(wildcard $(obj)/*.h)
+unwanted    := $(filter-out $(generic-y) $(generated-y) $(syscall-y),$(old-headers))
+
+quiet_cmd_wrap = WRAP    $@
+      cmd_wrap = echo "\#include <asm-generic/$*.h>" > $@
+
+quiet_cmd_remove = REMOVE  $(unwanted)
+      cmd_remove = rm -f $(unwanted)
+
+quiet_cmd_syshdr = SYSHDR  $@
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) \
+		   $(if $(syshdr-args-$*),$(syshdr-args-$*),$(syshdr-args)) \
+		   $(if $(syscall_compat),--prefix "compat$*_") \
+		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
+		   $< $@
+
+quiet_cmd_systbl = SYSTBL  $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) \
+		   $(if $(systbl-args-$*),$(systbl-args-$*),$(systbl-args)) \
+		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
+		   $< $@
+
+all: $(generic-y) $(syscall-y)
+	$(if $(unwanted),$(call cmd,remove))
+	@:
+
+$(obj)/%.h: $(srctree)/$(generic)/%.h
+	$(call cmd,wrap)
+
+$(obj)/unistd_%.h: $(syscalltbl) $(syshdr) FORCE
+	$(call if_changed,syshdr)
+
+$(obj)/unistd_compat_%.h: syscall_compat:=1
+$(obj)/unistd_compat_%.h: $(syscalltbl) $(syshdr) FORCE
+	$(call if_changed,syshdr)
+
+$(obj)/syscall_table_%.h: $(syscalltbl) $(systbl) FORCE
+	$(call if_changed,systbl)
+
+# Create output directory. Skip it if at least one old header exists
+# since we know the output directory already exists.
+ifeq ($(old-headers),)
+$(shell mkdir -p $(obj))
+endif
+
+FORCE:
+
+.PHONY: $(PHONY)
-- 
2.39.2


