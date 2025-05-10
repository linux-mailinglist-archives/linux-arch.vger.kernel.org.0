Return-Path: <linux-arch+bounces-11879-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E0EAB2117
	for <lists+linux-arch@lfdr.de>; Sat, 10 May 2025 06:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7742B1C21333
	for <lists+linux-arch@lfdr.de>; Sat, 10 May 2025 04:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6236B11712;
	Sat, 10 May 2025 04:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtFA2yLw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3144E33F6;
	Sat, 10 May 2025 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746849676; cv=none; b=U+EKiQ6ytXQ4YWUIas/tArTjZz6Ks7mpBZaSRJqVFp6nDT/X9YxnFGWOvCuorKJDgvF9ytwP36IVUWIuCXAHmFVaji8l3Epm9dljNSuxHLSyMOmDtEoruZQxjW6FdlaV4sppL+xPFdxLpvJUVEo5hf0pIXf//7oP1Oin2Bm1q1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746849676; c=relaxed/simple;
	bh=2yibZf/BqFCxmgeVfgrmZujspAalPwgoidGyV/l3wqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mswwtsyaXW7GnLCntpeqMZ7D6wF4SrbGFeviE9NqyprLX8OEUad/Rsvv6cgXYCmY7ECZlTBOYmF2LO8jMLCC/KLw6jwWX1cXIKKlg5nDWbm2CQsaTjeiK42824EjJ4jk9CXKC0qIzhA6ejGsWe2gW6czDp7FltTzuPoaP4V3VQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtFA2yLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D388C4CEE2;
	Sat, 10 May 2025 04:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746849675;
	bh=2yibZf/BqFCxmgeVfgrmZujspAalPwgoidGyV/l3wqk=;
	h=From:To:Cc:Subject:Date:From;
	b=BtFA2yLwnVdjLHchIkfY7OY4x7J1kbx8Xk9ui86caJDELx4yrx0dwuZEXBXVmq8CV
	 QDinFCNrmYM/EQRBfJ8BleQnnQooyBccyz1a57kc+XR43Bspf2dYrEqi//7DT8tKEZ
	 aoVOrWDa4gtSWBYZuzf81hxc/vD6qTlyRS+hQe/RVLL1oxn4Ie1eBSyzBjPztC7468
	 WxKEndhuCncg9H3kusGwV/iV/+JwORgbrVu/DdmRSBGL8SvQlTZeF4H5paNqvVPwJR
	 FHbO5bStjeEe410D3BORjtXnOC70Ai7+alX7ntgliJi6jvzpQFW0dAmtejBVBzMtg/
	 Psrz6tfXjg2zA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] lib/crc: make arch-optimized code use subsys_initcall
Date: Fri,  9 May 2025 20:59:59 -0700
Message-ID: <20250510035959.87995-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Make the architecture-optimized CRC code do its CPU feature checks in
subsys_initcalls instead of arch_initcalls.  This makes it consistent
with arch/*/lib/crypto/ and ensures that it runs after initcalls that
possibly could be a prerequisite for kernel-mode FPU, such as x86's
xfd_update_static_branch() and loongarch's init_euen_mask().

Note: as far as I can tell, x86's xfd_update_static_branch() isn't
*actually* needed for kernel-mode FPU.  loongarch's init_euen_mask() is
needed to enable save/restore of the vector registers, but loongarch
doesn't yet have any CRC or crypto code that uses vector registers
anyway.  Regardless, let's be consistent with arch/*/lib/crypto/ and
robust against any potential future dependency on an arch_initcall.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

I'm planning to take this through the crc tree.

 arch/arm/lib/crc-t10dif.c            | 2 +-
 arch/arm/lib/crc32.c                 | 2 +-
 arch/arm64/lib/crc-t10dif.c          | 2 +-
 arch/loongarch/lib/crc32-loongarch.c | 2 +-
 arch/mips/lib/crc32-mips.c           | 2 +-
 arch/powerpc/lib/crc-t10dif.c        | 2 +-
 arch/powerpc/lib/crc32.c             | 2 +-
 arch/sparc/lib/crc32.c               | 2 +-
 arch/x86/lib/crc-t10dif.c            | 2 +-
 arch/x86/lib/crc32.c                 | 2 +-
 arch/x86/lib/crc64.c                 | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/lib/crc-t10dif.c b/arch/arm/lib/crc-t10dif.c
