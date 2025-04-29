Return-Path: <linux-arch+bounces-11714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63630AA0CCE
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 15:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A51E483FA8
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6914A2D3A71;
	Tue, 29 Apr 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qndLv3n/"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176A2D29B4;
	Tue, 29 Apr 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931891; cv=none; b=U0Wp1kKIQ8MnaUY6rRLO9TS4SiSLcjQkxBQ07jXjxu8d2l+JjKxcyOZh5UwHs0oLt/Iu7HjsECO4pAm4+iuOXm/ne49sAv/qSY3PVmRJe7J2fZjDRXMICVyhUC7W6ndk/Ism8zJC5Ye8jRlADeHVuQ1uKLGPp9oYU+HBAbduJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931891; c=relaxed/simple;
	bh=BPjoQrBeSoxkcd82ei29z+rDIHsoHB5a3gcd8mm9ZwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYd75IYxqgZCOkp/y+eoQ0fFf7GezaM2ter4+nkhFKcApZpCWcpQfrdJ+vZlvHUEkZptbLIhKdnDBdpobtMThLnJWshCDa/Osxtkt58NlJsJEZGdlklvwc9feal0LHqGfTR7YVL4Ub0zK6fJrmupg9KijHPTIs0qwbkyshRVYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qndLv3n/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745931874;
	bh=BPjoQrBeSoxkcd82ei29z+rDIHsoHB5a3gcd8mm9ZwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qndLv3n/tGVvAOxnBFK/Of0mrIhDnL/+nnxiba6Ec5ZF6RxwCXcaPl7hS8GvOaXtl
	 xouUfImN6EqV8HeXm/jn/NmYdPtWJ2aKGEPfo7ULaNPWetf3sa63MkxTvbcFrZfDCA
	 FMutZ/ujBS+URG9esXI3QLMagSUwfztRF5yqsMRI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 29 Apr 2025 15:04:30 +0200
Subject: [PATCH v3 3/9] kbuild: add stamp file for vmlinux BTF data
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-module-hashes-v3-3-00e9258def9e@weissschuh.net>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
In-Reply-To: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745931873; l=2248;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BPjoQrBeSoxkcd82ei29z+rDIHsoHB5a3gcd8mm9ZwM=;
 b=Sf43zO4gBrfx31A5hdbo/qArDl6dxz2venScmPhuBFyao5lOhmq3ejeZRkUW/+hQCvuE4MIpY
 QFZ7FUiGQmdDTtrQZZkd9s500lVKq3kBdQkA+vCyWrmomRtKxvFnbFt
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
index 51367c2bfc21ef9a8ebbc30670b1edd220b571a3..5f060787ce3fbcbcfdca0c95789d619e2a1c7b72 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -113,6 +113,7 @@ vmlinux_link()
 gen_btf()
 {
 	local btf_data=${1}.btf.o
+	local btf_stamp=.tmp_vmlinux_btf.stamp
 
 	info BTF "${btf_data}"
 	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
@@ -133,6 +134,11 @@ gen_btf()
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
2.49.0


