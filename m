Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628DB7A242E
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 19:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjIORDB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjIORCn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 13:02:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A92E50
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 10:02:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso18725225ad.1
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694797353; x=1695402153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YenmJptO8OUyWvbDRPBx2LDiJqOG9TzUed92tXFO3E=;
        b=JoI68RCsFFhjehOH1hU/WGneOUf0DNW0eM6meWbrLKAG45uCrHm+u9YagtBpr3Rmlx
         l0E796fTTlyDQnLFOam1mGRuLgq0GX6UoSGhWgwMUK9YoRSfI8dpRC5EK+Cp6ihE5Whm
         6CZH7K6VQuQh6yJ6brL7bfyr4fM2upOEx/VIl/vjexPIRJdyJhXUggd6qIk3tvKyRCl9
         6BVqVvd4OO6UVLSB2M8muQqP4WkfG5/JPBGMS0Q9n9vQiLZAf68GjXwJBsRxyhGG1MOP
         NxfKTX6GT9jErxaB0/x+QzieDzBKrXoktnNafdGNLCbAxsOGgfvmGpmRotDj7LYAp3Qd
         J2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797353; x=1695402153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YenmJptO8OUyWvbDRPBx2LDiJqOG9TzUed92tXFO3E=;
        b=rWXm0aN2JUS67BkpbIp/j6yF2GGwNJktqqiYnVN+gkfDPdz9DwTqn4hrYmV6GkSrLI
         WuEr7jawOCq6zLABrAP+/TWu1/WKA3Rnk1aHve/z2FGlQ6rJJQT8etSzzaN0cMS3wpyK
         b5FhOvTLiC8J4KPIb/iESi7VSmjJY2fP1LChDv6FxUx52q9bjfeszu2o1clf6iuJhofj
         f/snU0DrLV7NbyjNH7Hjv+n139aMvdsWcrtfmetfmYfFW/bS2c/FlVun7miqcC1cDxRS
         GsYfsUMi8Rse2hqUrbOZZu4MDH4HbogeOv0ILaAB4JOWrhI4KUKHd95qCt9PkINYKSb7
         UNYQ==
X-Gm-Message-State: AOJu0YxqWVXfTbpHAWk4+rglTUvNbGrwC1tZwjK4Ol8PAvm4lMEW/4qX
        JXaJHof3bYh3nuIUS2LW8ZmZMQ==
X-Google-Smtp-Source: AGHT+IFhabtRSCNC2ojl0RQSGzjAOJkYDTlrQYNnmSckJagA35mnr1K8l3L+JQGHEIDnd04q9iFvYg==
X-Received: by 2002:a17:903:1249:b0:1c0:e472:5412 with SMTP id u9-20020a170903124900b001c0e4725412mr2500496plh.18.1694797353332;
        Fri, 15 Sep 2023 10:02:33 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001c44c8d857esm34299plq.120.2023.09.15.10.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:02:32 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 15 Sep 2023 10:01:19 -0700
Subject: [PATCH v6 3/4] riscv: Add checksum library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-optimize_checksum-v6-3-14a6cf61c618@rivosinc.com>
References: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
In-Reply-To: <20230915-optimize_checksum-v6-0-14a6cf61c618@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/riscv/lib/csum.c             | 198 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)

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
index 000000000000..1fda96d2bd8d
--- /dev/null
+++ b/arch/riscv/lib/csum.c
@@ -0,0 +1,198 @@
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
+	sum += (sum >> 32) | (sum << 32);
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
+	unsigned long csum = 0, data;
+	const unsigned long *ptr;
+
+	if (unlikely(len <= 0))
+		return 0;
+	/*
+	 * To align the address, grab the whole first byte in buff.
+	 * Since it is inside of a same byte, it will never cross pages or cache
+	 * lines.
+	 * Directly call KASAN with the alignment we will be using.
+	 */
+	offset = (unsigned long)buff & OFFSET_MASK;
+	kasan_check_read(buff, len);
+	ptr = (const unsigned long *)(buff - offset);
+	len = len + offset - sizeof(unsigned long);
+
+	/*
+	 * Clear the most signifant bits that were over-read if buff was not
+	 * aligned.
+	 */
+	shift = offset * 8;
+	data = *ptr;
+	if (IS_ENABLED(__LITTLE_ENDIAN))
+		data = (data >> shift) << shift;
+	else
+		data = (data << shift) >> shift;
+
+	/*
+	 * Do 32-bit reads on RV32 and 64-bit reads otherwise. This should be
+	 * faster than doing 32-bit reads on architectures that support larger
+	 * reads.
+	 */
+	while (len > 0) {
+		csum += data;
+		csum += csum < data;
+		len -= sizeof(unsigned long);
+		ptr += 1;
+		data = *ptr;
+	}
+
+	/*
+	 * Perform alignment (and over-read) bytes on the tail if any bytes
+	 * leftover.
+	 */
+	shift = len * -8;
+	if (IS_ENABLED(__LITTLE_ENDIAN))
+		data = (data << shift) >> shift;
+	else
+		data = (data >> shift) << shift;
+
+	csum += data;
+	csum += csum < data;
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
+		unsigned int fold_temp;
+
+		if (IS_ENABLED(CONFIG_32BIT)) {
+			asm_volatile_goto(".option push			\n\
+			.option arch,+zbb				\n\
+				rori	%[fold_temp], %[csum], 16	\n\
+				andi	%[offset], %[offset], 1		\n\
+				add	%[csum], %[fold_temp], %[csum]	\n\
+				beq	%[offset], zero, %l[end]	\n\
+				rev8	%[csum], %[csum]		\n\
+				zext.h	%[csum], %[csum]		\n\
+			.option pop"
+				: [csum] "+r" (csum),
+				  [fold_temp] "=&r" (fold_temp)
+				: [offset] "r" (offset)
+				:
+				: end);
+
+			return csum;
+		} else {
+			asm_volatile_goto(".option push			\n\
+			.option arch,+zbb				\n\
+				rori	%[fold_temp], %[csum], 32	\n\
+				add	%[csum], %[fold_temp], %[csum]	\n\
+				srli	%[csum], %[csum], 32		\n\
+				roriw	%[fold_temp], %[csum], 16	\n\
+				addw	%[csum], %[fold_temp], %[csum]	\n\
+				andi	%[offset], %[offset], 1		\n\
+				beq	%[offset], zero, %l[end]	\n\
+				rev8	%[csum], %[csum]		\n\
+				srli	%[csum], %[csum], 32		\n\
+				zext.h	%[csum], %[csum]		\n\
+			.option pop"
+				: [csum] "+r" (csum),
+				  [fold_temp] "=&r" (fold_temp)
+				: [offset] "r" (offset)
+				:
+				: end);
+
+			return csum;
+		}
+end:
+		return csum >> 16;
+	}
+
+#ifndef CONFIG_32BIT
+	csum += (csum >> 32) | (csum << 32);
+	csum >>= 32;
+#endif
+	csum = (unsigned int)csum + (((unsigned int)csum >> 16) | ((unsigned int)csum << 16));
+	if (offset & 1)
+		return (unsigned short)swab32(csum);
+	return csum >> 16;
+}

-- 
2.42.0