index 382437094bddd..1093f8ec13b0b 100644
--- a/arch/arm/lib/crc-t10dif.c
+++ b/arch/arm/lib/crc-t10dif.c
@@ -58,11 +58,11 @@ static int __init crc_t10dif_arm_init(void)
 		if (elf_hwcap2 & HWCAP2_PMULL)
 			static_branch_enable(&have_pmull);
 	}
 	return 0;
 }
-arch_initcall(crc_t10dif_arm_init);
+subsys_initcall(crc_t10dif_arm_init);
 
 static void __exit crc_t10dif_arm_exit(void)
 {
 }
 module_exit(crc_t10dif_arm_exit);
diff --git a/arch/arm/lib/crc32.c b/arch/arm/lib/crc32.c
index 7ef7db9c0de73..f2bef8849c7c3 100644
--- a/arch/arm/lib/crc32.c
+++ b/arch/arm/lib/crc32.c
@@ -101,11 +101,11 @@ static int __init crc32_arm_init(void)
 		static_branch_enable(&have_crc32);
 	if (elf_hwcap2 & HWCAP2_PMULL)
 		static_branch_enable(&have_pmull);
 	return 0;
 }
-arch_initcall(crc32_arm_init);
+subsys_initcall(crc32_arm_init);
 
 static void __exit crc32_arm_exit(void)
 {
 }
 module_exit(crc32_arm_exit);
diff --git a/arch/arm64/lib/crc-t10dif.c b/arch/arm64/lib/crc-t10dif.c
index 99d0b5668a286..c2ffe4fdb59d1 100644
--- a/arch/arm64/lib/crc-t10dif.c
+++ b/arch/arm64/lib/crc-t10dif.c
@@ -59,11 +59,11 @@ static int __init crc_t10dif_arm64_init(void)
 		if (cpu_have_named_feature(PMULL))
 			static_branch_enable(&have_pmull);
 	}
 	return 0;
 }
-arch_initcall(crc_t10dif_arm64_init);
+subsys_initcall(crc_t10dif_arm64_init);
 
 static void __exit crc_t10dif_arm64_exit(void)
 {
 }
 module_exit(crc_t10dif_arm64_exit);
diff --git a/arch/loongarch/lib/crc32-loongarch.c b/arch/loongarch/lib/crc32-loongarch.c
index 8e6d1f517e73c..b37cd8537b459 100644
--- a/arch/loongarch/lib/crc32-loongarch.c
+++ b/arch/loongarch/lib/crc32-loongarch.c
@@ -112,11 +112,11 @@ static int __init crc32_loongarch_init(void)
 {
 	if (cpu_has_crc32)
 		static_branch_enable(&have_crc32);
 	return 0;
 }
-arch_initcall(crc32_loongarch_init);
+subsys_initcall(crc32_loongarch_init);
 
 static void __exit crc32_loongarch_exit(void)
 {
 }
 module_exit(crc32_loongarch_exit);
diff --git a/arch/mips/lib/crc32-mips.c b/arch/mips/lib/crc32-mips.c
index 84df361e71813..45e4d2c9fbf54 100644
--- a/arch/mips/lib/crc32-mips.c
+++ b/arch/mips/lib/crc32-mips.c
@@ -161,11 +161,11 @@ static int __init crc32_mips_init(void)
 {
 	if (cpu_have_feature(cpu_feature(MIPS_CRC32)))
 		static_branch_enable(&have_crc32);
 	return 0;
 }
-arch_initcall(crc32_mips_init);
+subsys_initcall(crc32_mips_init);
 
 static void __exit crc32_mips_exit(void)
 {
 }
 module_exit(crc32_mips_exit);
diff --git a/arch/powerpc/lib/crc-t10dif.c b/arch/powerpc/lib/crc-t10dif.c
index ddd5c4088f508..4253842cc50d3 100644
--- a/arch/powerpc/lib/crc-t10dif.c
+++ b/arch/powerpc/lib/crc-t10dif.c
@@ -69,11 +69,11 @@ static int __init crc_t10dif_powerpc_init(void)
 	if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
 	    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_VEC_CRYPTO))
 		static_branch_enable(&have_vec_crypto);
 	return 0;
 }
