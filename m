Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE072E6E6
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 17:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjFMPT7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbjFMPTr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 11:19:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228AB19A8;
        Tue, 13 Jun 2023 08:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9B8461EC9;
        Tue, 13 Jun 2023 15:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B030C433F0;
        Tue, 13 Jun 2023 15:19:37 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add vector extensions support
Date:   Tue, 13 Jun 2023 23:19:18 +0800
Message-Id: <20230613151918.2039498-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add LoongArch's vector extensions support, which including 128bit LSX
(i.e., Loongson SIMD eXtension) and 256bit LASX (i.e., Loongson Advanced
SIMD eXtension).

Linux kernel doesn't use vector itself, it only handle exceptions and
context save/restore. So it only needs a subset of these instructions:

* Vector load/store:   vld vst vldx vstx xvld xvst xvldx xvstx
* 8bit-elements move:  vpickve2gr.b xvpickve2gr.b vinsgr2vr.b xvinsgr2vr.b
* 16bit-elements move: vpickve2gr.h xvpickve2gr.h vinsgr2vr.h xvinsgr2vr.h
* 32bit-elements move: vpickve2gr.w xvpickve2gr.w vinsgr2vr.w xvinsgr2vr.w
* 64bit-elements move: vpickve2gr.d xvpickve2gr.d vinsgr2vr.d xvinsgr2vr.d
* Elements permute:    vpermi.w vpermi.d xvpermi.w xvpermi.d xvpermi.q

Introduce CC_HAS_LSX_VECTORS and CC_HAS_LASX_VECTORS to avoid non-vector
toolchains complains unsupported instructions.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                       |  51 ++-
 arch/loongarch/include/asm/asmmacro.h        | 393 +++++++++++++++++++
 arch/loongarch/include/asm/fpu.h             | 185 ++++++++-
 arch/loongarch/include/uapi/asm/ptrace.h     |  16 +-
 arch/loongarch/include/uapi/asm/sigcontext.h |  18 +
 arch/loongarch/kernel/cpu-probe.c            |  12 +
 arch/loongarch/kernel/fpu.S                  | 270 +++++++++++++
 arch/loongarch/kernel/process.c              |  10 +-
 arch/loongarch/kernel/ptrace.c               | 110 ++++++
 arch/loongarch/kernel/signal.c               | 326 ++++++++++++++-
 arch/loongarch/kernel/traps.c                |  84 +++-
 11 files changed, 1452 insertions(+), 23 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 93b167f0203d..22a6cc5ef199 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -162,14 +162,6 @@ config 32BIT
 config 64BIT
 	def_bool y
 
-config CPU_HAS_FPU
-	bool
-	default y
-
-config CPU_HAS_PREFETCH
-	bool
-	default y
-
 config GENERIC_BUG
 	def_bool y
 	depends on BUG
@@ -242,6 +234,12 @@ config SCHED_OMIT_FRAME_POINTER
 config AS_HAS_EXPLICIT_RELOCS
 	def_bool $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
 
+config CC_HAS_LSX_VECTORS
+	def_bool $(cc-option,-mlsx)
+
+config CC_HAS_LASX_VECTORS
+	def_bool $(cc-option,-mlasx)
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
@@ -482,6 +480,43 @@ config ARCH_STRICT_ALIGN
 	  to run kernel only on systems with h/w unaligned access support in
 	  order to optimise for performance.
 
+config CPU_HAS_FPU
+	bool
+	default y
+
+config CPU_HAS_LSX
+	bool "Support for the Loongson SIMD Extension"
+	depends on CC_HAS_LSX_VECTORS
+	help
+	  Loongson SIMD Extension (LSX) introduces 128 bit wide vector registers
+	  and a set of SIMD instructions to operate on them. When this option
+	  is enabled the kernel will support allocating & switching LSX
+	  vector register contexts. If you know that your kernel will only be
+	  running on CPUs which do not support LSX or that your userland will
+	  not be making use of it then you may wish to say N here to reduce
+	  the size & complexity of your kernel.
+
+	  If unsure, say Y.
+
+config CPU_HAS_LASX
+	bool "Support for the Loongson Advanced SIMD Extension"
+	depends on CPU_HAS_LSX
+	depends on CC_HAS_LASX_VECTORS
+	help
+	  Loongson Advanced SIMD Extension (LASX) introduces 256 bit wide vector
+	  registers and a set of SIMD instructions to operate on them. When this
+	  option is enabled the kernel will support allocating & switching LASX
+	  vector register contexts. If you know that your kernel will only be
+	  running on CPUs which do not support LASX or that your userland will
+	  not be making use of it then you may wish to say N here to reduce
+	  the size & complexity of your kernel.
+
+	  If unsure, say Y.
+
+config CPU_HAS_PREFETCH
+	bool
+	default y
+
 config KEXEC
 	bool "Kexec system call"
 	select KEXEC_CORE
diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/include/asm/asmmacro.h
index c51a1b43acb4..79e1d53fea89 100644
--- a/arch/loongarch/include/asm/asmmacro.h
+++ b/arch/loongarch/include/asm/asmmacro.h
@@ -270,6 +270,399 @@
 	fld.d	$f31, \tmp, THREAD_FPR31 - THREAD_FPR0
 	.endm
 
