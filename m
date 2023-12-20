Return-Path: <linux-arch+bounces-1148-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E281AB20
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 00:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EA21F23EB1
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 23:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640564C605;
	Wed, 20 Dec 2023 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="04cs67Ti"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975324BAB7
	for <linux-arch@vger.kernel.org>; Wed, 20 Dec 2023 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6db963bd3acso135432a34.0
        for <linux-arch@vger.kernel.org>; Wed, 20 Dec 2023 15:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703115468; x=1703720268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPVTonO+LXQZXwYb7iCPbl02ew7Jx3P2FceZOwyOvEQ=;
        b=04cs67Ti4ejYEbEPQNbhdQQpbo2MzSiAs3DJZ7HPox8pE/0rJmWrTeH+qTxsEmsMD7
         YgEaIRY+lHmR5oUiyT57HqFCzn2uTuzCIj+9LT9L+s52KCf/Hk+5UqvnBHKC+uO6bPBF
         yhg2Dnnz/QfgtOoC1wFqrv7yGYShpRKJidyvXmpzWpoPjmQFEKgdJObkmp+xFC8e3j33
         r3gA0R1ePRBiAUvljlMnOZ7wG3Wp/6s93V2PA2udDbqkRfgG8ZSke+D0B2ZMNDku2z3f
         n6MvFHd73nfY8emqeQfSLKwamXPBgv6rP5DEP9wy/H7dukZf3vE8BNObFaM+v+BPO4zz
         l8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115468; x=1703720268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPVTonO+LXQZXwYb7iCPbl02ew7Jx3P2FceZOwyOvEQ=;
        b=I63w4wbkt9qJ3ODIB0MxgFuN4N31P2FUPJRGEj8G+JVN8EQ5V8QnweOdX3v4iNH/kz
         MzMNPCA0CSYe3XpO3SH8EyRJd4EpTsMRI2NFTW6IiPJz1+rXh3LHSI3fjwWEPQAy8IZZ
         8B1FGOY5AV6CMM4LBYCcIIoB7G21B+RsnFUu6vunqiILvwSnL2MdUimV/CAxaTTVh7FI
         D24GmCeo5yhVKFTPi97lw16ihaVoYdUcPc+0qpxUn/wz/yR6CFNPRb7ztJCI4/2rrp09
         xQPIgAyxJUg/dGuS1SVf4Gi64tJTjV0WbaHVgb9u0BgMxHN3L2m3sGza3KoU8wVUTRb1
         BV6g==
X-Gm-Message-State: AOJu0YwzLHOeV66rxHQute00MhFza9+wzcJpOmrN7fiKD78ONI/he4UC
	drhTn+s4BrdRtdbXCl0BhIOj3g==
X-Google-Smtp-Source: AGHT+IF4KCPD7r7j+fQ5maRaL/UjcyisDYP27k2seVV62R01xStGpdQqTneQ9AkLyRjEHmxGtOvmuw==
X-Received: by 2002:a9d:6a8b:0:b0:6db:b5d3:feab with SMTP id l11-20020a9d6a8b000000b006dbb5d3feabmr260907otq.76.1703115467706;
        Wed, 20 Dec 2023 15:37:47 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k5-20020a056830150500b006d87e38f91asm132834otp.56.2023.12.20.15.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:37:47 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 20 Dec 2023 15:37:42 -0800
Subject: [PATCH v13 4/5] riscv: Add checksum library
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-optimize_checksum-v13-4-a73547e1cad8@rivosinc.com>
References: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com>
In-Reply-To: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703115460; l=11199;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=eDRUmyydl8PJNUFvLDZrYV4a83sgieN+gaZVXKbTj+s=;
 b=0cLzfYYANWfCm4KmIGWnXbaYNPD6zFXuxwKZKt5EA7CFx4rzEiCmPljS2C97kaSvDY0Q0iRil
 ZlYPwujZiMfAFE5LNtyCHxPtasghEGtPNitq3xMvCaCadiX1DhDXkeS
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
will load from the buffer in groups of 32 bits, and when compiled for
64-bit will load in groups of 64 bits.

