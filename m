Return-Path: <linux-arch+bounces-8564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C95D9B0E8B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10761C219CD
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E2217672;
	Fri, 25 Oct 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0JkxrBo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CA217661;
	Fri, 25 Oct 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883750; cv=none; b=ZTviGr/tTEQePuFlvRUBckJvvZgJcaRAVkphJGE3fn/f++zaf7dCm7ecw+JwLpvuWaWwn1OXxHqwcJV1pZt8davni3Te0bVHU116/XLDCXM7HbvEmgYXvHV3oiGhK759NaJ4QxkV8nzNkgfuBEesJ16EHb8H9RE7Vw88Ltwu1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883750; c=relaxed/simple;
	bh=C1Eoo6ZdwZ6ma+QPnxpHev6POdiDHK4uQ/Pd5lLsWBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eauaVenX1xcJ/gg1WKYdy402eaH+lhAeNC1uh45OPV5pbd+e3PPDqYI6kf1ui4QVdaGUgECSGUhXn/tWQlVY488tkEA/FTuK4s7M0o9SeBprgwrCdErfEaV1lTe5eTvEo4VIssSjoOO1XGRsLUVLArp0CwwPp1a7wr6SPL+Y1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0JkxrBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA2EC4CEE6;
	Fri, 25 Oct 2024 19:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729883750;
	bh=C1Eoo6ZdwZ6ma+QPnxpHev6POdiDHK4uQ/Pd5lLsWBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0JkxrBorptbSvjunEMdzjVna9W+A1uELYkTSfUNqQrYSCNu52AYFloOnoRLCKHKi
	 X3N16jUW6Rl5Uo3v0mCBUJF+sXIQP8W7yCppnn9CadyOO5L6+KYpv84QIrJHZOxv0j
	 nqUVd7DRRJi2Un4U8qZ38BhDK//NXRxwORwqrvkNHpHZFmxEQf8FspDfYF/n1OxZp5
	 3xVaLnrOlYSwZFQl88EA+bxGzVATTL6d+hSBjzf2hsmxn0baLnoLbtScPZ8CXcUsVS
	 MRFEYvu9UjYXA9kt4RR0BK+J41yJVaAIYwsDjHV9TS4bCGmcCDA1xOQFRUi0ULfrvO
	 NWx5wfpLuCikg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 11/18] x86/crc32: update prototype for crc_pcl()
Date: Fri, 25 Oct 2024 12:14:47 -0700
Message-ID: <20241025191454.72616-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025191454.72616-1-ebiggers@kernel.org>
References: <20241025191454.72616-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

- Change the len parameter from unsigned int to size_t, so that the
  library function which takes a size_t can safely use this code.

- Rename to crc32c_x86_3way() which is much clearer.

- Move the crc parameter to the front, as this is the usual convention.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/crc32c-intel_glue.c       |  7 ++-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 63 ++++++++++++-----------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index 52c5d47ef5a1..603d159de400 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -39,12 +39,11 @@
  * size is >= 512 to account
  * for fpu state save/restore overhead.
  */
 #define CRC32C_PCL_BREAKEVEN	512
 