+	.macro	lsx_save_data thread tmp
+	li.w	\tmp, THREAD_FPR0
+	PTR_ADD \tmp, \thread, \tmp
+	vst	$vr0, \tmp, THREAD_FPR0  - THREAD_FPR0
+	vst	$vr1, \tmp, THREAD_FPR1  - THREAD_FPR0
+	vst	$vr2, \tmp, THREAD_FPR2  - THREAD_FPR0
+	vst	$vr3, \tmp, THREAD_FPR3  - THREAD_FPR0
+	vst	$vr4, \tmp, THREAD_FPR4  - THREAD_FPR0
+	vst	$vr5, \tmp, THREAD_FPR5  - THREAD_FPR0
+	vst	$vr6, \tmp, THREAD_FPR6  - THREAD_FPR0
+	vst	$vr7, \tmp, THREAD_FPR7  - THREAD_FPR0
+	vst	$vr8, \tmp, THREAD_FPR8  - THREAD_FPR0
+	vst	$vr9, \tmp, THREAD_FPR9  - THREAD_FPR0
+	vst	$vr10, \tmp, THREAD_FPR10 - THREAD_FPR0
+	vst	$vr11, \tmp, THREAD_FPR11 - THREAD_FPR0
+	vst	$vr12, \tmp, THREAD_FPR12 - THREAD_FPR0
+	vst	$vr13, \tmp, THREAD_FPR13 - THREAD_FPR0
+	vst	$vr14, \tmp, THREAD_FPR14 - THREAD_FPR0
+	vst	$vr15, \tmp, THREAD_FPR15 - THREAD_FPR0
+	vst	$vr16, \tmp, THREAD_FPR16 - THREAD_FPR0
+	vst	$vr17, \tmp, THREAD_FPR17 - THREAD_FPR0
+	vst	$vr18, \tmp, THREAD_FPR18 - THREAD_FPR0
+	vst	$vr19, \tmp, THREAD_FPR19 - THREAD_FPR0
+	vst	$vr20, \tmp, THREAD_FPR20 - THREAD_FPR0
+	vst	$vr21, \tmp, THREAD_FPR21 - THREAD_FPR0
+	vst	$vr22, \tmp, THREAD_FPR22 - THREAD_FPR0
+	vst	$vr23, \tmp, THREAD_FPR23 - THREAD_FPR0
+	vst	$vr24, \tmp, THREAD_FPR24 - THREAD_FPR0
+	vst	$vr25, \tmp, THREAD_FPR25 - THREAD_FPR0
+	vst	$vr26, \tmp, THREAD_FPR26 - THREAD_FPR0
+	vst	$vr27, \tmp, THREAD_FPR27 - THREAD_FPR0
+	vst	$vr28, \tmp, THREAD_FPR28 - THREAD_FPR0
+	vst	$vr29, \tmp, THREAD_FPR29 - THREAD_FPR0
+	vst	$vr30, \tmp, THREAD_FPR30 - THREAD_FPR0
+	vst	$vr31, \tmp, THREAD_FPR31 - THREAD_FPR0
+	.endm
+
+	.macro	lsx_restore_data thread tmp
+	li.w	\tmp, THREAD_FPR0
+	PTR_ADD	\tmp, \thread, \tmp
+	vld	$vr0, \tmp, THREAD_FPR0  - THREAD_FPR0
+	vld	$vr1, \tmp, THREAD_FPR1  - THREAD_FPR0
+	vld	$vr2, \tmp, THREAD_FPR2  - THREAD_FPR0
+	vld	$vr3, \tmp, THREAD_FPR3  - THREAD_FPR0
+	vld	$vr4, \tmp, THREAD_FPR4  - THREAD_FPR0
+	vld	$vr5, \tmp, THREAD_FPR5  - THREAD_FPR0
+	vld	$vr6, \tmp, THREAD_FPR6  - THREAD_FPR0
+	vld	$vr7, \tmp, THREAD_FPR7  - THREAD_FPR0
+	vld	$vr8, \tmp, THREAD_FPR8  - THREAD_FPR0
+	vld	$vr9, \tmp, THREAD_FPR9  - THREAD_FPR0
+	vld	$vr10, \tmp, THREAD_FPR10 - THREAD_FPR0
+	vld	$vr11, \tmp, THREAD_FPR11 - THREAD_FPR0
+	vld	$vr12, \tmp, THREAD_FPR12 - THREAD_FPR0
+	vld	$vr13, \tmp, THREAD_FPR13 - THREAD_FPR0
+	vld	$vr14, \tmp, THREAD_FPR14 - THREAD_FPR0
+	vld	$vr15, \tmp, THREAD_FPR15 - THREAD_FPR0
+	vld	$vr16, \tmp, THREAD_FPR16 - THREAD_FPR0
+	vld	$vr17, \tmp, THREAD_FPR17 - THREAD_FPR0
+	vld	$vr18, \tmp, THREAD_FPR18 - THREAD_FPR0
+	vld	$vr19, \tmp, THREAD_FPR19 - THREAD_FPR0
+	vld	$vr20, \tmp, THREAD_FPR20 - THREAD_FPR0
+	vld	$vr21, \tmp, THREAD_FPR21 - THREAD_FPR0
+	vld	$vr22, \tmp, THREAD_FPR22 - THREAD_FPR0
+	vld	$vr23, \tmp, THREAD_FPR23 - THREAD_FPR0
+	vld	$vr24, \tmp, THREAD_FPR24 - THREAD_FPR0
+	vld	$vr25, \tmp, THREAD_FPR25 - THREAD_FPR0
+	vld	$vr26, \tmp, THREAD_FPR26 - THREAD_FPR0
+	vld	$vr27, \tmp, THREAD_FPR27 - THREAD_FPR0
+	vld	$vr28, \tmp, THREAD_FPR28 - THREAD_FPR0
+	vld	$vr29, \tmp, THREAD_FPR29 - THREAD_FPR0
+	vld	$vr30, \tmp, THREAD_FPR30 - THREAD_FPR0
+	vld	$vr31, \tmp, THREAD_FPR31 - THREAD_FPR0
+	.endm
+
+	.macro	lsx_save_all	thread tmp0 tmp1
+	fpu_save_cc		\thread, \tmp0, \tmp1
+	fpu_save_csr		\thread, \tmp0
+	lsx_save_data		\thread, \tmp0
+	.endm
+
+	.macro	lsx_restore_all	thread tmp0 tmp1
+	lsx_restore_data	\thread, \tmp0
+	fpu_restore_cc		\thread, \tmp0, \tmp1
+	fpu_restore_csr		\thread, \tmp0
+	.endm
+
+	.macro	lsx_save_upper vd base tmp off
+	vpickve2gr.d	\tmp, \vd, 1
+	st.d		\tmp, \base, (\off+8)
+	.endm
+
+	.macro	lsx_save_all_upper thread base tmp
+	li.w		\tmp, THREAD_FPR0
+	PTR_ADD		\base, \thread, \tmp
+	lsx_save_upper	$vr0,  \base, \tmp, (THREAD_FPR0-THREAD_FPR0)
+	lsx_save_upper	$vr1,  \base, \tmp, (THREAD_FPR1-THREAD_FPR0)
+	lsx_save_upper	$vr2,  \base, \tmp, (THREAD_FPR2-THREAD_FPR0)
+	lsx_save_upper	$vr3,  \base, \tmp, (THREAD_FPR3-THREAD_FPR0)
+	lsx_save_upper	$vr4,  \base, \tmp, (THREAD_FPR4-THREAD_FPR0)
+	lsx_save_upper	$vr5,  \base, \tmp, (THREAD_FPR5-THREAD_FPR0)
+	lsx_save_upper	$vr6,  \base, \tmp, (THREAD_FPR6-THREAD_FPR0)
+	lsx_save_upper	$vr7,  \base, \tmp, (THREAD_FPR7-THREAD_FPR0)
+	lsx_save_upper	$vr8,  \base, \tmp, (THREAD_FPR8-THREAD_FPR0)
+	lsx_save_upper	$vr9,  \base, \tmp, (THREAD_FPR9-THREAD_FPR0)
+	lsx_save_upper	$vr10, \base, \tmp, (THREAD_FPR10-THREAD_FPR0)
+	lsx_save_upper	$vr11, \base, \tmp, (THREAD_FPR11-THREAD_FPR0)
+	lsx_save_upper	$vr12, \base, \tmp, (THREAD_FPR12-THREAD_FPR0)
+	lsx_save_upper	$vr13, \base, \tmp, (THREAD_FPR13-THREAD_FPR0)
+	lsx_save_upper	$vr14, \base, \tmp, (THREAD_FPR14-THREAD_FPR0)
+	lsx_save_upper	$vr15, \base, \tmp, (THREAD_FPR15-THREAD_FPR0)
+	lsx_save_upper	$vr16, \base, \tmp, (THREAD_FPR16-THREAD_FPR0)
+	lsx_save_upper	$vr17, \base, \tmp, (THREAD_FPR17-THREAD_FPR0)
+	lsx_save_upper	$vr18, \base, \tmp, (THREAD_FPR18-THREAD_FPR0)
+	lsx_save_upper	$vr19, \base, \tmp, (THREAD_FPR19-THREAD_FPR0)
+	lsx_save_upper	$vr20, \base, \tmp, (THREAD_FPR20-THREAD_FPR0)
+	lsx_save_upper	$vr21, \base, \tmp, (THREAD_FPR21-THREAD_FPR0)
+	lsx_save_upper	$vr22, \base, \tmp, (THREAD_FPR22-THREAD_FPR0)
+	lsx_save_upper	$vr23, \base, \tmp, (THREAD_FPR23-THREAD_FPR0)
+	lsx_save_upper	$vr24, \base, \tmp, (THREAD_FPR24-THREAD_FPR0)
+	lsx_save_upper	$vr25, \base, \tmp, (THREAD_FPR25-THREAD_FPR0)
+	lsx_save_upper	$vr26, \base, \tmp, (THREAD_FPR26-THREAD_FPR0)
+	lsx_save_upper	$vr27, \base, \tmp, (THREAD_FPR27-THREAD_FPR0)
+	lsx_save_upper	$vr28, \base, \tmp, (THREAD_FPR28-THREAD_FPR0)
+	lsx_save_upper	$vr29, \base, \tmp, (THREAD_FPR29-THREAD_FPR0)
+	lsx_save_upper	$vr30, \base, \tmp, (THREAD_FPR30-THREAD_FPR0)
+	lsx_save_upper	$vr31, \base, \tmp, (THREAD_FPR31-THREAD_FPR0)
+	.endm
+
+	.macro	lsx_restore_upper vd base tmp off
+	ld.d		\tmp, \base, (\off+8)
+	vinsgr2vr.d	\vd,  \tmp, 1
+	.endm
+
+	.macro	lsx_restore_all_upper thread base tmp
+	li.w		  \tmp, THREAD_FPR0
+	PTR_ADD		  \base, \thread, \tmp
+	lsx_restore_upper $vr0,  \base, \tmp, (THREAD_FPR0-THREAD_FPR0)
+	lsx_restore_upper $vr1,  \base, \tmp, (THREAD_FPR1-THREAD_FPR0)
+	lsx_restore_upper $vr2,  \base, \tmp, (THREAD_FPR2-THREAD_FPR0)
+	lsx_restore_upper $vr3,  \base, \tmp, (THREAD_FPR3-THREAD_FPR0)
+	lsx_restore_upper $vr4,  \base, \tmp, (THREAD_FPR4-THREAD_FPR0)
+	lsx_restore_upper $vr5,  \base, \tmp, (THREAD_FPR5-THREAD_FPR0)
+	lsx_restore_upper $vr6,  \base, \tmp, (THREAD_FPR6-THREAD_FPR0)
+	lsx_restore_upper $vr7,  \base, \tmp, (THREAD_FPR7-THREAD_FPR0)
+	lsx_restore_upper $vr8,  \base, \tmp, (THREAD_FPR8-THREAD_FPR0)
+	lsx_restore_upper $vr9,  \base, \tmp, (THREAD_FPR9-THREAD_FPR0)
+	lsx_restore_upper $vr10, \base, \tmp, (THREAD_FPR10-THREAD_FPR0)
+	lsx_restore_upper $vr11, \base, \tmp, (THREAD_FPR11-THREAD_FPR0)
+	lsx_restore_upper $vr12, \base, \tmp, (THREAD_FPR12-THREAD_FPR0)
+	lsx_restore_upper $vr13, \base, \tmp, (THREAD_FPR13-THREAD_FPR0)
+	lsx_restore_upper $vr14, \base, \tmp, (THREAD_FPR14-THREAD_FPR0)
+	lsx_restore_upper $vr15, \base, \tmp, (THREAD_FPR15-THREAD_FPR0)
+	lsx_restore_upper $vr16, \base, \tmp, (THREAD_FPR16-THREAD_FPR0)
+	lsx_restore_upper $vr17, \base, \tmp, (THREAD_FPR17-THREAD_FPR0)
+	lsx_restore_upper $vr18, \base, \tmp, (THREAD_FPR18-THREAD_FPR0)
+	lsx_restore_upper $vr19, \base, \tmp, (THREAD_FPR19-THREAD_FPR0)
+	lsx_restore_upper $vr20, \base, \tmp, (THREAD_FPR20-THREAD_FPR0)
+	lsx_restore_upper $vr21, \base, \tmp, (THREAD_FPR21-THREAD_FPR0)
+	lsx_restore_upper $vr22, \base, \tmp, (THREAD_FPR22-THREAD_FPR0)
+	lsx_restore_upper $vr23, \base, \tmp, (THREAD_FPR23-THREAD_FPR0)
+	lsx_restore_upper $vr24, \base, \tmp, (THREAD_FPR24-THREAD_FPR0)
+	lsx_restore_upper $vr25, \base, \tmp, (THREAD_FPR25-THREAD_FPR0)
+	lsx_restore_upper $vr26, \base, \tmp, (THREAD_FPR26-THREAD_FPR0)
+	lsx_restore_upper $vr27, \base, \tmp, (THREAD_FPR27-THREAD_FPR0)
+	lsx_restore_upper $vr28, \base, \tmp, (THREAD_FPR28-THREAD_FPR0)
+	lsx_restore_upper $vr29, \base, \tmp, (THREAD_FPR29-THREAD_FPR0)
+	lsx_restore_upper $vr30, \base, \tmp, (THREAD_FPR30-THREAD_FPR0)
+	lsx_restore_upper $vr31, \base, \tmp, (THREAD_FPR31-THREAD_FPR0)
+	.endm
+
+	.macro	lsx_init_upper vd tmp
+	vinsgr2vr.d	\vd, \tmp, 1
+	.endm
+
+	.macro	lsx_init_all_upper tmp
+	not		\tmp, zero
+	lsx_init_upper	$vr0 \tmp
+	lsx_init_upper	$vr1 \tmp
+	lsx_init_upper	$vr2 \tmp
+	lsx_init_upper	$vr3 \tmp
+	lsx_init_upper	$vr4 \tmp
+	lsx_init_upper	$vr5 \tmp
+	lsx_init_upper	$vr6 \tmp
+	lsx_init_upper	$vr7 \tmp
+	lsx_init_upper	$vr8 \tmp
+	lsx_init_upper	$vr9 \tmp
+	lsx_init_upper	$vr10 \tmp
+	lsx_init_upper	$vr11 \tmp
+	lsx_init_upper	$vr12 \tmp
+	lsx_init_upper	$vr13 \tmp
+	lsx_init_upper	$vr14 \tmp
+	lsx_init_upper	$vr15 \tmp
+	lsx_init_upper	$vr16 \tmp
+	lsx_init_upper	$vr17 \tmp
+	lsx_init_upper	$vr18 \tmp
+	lsx_init_upper	$vr19 \tmp
+	lsx_init_upper	$vr20 \tmp
+	lsx_init_upper	$vr21 \tmp
+	lsx_init_upper	$vr22 \tmp
+	lsx_init_upper	$vr23 \tmp
+	lsx_init_upper	$vr24 \tmp
+	lsx_init_upper	$vr25 \tmp
+	lsx_init_upper	$vr26 \tmp
+	lsx_init_upper	$vr27 \tmp
+	lsx_init_upper	$vr28 \tmp
+	lsx_init_upper	$vr29 \tmp
+	lsx_init_upper	$vr30 \tmp
+	lsx_init_upper	$vr31 \tmp
+	.endm
+
+	.macro	lasx_save_data thread tmp
+	li.w	\tmp, THREAD_FPR0
+	PTR_ADD	\tmp, \thread, \tmp
+	xvst	$xr0, \tmp, THREAD_FPR0  - THREAD_FPR0
+	xvst	$xr1, \tmp, THREAD_FPR1  - THREAD_FPR0
+	xvst	$xr2, \tmp, THREAD_FPR2  - THREAD_FPR0
+	xvst	$xr3, \tmp, THREAD_FPR3  - THREAD_FPR0
+	xvst	$xr4, \tmp, THREAD_FPR4  - THREAD_FPR0
+	xvst	$xr5, \tmp, THREAD_FPR5  - THREAD_FPR0
+	xvst	$xr6, \tmp, THREAD_FPR6  - THREAD_FPR0
+	xvst	$xr7, \tmp, THREAD_FPR7  - THREAD_FPR0
+	xvst	$xr8, \tmp, THREAD_FPR8  - THREAD_FPR0
+	xvst	$xr9, \tmp, THREAD_FPR9  - THREAD_FPR0
+	xvst	$xr10, \tmp, THREAD_FPR10 - THREAD_FPR0
+	xvst	$xr11, \tmp, THREAD_FPR11 - THREAD_FPR0
+	xvst	$xr12, \tmp, THREAD_FPR12 - THREAD_FPR0
+	xvst	$xr13, \tmp, THREAD_FPR13 - THREAD_FPR0
+	xvst	$xr14, \tmp, THREAD_FPR14 - THREAD_FPR0
+	xvst	$xr15, \tmp, THREAD_FPR15 - THREAD_FPR0
+	xvst	$xr16, \tmp, THREAD_FPR16 - THREAD_FPR0
+	xvst	$xr17, \tmp, THREAD_FPR17 - THREAD_FPR0
+	xvst	$xr18, \tmp, THREAD_FPR18 - THREAD_FPR0
+	xvst	$xr19, \tmp, THREAD_FPR19 - THREAD_FPR0
+	xvst	$xr20, \tmp, THREAD_FPR20 - THREAD_FPR0
+	xvst	$xr21, \tmp, THREAD_FPR21 - THREAD_FPR0
+	xvst	$xr22, \tmp, THREAD_FPR22 - THREAD_FPR0
+	xvst	$xr23, \tmp, THREAD_FPR23 - THREAD_FPR0
+	xvst	$xr24, \tmp, THREAD_FPR24 - THREAD_FPR0
+	xvst	$xr25, \tmp, THREAD_FPR25 - THREAD_FPR0
+	xvst	$xr26, \tmp, THREAD_FPR26 - THREAD_FPR0
+	xvst	$xr27, \tmp, THREAD_FPR27 - THREAD_FPR0
+	xvst	$xr28, \tmp, THREAD_FPR28 - THREAD_FPR0
+	xvst	$xr29, \tmp, THREAD_FPR29 - THREAD_FPR0
+	xvst	$xr30, \tmp, THREAD_FPR30 - THREAD_FPR0
+	xvst	$xr31, \tmp, THREAD_FPR31 - THREAD_FPR0
+	.endm
+
+	.macro	lasx_restore_data thread tmp
+	li.w	\tmp, THREAD_FPR0
+	PTR_ADD	\tmp, \thread, \tmp
+	xvld	$xr0, \tmp, THREAD_FPR0  - THREAD_FPR0
+	xvld	$xr1, \tmp, THREAD_FPR1  - THREAD_FPR0
+	xvld	$xr2, \tmp, THREAD_FPR2  - THREAD_FPR0
+	xvld	$xr3, \tmp, THREAD_FPR3  - THREAD_FPR0
+	xvld	$xr4, \tmp, THREAD_FPR4  - THREAD_FPR0
+	xvld	$xr5, \tmp, THREAD_FPR5  - THREAD_FPR0
+	xvld	$xr6, \tmp, THREAD_FPR6  - THREAD_FPR0
+	xvld	$xr7, \tmp, THREAD_FPR7  - THREAD_FPR0
+	xvld	$xr8, \tmp, THREAD_FPR8  - THREAD_FPR0
+	xvld	$xr9, \tmp, THREAD_FPR9  - THREAD_FPR0
+	xvld	$xr10, \tmp, THREAD_FPR10 - THREAD_FPR0
+	xvld	$xr11, \tmp, THREAD_FPR11 - THREAD_FPR0
+	xvld	$xr12, \tmp, THREAD_FPR12 - THREAD_FPR0
+	xvld	$xr13, \tmp, THREAD_FPR13 - THREAD_FPR0
+	xvld	$xr14, \tmp, THREAD_FPR14 - THREAD_FPR0
+	xvld	$xr15, \tmp, THREAD_FPR15 - THREAD_FPR0
+	xvld	$xr16, \tmp, THREAD_FPR16 - THREAD_FPR0
+	xvld	$xr17, \tmp, THREAD_FPR17 - THREAD_FPR0
+	xvld	$xr18, \tmp, THREAD_FPR18 - THREAD_FPR0
+	xvld	$xr19, \tmp, THREAD_FPR19 - THREAD_FPR0
+	xvld	$xr20, \tmp, THREAD_FPR20 - THREAD_FPR0
+	xvld	$xr21, \tmp, THREAD_FPR21 - THREAD_FPR0
+	xvld	$xr22, \tmp, THREAD_FPR22 - THREAD_FPR0
+	xvld	$xr23, \tmp, THREAD_FPR23 - THREAD_FPR0
+	xvld	$xr24, \tmp, THREAD_FPR24 - THREAD_FPR0
+	xvld	$xr25, \tmp, THREAD_FPR25 - THREAD_FPR0
+	xvld	$xr26, \tmp, THREAD_FPR26 - THREAD_FPR0
+	xvld	$xr27, \tmp, THREAD_FPR27 - THREAD_FPR0
+	xvld	$xr28, \tmp, THREAD_FPR28 - THREAD_FPR0
+	xvld	$xr29, \tmp, THREAD_FPR29 - THREAD_FPR0
+	xvld	$xr30, \tmp, THREAD_FPR30 - THREAD_FPR0
+	xvld	$xr31, \tmp, THREAD_FPR31 - THREAD_FPR0
+	.endm
+
+	.macro	lasx_save_all	thread tmp0 tmp1
+	fpu_save_cc		\thread, \tmp0, \tmp1
+	fpu_save_csr		\thread, \tmp0
+	lasx_save_data		\thread, \tmp0
+	.endm
+
+	.macro	lasx_restore_all thread tmp0 tmp1
+	lasx_restore_data	\thread, \tmp0
+	fpu_restore_cc		\thread, \tmp0, \tmp1
+	fpu_restore_csr		\thread, \tmp0
+	.endm
+
+	.macro	lasx_save_upper xd base tmp off
+	/* Nothing */
+	.endm
+
+	.macro	lasx_save_all_upper thread base tmp
+	/* Nothing */
+	.endm
+
+	.macro	lasx_restore_upper xd base tmp0 tmp1 off
+	vld		\tmp0, \base, (\off+16)
+	xvpermi.q 	\xd,   \tmp1, 0x2
+	.endm
+
+	.macro	lasx_restore_all_upper thread base tmp
+	li.w		\tmp, THREAD_FPR0
+	PTR_ADD		\base, \thread, \tmp
+	/* Save $vr31 ($xr31 lower bits) with xvpickve2gr */
+	xvpickve2gr.d	$r17, $xr31, 0
+	xvpickve2gr.d	$r18, $xr31, 1
+	lasx_restore_upper $xr0, \base, $vr31, $xr31, (THREAD_FPR0-THREAD_FPR0)
+	lasx_restore_upper $xr1, \base, $vr31, $xr31, (THREAD_FPR1-THREAD_FPR0)
+	lasx_restore_upper $xr2, \base, $vr31, $xr31, (THREAD_FPR2-THREAD_FPR0)
+	lasx_restore_upper $xr3, \base, $vr31, $xr31, (THREAD_FPR3-THREAD_FPR0)
+	lasx_restore_upper $xr4, \base, $vr31, $xr31, (THREAD_FPR4-THREAD_FPR0)
+	lasx_restore_upper $xr5, \base, $vr31, $xr31, (THREAD_FPR5-THREAD_FPR0)
+	lasx_restore_upper $xr6, \base, $vr31, $xr31, (THREAD_FPR6-THREAD_FPR0)
+	lasx_restore_upper $xr7, \base, $vr31, $xr31, (THREAD_FPR7-THREAD_FPR0)
+	lasx_restore_upper $xr8, \base, $vr31, $xr31, (THREAD_FPR8-THREAD_FPR0)
+	lasx_restore_upper $xr9, \base, $vr31, $xr31, (THREAD_FPR9-THREAD_FPR0)
+	lasx_restore_upper $xr10, \base, $vr31, $xr31, (THREAD_FPR10-THREAD_FPR0)
+	lasx_restore_upper $xr11, \base, $vr31, $xr31, (THREAD_FPR11-THREAD_FPR0)
+	lasx_restore_upper $xr12, \base, $vr31, $xr31, (THREAD_FPR12-THREAD_FPR0)
+	lasx_restore_upper $xr13, \base, $vr31, $xr31, (THREAD_FPR13-THREAD_FPR0)
+	lasx_restore_upper $xr14, \base, $vr31, $xr31, (THREAD_FPR14-THREAD_FPR0)
+	lasx_restore_upper $xr15, \base, $vr31, $xr31, (THREAD_FPR15-THREAD_FPR0)
+	lasx_restore_upper $xr16, \base, $vr31, $xr31, (THREAD_FPR16-THREAD_FPR0)
+	lasx_restore_upper $xr17, \base, $vr31, $xr31, (THREAD_FPR17-THREAD_FPR0)
+	lasx_restore_upper $xr18, \base, $vr31, $xr31, (THREAD_FPR18-THREAD_FPR0)
+	lasx_restore_upper $xr19, \base, $vr31, $xr31, (THREAD_FPR19-THREAD_FPR0)
+	lasx_restore_upper $xr20, \base, $vr31, $xr31, (THREAD_FPR20-THREAD_FPR0)
+	lasx_restore_upper $xr21, \base, $vr31, $xr31, (THREAD_FPR21-THREAD_FPR0)
+	lasx_restore_upper $xr22, \base, $vr31, $xr31, (THREAD_FPR22-THREAD_FPR0)
+	lasx_restore_upper $xr23, \base, $vr31, $xr31, (THREAD_FPR23-THREAD_FPR0)
+	lasx_restore_upper $xr24, \base, $vr31, $xr31, (THREAD_FPR24-THREAD_FPR0)
+	lasx_restore_upper $xr25, \base, $vr31, $xr31, (THREAD_FPR25-THREAD_FPR0)
+	lasx_restore_upper $xr26, \base, $vr31, $xr31, (THREAD_FPR26-THREAD_FPR0)
+	lasx_restore_upper $xr27, \base, $vr31, $xr31, (THREAD_FPR27-THREAD_FPR0)
+	lasx_restore_upper $xr28, \base, $vr31, $xr31, (THREAD_FPR28-THREAD_FPR0)
+	lasx_restore_upper $xr29, \base, $vr31, $xr31, (THREAD_FPR29-THREAD_FPR0)
+	lasx_restore_upper $xr30, \base, $vr31, $xr31, (THREAD_FPR30-THREAD_FPR0)
+	lasx_restore_upper $xr31, \base, $vr31, $xr31, (THREAD_FPR31-THREAD_FPR0)
+	/* Restore $vr31 ($xr31 lower bits) with xvinsgr2vr */
+	xvinsgr2vr.d	$xr31, $r17, 0
+	xvinsgr2vr.d	$xr31, $r18, 1
+	.endm
+
+	.macro	lasx_init_upper xd tmp
+	xvinsgr2vr.d	\xd, \tmp, 2
+	xvinsgr2vr.d	\xd, \tmp, 3
+	.endm
+
+	.macro	lasx_init_all_upper tmp
+	not		\tmp, zero
+	lasx_init_upper	$xr0 \tmp
+	lasx_init_upper	$xr1 \tmp
+	lasx_init_upper	$xr2 \tmp
+	lasx_init_upper	$xr3 \tmp
+	lasx_init_upper	$xr4 \tmp
+	lasx_init_upper	$xr5 \tmp
+	lasx_init_upper	$xr6 \tmp
+	lasx_init_upper	$xr7 \tmp
+	lasx_init_upper	$xr8 \tmp
+	lasx_init_upper	$xr9 \tmp
+	lasx_init_upper	$xr10 \tmp
+	lasx_init_upper	$xr11 \tmp
+	lasx_init_upper	$xr12 \tmp
+	lasx_init_upper	$xr13 \tmp
+	lasx_init_upper	$xr14 \tmp
+	lasx_init_upper	$xr15 \tmp
+	lasx_init_upper	$xr16 \tmp
+	lasx_init_upper	$xr17 \tmp
+	lasx_init_upper	$xr18 \tmp
+	lasx_init_upper	$xr19 \tmp
+	lasx_init_upper	$xr20 \tmp
+	lasx_init_upper	$xr21 \tmp
+	lasx_init_upper	$xr22 \tmp
+	lasx_init_upper	$xr23 \tmp
+	lasx_init_upper	$xr24 \tmp
+	lasx_init_upper	$xr25 \tmp
+	lasx_init_upper	$xr26 \tmp
+	lasx_init_upper	$xr27 \tmp
+	lasx_init_upper	$xr28 \tmp
+	lasx_init_upper	$xr29 \tmp
+	lasx_init_upper	$xr30 \tmp
+	lasx_init_upper	$xr31 \tmp
+	.endm
+
 .macro not dst src
 	nor	\dst, \src, zero
 .endm
diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index 192f8e35d912..e4193d637f66 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -28,6 +28,26 @@ extern void _init_fpu(unsigned int);
 extern void _save_fp(struct loongarch_fpu *);
 extern void _restore_fp(struct loongarch_fpu *);
 
+extern void _save_lsx(struct loongarch_fpu *fpu);
+extern void _restore_lsx(struct loongarch_fpu *fpu);
+extern void _init_lsx_upper(void);
+extern void _restore_lsx_upper(struct loongarch_fpu *fpu);
+
+extern void _save_lasx(struct loongarch_fpu *fpu);
+extern void _restore_lasx(struct loongarch_fpu *fpu);
+extern void _init_lasx_upper(void);
+extern void _restore_lasx_upper(struct loongarch_fpu *fpu);
+
+static inline void enable_lsx(void);
+static inline void disable_lsx(void);
+static inline void save_lsx(struct task_struct *t);
+static inline void restore_lsx(struct task_struct *t);
+
+static inline void enable_lasx(void);
+static inline void disable_lasx(void);
+static inline void save_lasx(struct task_struct *t);
+static inline void restore_lasx(struct task_struct *t);
+
 /*
  * Mask the FCSR Cause bits according to the Enable bits, observing
  * that Unimplemented is always enabled.
@@ -44,6 +64,29 @@ static inline int is_fp_enabled(void)
 		1 : 0;
 }
 
+static inline int is_lsx_enabled(void)
+{
+	if (!cpu_has_lsx)
+		return 0;
+
+	return (csr_read32(LOONGARCH_CSR_EUEN) & CSR_EUEN_LSXEN) ?
+		1 : 0;
+}
+
+static inline int is_lasx_enabled(void)
+{
+	if (!cpu_has_lasx)
+		return 0;
+
+	return (csr_read32(LOONGARCH_CSR_EUEN) & CSR_EUEN_LASXEN) ?
+		1 : 0;
+}
+
+static inline int is_simd_enabled(void)
+{
+	return is_lsx_enabled() | is_lasx_enabled();
+}
+
 #define enable_fpu()		set_csr_euen(CSR_EUEN_FPEN)
 
 #define disable_fpu()		clear_csr_euen(CSR_EUEN_FPEN)
@@ -81,9 +124,22 @@ static inline void own_fpu(int restore)
 static inline void lose_fpu_inatomic(int save, struct task_struct *tsk)
 {
 	if (is_fpu_owner()) {
-		if (save)
-			_save_fp(&tsk->thread.fpu);
-		disable_fpu();
+		if (!is_simd_enabled()) {
+			if (save)
+				_save_fp(&tsk->thread.fpu);
+			disable_fpu();
+		} else {
+			if (save) {
+				if (!is_lasx_enabled())
+					save_lsx(tsk);
+				else
+					save_lasx(tsk);
+			}
+			disable_fpu();
+			disable_lsx();
+			disable_lasx();
+			clear_tsk_thread_flag(tsk, TIF_USEDSIMD);
+		}
 		clear_tsk_thread_flag(tsk, TIF_USEDFPU);
 	}
 	KSTK_EUEN(tsk) &= ~(CSR_EUEN_FPEN | CSR_EUEN_LSXEN | CSR_EUEN_LASXEN);
@@ -129,4 +185,127 @@ static inline union fpureg *get_fpu_regs(struct task_struct *tsk)
 	return tsk->thread.fpu.fpr;
 }
 
+static inline int is_simd_owner(void)
+{
+	return test_thread_flag(TIF_USEDSIMD);
+}
+
+#ifdef CONFIG_CPU_HAS_LSX
+
+static inline void enable_lsx(void)
+{
+	if (cpu_has_lsx)
+		csr_xchg32(CSR_EUEN_LSXEN, CSR_EUEN_LSXEN, LOONGARCH_CSR_EUEN);
+}
+
+static inline void disable_lsx(void)
+{
+	if (cpu_has_lsx)
+		csr_xchg32(0, CSR_EUEN_LSXEN, LOONGARCH_CSR_EUEN);
+}
+
+static inline void save_lsx(struct task_struct *t)
+{
+	if (cpu_has_lsx)
+		_save_lsx(&t->thread.fpu);
+}
+
+static inline void restore_lsx(struct task_struct *t)
+{
+	if (cpu_has_lsx)
+		_restore_lsx(&t->thread.fpu);
+}
+
+static inline void init_lsx_upper(void)
+{
+	/*
+	 * Check cpu_has_lsx only if it's a constant. This will allow the
+	 * compiler to optimise out code for CPUs without LSX without adding
+	 * an extra redundant check for CPUs with LSX.
+	 */
+	if (__builtin_constant_p(cpu_has_lsx) && !cpu_has_lsx)
+		return;
+
+	_init_lsx_upper();
+}
+
+static inline void restore_lsx_upper(struct task_struct *t)
+{
+	if (cpu_has_lsx)
+		_restore_lsx_upper(&t->thread.fpu);
+}
+
+#else
+static inline void enable_lsx(void) {}
+static inline void disable_lsx(void) {}
+static inline void save_lsx(struct task_struct *t) {}
+static inline void restore_lsx(struct task_struct *t) {}
+static inline void init_lsx_upper(void) {}
+static inline void restore_lsx_upper(struct task_struct *t) {}
+#endif
+
+#ifdef CONFIG_CPU_HAS_LASX
+
+static inline void enable_lasx(void)
+{
+
+	if (cpu_has_lasx)
+		csr_xchg32(CSR_EUEN_LASXEN, CSR_EUEN_LASXEN, LOONGARCH_CSR_EUEN);
+}
+
+static inline void disable_lasx(void)
+{
+	if (cpu_has_lasx)
+		csr_xchg32(0, CSR_EUEN_LASXEN, LOONGARCH_CSR_EUEN);
+}
+
+static inline void save_lasx(struct task_struct *t)
+{
+	if (cpu_has_lasx)
+		_save_lasx(&t->thread.fpu);
+}
+
+static inline void restore_lasx(struct task_struct *t)
+{
+	if (cpu_has_lasx)
+		_restore_lasx(&t->thread.fpu);
+}
+
+static inline void init_lasx_upper(void)
+{
+	if (cpu_has_lasx)
+		_init_lasx_upper();
+}
+
+static inline void restore_lasx_upper(struct task_struct *t)
+{
+	if (cpu_has_lasx)
+		_restore_lasx_upper(&t->thread.fpu);
+}
+
+#else
+static inline void enable_lasx(void) {}
+static inline void disable_lasx(void) {}
+static inline void save_lasx(struct task_struct *t) {}
+static inline void restore_lasx(struct task_struct *t) {}
+static inline void init_lasx_upper(void) {}
+static inline void restore_lasx_upper(struct task_struct *t) {}
+#endif
+
+static inline int thread_lsx_context_live(void)
+{
+	if (__builtin_constant_p(cpu_has_lsx) && !cpu_has_lsx)
+		return 0;
+
+	return test_thread_flag(TIF_LSX_CTX_LIVE);
+}
+
+static inline int thread_lasx_context_live(void)
+{
+	if (__builtin_constant_p(cpu_has_lasx) && !cpu_has_lasx)
+		return 0;
+
+	return test_thread_flag(TIF_LASX_CTX_LIVE);
+}
+
 #endif /* _ASM_FPU_H */
