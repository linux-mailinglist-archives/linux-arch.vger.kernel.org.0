Return-Path: <linux-arch+bounces-7207-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D910975064
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AD9288DC4
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9BB187334;
	Wed, 11 Sep 2024 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rde4AoKt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27471185949;
	Wed, 11 Sep 2024 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052650; cv=none; b=g7oFBofO005zcihzsWY+GaXHeatZxiv9OEhncoWQtbi7DE9sASmBAsNui7aotWN/CtBmIPe9AYM9l+6TnI8KEplQQDWZVOXvTRV4C3AEXLOO8ODSxmAb3oU0w4jj5ntwCZ7NY7fpZFlAXGI2ncJn//CacIycu5E4PYFd2Bq/8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052650; c=relaxed/simple;
	bh=ftZk5h2C2mAaLfNPnOAoAK7jRJIpQM7hPpHEjmo6pUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqrHJno9Qb3XCROWsMth42/sSw5ojE5nr2sq85oqGVTfwcxSro4s0QpqCeJ5BWbpP+ZMNp8BdvHLmjFT0R2rIv+gyP56nXn9tt+M40vC6L3MKBXkuBykAs8t1T+ZU4YQpBGQgWNWjP9QLUHJ8YzMFDQF+3fDPYSINkrmj0leUc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rde4AoKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEA5C4CEC6;
	Wed, 11 Sep 2024 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726052649;
	bh=ftZk5h2C2mAaLfNPnOAoAK7jRJIpQM7hPpHEjmo6pUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rde4AoKtM2lgQiMKJX5jxFUPfs69kGu0Ymg6fnELn33COv3S7Ww9XWT9ie/f3hFYP
	 5H/5bhbOYhnjatREHOUlz1HXZkcNGvTAn+qvTmt82mNfahXoHMemfctFiEOhf7vg+4
	 TyNSQMbFE6J/TSpyrv5OxiI/VFORVc6Ytv3tkevt6Xbxo9glfvdq4jyj0CDRIusgy4
	 KbDIcOsymS+MtIP3lnSCwJBhFHYczxYiu99wZI+pfEb88y94IqIIW+1D/zv5FqLrxa
	 sf4/jKtPwQ5aZzd7x2BlCXx3ei8Bq/gOdlfLrOMz2etTpFdAgi2eEFBJTI78Hs56Uc
	 cbcCGJahiQE1w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 2/3] btf: move pahole check in scripts/link-vmlinux.sh to lib/Kconfig.debug
Date: Wed, 11 Sep 2024 20:03:57 +0900
Message-ID: <20240911110401.598586-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911110401.598586-1-masahiroy@kernel.org>
References: <20240911110401.598586-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DEBUG_INFO_DWARF5 is selected, pahole 1.21+ is required to enable
DEBUG_INFO_BTF.

When DEBUG_INFO_DWARF4 or DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is selected,
DEBUG_INFO_BTF can be enabled without pahole installed, but a build error
will occur in scripts/link-vmlinux.sh:

    LD      .tmp_vmlinux1
  BTF: .tmp_vmlinux1: pahole (pahole) is not available
  Failed to generate BTF for vmlinux
  Try to disable CONFIG_DEBUG_INFO_BTF

We did not guard DEBUG_INFO_BTF by PAHOLE_VERSION when previously
discussed [1].

However, commit 613fe1692377 ("kbuild: Add CONFIG_PAHOLE_VERSION")
added CONFIG_PAHOLE_VERSION at all. Now several CONFIG options, as
well as the combination of DEBUG_INFO_BTF and DEBUG_INFO_DWARF5, are
guarded by PAHOLE_VERSION.

The remaining compile-time check in scripts/link-vmlinux.sh now appears
to be an awkward inconsistency.

This commit adopts Nathan's original work.

[1]: https://lore.kernel.org/lkml/20210111180609.713998-1-natechancellor@gmail.com/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 lib/Kconfig.debug       |  3 ++-
 scripts/link-vmlinux.sh | 12 ------------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5e2f30921cb2..eff408a88dfd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -379,12 +379,13 @@ config DEBUG_INFO_BTF
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
+	depends on PAHOLE_VERSION >= 116
 	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >= 121
 	# pahole uses elfutils, which does not have support for Hexagon relocations
 	depends on !HEXAGON
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
-	  Turning this on expects presence of pahole tool, which will convert
+	  Turning this on requires presence of pahole tool, which will convert
 	  DWARF type info into equivalent deduplicated BTF type info.
 
 config PAHOLE_HAS_SPLIT_BTF
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index cfffc41e20ed..53bd4b727e21 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -111,20 +111,8 @@ vmlinux_link()
 # ${1} - vmlinux image
 gen_btf()
 {
-	local pahole_ver
 	local btf_data=${1}.btf.o
 
-	if ! [ -x "$(command -v ${PAHOLE})" ]; then
-		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
-		return 1
-	fi
-
-	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
-	if [ "${pahole_ver}" -lt "116" ]; then
-		echo >&2 "BTF: ${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.16"
-		return 1
-	fi
-
 	info BTF "${btf_data}"
 	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
 
-- 
2.43.0


