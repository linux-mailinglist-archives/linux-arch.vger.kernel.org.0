Return-Path: <linux-arch+bounces-15777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F07D18DD8
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F26E830515A6
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2D5392B98;
	Tue, 13 Jan 2026 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="O9Xe+RO7"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83773921DF;
	Tue, 13 Jan 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307873; cv=none; b=DTjFljwrcrDWMJ822amGWflm9MtMFwTy5Ijd0xyqhhNqchcxqaVjq8vcaGrRIDdbviEwnKHsURohX9tTBS05t10oGT1kqRX8lxXcIpf6XP13RI4SfyBZblqHlrhNvyqRC6ss9uyX0taAFXsofsi6bKaDcq640z/pqY/SEjYljRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307873; c=relaxed/simple;
	bh=Ws8Eb0NwBaSsIELRvPFLQCi4wI4t0JSg+rOArDpr4jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjOf+Y5245XTTrgtw4f9eWg0iAhuR0JmA0ALGMuygvDMLP+7H8D6VrOFCRy0IMUbd5KfZ66tC+iHOX7yqCVSO6QXc+FRNm9LhGHWkSIPBYxWXsogALvwZnY/zRRA+dNTLx7LFaO0i5YC18enGv+ZXnL9jYy+dpnR+CspE38JQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=O9Xe+RO7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307861;
	bh=Ws8Eb0NwBaSsIELRvPFLQCi4wI4t0JSg+rOArDpr4jQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O9Xe+RO75UPCb36u5nzxwzV4aFggvjHY0s8dnC9SRndh/IQGhUfIuuT5vLRHHP6Mc
	 K1sGiiSW4ebwVx+7Utb4cgjie5ndXNJBjH7Lg49kYigRXnXpkxRbcHBRO0bqcmXgZj
	 MgNncGcUilz/vm19oRV49rtYw8DPUlXsLyytbp+Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:29:01 +0100
Subject: [PATCH v4 17/17] kbuild: make CONFIG_MODULE_HASHES compatible with
 module stripping
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-17-0b932db9b56b@weissschuh.net>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
In-Reply-To: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, Nicolas Schier <nsc@kernel.org>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=3767;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Ws8Eb0NwBaSsIELRvPFLQCi4wI4t0JSg+rOArDpr4jQ=;
 b=oEsyx/jtBizezIcvSkje+0qtObz/4ddhy8qPoVzSRgXe5bKNpF2FVLAcW5REc98tF23qYcGl2
 oWzLDhETAiYD5GsTguxB0tE2w91SHoXCLNfs4qDbap5w+MSSx88FHYp
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

CONFIG_MODULE_HASHES needs to process the modules at build time in the
exact form they will be loaded at runtime. If the modules are stripped
afterwards they will not be loadable anymore.

Also evaluate INSTALL_MOD_STRIP at build time and build the hashes based
on modules stripped this way.

If users specify inconsistent values of INSTALL_MOD_STRIP between build
and installation time, an error is reported.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 .gitignore                | 1 +
 kernel/module/Kconfig     | 5 +++++
 scripts/Makefile.modfinal | 9 +++++++--
 scripts/Makefile.modinst  | 4 ++--
 scripts/Makefile.vmlinux  | 1 +
 5 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index 299c54083672..900251c72ade 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,6 +29,7 @@
 *.gz
 *.i
 *.ko
+*.ko.stripped
 *.lex.c
 *.ll
 *.lst
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index c00ca830330c..9fd34765ce2c 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -425,6 +425,11 @@ config MODULE_HASHES
 
 	  Also see the warning in MODULE_SIG about stripping modules.
 
+# To validate the consistency of INSTALL_MOD_STRIP for MODULE_HASHES
+config MODULE_INSTALL_STRIP
+	string
+	default "$(INSTALL_MOD_STRIP)"
+
 config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	bool "Allow loading of modules with missing namespace imports"
 	help
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 5b8e94170beb..890724edac69 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -63,10 +63,14 @@ ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 endif
 	+$(call cmd,check_tracepoint)
 
+%.ko.stripped: %.ko $(wildcard include/config/MODULE_INSTALL_STRIP)
+	$(call cmd,install_mod)
+	$(call cmd,strip_mod)
+
 quiet_cmd_merkle = MERKLE  $@
-      cmd_merkle = $(objtree)/scripts/modules-merkle-tree $@ .ko
+      cmd_merkle = $(objtree)/scripts/modules-merkle-tree $@ $(if $(CONFIG_MODULE_INSTALL_STRIP),.ko.stripped,.ko)
 
-.tmp_module_hashes.c: $(modules:%.o=%.ko) $(objtree)/scripts/modules-merkle-tree FORCE
+.tmp_module_hashes.c: $(if $(CONFIG_MODULE_INSTALL_STRIP),$(modules:%.o=%.ko.stripped),$(modules:%.o=%.ko)) $(objtree)/scripts/modules-merkle-tree $(wildcard include/config/MODULE_INSTALL_STRIP) FORCE
 	$(call cmd,merkle)
 
 ifdef CONFIG_MODULE_HASHES
@@ -75,6 +79,7 @@ endif
 
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
 targets += $(modules:%.o=%.merkle) .tmp_module_hashes.c
+targets += $(modules:%.o=%.ko.stripped)
 
 # Add FORCE to the prerequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 07380c7233a0..45606f994ad9 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -68,8 +68,8 @@ __modinst: $(install-y)
 
 ifdef CONFIG_MODULE_HASHES
 ifeq ($(KBUILD_EXTMOD),)
-ifdef INSTALL_MOD_STRIP
-$(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusive)
+ifneq ($(INSTALL_MOD_STRIP),$(CONFIG_MODULE_INSTALL_STRIP))
+$(error Inconsistent values for INSTALL_MOD_STRIP between build and installation)
 endif
 endif
 endif
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index f4e38b953b01..4ce849f6253a 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -81,6 +81,7 @@ endif
 ifdef CONFIG_MODULE_HASHES
 vmlinux.unstripped: $(objtree)/scripts/modules-merkle-tree
 vmlinux.unstripped: modules.order
+vmlinux.unstripped: $(wildcard include/config/MODULE_INSTALL_STRIP)
 endif
 
 # vmlinux

-- 
2.52.0