diff --git a/arch/loongarch/include/uapi/asm/ptrace.h b/arch/loongarch/include/uapi/asm/ptrace.h
index 82d811b5c6e9..06e3be52cb04 100644
--- a/arch/loongarch/include/uapi/asm/ptrace.h
+++ b/arch/loongarch/include/uapi/asm/ptrace.h
@@ -41,9 +41,19 @@ struct user_pt_regs {
 } __attribute__((aligned(8)));
 
 struct user_fp_state {
-	uint64_t    fpr[32];
-	uint64_t    fcc;
-	uint32_t    fcsr;
+	uint64_t fpr[32];
+	uint64_t fcc;
+	uint32_t fcsr;
+};
+
+struct user_lsx_state {
+	/* 32 registers, 128 bits width per register. */
+	uint64_t vregs[32*2];
+};
+
+struct user_lasx_state {
+	/* 32 registers, 256 bits width per register. */
+	uint64_t vregs[32*4];
 };
 
 struct user_watch_state {
diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
index 52e49b8bf4be..4cd7d16f7037 100644
--- a/arch/loongarch/include/uapi/asm/sigcontext.h
+++ b/arch/loongarch/include/uapi/asm/sigcontext.h
@@ -41,4 +41,22 @@ struct fpu_context {
 	__u32	fcsr;
 };
 
+/* LSX context */
+#define LSX_CTX_MAGIC		0x53580001
+#define LSX_CTX_ALIGN		16
+struct lsx_context {
+	__u64	regs[2*32];
+	__u64	fcc;
+	__u32	fcsr;
+};
+
+/* LASX context */
+#define LASX_CTX_MAGIC		0x41535801
+#define LASX_CTX_ALIGN		32
+struct lasx_context {
+	__u64	regs[4*32];
+	__u64	fcc;
+	__u32	fcsr;
+};
+
 #endif /* _UAPI_ASM_SIGCONTEXT_H */
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 5adf0f736c6d..f42acc6c8df6 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -116,6 +116,18 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |= LOONGARCH_CPU_FPU;
 		elf_hwcap |= HWCAP_LOONGARCH_FPU;
 	}
