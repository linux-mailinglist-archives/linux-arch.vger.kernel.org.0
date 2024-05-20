Return-Path: <linux-arch+bounces-4469-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65888C9D9A
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 14:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC31286A1F
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E856450;
	Mon, 20 May 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyBNcowk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB56CDD5;
	Mon, 20 May 2024 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208953; cv=none; b=RfSchIMC4HYW1XiEhXVe3LqbR1WT1qaQKVxlB11Z1BL/SA9T/nWSl5N7Oa3NFHlONZCtOQc4+SAvGPe09yQYZJ01rOJr+piPFW7KCMnD3ZQPZhrFjvVN8V8SsyzUz4WajtaMwjt93BqnOq+1C2C79uyC6MgoO/1673Nx1356Dy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208953; c=relaxed/simple;
	bh=qk3nM/f5UNsXDM1W0TPogosoeVu0tHgz+zzN7497OSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQhoj2aD/tJxnlv6BFOUTQI0TOIZou0BOw+gVH79aKzLiJ7YpmdtAjNuUks3EeCqKWWLRpXsAqnZshYdligxgm1z4AuXBcp4E7QFFE6lUslMRn1TGME+Gzq8KOoaDgVb1udaZ2TqzrAw7w2edwyLF5AaiMWi7ukA51ogcEwBDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyBNcowk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59504C32786;
	Mon, 20 May 2024 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716208953;
	bh=qk3nM/f5UNsXDM1W0TPogosoeVu0tHgz+zzN7497OSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyBNcowkR08Pvva3DQQQaiEwxnZnUx+kN1mQU0jtioTFXWWKsNcbTU/NJDobKCHpi
	 G4gNLhmyWu3xXc+jouWTyEfRCVviOB0FBPuOERgBnNRPebrTK6Ohb+4SQgVdH81ZcR
	 zErsQhS/IKbQbBfwXoAHzirERRlibrU40Vpn8YbatPxmg4ytJ1YSD39C0Y0wASc7ri
	 ZWppDnOZszLi5QDEv+1q4C509KA2ubG6Yudb4GPTYeVMMn+0dO8Y44XirOKLrHSIZw
	 8bffSy8phNrrXDYmSnnsDP5fw1p063RTZeHQCEZp32eRat/TI3JjTZ1LS3BzjafWVS
	 CXAM0M012rUTg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-arch@vger.kernel.org
Subject: [PATCH 4/4] kbuild: remove PROVIDE() for kallsyms symbols
Date: Mon, 20 May 2024 21:42:12 +0900
Message-Id: <20240520124212.2351033-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240520124212.2351033-1-masahiroy@kernel.org>
References: <20240520124212.2351033-1-masahiroy@kernel.org>
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

I shuffled scripts/link-vmlinux.sh to prepend one more kallsyms step.
The following logs illustrates how it works.

[Before]

    LD      .tmp_vmlinux.kallsyms1
    NM      .tmp_vmlinux.kallsyms1.syms
    KSYMS   .tmp_vmlinux.kallsyms1.S
    AS      .tmp_vmlinux.kallsyms1.o
    LD      .tmp_vmlinux.kallsyms2
    NM      .tmp_vmlinux.kallsyms2.syms
    KSYMS   .tmp_vmlinux.kallsyms2.S
    AS      .tmp_vmlinux.kallsyms2.o
    LD      vmlinux

[After]

    KSYMS   .tmp_vmlinux.kallsyms0.S          # added
    AS      .tmp_vmlinux.kallsyms0.o          # added
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
which has a valid kallsyms format with zero symbols, and can be linked
to vmlinux. Since it is really small, the added compile-time cost is
negligible.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/vmlinux.lds.h | 19 -------------
 kernel/kallsyms_internal.h        |  5 ----
 scripts/kallsyms.c                |  6 -----
 scripts/link-vmlinux.sh           | 45 ++++++++++++++++---------------
 4 files changed, 24 insertions(+), 51 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 870753fbb123..9752eb420ffa 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -448,30 +448,11 @@
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
index 653b92f6d4c8..6b90f52fd707 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -246,12 +246,6 @@ static void shrink_table(void)
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
index 7aca51b24e9f..242a92e24f20 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -165,27 +165,25 @@ kallsyms()
 		kallsymopt="${kallsymopt} --lto-clang"
 	fi
 
-	info KSYMS ${2}
-	scripts/kallsyms ${kallsymopt} ${1} > ${2}
+	info KSYMS "${2}.S"
+	scripts/kallsyms ${kallsymopt} "${1}" > "${2}.S"
+
+	info AS "${2}.o"
+	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
+	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} \
+	      -c -o "${2}.o" "${2}.S"
+	kallsymso=${2}.o
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
 # vmlinux.
 kallsyms_step()
 {
-	kallsymso_prev=${kallsymso}
 	kallsyms_vmlinux=.tmp_vmlinux.kallsyms${1}
-	kallsymso=${kallsyms_vmlinux}.o
-	kallsyms_S=${kallsyms_vmlinux}.S
 
-	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o}
-	mksysmap ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms
-	kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S}
-
-	info AS ${kallsymso}
-	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
-	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} \
-	      -c -o ${kallsymso} ${kallsyms_S}
+	vmlinux_link "${kallsyms_vmlinux}" "${kallsymso}" "${btf_vmlinux_bin_o}"
+	mksysmap "${kallsyms_vmlinux}" "${kallsyms_vmlinux}.syms"
+	kallsyms "${kallsyms_vmlinux}.syms" "${kallsyms_vmlinux}"
 }
 
 # Create map file with all symbols from ${1}
@@ -235,15 +233,15 @@ if is_enabled CONFIG_DEBUG_INFO_BTF; then
 fi
 
 kallsymso=""
-kallsymso_prev=""
-kallsyms_vmlinux=""
 if is_enabled CONFIG_KALLSYMS; then
 
 	# kallsyms support
 	# Generate section listing all symbols and add it into vmlinux
-	# It's a three step process:
+	# It's a four step process:
+	# 0)  Generate a dummy __kallsyms, which has zero symbols, but a valid
+	#     format.
 	# 1)  Link .tmp_vmlinux.kallsyms1 so it has all symbols and sections,
-	#     but __kallsyms is empty.
+	#     with a dummy __kallsyms.
 	#     Running kallsyms on that gives us .tmp_kallsyms1.o with
 	#     the right size
 	# 2)  Link .tmp_vmlinux.kallsyms2 so it now has a __kallsyms section of
@@ -262,13 +260,18 @@ if is_enabled CONFIG_KALLSYMS; then
 	# a)  Verify that the System.map from vmlinux matches the map from
 	#     ${kallsymso}.
 
-	kallsyms_step 1
-	kallsyms_step 2
+	# step 0
+	kallsyms /dev/null .tmp_vmlinux.kallsyms0
 
-	# step 3
-	size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso_prev})
+	# step 1
+	kallsyms_step 1
+	size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
+
+	# step 2
+	kallsyms_step 2
 	size2=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
 
+	# step 3
 	if [ $size1 -ne $size2 ] || [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
 		kallsyms_step 3
 	fi
-- 
2.40.1


