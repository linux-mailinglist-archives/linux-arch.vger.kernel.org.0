Return-Path: <linux-arch+bounces-9488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 889EC9FC6B5
	for <lists+linux-arch@lfdr.de>; Wed, 25 Dec 2024 23:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAF8162CDF
	for <lists+linux-arch@lfdr.de>; Wed, 25 Dec 2024 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B51C3F36;
	Wed, 25 Dec 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fSvgjwCg"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB11B6D17;
	Wed, 25 Dec 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735167170; cv=none; b=a2U/jITI5UBHK3FOdxT1fTTvtxWZZPcSuVz2AHw1vTo8y/KhRGO7zth6AgV7XRPhXb06A0wRwcFvSTTAHfyGsiAvN2+sZi6VHKcLv4uQV/iyvJzPW+XZx6DTzmNEmig3pCIIv81pmu5MVNRGHCGkKHAOrCUf979FZ7zSZrw7uLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735167170; c=relaxed/simple;
	bh=y6OlfJobqzwuYVaff/mCAKdWA+e3Q9Vj2fxw7lp4Yv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhiMmJLW5TCzmhbejw+dc52GwiThd2nc8WId/Zwth1iLDqm6htBmh7hhrUHMdqUFdCP20i+QajPK1TMfrfDnnQiEUoDPZKGPoj8KZqyr6uo7GifcH2ruKIyI77/7S+8pnx1x+tgTkgwNBbap5hn9SEp7gjs+nb4pyIdqrLYGCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fSvgjwCg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735167158;
	bh=y6OlfJobqzwuYVaff/mCAKdWA+e3Q9Vj2fxw7lp4Yv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fSvgjwCgv9dK1dlfEzkuixJReuW1RM+a26bQrzlJdNuNGJ8A1L31oZaPPJRgm6CUA
	 myuywrtCc8dcb1eFpcvfC7Gq7fGt4wdYY2AZ1Nfib/K54Pf4+MfuEalJoJ+qlABmpR
	 wKzGtUKoKFQyzxhTUXXrnosQNtk580iMLSHecDc8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 25 Dec 2024 23:51:59 +0100
Subject: [PATCH RFC 1/2] kbuild: add stamp file for vmlinux BTF data
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241225-module-hashes-v1-1-d710ce7a3fd1@weissschuh.net>
References: <20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net>
In-Reply-To: <20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735167158; l=2248;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=y6OlfJobqzwuYVaff/mCAKdWA+e3Q9Vj2fxw7lp4Yv4=;
 b=JhkV9v88E/yLjov5+gA+XlPvMyTJl/FrCdSpMdMOoSfJNwImODrjI5LzAbqlnmBEwBc3DA80b
 qmepGfLNw0cAu8F5pjklaBegdOZzcjyq2Ll4BH7dPoUk35tZNquye38
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
2.47.1