-asmlinkage unsigned int crc_pcl(const u8 *buffer, unsigned int len,
-				unsigned int crc_init);
+asmlinkage u32 crc32c_x86_3way(u32 crc, const u8 *buffer, size_t len);
 #endif /* CONFIG_X86_64 */
 
 static u32 crc32c_intel_le_hw_byte(u32 crc, unsigned char const *data, size_t length)
 {
 	while (length--) {
@@ -157,11 +156,11 @@ static int crc32c_pcl_intel_update(struct shash_desc *desc, const u8 *data,
 	 * use faster PCL version if datasize is large enough to
 	 * overcome kernel fpu state save/restore overhead
 	 */
 	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
 		kernel_fpu_begin();
-		*crcp = crc_pcl(data, len, *crcp);
+		*crcp = crc32c_x86_3way(*crcp, data, len);
 		kernel_fpu_end();
 	} else
 		*crcp = crc32c_intel_le_hw(*crcp, data, len);
 	return 0;
 }
@@ -169,11 +168,11 @@ static int crc32c_pcl_intel_update(struct shash_desc *desc, const u8 *data,
 static int __crc32c_pcl_intel_finup(u32 *crcp, const u8 *data, unsigned int len,
 				u8 *out)
 {
 	if (len >= CRC32C_PCL_BREAKEVEN && crypto_simd_usable()) {
 		kernel_fpu_begin();
-		*(__le32 *)out = ~cpu_to_le32(crc_pcl(data, len, *crcp));
+		*(__le32 *)out = ~cpu_to_le32(crc32c_x86_3way(*crcp, data, len));
 		kernel_fpu_end();
 	} else
 		*(__le32 *)out =
 			~cpu_to_le32(crc32c_intel_le_hw(*crcp, data, len));
 	return 0;
diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 752812bc4991..9b8770503bbc 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -50,19 +50,20 @@
 
 # Define threshold below which buffers are considered "small" and routed to
 # regular CRC code that does not interleave the CRC instructions.
 #define SMALL_SIZE 200
 
-# unsigned int crc_pcl(const u8 *buffer, unsigned int len, unsigned int crc_init);
+# u32 crc32c_x86_3way(u32 crc, const u8 *buffer, size_t len);
 
 .text
-SYM_FUNC_START(crc_pcl)
-#define    bufp		  %rdi
-#define    bufp_d	  %edi
-#define    len		  %esi
-#define    crc_init	  %edx
-#define    crc_init_q	  %rdx
+SYM_FUNC_START(crc32c_x86_3way)
+#define    crc0		  %edi
+#define    crc0_q	  %rdi
+#define    bufp		  %rsi
+#define    bufp_d	  %esi
+#define    len		  %rdx
+#define    len_dw	  %edx
 #define    n_misaligned	  %ecx /* overlaps chunk_bytes! */
 #define    n_misaligned_q %rcx
 #define    chunk_bytes	  %ecx /* overlaps n_misaligned! */
 #define    chunk_bytes_q  %rcx
 #define    crc1		  %r8
@@ -83,13 +84,13 @@ SYM_FUNC_START(crc_pcl)
 	# Process 1 <= n_misaligned <= 7 bytes individually in order to align
 	# the remaining data to an 8-byte boundary.
 .Ldo_align:
 	movq	(bufp), %rax
 	add	n_misaligned_q, bufp
-	sub	n_misaligned, len
+	sub	n_misaligned_q, len
 .Lalign_loop:
-	crc32b	%al, crc_init		# compute crc32 of 1-byte
+	crc32b	%al, crc0		# compute crc32 of 1-byte
 	shr	$8, %rax		# get next byte
 	dec	n_misaligned
 	jne     .Lalign_loop
 .Laligned:
 
@@ -100,11 +101,11 @@ SYM_FUNC_START(crc_pcl)
 	cmp	$128*24, len
 	jae     .Lfull_block
 
 .Lpartial_block:
 	# Compute floor(len / 24) to get num qwords to process from each lane.
-	imul	$2731, len, %eax	# 2731 = ceil(2^16 / 24)
+	imul	$2731, len_dw, %eax	# 2731 = ceil(2^16 / 24)
 	shr	$16, %eax
 	jmp	.Lcrc_3lanes
 
 .Lfull_block:
 	# Processing 128 qwords from each lane.
@@ -123,20 +124,20 @@ SYM_FUNC_START(crc_pcl)
 	jl	.Lcrc_3lanes_4x_done
 
 	# Unroll the loop by a factor of 4 to reduce the overhead of the loop
 	# bookkeeping instructions, which can compete with crc32q for the ALUs.
 .Lcrc_3lanes_4x_loop:
-	crc32q	(bufp), crc_init_q
+	crc32q	(bufp), crc0_q
 	crc32q	(bufp,chunk_bytes_q), crc1
 	crc32q	(bufp,chunk_bytes_q,2), crc2
-	crc32q	8(bufp), crc_init_q
+	crc32q	8(bufp), crc0_q
 	crc32q	8(bufp,chunk_bytes_q), crc1
 	crc32q	8(bufp,chunk_bytes_q,2), crc2
-	crc32q	16(bufp), crc_init_q
+	crc32q	16(bufp), crc0_q
 	crc32q	16(bufp,chunk_bytes_q), crc1
 	crc32q	16(bufp,chunk_bytes_q,2), crc2
-	crc32q	24(bufp), crc_init_q
+	crc32q	24(bufp), crc0_q
 	crc32q	24(bufp,chunk_bytes_q), crc1
 	crc32q	24(bufp,chunk_bytes_q,2), crc2
 	add	$32, bufp
 	sub	$4, %eax
 	jge	.Lcrc_3lanes_4x_loop
@@ -144,42 +145,42 @@ SYM_FUNC_START(crc_pcl)
 .Lcrc_3lanes_4x_done:
 	add	$4, %eax
 	jz	.Lcrc_3lanes_last_qword
 
 .Lcrc_3lanes_1x_loop:
-	crc32q	(bufp), crc_init_q
+	crc32q	(bufp), crc0_q
 	crc32q	(bufp,chunk_bytes_q), crc1
 	crc32q	(bufp,chunk_bytes_q,2), crc2
 	add	$8, bufp
 	dec	%eax
 	jnz	.Lcrc_3lanes_1x_loop
 
 .Lcrc_3lanes_last_qword:
-	crc32q	(bufp), crc_init_q
+	crc32q	(bufp), crc0_q
 	crc32q	(bufp,chunk_bytes_q), crc1
 # SKIP  crc32q	(bufp,chunk_bytes_q,2), crc2	; Don't do this one yet
 
 	################################################################
 	## 4) Combine three results:
 	################################################################
 
 	lea	(K_table-8)(%rip), %rax		# first entry is for idx 1
 	pmovzxdq (%rax,chunk_bytes_q), %xmm0	# 2 consts: K1:K2
 	lea	(chunk_bytes,chunk_bytes,2), %eax # chunk_bytes * 3
-	sub	%eax, len			# len -= chunk_bytes * 3
+	sub	%rax, len			# len -= chunk_bytes * 3
 
-	movq	crc_init_q, %xmm1		# CRC for block 1
+	movq	crc0_q, %xmm1			# CRC for block 1
 	pclmulqdq $0x00, %xmm0, %xmm1		# Multiply by K2
 
 	movq    crc1, %xmm2			# CRC for block 2
 	pclmulqdq $0x10, %xmm0, %xmm2		# Multiply by K1
 
 	pxor    %xmm2,%xmm1
 	movq    %xmm1, %rax
 	xor	(bufp,chunk_bytes_q,2), %rax
-	mov	crc2, crc_init_q
-	crc32	%rax, crc_init_q
+	mov	crc2, crc0_q
+	crc32	%rax, crc0_q
 	lea	8(bufp,chunk_bytes_q,2), bufp
 
 	################################################################
 	## 5) If more blocks remain, goto (2):
 	################################################################
@@ -191,38 +192,38 @@ SYM_FUNC_START(crc_pcl)
 
 	#######################################################################
 	## 6) Process any remainder without interleaving:
 	#######################################################################
 .Lsmall:
-	test	len, len
+	test	len_dw, len_dw
 	jz	.Ldone
-	mov	len, %eax
+	mov	len_dw, %eax
 	shr	$3, %eax
 	jz	.Ldo_dword
 .Ldo_qwords:
-	crc32q	(bufp), crc_init_q
+	crc32q	(bufp), crc0_q
 	add	$8, bufp
 	dec	%eax
 	jnz	.Ldo_qwords
 .Ldo_dword:
-	test	$4, len
+	test	$4, len_dw
 	jz	.Ldo_word
-	crc32l	(bufp), crc_init
+	crc32l	(bufp), crc0
 	add	$4, bufp
 .Ldo_word:
-	test	$2, len
+	test	$2, len_dw
 	jz	.Ldo_byte
-	crc32w	(bufp), crc_init
+	crc32w	(bufp), crc0
 	add	$2, bufp
 .Ldo_byte:
-	test	$1, len
+	test	$1, len_dw
 	jz	.Ldone
-	crc32b	(bufp), crc_init
+	crc32b	(bufp), crc0
 .Ldone:
-	mov	crc_init, %eax
+	mov	crc0, %eax
         RET
-SYM_FUNC_END(crc_pcl)
+SYM_FUNC_END(crc32c_x86_3way)
 
 .section	.rodata, "a", @progbits
 	################################################################
 	## PCLMULQDQ tables
 	## Table is 128 entries x 2 words (8 bytes) each
-- 
2.47.0


