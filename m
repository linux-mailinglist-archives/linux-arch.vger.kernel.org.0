Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1F7DA3B5
	for <lists+linux-arch@lfdr.de>; Sat, 28 Oct 2023 00:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346676AbjJ0WoN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346686AbjJ0WoG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 18:44:06 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8101B9
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 15:44:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so1648632a34.2
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698446643; x=1699051443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BafBaWBWsOb19tamkke5Dj16vu64sm5n6mJ/bBKmhE=;
        b=U82BWtjSiTn44LxbapxKT7cw7F5zwvydxrFJTKUH1krGBEWIjJA4yAEZg0naLq0c1F
         Tzo/+sWiO9xTW8MTEdZhfSkgH3e/ZQDUQ2Hq1NMqT5Mo/Gw+BSmnQJ6u0cM6ycOkA8aM
         GfPLXZLX9pGf5TlBr3aHoEimthKUnyEkOkdFGqQLLwjDSgRzBpMSYf4m4gSTZaIoEM2d
         phviU7XmIGZiCeHmC4oj1UCOX+LKyMIjL0OliBaoyExcBBJNavpq6e0zXNwy1Guftc8w
         5oHHcN/bHaFNH0R8wpVx2ch50n5Bw0v+wRY1kMS++H62y7/e012zAaKsy1nmeiG1aJfZ
         VTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698446643; x=1699051443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BafBaWBWsOb19tamkke5Dj16vu64sm5n6mJ/bBKmhE=;
        b=d7djwmTQI8eIyc8wK/bA2bydosjXcVRuri76BFqj5+UynayBbiMNsYMcAwfSezPkHO
         I3dAmtVvBRkLRaFum22jmoymkCNlM56qx2sZCC2t6Md+J+3hxgorKjQNJClcJCGeNJmc
         IlYLEgmueJwWv2UqDOu/m/PFKU1ueP4uVR7kNp1jtYTa3xnrqlCPDdYJokOHqHdmP05I
         Ex/diHMyIAhXJ1v1L1CHHsNbxC3KEH/vvpJ2TM8WvSWfG5w0c+FQWqdfAFifDJCMlhht
         xWYowI4MHeYdm96cFBNlyT4Wnrx8yD2Zw2QwoC5aryFOk5hKgng43jld/H4qaLwqa7XK
         xUjQ==
X-Gm-Message-State: AOJu0YxqD8y6fJH9AAJKxJ/8BSo3eaM2pXRNZ5xpiVIHM4XhlkDpa6+O
        ZaX0L7ClOTExBPt567V1Co+Qgg==
X-Google-Smtp-Source: AGHT+IEPbxJRpeWOtruPaR4gtsoYOSkyXUjTp4UCIDh0rJAvuI4jazlUIen6Q8F8ILANAMxvX1lBQA==
X-Received: by 2002:a05:6830:925:b0:6bf:1444:966d with SMTP id v37-20020a056830092500b006bf1444966dmr4123246ott.1.1698446643442;
        Fri, 27 Oct 2023 15:44:03 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d748f000000b006c61c098d38sm448564otk.21.2023.10.27.15.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:44:02 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 27 Oct 2023 15:43:53 -0700
Subject: [PATCH v8 3/5] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-optimize_checksum-v8-3-feb7101d128d@rivosinc.com>
References: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
In-Reply-To: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/checksum.h | 92 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..9fd4b1b80641
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * IP checksum routines
+ *
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#ifndef __ASM_RISCV_CHECKSUM_H
+#define __ASM_RISCV_CHECKSUM_H
+
+#include <linux/in6.h>
+#include <linux/uaccess.h>
+
+#define ip_fast_csum ip_fast_csum
+
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
+/* Define riscv versions of functions before importing asm-generic/checksum.h */
+#include <asm-generic/checksum.h>
+
+/*
+ * Quickly compute an IP checksum with the assumption that IPv4 headers will
+ * always be in multiples of 32-bits, and have an ihl of at least 5.
+ * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
+ * @iph is assumed to be word aligned given that NET_IP_ALIGN is set to 2 on
+ *	riscv, defining IP headers to be aligned.
+ */
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	unsigned long csum = 0;
+	int pos = 0;
+
+	do {
+		csum += ((const unsigned int *)iph)[pos];
+		if (IS_ENABLED(CONFIG_32BIT))
+			csum += csum < ((const unsigned int *)iph)[pos];
+	} while (++pos < ihl);
+
+	/*
+	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
+	 * worth checking if supported without Alternatives.
+	 */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		unsigned long fold_temp;
+
+		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+					      RISCV_ISA_EXT_ZBB, 1)
+		    :
+		    :
+		    :
+		    : no_zbb);
+
+		if (IS_ENABLED(CONFIG_32BIT)) {
+			asm(".option push				\n\
+			.option arch,+zbb				\n\
+				not	%[fold_temp], %[csum]		\n\
+				rori	%[csum], %[csum], 16		\n\
+				sub	%[csum], %[fold_temp], %[csum]	\n\
+			.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+		} else {
+			asm(".option push				\n\
+			.option arch,+zbb				\n\
+				rori	%[fold_temp], %[csum], 32	\n\
+				add	%[csum], %[fold_temp], %[csum]	\n\
+				srli	%[csum], %[csum], 32		\n\
+				not	%[fold_temp], %[csum]		\n\
+				roriw	%[csum], %[csum], 16		\n\
+				subw	%[csum], %[fold_temp], %[csum]	\n\
+			.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+		}
+		return csum >> 16;
+	}
+no_zbb:
+#ifndef CONFIG_32BIT
+	csum += (csum >> 32) | (csum << 32);
+	csum >>= 32;
+#endif
+	return csum_fold((__force __wsum)csum);
+}
+
+#endif /* __ASM_RISCV_CHECKSUM_H */

-- 
2.42.0