+#ifdef CONFIG_CPU_HAS_LSX
+	if (config & CPUCFG2_LSX) {
+		c->options |= LOONGARCH_CPU_LSX;
+		elf_hwcap |= HWCAP_LOONGARCH_LSX;
+	}
+#endif
+#ifdef CONFIG_CPU_HAS_LASX
+	if (config & CPUCFG2_LASX) {
+		c->options |= LOONGARCH_CPU_LASX;
+		elf_hwcap |= HWCAP_LOONGARCH_LASX;
+	}
+#endif
 	if (config & CPUCFG2_COMPLEX) {
 		c->options |= LOONGARCH_CPU_COMPLEX;
 		elf_hwcap |= HWCAP_LOONGARCH_COMPLEX;
diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index ccde94140c89..f3df5f0a4509 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -145,6 +145,154 @@
 	movgr2fcsr	fcsr0, \tmp0
 	.endm
 
+	.macro sc_save_lsx base
+#ifdef CONFIG_CPU_HAS_LSX
+	EX	vst	$vr0,  \base, (0 * LSX_REG_WIDTH)
+	EX	vst	$vr1,  \base, (1 * LSX_REG_WIDTH)
+	EX	vst	$vr2,  \base, (2 * LSX_REG_WIDTH)
+	EX	vst	$vr3,  \base, (3 * LSX_REG_WIDTH)
+	EX	vst	$vr4,  \base, (4 * LSX_REG_WIDTH)
+	EX	vst	$vr5,  \base, (5 * LSX_REG_WIDTH)
+	EX	vst	$vr6,  \base, (6 * LSX_REG_WIDTH)
+	EX	vst	$vr7,  \base, (7 * LSX_REG_WIDTH)
+	EX	vst	$vr8,  \base, (8 * LSX_REG_WIDTH)
+	EX	vst	$vr9,  \base, (9 * LSX_REG_WIDTH)
+	EX	vst	$vr10, \base, (10 * LSX_REG_WIDTH)
+	EX	vst	$vr11, \base, (11 * LSX_REG_WIDTH)
+	EX	vst	$vr12, \base, (12 * LSX_REG_WIDTH)
+	EX	vst	$vr13, \base, (13 * LSX_REG_WIDTH)
+	EX	vst	$vr14, \base, (14 * LSX_REG_WIDTH)
+	EX	vst	$vr15, \base, (15 * LSX_REG_WIDTH)
+	EX	vst	$vr16, \base, (16 * LSX_REG_WIDTH)
+	EX	vst	$vr17, \base, (17 * LSX_REG_WIDTH)
+	EX	vst	$vr18, \base, (18 * LSX_REG_WIDTH)
+	EX	vst	$vr19, \base, (19 * LSX_REG_WIDTH)
+	EX	vst	$vr20, \base, (20 * LSX_REG_WIDTH)
+	EX	vst	$vr21, \base, (21 * LSX_REG_WIDTH)
+	EX	vst	$vr22, \base, (22 * LSX_REG_WIDTH)
+	EX	vst	$vr23, \base, (23 * LSX_REG_WIDTH)
+	EX	vst	$vr24, \base, (24 * LSX_REG_WIDTH)
+	EX	vst	$vr25, \base, (25 * LSX_REG_WIDTH)
+	EX	vst	$vr26, \base, (26 * LSX_REG_WIDTH)
+	EX	vst	$vr27, \base, (27 * LSX_REG_WIDTH)
+	EX	vst	$vr28, \base, (28 * LSX_REG_WIDTH)
+	EX	vst	$vr29, \base, (29 * LSX_REG_WIDTH)
+	EX	vst	$vr30, \base, (30 * LSX_REG_WIDTH)
+	EX	vst	$vr31, \base, (31 * LSX_REG_WIDTH)
+#endif
+	.endm
+
+	.macro sc_restore_lsx base
+#ifdef CONFIG_CPU_HAS_LSX
+	EX	vld	$vr0,  \base, (0 * LSX_REG_WIDTH)
+	EX	vld	$vr1,  \base, (1 * LSX_REG_WIDTH)
+	EX	vld	$vr2,  \base, (2 * LSX_REG_WIDTH)
+	EX	vld	$vr3,  \base, (3 * LSX_REG_WIDTH)
+	EX	vld	$vr4,  \base, (4 * LSX_REG_WIDTH)
+	EX	vld	$vr5,  \base, (5 * LSX_REG_WIDTH)
+	EX	vld	$vr6,  \base, (6 * LSX_REG_WIDTH)
+	EX	vld	$vr7,  \base, (7 * LSX_REG_WIDTH)
+	EX	vld	$vr8,  \base, (8 * LSX_REG_WIDTH)
+	EX	vld	$vr9,  \base, (9 * LSX_REG_WIDTH)
+	EX	vld	$vr10, \base, (10 * LSX_REG_WIDTH)
+	EX	vld	$vr11, \base, (11 * LSX_REG_WIDTH)
+	EX	vld	$vr12, \base, (12 * LSX_REG_WIDTH)
+	EX	vld	$vr13, \base, (13 * LSX_REG_WIDTH)
+	EX	vld	$vr14, \base, (14 * LSX_REG_WIDTH)
+	EX	vld	$vr15, \base, (15 * LSX_REG_WIDTH)
+	EX	vld	$vr16, \base, (16 * LSX_REG_WIDTH)
+	EX	vld	$vr17, \base, (17 * LSX_REG_WIDTH)
+	EX	vld	$vr18, \base, (18 * LSX_REG_WIDTH)
+	EX	vld	$vr19, \base, (19 * LSX_REG_WIDTH)
+	EX	vld	$vr20, \base, (20 * LSX_REG_WIDTH)
+	EX	vld	$vr21, \base, (21 * LSX_REG_WIDTH)
+	EX	vld	$vr22, \base, (22 * LSX_REG_WIDTH)
+	EX	vld	$vr23, \base, (23 * LSX_REG_WIDTH)
+	EX	vld	$vr24, \base, (24 * LSX_REG_WIDTH)
+	EX	vld	$vr25, \base, (25 * LSX_REG_WIDTH)
+	EX	vld	$vr26, \base, (26 * LSX_REG_WIDTH)
+	EX	vld	$vr27, \base, (27 * LSX_REG_WIDTH)
+	EX	vld	$vr28, \base, (28 * LSX_REG_WIDTH)
+	EX	vld	$vr29, \base, (29 * LSX_REG_WIDTH)
+	EX	vld	$vr30, \base, (30 * LSX_REG_WIDTH)
+	EX	vld	$vr31, \base, (31 * LSX_REG_WIDTH)
+#endif
+	.endm
+
+	.macro sc_save_lasx base
+#ifdef CONFIG_CPU_HAS_LASX
+	EX	xvst	$xr0,  \base, (0 * LASX_REG_WIDTH)
+	EX	xvst	$xr1,  \base, (1 * LASX_REG_WIDTH)
+	EX	xvst	$xr2,  \base, (2 * LASX_REG_WIDTH)
+	EX	xvst	$xr3,  \base, (3 * LASX_REG_WIDTH)
+	EX	xvst	$xr4,  \base, (4 * LASX_REG_WIDTH)
+	EX	xvst	$xr5,  \base, (5 * LASX_REG_WIDTH)
+	EX	xvst	$xr6,  \base, (6 * LASX_REG_WIDTH)
+	EX	xvst	$xr7,  \base, (7 * LASX_REG_WIDTH)
+	EX	xvst	$xr8,  \base, (8 * LASX_REG_WIDTH)
+	EX	xvst	$xr9,  \base, (9 * LASX_REG_WIDTH)
+	EX	xvst	$xr10, \base, (10 * LASX_REG_WIDTH)
+	EX	xvst	$xr11, \base, (11 * LASX_REG_WIDTH)
+	EX	xvst	$xr12, \base, (12 * LASX_REG_WIDTH)
+	EX	xvst	$xr13, \base, (13 * LASX_REG_WIDTH)
+	EX	xvst	$xr14, \base, (14 * LASX_REG_WIDTH)
+	EX	xvst	$xr15, \base, (15 * LASX_REG_WIDTH)
+	EX	xvst	$xr16, \base, (16 * LASX_REG_WIDTH)
+	EX	xvst	$xr17, \base, (17 * LASX_REG_WIDTH)
+	EX	xvst	$xr18, \base, (18 * LASX_REG_WIDTH)
+	EX	xvst	$xr19, \base, (19 * LASX_REG_WIDTH)
+	EX	xvst	$xr20, \base, (20 * LASX_REG_WIDTH)
+	EX	xvst	$xr21, \base, (21 * LASX_REG_WIDTH)
+	EX	xvst	$xr22, \base, (22 * LASX_REG_WIDTH)
+	EX	xvst	$xr23, \base, (23 * LASX_REG_WIDTH)
+	EX	xvst	$xr24, \base, (24 * LASX_REG_WIDTH)
+	EX	xvst	$xr25, \base, (25 * LASX_REG_WIDTH)
+	EX	xvst	$xr26, \base, (26 * LASX_REG_WIDTH)
+	EX	xvst	$xr27, \base, (27 * LASX_REG_WIDTH)
+	EX	xvst	$xr28, \base, (28 * LASX_REG_WIDTH)
+	EX	xvst	$xr29, \base, (29 * LASX_REG_WIDTH)
+	EX	xvst	$xr30, \base, (30 * LASX_REG_WIDTH)
+	EX	xvst	$xr31, \base, (31 * LASX_REG_WIDTH)
+#endif
+	.endm
+
+	.macro sc_restore_lasx base
+#ifdef CONFIG_CPU_HAS_LASX
+	EX	xvld	$xr0,  \base, (0 * LASX_REG_WIDTH)
+	EX	xvld	$xr1,  \base, (1 * LASX_REG_WIDTH)
+	EX	xvld	$xr2,  \base, (2 * LASX_REG_WIDTH)
+	EX	xvld	$xr3,  \base, (3 * LASX_REG_WIDTH)
+	EX	xvld	$xr4,  \base, (4 * LASX_REG_WIDTH)
+	EX	xvld	$xr5,  \base, (5 * LASX_REG_WIDTH)
+	EX	xvld	$xr6,  \base, (6 * LASX_REG_WIDTH)
+	EX	xvld	$xr7,  \base, (7 * LASX_REG_WIDTH)
+	EX	xvld	$xr8,  \base, (8 * LASX_REG_WIDTH)
+	EX	xvld	$xr9,  \base, (9 * LASX_REG_WIDTH)
+	EX	xvld	$xr10, \base, (10 * LASX_REG_WIDTH)
+	EX	xvld	$xr11, \base, (11 * LASX_REG_WIDTH)
+	EX	xvld	$xr12, \base, (12 * LASX_REG_WIDTH)
+	EX	xvld	$xr13, \base, (13 * LASX_REG_WIDTH)
+	EX	xvld	$xr14, \base, (14 * LASX_REG_WIDTH)
+	EX	xvld	$xr15, \base, (15 * LASX_REG_WIDTH)
+	EX	xvld	$xr16, \base, (16 * LASX_REG_WIDTH)
+	EX	xvld	$xr17, \base, (17 * LASX_REG_WIDTH)
+	EX	xvld	$xr18, \base, (18 * LASX_REG_WIDTH)
+	EX	xvld	$xr19, \base, (19 * LASX_REG_WIDTH)
+	EX	xvld	$xr20, \base, (20 * LASX_REG_WIDTH)
+	EX	xvld	$xr21, \base, (21 * LASX_REG_WIDTH)
+	EX	xvld	$xr22, \base, (22 * LASX_REG_WIDTH)
+	EX	xvld	$xr23, \base, (23 * LASX_REG_WIDTH)
+	EX	xvld	$xr24, \base, (24 * LASX_REG_WIDTH)
+	EX	xvld	$xr25, \base, (25 * LASX_REG_WIDTH)
+	EX	xvld	$xr26, \base, (26 * LASX_REG_WIDTH)
+	EX	xvld	$xr27, \base, (27 * LASX_REG_WIDTH)
+	EX	xvld	$xr28, \base, (28 * LASX_REG_WIDTH)
+	EX	xvld	$xr29, \base, (29 * LASX_REG_WIDTH)
+	EX	xvld	$xr30, \base, (30 * LASX_REG_WIDTH)
+	EX	xvld	$xr31, \base, (31 * LASX_REG_WIDTH)
+#endif
+	.endm
+
 /*
  * Save a thread's fp context.
  */
@@ -166,6 +314,76 @@ SYM_FUNC_START(_restore_fp)
 	jr			ra
 SYM_FUNC_END(_restore_fp)
 
+#ifdef CONFIG_CPU_HAS_LSX
+
+/*
+ * Save a thread's LSX vector context.
+ */
+SYM_FUNC_START(_save_lsx)
+	lsx_save_all	a0 t1 t2
+	jr	ra
+SYM_FUNC_END(_save_lsx)
+EXPORT_SYMBOL(_save_lsx)
+
+/*
+ * Restore a thread's LSX vector context.
+ */
+SYM_FUNC_START(_restore_lsx)
+	lsx_restore_all	a0 t1 t2
+	jr	ra
+SYM_FUNC_END(_restore_lsx)
+
+SYM_FUNC_START(_save_lsx_upper)
+	lsx_save_all_upper a0 t0 t1
+	jr	ra
+SYM_FUNC_END(_save_lsx_upper)
+
+SYM_FUNC_START(_restore_lsx_upper)
+	lsx_restore_all_upper a0 t0 t1
+	jr	ra
+SYM_FUNC_END(_restore_lsx_upper)
+
+SYM_FUNC_START(_init_lsx_upper)
+	lsx_init_all_upper t1
+	jr	ra
+SYM_FUNC_END(_init_lsx_upper)
+#endif
+
+#ifdef CONFIG_CPU_HAS_LASX
+
+/*
+ * Save a thread's LASX vector context.
+ */
+SYM_FUNC_START(_save_lasx)
+	lasx_save_all	a0 t1 t2
+	jr	ra
+SYM_FUNC_END(_save_lasx)
+EXPORT_SYMBOL(_save_lasx)
+
+/*
+ * Restore a thread's LASX vector context.
+ */
+SYM_FUNC_START(_restore_lasx)
+	lasx_restore_all a0 t1 t2
+	jr	ra
+SYM_FUNC_END(_restore_lasx)
+
+SYM_FUNC_START(_save_lasx_upper)
+	lasx_save_all_upper a0 t0 t1
+	jr	ra
+SYM_FUNC_END(_save_lasx_upper)
+
+SYM_FUNC_START(_restore_lasx_upper)
+	lasx_restore_all_upper a0 t0 t1
+	jr	ra
+SYM_FUNC_END(_restore_lasx_upper)
+
+SYM_FUNC_START(_init_lasx_upper)
+	lasx_init_all_upper t1
+	jr	ra
+SYM_FUNC_END(_init_lasx_upper)
+#endif
+
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using has
  * the property that no matter whether considered as single or as double
@@ -244,6 +462,58 @@ SYM_FUNC_START(_restore_fp_context)
 	jr		ra
 SYM_FUNC_END(_restore_fp_context)
 
+/*
+ * a0: fpregs
+ * a1: fcc
+ * a2: fcsr
+ */
+SYM_FUNC_START(_save_lsx_context)
+	sc_save_fcc a1, t0, t1
+	sc_save_fcsr a2, t0
+	sc_save_lsx a0
+	li.w	a0, 0					# success
+	jr	ra
+SYM_FUNC_END(_save_lsx_context)
+
+/*
+ * a0: fpregs
+ * a1: fcc
+ * a2: fcsr
+ */
+SYM_FUNC_START(_restore_lsx_context)
+	sc_restore_lsx a0
+	sc_restore_fcc a1, t1, t2
+	sc_restore_fcsr a2, t1
+	li.w	a0, 0					# success
+	jr	ra
+SYM_FUNC_END(_restore_lsx_context)
+
+/*
+ * a0: fpregs
+ * a1: fcc
+ * a2: fcsr
+ */
+SYM_FUNC_START(_save_lasx_context)
+	sc_save_fcc a1, t0, t1
+	sc_save_fcsr a2, t0
+	sc_save_lasx a0
+	li.w	a0, 0					# success
+	jr	ra
+SYM_FUNC_END(_save_lasx_context)
+
+/*
+ * a0: fpregs
+ * a1: fcc
+ * a2: fcsr
+ */
+SYM_FUNC_START(_restore_lasx_context)
+	sc_restore_lasx a0
+	sc_restore_fcc a1, t1, t2
+	sc_restore_fcsr a2, t1
+	li.w	a0, 0					# success
+	jr	ra
+SYM_FUNC_END(_restore_lasx_context)
+
 SYM_FUNC_START(fault)
 	li.w	a0, -EFAULT				# failure
 	jr	ra
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 9535a0662480..2e04eb07abb6 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -117,8 +117,14 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	 */
 	preempt_disable();
 
-	if (is_fpu_owner())
-		save_fp(current);
+	if (is_fpu_owner()) {
+		if (is_lasx_enabled())
+			save_lasx(current);
+		else if (is_lsx_enabled())
+			save_lsx(current);
+		else
+			save_fp(current);
+	}
 
 	preempt_enable();
 
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index 5fcffb452367..a0767c3a0f0a 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -250,6 +250,90 @@ static int cfg_set(struct task_struct *target,
 	return 0;
 }
 
+#ifdef CONFIG_CPU_HAS_LSX
+
+static void copy_pad_fprs(struct task_struct *target,
+			 const struct user_regset *regset,
+			 struct membuf *to, unsigned int live_sz)
+{
+	int i, j;
+	unsigned long long fill = ~0ull;
+	unsigned int cp_sz, pad_sz;
+
+	cp_sz = min(regset->size, live_sz);
+	pad_sz = regset->size - cp_sz;
+	WARN_ON(pad_sz % sizeof(fill));
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		membuf_write(to, &target->thread.fpu.fpr[i], cp_sz);
+		for (j = 0; j < (pad_sz / sizeof(fill)); j++) {
+			membuf_store(to, fill);
+		}
+	}
+}
+
+static int simd_get(struct task_struct *target,
+		    const struct user_regset *regset,
+		    struct membuf to)
+{
+	const unsigned int wr_size = NUM_FPU_REGS * regset->size;
+
+	if (!tsk_used_math(target)) {
+		/* The task hasn't used FP or LSX, fill with 0xff */
+		copy_pad_fprs(target, regset, &to, 0);
+	} else if (!test_tsk_thread_flag(target, TIF_LSX_CTX_LIVE)) {
+		/* Copy scalar FP context, fill the rest with 0xff */
+		copy_pad_fprs(target, regset, &to, 8);
+#ifdef CONFIG_CPU_HAS_LASX
+	} else if (!test_tsk_thread_flag(target, TIF_LASX_CTX_LIVE)) {
+		/* Copy LSX 128 Bit context, fill the rest with 0xff */
+		copy_pad_fprs(target, regset, &to, 16);
+#endif
+	} else if (sizeof(target->thread.fpu.fpr[0]) == regset->size) {
+		/* Trivially copy the vector registers */
+		membuf_write(&to, &target->thread.fpu.fpr, wr_size);
+	} else {
+		/* Copy as much context as possible, fill the rest with 0xff */
+		copy_pad_fprs(target, regset, &to, sizeof(target->thread.fpu.fpr[0]));
+	}
+
+	return 0;
+}
+
+static int simd_set(struct task_struct *target,
+		    const struct user_regset *regset,
+		    unsigned int pos, unsigned int count,
+		    const void *kbuf, const void __user *ubuf)
+{
+	const unsigned int wr_size = NUM_FPU_REGS * regset->size;
+	unsigned int cp_sz;
+	int i, err, start;
+
+	init_fp_ctx(target);
+
+	if (sizeof(target->thread.fpu.fpr[0]) == regset->size) {
+		/* Trivially copy the vector registers */
+		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &target->thread.fpu.fpr,
+					 0, wr_size);
+	} else {
+		/* Copy as much context as possible */
+		cp_sz = min_t(unsigned int, regset->size,
+			      sizeof(target->thread.fpu.fpr[0]));
+
+		i = start = err = 0;
+		for (; i < NUM_FPU_REGS; i++, start += regset->size) {
+			err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+						  &target->thread.fpu.fpr[i],
+						  start, start + cp_sz);
+		}
+	}
+
+	return err;
+}
+
+#endif /* CONFIG_CPU_HAS_LSX */
+
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 
 /*
@@ -708,6 +792,12 @@ enum loongarch_regset {
 	REGSET_GPR,
 	REGSET_FPR,
 	REGSET_CPUCFG,
+#ifdef CONFIG_CPU_HAS_LSX
+	REGSET_LSX,
+#endif
+#ifdef CONFIG_CPU_HAS_LASX
+	REGSET_LASX,
+#endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	REGSET_HW_BREAK,
 	REGSET_HW_WATCH,
@@ -739,6 +829,26 @@ static const struct user_regset loongarch64_regsets[] = {
 		.regset_get	= cfg_get,
 		.set		= cfg_set,
 	},
+#ifdef CONFIG_CPU_HAS_LSX
+	[REGSET_LSX] = {
+		.core_note_type	= NT_LOONGARCH_LSX,
+		.n		= NUM_FPU_REGS,
+		.size		= 16,
+		.align		= 16,
+		.regset_get	= simd_get,
+		.set		= simd_set,
+	},
+#endif
+#ifdef CONFIG_CPU_HAS_LASX
+	[REGSET_LASX] = {
+		.core_note_type	= NT_LOONGARCH_LASX,
+		.n		= NUM_FPU_REGS,
+		.size		= 32,
+		.align		= 32,
+		.regset_get	= simd_get,
+		.set		= simd_set,
+	},
+#endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	[REGSET_HW_BREAK] = {
 		.core_note_type = NT_LOONGARCH_HW_BREAK,
diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
index 8f5b7986374b..ceb899366c0a 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -50,6 +50,14 @@ extern asmlinkage int
 _save_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
 extern asmlinkage int
 _restore_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
+extern asmlinkage int
+_save_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
+extern asmlinkage int
+_restore_lsx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
+extern asmlinkage int
+_save_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
+extern asmlinkage int
+_restore_lasx_context(void __user *fpregs, void __user *fcc, void __user *fcsr);
 
 struct rt_sigframe {
 	struct siginfo rs_info;
@@ -65,6 +73,8 @@ struct extctx_layout {
 	unsigned long size;
 	unsigned int flags;
 	struct _ctx_layout fpu;
+	struct _ctx_layout lsx;
+	struct _ctx_layout lasx;
 	struct _ctx_layout end;
 };
 
@@ -115,6 +125,96 @@ static int copy_fpu_from_sigcontext(struct fpu_context __user *ctx)
 	return err;
 }
 
+static int copy_lsx_to_sigcontext(struct lsx_context __user *ctx)
+{
+	int i;
+	int err = 0;
+	uint64_t __user *regs	= (uint64_t *)&ctx->regs;
+	uint64_t __user *fcc	= &ctx->fcc;
+	uint32_t __user *fcsr	= &ctx->fcsr;
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		err |= __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
+				  &regs[2*i]);
+		err |= __put_user(get_fpr64(&current->thread.fpu.fpr[i], 1),
+				  &regs[2*i+1]);
+	}
+	err |= __put_user(current->thread.fpu.fcc, fcc);
+	err |= __put_user(current->thread.fpu.fcsr, fcsr);
+
+	return err;
+}
+
+static int copy_lsx_from_sigcontext(struct lsx_context __user *ctx)
+{
+	int i;
+	int err = 0;
+	u64 fpr_val;
+	uint64_t __user *regs	= (uint64_t *)&ctx->regs;
+	uint64_t __user *fcc	= &ctx->fcc;
+	uint32_t __user *fcsr	= &ctx->fcsr;
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		err |= __get_user(fpr_val, &regs[2*i]);
+		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
+		err |= __get_user(fpr_val, &regs[2*i+1]);
+		set_fpr64(&current->thread.fpu.fpr[i], 1, fpr_val);
+	}
+	err |= __get_user(current->thread.fpu.fcc, fcc);
+	err |= __get_user(current->thread.fpu.fcsr, fcsr);
+
+	return err;
+}
+
+static int copy_lasx_to_sigcontext(struct lasx_context __user *ctx)
+{
+	int i;
+	int err = 0;
+	uint64_t __user *regs	= (uint64_t *)&ctx->regs;
+	uint64_t __user *fcc	= &ctx->fcc;
+	uint32_t __user *fcsr	= &ctx->fcsr;
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		err |= __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
+				  &regs[4*i]);
+		err |= __put_user(get_fpr64(&current->thread.fpu.fpr[i], 1),
+				  &regs[4*i+1]);
+		err |= __put_user(get_fpr64(&current->thread.fpu.fpr[i], 2),
+				  &regs[4*i+2]);
+		err |= __put_user(get_fpr64(&current->thread.fpu.fpr[i], 3),
+				  &regs[4*i+3]);
+	}
+	err |= __put_user(current->thread.fpu.fcc, fcc);
+	err |= __put_user(current->thread.fpu.fcsr, fcsr);
+
+	return err;
+}
+
+static int copy_lasx_from_sigcontext(struct lasx_context __user *ctx)
+{
+	int i;
+	int err = 0;
+	u64 fpr_val;
+	uint64_t __user *regs	= (uint64_t *)&ctx->regs;
+	uint64_t __user *fcc	= &ctx->fcc;
+	uint32_t __user *fcsr	= &ctx->fcsr;
+
+	for (i = 0; i < NUM_FPU_REGS; i++) {
+		err |= __get_user(fpr_val, &regs[4*i]);
+		set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
+		err |= __get_user(fpr_val, &regs[4*i+1]);
+		set_fpr64(&current->thread.fpu.fpr[i], 1, fpr_val);
+		err |= __get_user(fpr_val, &regs[4*i+2]);
+		set_fpr64(&current->thread.fpu.fpr[i], 2, fpr_val);
+		err |= __get_user(fpr_val, &regs[4*i+3]);
+		set_fpr64(&current->thread.fpu.fpr[i], 3, fpr_val);
+	}
+	err |= __get_user(current->thread.fpu.fcc, fcc);
+	err |= __get_user(current->thread.fpu.fcsr, fcsr);
+
+	return err;
+}
+
 /*
  * Wrappers for the assembly _{save,restore}_fp_context functions.
  */
