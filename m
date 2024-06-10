Return-Path: <linux-arch+bounces-4793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B390204F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443C9B23061
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 11:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175497EEF5;
	Mon, 10 Jun 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt9WQa2p"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB257E78E;
	Mon, 10 Jun 2024 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018828; cv=none; b=Q18Q8Wrloll3Q3g5YPwmTUHwdKfCDsh146lbcD2/WIDkhb9pEYOOH9D3PzNm3kB/2DHXqPFoiIMGDeNU6975oPaH3RAnRlNt98mYzhKXVpppp0+CoG6sfz0mA8AoCwnVslgPsY9uBT83Rtgjlmz8PNEjne2BwQy5umXDS2Vzaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018828; c=relaxed/simple;
	bh=YWp1iPiHIeGBDNvDvreiqYv1vQdWI/GImqbN1VWn/nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqAoTBtt2NfLYB8mb1cNkZpNAHakFC0S8QuAPMNfivJUGbzYxJqLgtxfJ/RdO84mNrrnxnWIiyo/dWNFi4AaZJFDjcCE1BSUMfxX8TiDR3GlN8TXo/E7SMmytd5dz6zSQu46NQv7KyZwilFvib8GArVQbln47yiLd4zDJ/qVCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt9WQa2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB902C4AF1D;
	Mon, 10 Jun 2024 11:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718018827;
	bh=YWp1iPiHIeGBDNvDvreiqYv1vQdWI/GImqbN1VWn/nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dt9WQa2pVZQEA5iKkUemxtcdDb8LfWC/qRuniwk/stUC3xFMhgWZmyE2J3n31ertE
	 9AKudK7LS2a06beEdtra+N6Jpel/AUTbuo228cPehjHoKPmBwr/aMmjzDm/L3lnMQ+
	 4EJ/fHrL897FL8fmyuX2Dx9dxM5ttmZt2UJI/AZMGtgCHhXJPWxaDmIwB1SRNaAWZq
	 E2UIL26fVE9kn85Z2xies8fTm+nOrz5MLE+fvUN2KnU9pcjtPc2u4eJUCWumPCmaFo
	 BVW/E4KW7u5Lol/G76mgBcFQy2ifPccQPGYP0xvZz+fIbaRSoex5A3a3GYONZGf/FX
	 19jZ0KGBTnMqA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 2/3] kbuild: remove PROVIDE() for kallsyms symbols
Date: Mon, 10 Jun 2024 20:25:17 +0900
Message-ID: <20240610112657.602958-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610112657.602958-1-masahiroy@kernel.org>
References: <20240610112657.602958-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reimplements commit 951bcae6c5a0 ("kallsyms: Avoid weak references
for kallsyms symbols") because I am not a big fan of PROVIDE().

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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---

(no changes since v1)

 include/asm-generic/vmlinux.lds.h | 19 -------------------
 kernel/kallsyms_internal.h        |  5 -----
 scripts/kallsyms.c                |  6 ------
 scripts/link-vmlinux.sh           |  9 +++++++--
 4 files changed, 7 insertions(+), 32 deletions(-)

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
index 3d9d7257143a..83d605ba7241 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -227,6 +227,10 @@ btf_vmlinux_bin_o=
 kallsymso=
 strip_debug=
 
+if is_enabled CONFIG_KALLSYMS; then
+	kallsyms /dev/null .tmp_vmlinux.kallsyms0
+fi
+
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	if ! gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
 		echo >&2 "Failed to generate BTF for vmlinux"
@@ -239,9 +243,10 @@ if is_enabled CONFIG_KALLSYMS; then
 
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
2.43.0


