Return-Path: <linux-arch+bounces-8565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F09B0E97
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BDCB26A14
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A9218944;
	Fri, 25 Oct 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioauDeBj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892A21893A;
	Fri, 25 Oct 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883751; cv=none; b=EPiR3428gUxOjJNTeQGtdnBuNgGD1onBIWqN/KMxvZKJTQyAQsgoinzY7LMpRZvZLWgUi1T1YhX18jjvsMfxsjXCxukTzRuBPLddDc1QcaBr8qhTnKkeUF6b24JStqTDZl+Ir5lPYnOW7IFmMpqQ6WkpV5kfpwpRpnl6edzI3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883751; c=relaxed/simple;
	bh=kHWHhodawY/PaSA95ElCxVPVWHZVNPifFLwbM7bCJig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ewo8C5yrP15bwAHD4Vg0JEr9rYWIWiXRLNz8qOjXTjeLSgPGl6WoqUqo70zuQsNUx1zAbRrhwJZqWxSILPmUTVsiQoE7CEZDcpb8TDcruBIHgKLrDbMOQpafJ24rKLJQEIhfz+1fPtk59KdHCUs/XVMasP9dpP7MCwuNPuHnqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioauDeBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F53C4CEC3;
	Fri, 25 Oct 2024 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729883750;
	bh=kHWHhodawY/PaSA95ElCxVPVWHZVNPifFLwbM7bCJig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioauDeBjed5AAxh0JktDhYhi//5q/79Oew//g2sBJO13l2hTcNiaOzFClw1uFOpJl
	 rez/R7AKxxbYxkaWAyms6YMS+o3pM4bEihrrbv8z8UL37fGqhwnuntxVSI/7f43Wy6
	 mZw7T3LOw+SABicICJJxn3z8hI/G+4Sa4T67U/vgn8DmjFTay1sHjWvOsj65tmEbes
	 6pv2MdY4dgWymSofU/faEl+xKBXglzLHDguJlmHKvBSGhErnz15T42CNOP4Uawgm9j
	 dc/PHWgP+6kLGE9kFH4CvGiW+VriTxcErjLcw+o1XBxiYq0eauhf1GJ5XGdBxHiy0v
	 rL2YEdWvEgIrQ==
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
Subject: [PATCH v2 12/18] x86/crc32: update prototype for crc32_pclmul_le_16()
Date: Fri, 25 Oct 2024 12:14:48 -0700
Message-ID: <20241025191454.72616-13-ebiggers@kernel.org>
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

- Move the crc parameter to the front, as this is the usual convention.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/crypto/crc32-pclmul_asm.S  | 19 +++++++++----------
 arch/x86/crypto/crc32-pclmul_glue.c |  4 ++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/crypto/crc32-pclmul_asm.S b/arch/x86/crypto/crc32-pclmul_asm.S
index 5d31137e2c7d..f9637789cac1 100644
--- a/arch/x86/crypto/crc32-pclmul_asm.S
+++ b/arch/x86/crypto/crc32-pclmul_asm.S
@@ -56,30 +56,29 @@
 	.octa 0x00000001F701164100000001DB710641
 
 #define CONSTANT %xmm0
 
 #ifdef __x86_64__
-#define BUF     %rdi
-#define LEN     %rsi
-#define CRC     %edx
+#define CRC     %edi
+#define BUF     %rsi
+#define LEN     %rdx
 #else
-#define BUF     %eax
-#define LEN     %edx
-#define CRC     %ecx
+#define CRC     %eax
+#define BUF     %edx
+#define LEN     %ecx
 #endif
 
 
 
 .text
 /**
  *      Calculate crc32
- *      BUF - buffer (16 bytes aligned)
- *      LEN - sizeof buffer (16 bytes aligned), LEN should be grater than 63
  *      CRC - initial crc32
+ *      BUF - buffer (16 bytes aligned)
+ *      LEN - sizeof buffer (16 bytes aligned), LEN should be greater than 63
  *      return %eax crc32
- *      uint crc32_pclmul_le_16(unsigned char const *buffer,
- *	                     size_t len, uint crc32)
+ *      u32 crc32_pclmul_le_16(u32 crc, const u8 *buffer, size_t len);
  */
 
 SYM_FUNC_START(crc32_pclmul_le_16) /* buffer and buffer size are 16 bytes aligned */
 	movdqa  (BUF), %xmm1
 	movdqa  0x10(BUF), %xmm2
diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index 9f5e342b9845..9d14eac51c5b 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -44,11 +44,11 @@
 #define PCLMUL_MIN_LEN		64L     /* minimum size of buffer
 					 * for crc32_pclmul_le_16 */
 #define SCALE_F			16L	/* size of xmm register */
 #define SCALE_F_MASK		(SCALE_F - 1)
 
-u32 crc32_pclmul_le_16(unsigned char const *buffer, size_t len, u32 crc32);
+u32 crc32_pclmul_le_16(u32 crc, const u8 *buffer, size_t len);
 
 static u32 __attribute__((pure))
 	crc32_pclmul_le(u32 crc, unsigned char const *p, size_t len)
 {
 	unsigned int iquotient;
@@ -69,11 +69,11 @@ static u32 __attribute__((pure))
 	}
 	iquotient = len & (~SCALE_F_MASK);
 	iremainder = len & SCALE_F_MASK;
 
 	kernel_fpu_begin();
-	crc = crc32_pclmul_le_16(p, iquotient, crc);
+	crc = crc32_pclmul_le_16(crc, p, iquotient);
 	kernel_fpu_end();
 
 	if (iremainder)
 		crc = crc32_le(crc, p + iquotient, iremainder);
 
-- 
2.47.0


