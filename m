Return-Path: <linux-arch+bounces-15780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE18D18DF0
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 120E5305497A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A83933F0;
	Tue, 13 Jan 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IYN9eaFO"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0068D38E5F1;
	Tue, 13 Jan 2026 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307875; cv=none; b=atG6cychtFTHt07oNHLVMJeDBC+V+Tv5rSPsTAqtvK2yam3fiPH37Ty0HrAi4eJBXhF5/oAfmZBO7w+xtA2I4kVqyzk/H4gaU5mMnIwSKhjVnezuVbz8TK0vcgmELZoGHqrXk53AXp8YFbAJNZ9QJao8piLZk0ye1b/TsnbKPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307875; c=relaxed/simple;
	bh=ffsEg3AzeAOjcEOKQgQ3fDyvlrqj0lZ8Wi7Qp/6UEEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjZAieF9t65Y31kMN4St+Y9zPJfg/+dGStmKZUd4wjtzTWOb2Lr7CBN/rPxtFpl76Kx//bFgTXUe+oTqm3/g+89HaUgIZCjLP3gIV4HgiaswROPa+c8i0JkhsvwV1u+RkPFbaO2tszJzQl//33bu26Bg5hlrfWLdw0dhHS+3HHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IYN9eaFO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307860;
	bh=ffsEg3AzeAOjcEOKQgQ3fDyvlrqj0lZ8Wi7Qp/6UEEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IYN9eaFOHeqMdGkaTGB+TVa+imZW+KJUTkVyaop8E7fOAlzwCN4yYsDEsaCUKMvJb
	 BJ7+ic09FhUq56ePuK99CKjQ1kPB5mB/3SA0LORNRAOl75FlxxZsJAFWdv6uc+Is5a
	 jSr+kStLLuMEj2vMFjoKX/2WZjWeuYceLKDQ3AOM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:50 +0100
Subject: [PATCH v4 06/17] kbuild: add stamp file for vmlinux BTF data
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=2136;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ffsEg3AzeAOjcEOKQgQ3fDyvlrqj0lZ8Wi7Qp/6UEEQ=;
 b=b4EDQNJ82epRfEGaJ/hp28TeOBgtAEcqVjtkr3ZVEIkCclYbVB5JmexdIWsJA9Fnwm23h6Qpt
 k9oimKRiUl5DMEFJmFf+vUyh81OfbtZAcHsW0m3IjftklL33x2aCRzb
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
index 149e12ff5700..adfef1e002a9 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -56,8 +56,8 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
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
index 4ab44c73da4d..8c98f8645a5c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -111,6 +111,7 @@ vmlinux_link()
 gen_btf()
 {
 	local btf_data=${1}.btf.o
+	local btf_stamp=.tmp_vmlinux_btf.stamp
 
 	info BTF "${btf_data}"
 	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
@@ -131,6 +132,11 @@ gen_btf()
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
2.52.0