@@ -136,6 +236,42 @@ static int restore_hw_fpu_context(struct fpu_context __user *ctx)
 	return _restore_fp_context(regs, fcc, fcsr);
 }
 
+static int save_hw_lsx_context(struct lsx_context __user *ctx)
+{
+	uint64_t __user *regs	= (uint64_t *)&ctx->regs;
+	uint64_t __user *fcc	= &ctx->fcc;
+	uint32_t __user *fcsr	= &ctx->fcsr;
+
+	return _save_lsx_context(regs, fcc, fcsr);
+}
+
+static int restore_hw_lsx_context(struct lsx_context __user *ctx)
+{
+	uint64_t __user *regs	= (uint64_t *)&ctx->regs;
+	uint64_t __user *fcc	= &ctx->fcc;
+	uint32_t __user *fcsr	= &ctx->fcsr;
+
+	return _restore_lsx_context(regs, fcc, fcsr);
+}
+
+static int save_hw_lasx_context(struct lasx_context __user *ctx)
+{
+	uint64_t __user *regs	= (uint64_t *)&ctx->regs;
+	uint64_t __user *fcc	= &ctx->fcc;
+	uint32_t __user *fcsr	= &ctx->fcsr;
+
+	return _save_lasx_context(regs, fcc, fcsr);
+}
+
+static int restore_hw_lasx_context(struct lasx_context __user *ctx)
+{
+	uint64_t __user *regs	= (uint64_t *)&ctx->regs;
+	uint64_t __user *fcc	= &ctx->fcc;
+	uint32_t __user *fcsr	= &ctx->fcsr;
+
+	return _restore_lasx_context(regs, fcc, fcsr);
+}
+
 static int fcsr_pending(unsigned int __user *fcsr)
 {
 	int err, sig = 0;
@@ -227,6 +363,162 @@ static int protected_restore_fpu_context(struct extctx_layout *extctx)
 	return err ?: sig;
 }
 