Additionally provide riscv optimized implementation of csum_ipv6_magic.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/include/asm/checksum.h |  11 ++
 arch/riscv/lib/Makefile           |   1 +
 arch/riscv/lib/csum.c             | 326 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index 5a810126aac7..a5b60b54b101 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -12,6 +12,17 @@
 
 #define ip_fast_csum ip_fast_csum
 
+extern unsigned int do_csum(const unsigned char *buff, int len);
+#define do_csum do_csum
+
+/* Default version is sufficient for 32 bit */
+#ifndef CONFIG_32BIT
+#define _HAVE_ARCH_IPV6_CSUM
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum sum);
+#endif
+
 /* Define riscv versions of functions before importing asm-generic/checksum.h */
 #include <asm-generic/checksum.h>
 
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 26cb2502ecf8..2aa1a4ad361f 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -6,6 +6,7 @@ lib-y			+= memmove.o
 lib-y			+= strcmp.o
 lib-y			+= strlen.o
 lib-y			+= strncmp.o
+lib-y			+= csum.o
 lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
new file mode 100644
index 000000000000..06ce8e7250d9
--- /dev/null
+++ b/arch/riscv/lib/csum.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Checksum library
+ *
+ * Influenced by arch/arm64/lib/csum.c
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/jump_label.h>
+#include <linux/kasan-checks.h>
+#include <linux/kernel.h>
+
+#include <asm/cpufeature.h>
+
+#include <net/checksum.h>
+
+/* Default version is sufficient for 32 bit */
+#ifndef CONFIG_32BIT
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum csum)
+{
+	unsigned int ulen, uproto;
+	unsigned long sum = (__force unsigned long)csum;
+
+	sum += (__force unsigned long)saddr->s6_addr32[0];
+	sum += (__force unsigned long)saddr->s6_addr32[1];
+	sum += (__force unsigned long)saddr->s6_addr32[2];
+	sum += (__force unsigned long)saddr->s6_addr32[3];
+
+	sum += (__force unsigned long)daddr->s6_addr32[0];
+	sum += (__force unsigned long)daddr->s6_addr32[1];
+	sum += (__force unsigned long)daddr->s6_addr32[2];
+	sum += (__force unsigned long)daddr->s6_addr32[3];
+
+	ulen = (__force unsigned int)htonl((unsigned int)len);
+	sum += ulen;
+
+	uproto = (__force unsigned int)htonl(proto);
+	sum += uproto;
+
+	/*
+	 * Zbb support saves 4 instructions, so not worth checking without
+	 * alternatives if supported
+	 */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		unsigned long fold_temp;
+
+		/*
+		 * Zbb is likely available when the kernel is compiled with Zbb
+		 * support, so nop when Zbb is available and jump when Zbb is
+		 * not available.
+		 */
+		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+					      RISCV_ISA_EXT_ZBB, 1)
+				  :
+				  :
+				  :
+				  : no_zbb);
+		asm(".option push					\n\
+		.option arch,+zbb					\n\
+			rori	%[fold_temp], %[sum], 32		\n\
+			add	%[sum], %[fold_temp], %[sum]		\n\
+			srli	%[sum], %[sum], 32			\n\
+			not	%[fold_temp], %[sum]			\n\
+			roriw	%[sum], %[sum], 16			\n\
+			subw	%[sum], %[fold_temp], %[sum]		\n\
+		.option pop"
+		: [sum] "+r" (sum), [fold_temp] "=&r" (fold_temp));
+		return (__force __sum16)(sum >> 16);
+	}
+no_zbb:
+	sum += ror64(sum, 32);
+	sum >>= 32;
+	return csum_fold((__force __wsum)sum);
+}
+EXPORT_SYMBOL(csum_ipv6_magic);
+#endif /* !CONFIG_32BIT */
+
+#ifdef CONFIG_32BIT
+#define OFFSET_MASK 3
+#elif CONFIG_64BIT
+#define OFFSET_MASK 7
+#endif
+
+static inline __no_sanitize_address unsigned long
+do_csum_common(const unsigned long *ptr, const unsigned long *end,
+	       unsigned long data)
+{
+	unsigned int shift;
+	unsigned long csum = 0, carry = 0;
+
+	/*
+	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
+	 * faster than doing 32-bit reads on architectures that support larger
+	 * reads.
+	 */
+	while (ptr < end) {
+		csum += data;
+		carry += csum < data;
+		data = *(ptr++);
+	}
+
+	/*
+	 * Perform alignment (and over-read) bytes on the tail if any bytes
+	 * leftover.
+	 */
+	shift = ((long)ptr - (long)end) * 8;
+#ifdef __LITTLE_ENDIAN
+	data = (data << shift) >> shift;
+#else
+	data = (data >> shift) << shift;
+#endif
+	csum += data;
+	carry += csum < data;
+	csum += carry;
+	csum += csum < carry;
+
+	return csum;
+}
+
+/*
+ * Algorithm accounts for buff being misaligned.
+ * If buff is not aligned, will over-read bytes but not use the bytes that it
+ * shouldn't. The same thing will occur on the tail-end of the read.
+ */
+static inline __no_sanitize_address unsigned int
+do_csum_with_alignment(const unsigned char *buff, int len)
+{
+	unsigned int offset, shift;
+	unsigned long csum, data;
+	const unsigned long *ptr, *end;
+
+	/*
+	 * Align address to closest word (double word on rv64) that comes before
+	 * buff. This should always be in the same page and cache line.
+	 * Directly call KASAN with the alignment we will be using.
+	 */
+	offset = (unsigned long)buff & OFFSET_MASK;
+	kasan_check_read(buff, len);
+	ptr = (const unsigned long *)(buff - offset);
+
+	/*
+	 * Clear the most significant bytes that were over-read if buff was not
+	 * aligned.
+	 */
+	shift = offset * 8;
+	data = *(ptr++);
+#ifdef __LITTLE_ENDIAN
+	data = (data >> shift) << shift;
+#else
+	data = (data << shift) >> shift;
+#endif
+	end = (const unsigned long *)(buff + len);
+	csum = do_csum_common(ptr, end, data);
+
+	/*
+	 * Zbb support saves 6 instructions, so not worth checking without
+	 * alternatives if supported
+	 */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		unsigned long fold_temp;
+
+		/*
+		 * Zbb is likely available when the kernel is compiled with Zbb
+		 * support, so nop when Zbb is available and jump when Zbb is
+		 * not available.
+		 */
+		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+					      RISCV_ISA_EXT_ZBB, 1)
+				  :
+				  :
+				  :
+				  : no_zbb);
+
+#ifdef CONFIG_32BIT
+		asm_volatile_goto(".option push			\n\
+		.option arch,+zbb				\n\
+			rori	%[fold_temp], %[csum], 16	\n\
+			andi	%[offset], %[offset], 1		\n\
+			add	%[csum], %[fold_temp], %[csum]	\n\
+			beq	%[offset], zero, %l[end]	\n\
+			rev8	%[csum], %[csum]		\n\
+		.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
+			: [offset] "r" (offset)
+			:
+			: end);
+
+		return (unsigned short)csum;
+#else /* !CONFIG_32BIT */
+		asm_volatile_goto(".option push			\n\
+		.option arch,+zbb				\n\
+			rori	%[fold_temp], %[csum], 32	\n\
+			add	%[csum], %[fold_temp], %[csum]	\n\
+			srli	%[csum], %[csum], 32		\n\
+			roriw	%[fold_temp], %[csum], 16	\n\
+			addw	%[csum], %[fold_temp], %[csum]	\n\
+			andi	%[offset], %[offset], 1		\n\
+			beq	%[offset], zero, %l[end]	\n\
+			rev8	%[csum], %[csum]		\n\
+		.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
+			: [offset] "r" (offset)
+			:
+			: end);
+
+		return (csum << 16) >> 48;
+#endif /* !CONFIG_32BIT */
+end:
+		return csum >> 16;
+	}
+no_zbb:
+#ifndef CONFIG_32BIT
+	csum += ror64(csum, 32);
+	csum >>= 32;
+#endif
+	csum = (u32)csum + ror32((u32)csum, 16);
+	if (offset & 1)
+		return (u16)swab32(csum);
+	return csum >> 16;
+}
+
+/*
+ * Does not perform alignment, should only be used if machine has fast
+ * misaligned accesses, or when buff is known to be aligned.
+ */
+static inline __no_sanitize_address unsigned int
+do_csum_no_alignment(const unsigned char *buff, int len)
+{
+	unsigned long csum, data;
+	const unsigned long *ptr, *end;
+
+	ptr = (const unsigned long *)(buff);
+	data = *(ptr++);
+
+	kasan_check_read(buff, len);
+
+	end = (const unsigned long *)(buff + len);
+	csum = do_csum_common(ptr, end, data);
+
+	/*
+	 * Zbb support saves 6 instructions, so not worth checking without
+	 * alternatives if supported
+	 */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		unsigned long fold_temp;
+
+		/*
+		 * Zbb is likely available when the kernel is compiled with Zbb
+		 * support, so nop when Zbb is available and jump when Zbb is
+		 * not available.
+		 */
+		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+					      RISCV_ISA_EXT_ZBB, 1)
+				  :
+				  :
+				  :
+				  : no_zbb);
+
+#ifdef CONFIG_32BIT
+		asm (".option push				\n\
+		.option arch,+zbb				\n\
+			rori	%[fold_temp], %[csum], 16	\n\
+			add	%[csum], %[fold_temp], %[csum]	\n\
+		.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
+			:
+			: );
+
+#else /* !CONFIG_32BIT */
+		asm (".option push				\n\
+		.option arch,+zbb				\n\
+			rori	%[fold_temp], %[csum], 32	\n\
+			add	%[csum], %[fold_temp], %[csum]	\n\
+			srli	%[csum], %[csum], 32		\n\
+			roriw	%[fold_temp], %[csum], 16	\n\
+			addw	%[csum], %[fold_temp], %[csum]	\n\
+		.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
+			:
+			: );
+#endif /* !CONFIG_32BIT */
+		return csum >> 16;
+	}
+no_zbb:
+#ifndef CONFIG_32BIT
+	csum += ror64(csum, 32);
+	csum >>= 32;
+#endif
+	csum = (u32)csum + ror32((u32)csum, 16);
+	return csum >> 16;
+}
+
+/*
+ * Perform a checksum on an arbitrary memory address.
+ * Will do a light-weight address alignment if buff is misaligned, unless
+ * cpu supports fast misaligned accesses.
+ */
+unsigned int do_csum(const unsigned char *buff, int len)
+{
+	if (unlikely(len <= 0))
+		return 0;
+
+	/*
+	 * Significant performance gains can be seen by not doing alignment
+	 * on machines with fast misaligned accesses.
+	 *
+	 * There is some duplicate code between the "with_alignment" and
+	 * "no_alignment" implmentations, but the overlap is too awkward to be
+	 * able to fit in one function without introducing multiple static
+	 * branches. The largest chunk of overlap was delegated into the
+	 * do_csum_common function.
+	 */
+	if (static_branch_likely(&fast_misaligned_access_speed_key))
+		return do_csum_no_alignment(buff, len);
+
+	if (((unsigned long)buff & OFFSET_MASK) == 0)
+		return do_csum_no_alignment(buff, len);
+
+	return do_csum_with_alignment(buff, len);
+}

-- 
2.43.0


