Return-Path: <linux-arch+bounces-9824-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88845A17238
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DCE3A38D6
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A741EE7A1;
	Mon, 20 Jan 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UeX/PmWz"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428A1EBFE4;
	Mon, 20 Jan 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395144; cv=none; b=MBZgNPrYDOWHC2Hz0WLWwlYifVBofCGrQG+msOMIdW4hdTeGkbXPOF2StmGtqj3jkoYxjpnPHoWG8YZw6nUXIHr2jLCM42pjwvZy6DrxcidhSYQsepkI2NmQM2y8WCXVhDGYsk8CKJ2khyLMmUOADbVQlBYjRCD+fu4olwskRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395144; c=relaxed/simple;
	bh=HDDtbmikCEDSTHmKoHeEuCaqiT8pJK9CEVdCoy2Xjus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Re1L9BSR1q5JMkVLuVCbRdbXPWockOoCJ4yMd9uvmlGh5Stf557xcii30JbPLG2jXM/Y17M671OaJjzfHReAeEur55RpeSWIRdxKfVZWJhYNPPfUf1YiaqA2Z3e/NORXH0+uAvBcGCsmnOCLj4jcAtskUyu2x7P8Q+5ISyhHTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UeX/PmWz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737395132;
	bh=HDDtbmikCEDSTHmKoHeEuCaqiT8pJK9CEVdCoy2Xjus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UeX/PmWztk+p/6ZQS9PW34KmIjbSktI1uzZkkxJMG1XJMyKXdUnhgds3FB0do7gzO
	 jD7WSHxDhw9r8u0pHL1eziFZqr2kiBXU48DMiXcS8gu0K8y5zru30Ap7DcFg30jGhf
	 6ovJYYzIEZHWvuT0cHFBLnoVUeKpIRzRtoPXJb7w=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 20 Jan 2025 18:44:20 +0100
Subject: [PATCH v2 1/6] kbuild: add stamp file for vmlinux BTF data
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250120-module-hashes-v2-1-ba1184e27b7f@weissschuh.net>
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
In-Reply-To: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737395132; l=2248;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HDDtbmikCEDSTHmKoHeEuCaqiT8pJK9CEVdCoy2Xjus=;
 b=UYlaeR44AqJC7COzsLKEo6ELnaEGSvoeIBK0aU8S7+Y9eg7ng/SRYoAuLDiMtsQfEyTn2FD0g
 Ryo/YTiwBZEDrM2KhnQINuGzuatlDMCSKLEVfqboSmMjmD0/UWTMao2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming module hashes functionality will build the modules in
between the generation of the BTF data and the final link of vmlinux.
Having a dependency from the modules on vmlinux would make this
impossible as it would mean having a cyclic dependency.
Break this cyclic dependency by introducing a new target.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.modfinal | 4 ++--
 scripts/link-vmlinux.sh   | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 542ba462ed3ec9607e0df10e26613a4c7ac318e8..5d01b553ec9a4565c8e5a6edd05665c409003bc1 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -52,8 +52,8 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
-	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
+%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/.tmp_vmlinux_btf.stamp) FORCE
+	+$(call if_changed_except,ld_ko_o,$(objtree)/.tmp_vmlinux_btf.stamp)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d853ddb3b28c1238ec9079ebbbe77df26980a0a1..803c8d6f35a7f29fb68b29afa8546f4dde0bd4cb 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -112,6 +112,7 @@ vmlinux_link()
 gen_btf()
 {
 	local btf_data=${1}.btf.o
+	local btf_stamp=.tmp_vmlinux_btf.stamp
 
 	info BTF "${btf_data}"
 	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
@@ -132,6 +133,11 @@ gen_btf()
 	fi
 	printf "${et_rel}" | dd of="${btf_data}" conv=notrunc bs=1 seek=16 status=none
 
+	info STAMP $btf_stamp
+	if ! cmp --silent $btf_data $btf_stamp; then
+		cp $btf_data $btf_stamp
+	fi
+
 	btf_vmlinux_bin_o=${btf_data}
 }
 

-- 
2.48.1