+static int protected_save_lsx_context(struct extctx_layout *extctx)
+{
+	int err = 0;
+	struct sctx_info __user *info = extctx->lsx.addr;
+	struct lsx_context __user *lsx_ctx = (struct lsx_context *)get_ctx_through_ctxinfo(info);
+	uint64_t __user *regs	= (uint64_t *)&lsx_ctx->regs;
+	uint64_t __user *fcc	= &lsx_ctx->fcc;
+	uint32_t __user *fcsr	= &lsx_ctx->fcsr;
+
+	while (1) {
+		lock_fpu_owner();
+		if (is_lsx_enabled())
+			err = save_hw_lsx_context(lsx_ctx);
+		else {
+			if (is_fpu_owner())
+				save_fp(current);
+			err = copy_lsx_to_sigcontext(lsx_ctx);
+		}
+		unlock_fpu_owner();
+
+		err |= __put_user(LSX_CTX_MAGIC, &info->magic);
+		err |= __put_user(extctx->lsx.size, &info->size);
+
+		if (likely(!err))
+			break;
+		/* Touch the LSX context and try again */
+		err = __put_user(0, &regs[0]) |
+			__put_user(0, &regs[32*2-1]) |
+			__put_user(0, fcc) |
+			__put_user(0, fcsr);
+		if (err)
+			return err;	/* really bad sigcontext */
+	}
+
+	return err;
+}
+
+static int protected_restore_lsx_context(struct extctx_layout *extctx)
+{
+	int err = 0, sig = 0, tmp __maybe_unused;
+	struct sctx_info __user *info = extctx->lsx.addr;
+	struct lsx_context __user *lsx_ctx = (struct lsx_context *)get_ctx_through_ctxinfo(info);
+	uint64_t __user *regs	= (uint64_t *)&lsx_ctx->regs;
+	uint64_t __user *fcc	= &lsx_ctx->fcc;
+	uint32_t __user *fcsr	= &lsx_ctx->fcsr;
+
+	err = sig = fcsr_pending(fcsr);
+	if (err < 0)
+		return err;
+
+	while (1) {
+		lock_fpu_owner();
+		if (is_lsx_enabled())
+			err = restore_hw_lsx_context(lsx_ctx);
+		else {
+			err = copy_lsx_from_sigcontext(lsx_ctx);
+			if (is_fpu_owner())
+				restore_fp(current);
+		}
+		unlock_fpu_owner();
+
+		if (likely(!err))
+			break;
+		/* Touch the LSX context and try again */
+		err = __get_user(tmp, &regs[0]) |
+			__get_user(tmp, &regs[32*2-1]) |
+			__get_user(tmp, fcc) |
+			__get_user(tmp, fcsr);
+		if (err)
+			break;	/* really bad sigcontext */
+	}
+
+	return err ?: sig;
+}
+
+static int protected_save_lasx_context(struct extctx_layout *extctx)
+{
+	int err = 0;
+	struct sctx_info __user *info = extctx->lasx.addr;
+	struct lasx_context __user *lasx_ctx =
+		(struct lasx_context *)get_ctx_through_ctxinfo(info);
+	uint64_t __user *regs	= (uint64_t *)&lasx_ctx->regs;
+	uint64_t __user *fcc	= &lasx_ctx->fcc;
+	uint32_t __user *fcsr	= &lasx_ctx->fcsr;
+
+	while (1) {
+		lock_fpu_owner();
+		if (is_lasx_enabled())
+			err = save_hw_lasx_context(lasx_ctx);
+		else {
+			if (is_lsx_enabled())
+				save_lsx(current);
+			else if (is_fpu_owner())
+				save_fp(current);
+			err = copy_lasx_to_sigcontext(lasx_ctx);
+		}
+		unlock_fpu_owner();
+
+		err |= __put_user(LASX_CTX_MAGIC, &info->magic);
+		err |= __put_user(extctx->lasx.size, &info->size);
+
+		if (likely(!err))
+			break;
+		/* Touch the LASX context and try again */
+		err = __put_user(0, &regs[0]) |
+			__put_user(0, &regs[32*4-1]) |
+			__put_user(0, fcc) |
+			__put_user(0, fcsr);
+		if (err)
+			return err;	/* really bad sigcontext */
+	}
+
+	return err;
+}
+
+static int protected_restore_lasx_context(struct extctx_layout *extctx)
+{
+	int err = 0, sig = 0, tmp __maybe_unused;
+	struct sctx_info __user *info = extctx->lasx.addr;
+	struct lasx_context __user *lasx_ctx =
+		(struct lasx_context *)get_ctx_through_ctxinfo(info);
+	uint64_t __user *regs	= (uint64_t *)&lasx_ctx->regs;
+	uint64_t __user *fcc	= &lasx_ctx->fcc;
+	uint32_t __user *fcsr	= &lasx_ctx->fcsr;
+
+	err = sig = fcsr_pending(fcsr);
+	if (err < 0)
+		return err;
+
+	while (1) {
+		lock_fpu_owner();
+		if (is_lasx_enabled())
+			err = restore_hw_lasx_context(lasx_ctx);
+		else {
+			err = copy_lasx_from_sigcontext(lasx_ctx);
+			if (is_lsx_enabled())
+				restore_lsx(current);
+			else if (is_fpu_owner())
+				restore_fp(current);
+		}
+		unlock_fpu_owner();
+
+		if (likely(!err))
+			break;
+		/* Touch the LASX context and try again */
+		err = __get_user(tmp, &regs[0]) |
+			__get_user(tmp, &regs[32*4-1]) |
+			__get_user(tmp, fcc) |
+			__get_user(tmp, fcsr);
+		if (err)
+			break;	/* really bad sigcontext */
+	}
+
+	return err ?: sig;
+}
+
 static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
 			    struct extctx_layout *extctx)
 {
@@ -240,7 +532,11 @@ static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
 	for (i = 1; i < 32; i++)
 		err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
 
-	if (extctx->fpu.addr)
+	if (extctx->lasx.addr)
+		err |= protected_save_lasx_context(extctx);
+	else if (extctx->lsx.addr)
+		err |= protected_save_lsx_context(extctx);
+	else if (extctx->fpu.addr)
 		err |= protected_save_fpu_context(extctx);
 
 	/* Set the "end" magic */
@@ -274,6 +570,20 @@ static int parse_extcontext(struct sigcontext __user *sc, struct extctx_layout *
 			extctx->fpu.addr = info;
 			break;
 
+		case LSX_CTX_MAGIC:
+			if (size < (sizeof(struct sctx_info) +
+				    sizeof(struct lsx_context)))
+				goto invalid;
+			extctx->lsx.addr = info;
+			break;
+
+		case LASX_CTX_MAGIC:
+			if (size < (sizeof(struct sctx_info) +
+				    sizeof(struct lasx_context)))
+				goto invalid;
+			extctx->lasx.addr = info;
+			break;
+
 		default:
 			goto invalid;
 		}
@@ -319,7 +629,11 @@ static int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc
 	for (i = 1; i < 32; i++)
 		err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
 
-	if (extctx.fpu.addr)
+	if (extctx.lasx.addr)
+		err |= protected_restore_lasx_context(&extctx);
+	else if (extctx.lsx.addr)
+		err |= protected_restore_lsx_context(&extctx);
+	else if (extctx.fpu.addr)
 		err |= protected_restore_fpu_context(&extctx);
 
 bad:
@@ -375,7 +689,13 @@ static unsigned long setup_extcontext(struct extctx_layout *extctx, unsigned lon
 	extctx->size += extctx->end.size;
 
 	if (extctx->flags & SC_USED_FP) {
-		if (cpu_has_fpu)
+		if (cpu_has_lasx && thread_lasx_context_live())
+			new_sp = extframe_alloc(extctx, &extctx->lasx,
+			  sizeof(struct lasx_context), LASX_CTX_ALIGN, new_sp);
+		else if (cpu_has_lsx && thread_lsx_context_live())
+			new_sp = extframe_alloc(extctx, &extctx->lsx,
+			  sizeof(struct lsx_context), LSX_CTX_ALIGN, new_sp);
+		else if (cpu_has_fpu)
 			new_sp = extframe_alloc(extctx, &extctx->fpu,
 			  sizeof(struct fpu_context), FPU_CTX_ALIGN, new_sp);
 	}
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 8db26e4ca447..417cec119638 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -852,12 +852,67 @@ static void init_restore_fp(void)
 	BUG_ON(!is_fp_enabled());
 }
 
+static void init_restore_lsx(void)
+{
+	enable_lsx();
+
+	if (!thread_lsx_context_live()) {
+		/* First time LSX context user */
+		init_restore_fp();
+		init_lsx_upper();
+		set_thread_flag(TIF_LSX_CTX_LIVE);
+	} else {
+		if (!is_simd_owner()) {
+			if (is_fpu_owner()) {
+				restore_lsx_upper(current);
+			} else {
+				__own_fpu();
+				restore_lsx(current);
+			}
+		}
+	}
+
+	set_thread_flag(TIF_USEDSIMD);
+
+	BUG_ON(!is_fp_enabled());
+	BUG_ON(!is_lsx_enabled());
+}
+
+static void init_restore_lasx(void)
+{
+	enable_lasx();
+
+	if (!thread_lasx_context_live()) {
+		/* First time LASX context user */
+		init_restore_lsx();
+		init_lasx_upper();
+		set_thread_flag(TIF_LASX_CTX_LIVE);
+	} else {
+		if (is_fpu_owner() || is_simd_owner()) {
+			init_restore_lsx();
+			restore_lasx_upper(current);
+		} else {
+			__own_fpu();
+			enable_lsx();
+			restore_lasx(current);
+		}
+	}
+
+	set_thread_flag(TIF_USEDSIMD);
+
+	BUG_ON(!is_fp_enabled());
+	BUG_ON(!is_lsx_enabled());
+	BUG_ON(!is_lasx_enabled());
+}
+
 asmlinkage void noinstr do_fpu(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
 	local_irq_enable();
 	die_if_kernel("do_fpu invoked from kernel context!", regs);
+	BUG_ON(is_lsx_enabled());
+	BUG_ON(is_lasx_enabled());
 
 	preempt_disable();
 	init_restore_fp();
@@ -872,9 +927,20 @@ asmlinkage void noinstr do_lsx(struct pt_regs *regs)
 	irqentry_state_t state = irqentry_enter(regs);
 
 	local_irq_enable();
-	force_sig(SIGILL);
-	local_irq_disable();
+	if (!cpu_has_lsx) {
+		force_sig(SIGILL);
+		goto out;
+	}
+
+	die_if_kernel("do_lsx invoked from kernel context!", regs);
+	BUG_ON(is_lasx_enabled());
 
+	preempt_disable();
+	init_restore_lsx();
+	preempt_enable();
+
+out:
+	local_irq_disable();
 	irqentry_exit(regs, state);
 }
 
@@ -883,9 +949,19 @@ asmlinkage void noinstr do_lasx(struct pt_regs *regs)
 	irqentry_state_t state = irqentry_enter(regs);
 
 	local_irq_enable();
-	force_sig(SIGILL);
-	local_irq_disable();
+	if (!cpu_has_lasx) {
+		force_sig(SIGILL);
+		goto out;
+	}
+
+	die_if_kernel("do_lasx invoked from kernel context!", regs);
 
+	preempt_disable();
+	init_restore_lasx();
+	preempt_enable();
+
+out:
+	local_irq_disable();
 	irqentry_exit(regs, state);
 }
 
-- 
2.39.3

