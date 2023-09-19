Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82277A6AD5
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjISSpQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 14:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjISSpI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 14:45:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B82BF
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:45:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-578cc95db68so332592a12.1
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695149101; x=1695753901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBEhBoTZVdBzO00bPBG/F1gext25nbTtr4JBvrUc/xg=;
        b=ZHNtvAWeZapjs/fHPIDMdKK99kyw6FEI2A82YEqb9berj8Tuu8+Sl+uHf5E5ZKki18
         K7FDHD3btxwSA+oWIVUyb6d+kTi8hUPbBha/8vSqrkDavQc7kcuVzAg/EkQwsAD2P9KU
         cp6kXTA5AOkWFjtQgpJglXJSNMOiIUUlLldtom9O0R39U760w4OpmxP09A+bHFGeRoON
         uH8AZWGY6EkakDozqbF/pLRdbUVyAvvg92SsRjdrKOk3lTb4W6VKK17BrFaJlXBlw1zE
         B6fovKAky/7uPweGfuKM5qN4TVZU4P8S8Ly0yDN5MXntZk577kRkOaAhV742FrWlfIZw
         czaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149101; x=1695753901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBEhBoTZVdBzO00bPBG/F1gext25nbTtr4JBvrUc/xg=;
        b=V6IVo5KRcjkzl11RfZcTw4xh350iYVr9Cfik5s9hN3WDcdwCh35bjGoYcbdO0U7dod
         0B/kauNSqq6CfyF++GHpXywXwXFDDYrrJxVw+J4IxP4gAjONQOIrw1YroOBy5LuTRqG5
         T+mbxOoktu7Y3oDbPPZnOap8LKrLeoQDZ5U5+qXRNSAUwBIPntPEE3U9PAOjnd4p69Ei
         +gwu7yPYbNXTZuAT1vY8l6w9PBfI8hIlniBl8R3kTz943eXJJQyGFrShaGHCLqxeNglm
         heeJ/TWX7HDNvOHfnmXidfuzTpSkt2nuqM73X3xE6UbtTgP8mgp8Rf+jy5/HBtHlCq3J
         kg/w==
X-Gm-Message-State: AOJu0Yzs9MrBRniRpHkVn3qeUeXKKMQlUTt4YlWNFE+uenXCWNNHXa8M
        mDTwdCUQusH/M4Brd815WEEn1Q==
X-Google-Smtp-Source: AGHT+IHNyfSonRdI27THvWjGDFHPrz18UTQAGvVa8rfVkN53t36b7cwgCWXBxi3ba6U2x8t+an2Myw==
X-Received: by 2002:a17:90a:6881:b0:268:b0b:a084 with SMTP id a1-20020a17090a688100b002680b0ba084mr544576pjd.46.1695149101593;
        Tue, 19 Sep 2023 11:45:01 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090b068500b0026309d57724sm3876846pjz.39.2023.09.19.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 11:45:01 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 19 Sep 2023 11:44:32 -0700
Subject: [PATCH v7 3/4] riscv: Add checksum library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-optimize_checksum-v7-3-06c7d0ddd5d6@rivosinc.com>
References: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
In-Reply-To: <20230919-optimize_checksum-v7-0-06c7d0ddd5d6@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provide a 32 and 64 bit version of do_csum. When compiled for 32-bit
will load from the buffer in groups of 32 bits, and when compiled for
64-bit will load in groups of 64 bits.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h |  12 +++
 arch/riscv/lib/Makefile           |   1 +
 arch/riscv/lib/csum.c             | 217 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index dc0dd89f2a13..7fcd07edb8b3 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -12,6 +12,18 @@
 
 #define ip_fast_csum ip_fast_csum
 
+extern unsigned int do_csum(const unsigned char *buff, int len);
+#define do_csum do_csum
+
+/* Default version is sufficient for 32 bit */
+#ifdef CONFIG_64BIT
+#define _HAVE_ARCH_IPV6_CSUM
+__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
+			const struct in6_addr *daddr,
+			__u32 len, __u8 proto, __wsum sum);
+#endif
+
+// Define riscv versions of functions before importing asm-generic/checksum.h
 #include <asm-generic/checksum.h>
 
 /*
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
index 000000000000..d8fc94bff602
--- /dev/null
+++ b/arch/riscv/lib/csum.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IP checksum library
+ *
+ * Influenced by arch/arm64/lib/csum.c
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/kasan-checks.h>
+#include <linux/kernel.h>
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
+	unsigned long sum = csum;
+
+	sum += saddr->s6_addr32[0];
+	sum += saddr->s6_addr32[1];
+	sum += saddr->s6_addr32[2];
+	sum += saddr->s6_addr32[3];
+
+	sum += daddr->s6_addr32[0];
+	sum += daddr->s6_addr32[1];
+	sum += daddr->s6_addr32[2];
+	sum += daddr->s6_addr32[3];
+
+	ulen = htonl((unsigned int)len);
+	sum += ulen;
+
+	uproto = htonl(proto);
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
+#endif // !CONFIG_32BIT
+
+#ifdef CONFIG_32BIT
+#define OFFSET_MASK 3
+#elif CONFIG_64BIT
+#define OFFSET_MASK 7
+#endif
+
+/*
+ * Perform a checksum on an arbitrary memory address.
+ * Algorithm accounts for buff being misaligned.
+ * If buff is not aligned, will over-read bytes but not use the bytes that it
+ * shouldn't. The same thing will occur on the tail-end of the read.
+ */
+unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
+{
+	unsigned int offset, shift;
+	unsigned long csum = 0, carry = 0, data;
+	const unsigned long *ptr, *end;
+
+	if (unlikely(len <= 0))
+		return 0;
+
+	end = (const unsigned long *)(buff + len);
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
+	/*
+	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
+	 * faster than doing 32-bit reads on architectures that support larger
+	 * reads.
+	 */
+	while (ptr < end) {
+		csum += data;
+		carry += csum < data;
+		len -= sizeof(long);
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
+			: [csum] "+r" (csum),
+				[fold_temp] "=&r" (fold_temp)
+			: [offset] "r" (offset)
+			:
+			: end);
+
+		return (unsigned short)csum;
+#else // !CONFIG_32BIT
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
+			: [csum] "+r" (csum),
+				[fold_temp] "=&r" (fold_temp)
+			: [offset] "r" (offset)
+			:
+			: end);
+
+		return (csum << 16) >> 48;
+#endif // !CONFIG_32BIT
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

-- 
2.42.0