-arch_initcall(crc_t10dif_powerpc_init);
+subsys_initcall(crc_t10dif_powerpc_init);
 
 static void __exit crc_t10dif_powerpc_exit(void)
 {
 }
 module_exit(crc_t10dif_powerpc_exit);
diff --git a/arch/powerpc/lib/crc32.c b/arch/powerpc/lib/crc32.c
index 42f2dd3c85dde..77e5a37006f00 100644
--- a/arch/powerpc/lib/crc32.c
+++ b/arch/powerpc/lib/crc32.c
@@ -70,11 +70,11 @@ static int __init crc32_powerpc_init(void)
 	if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
 	    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_VEC_CRYPTO))
 		static_branch_enable(&have_vec_crypto);
 	return 0;
 }
-arch_initcall(crc32_powerpc_init);
+subsys_initcall(crc32_powerpc_init);
 
 static void __exit crc32_powerpc_exit(void)
 {
 }
 module_exit(crc32_powerpc_exit);
diff --git a/arch/sparc/lib/crc32.c b/arch/sparc/lib/crc32.c
index 428fd5588e936..40d4720a42a1b 100644
--- a/arch/sparc/lib/crc32.c
+++ b/arch/sparc/lib/crc32.c
@@ -72,11 +72,11 @@ static int __init crc32_sparc_init(void)
 
 	static_branch_enable(&have_crc32c_opcode);
 	pr_info("Using sparc64 crc32c opcode optimized CRC32C implementation\n");
 	return 0;
 }
-arch_initcall(crc32_sparc_init);
+subsys_initcall(crc32_sparc_init);
 
 static void __exit crc32_sparc_exit(void)
 {
 }
 module_exit(crc32_sparc_exit);
diff --git a/arch/x86/lib/crc-t10dif.c b/arch/x86/lib/crc-t10dif.c
index d073b3678edc2..db7ce59c31ace 100644
--- a/arch/x86/lib/crc-t10dif.c
+++ b/arch/x86/lib/crc-t10dif.c
@@ -27,11 +27,11 @@ static int __init crc_t10dif_x86_init(void)
 		static_branch_enable(&have_pclmulqdq);
 		INIT_CRC_PCLMUL(crc16_msb);
 	}
 	return 0;
 }
-arch_initcall(crc_t10dif_x86_init);
+subsys_initcall(crc_t10dif_x86_init);
 
 static void __exit crc_t10dif_x86_exit(void)
 {
 }
 module_exit(crc_t10dif_x86_exit);
diff --git a/arch/x86/lib/crc32.c b/arch/x86/lib/crc32.c
index e6a6285cfca87..d09343e2cea93 100644
--- a/arch/x86/lib/crc32.c
+++ b/arch/x86/lib/crc32.c
@@ -86,11 +86,11 @@ static int __init crc32_x86_init(void)
 		static_branch_enable(&have_pclmulqdq);
 		INIT_CRC_PCLMUL(crc32_lsb);
 	}
 	return 0;
 }
-arch_initcall(crc32_x86_init);
+subsys_initcall(crc32_x86_init);
 
 static void __exit crc32_x86_exit(void)
 {
 }
 module_exit(crc32_x86_exit);
diff --git a/arch/x86/lib/crc64.c b/arch/x86/lib/crc64.c
index 1214ee726c16d..351a09f5813e2 100644
--- a/arch/x86/lib/crc64.c
+++ b/arch/x86/lib/crc64.c
@@ -37,11 +37,11 @@ static int __init crc64_x86_init(void)
 		INIT_CRC_PCLMUL(crc64_msb);
 		INIT_CRC_PCLMUL(crc64_lsb);
 	}
 	return 0;
 }
-arch_initcall(crc64_x86_init);
+subsys_initcall(crc64_x86_init);
 
 static void __exit crc64_x86_exit(void)
 {
 }
 module_exit(crc64_x86_exit);

base-commit: 46e3311607d6c18a760fba4afbd5d24d42abb0f3
-- 
2.49.0


