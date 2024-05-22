Return-Path: <linux-arch+bounces-4487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF218CC094
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 13:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9961C223E2
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C513D638;
	Wed, 22 May 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvWpMfA0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458BE13D62E;
	Wed, 22 May 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378489; cv=none; b=HQ4iGklaUGWunRuLC+GJNSSYE8BCVi0kyp+zEA/Eg5e2TlWVl+Gjg0IY8NDYk/PPTGn+lk8L9hAUnrc1/4HiIqeBQolEm9TE7joqsuguugb8bxFvO9rkv94A3RoO0mtUkwjctW1Eki7NxQQ7qjympwY3YoN39I6DmrPP/sVlw3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378489; c=relaxed/simple;
	bh=DofAHYGydy0MCK/MriRhv/qvO56aW0i8A+dCe++PsSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxD3caEk5Vai099cM8ERfSkWb512iWdSUrrmz0lYZ7/6Kdsn9hrtKl+f8liM7IkrmtKBOFFTHhp5dOqDarKjbFc+1hcsDXd7MZ66Fis4cqCQjvoFtK8jLStXamf6Gw6wRXUddy54Xurc/3uBVratSQ9CzUg1h3TtWIM0qf684Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvWpMfA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFAFC4AF07;
	Wed, 22 May 2024 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716378488;
	bh=DofAHYGydy0MCK/MriRhv/qvO56aW0i8A+dCe++PsSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvWpMfA0ZKDDpmpdNmMsLDfzEjl2O8ngZw7+tWEel9/y9ODVFBsG2VViWRci2eAdy
	 v7/xHnm/URk9ahj6Ir+1ECgkVs1nczWBa5QNnfJAhyvCkdihNFiAMsLCXAwYXIfuWq
	 XyboSgG+ZmmxB0tix3B+0YZmnL1My+kwgp2n+h81l6TLgsz0q232ijAmerCRHaCHNj
	 UnKnpPiAXDPCT+cBrOumghIE3tBUv8pCNG7fgsgY3ZxrrRtykIOU3VMKiGOvVG8mg6
	 Iyh9gKHSWrR1ApfKFxgESwnj1JzDsP7ltqi/XHU09CVEZV5FbOn0HHTmsrrd6ZeFIT
	 0fboDRvyJfLcQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-arch@vger.kernel.org
Subject: [PATCH 2/3] kbuild: remove PROVIDE() for kallsyms symbols
Date: Wed, 22 May 2024 20:47:54 +0900
Message-Id: <20240522114755.318238-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240522114755.318238-1-masahiroy@kernel.org>
References: <20240522114755.318238-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reimplements commit 951bcae6c5a0 ("kallsyms: Avoid weak references
for kallsyms symbols").

I am not a big fan of PROVIDE() because it always satisfies the linker
even in situations that should result in a link error. In other words,
it can potentially shift a compile-time error into a run-time error.

Duplicating kallsyms_* in vmlinux.lds.h also reduces maintainability.

As an alternative solution, this commit prepends one more kallsyms step.

    KSYMS   .tmp_vmlinux.kallsyms0.S          # added
    AS      .tmp_vmlinux.kallsyms0.o          # added
    LD      .tmp_vmlinux.btf
    BTF     .btf.vmlinux.bin.o
    LD      .tmp_vmlinux.kallsyms1
    NM      .tmp_vmlinux.kallsyms1.syms
    KSYMS   .tmp_vmlinux.kallsyms1.S
    AS      .tmp_vmlinux.kallsyms1.o
    LD      .tmp_vmlinux.kallsyms2
    NM      .tmp_vmlinux.kallsyms2.syms
    KSYMS   .tmp_vmlinux.kallsyms2.S
    AS      .tmp_vmlinux.kallsyms2.o
    LD      vmlinux

Step 0 takes /dev/null as input, and generates .tmp_vmlinux.kallsyms0.o,
which has a valid kallsyms format with the empty symbol list, and can be
linked to vmlinux. Since it is really small, the added compile-time cost
is negligible.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/vmlinux.lds.h | 19 -------------------
 kernel/kallsyms_internal.h        |  5 -----
 scripts/kallsyms.c                |  6 ------
 scripts/link-vmlinux.sh           | 10 ++++++++--
 4 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5703526d6ebf..62b4cb0462e6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -451,30 +451,11 @@
 #endif
 #endif
 
-/*
- * Some symbol definitions will not exist yet during the first pass of the
- * link, but are guaranteed to exist in the final link. Provide preliminary
- * definitions that will be superseded in the final link to avoid having to
- * rely on weak external linkage, which requires a GOT when used in position
- * independent code.
- */
-#define PRELIMINARY_SYMBOL_DEFINITIONS					\
-	PROVIDE(kallsyms_addresses = .);				\
-	PROVIDE(kallsyms_offsets = .);					\
-	PROVIDE(kallsyms_names = .);					\
-	PROVIDE(kallsyms_num_syms = .);					\
-	PROVIDE(kallsyms_relative_base = .);				\
-	PROVIDE(kallsyms_token_table = .);				\
-	PROVIDE(kallsyms_token_index = .);				\
-	PROVIDE(kallsyms_markers = .);					\
-	PROVIDE(kallsyms_seqs_of_names = .);
-
 /*
  * Read only Data
  */
 #define RO_DATA(align)							\
 	. = ALIGN((align));						\
-	PRELIMINARY_SYMBOL_DEFINITIONS					\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 85480274fc8f..925f2ab22639 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -4,11 +4,6 @@
 
 #include <linux/types.h>
 
-/*
- * These will be re-linked against their real values during the second link
- * stage. Preliminary values must be provided in the linker script using the
- * PROVIDE() directive so that the first link stage can complete successfully.
- */
 extern const unsigned long kallsyms_addresses[];
 extern const int kallsyms_offsets[];
 extern const u8 kallsyms_names[];
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 47978efe4797..fa53b5eef553 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -259,12 +259,6 @@ static void shrink_table(void)
 		}
 	}
 	table_cnt = pos;
-
-	/* When valid symbol is not registered, exit to error */
-	if (!table_cnt) {
-		fprintf(stderr, "No valid symbol.\n");
-		exit(1);
-	}
 }
 
 static void read_map(const char *in)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index b16967d33f1c..fe7db9a265ca 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -225,6 +225,11 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init init/version-timestamp.o
 kallsymso=
 btf_vmlinux_bin_o=
 
+if is_enabled CONFIG_KALLSYMS; then
+	# kallsyms step 0
+	kallsyms /dev/null .tmp_vmlinux.kallsyms0
+fi
+
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	if ! gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
 		echo >&2 "Failed to generate BTF for vmlinux"
@@ -237,9 +242,10 @@ if is_enabled CONFIG_KALLSYMS; then
 
 	# kallsyms support
 	# Generate section listing all symbols and add it into vmlinux
-	# It's a three step process:
+	# It's a four step process:
+	# 0)  Generate a dummy __kallsyms with empty symbol list.
 	# 1)  Link .tmp_vmlinux.kallsyms1 so it has all symbols and sections,
-	#     but __kallsyms is empty.
+	#     with a dummy __kallsyms.
 	#     Running kallsyms on that gives us .tmp_kallsyms1.o with
 	#     the right size
 	# 2)  Link .tmp_vmlinux.kallsyms2 so it now has a __kallsyms section of
-- 
2.40.1


