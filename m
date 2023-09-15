Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84E7A242B
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjIORDB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjIORCi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 13:02:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2532710
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 10:02:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c0ecb9a075so19904485ad.2
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694797352; x=1695402152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1k75qxIvoyjoXO7i5f1b9o5ew6JdXdHy21zFkpaW4Nc=;
        b=QTjIO+zalWvOOy048VbiCaKq7TESIubbUhWzSQK692xypb8OJwzrne6DVs9LGqY4Wx
         0fZ8t4a2JHxdtoko0KWNZmk8DxP4bmHFYMf2NMngC2bfcYKR7oaqAtnUhoiNkVIeO3HR
         iHFWm91uzQV3kYmAtpBLoKWwMeFU6xP3gYfRxXLhdnJbARdL2n0K8AHjX/TEgg5BpcWd
         j70XM7AIcLKZ2oFJl1U8e2TDSGmr6neMLMytJSCJXU2zlPSqLbtvWFSLPdqJ1X9O+oa2
         yKYmEbhXxVJSVBUCNybKJofKm0M9DRA5G78Ipum75k0b+mfDhLyr4KJrgVo+RbewP1T5
         F+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797352; x=1695402152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k75qxIvoyjoXO7i5f1b9o5ew6JdXdHy21zFkpaW4Nc=;
        b=Sn8ztiTegZowfRDZoQEdaZLl6QSaF7j6wppsPvCSwpP8BWYgNk6GQ3ZvYbls8Zgvmd
         LlffPNPYmb6gnQNA1q7HumuM4ZR/Vi6B7Y0x7r828ZrV6/kkzQ0r8CyNTyfgeY9Wejn+
         PowmNeSw3X+GHKTeITv+HUeEx3ZDybbgMqG2fb8IOQjnaio0FAHmywJD1jjai/71SmaJ
         Op8sLjSWKkdyMyMx2A7/hzXmpVN84un22gE/7/0f779gNHxU7c/zdLZWjfLodjk1BAfW
         eM058f9gn3JXCILmEbjDrKU5jUj6SKYPzFGusA/99psQU24lMPzBq3as0s8tn/LOGaL+
         GnSA==
X-Gm-Message-State: AOJu0Yy+CAFht9uHUMrDi2iDsPLhjpGAmyRmD4iRcTC7Bik4aqpr0HBz
        Q24Y1oqycyAAVqIf411eo7skbg==
X-Google-Smtp-Source: AGHT+IH1jPn04soXbAnfI7sIsWevrTzCm19sW4JGO/9RBel+0bsUazXseS8iwam4Uk1qhMvvhuehhw==
X-Received: by 2002:a17:902:ab5d:b0:1c3:8679:6ed4 with SMTP id ij29-20020a170902ab5d00b001c386796ed4mr2424521plb.8.1694797352279;
        Fri, 15 Sep 2023 10:02:32 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709029f9600b001c44c8d857esm34299plq.120.2023.09.15.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:02:31 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 15 Sep 2023 10:01:18 -0700
Subject: [PATCH v6 2/4] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230915-optimize_checksum-v6-2-14a6cf61c618@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/checksum.h | 79 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..dc0dd89f2a13
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,79 @@
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
+#include <asm-generic/checksum.h>
+
+/*
+ * Quickly compute an IP checksum with the assumption that IPv4 headers will
+ * always be in multiples of 32-bits, and have an ihl of at least 5.
+ * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
+ * @iph is assumed to be word aligned.
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
+#endif // __ASM_RISCV_CHECKSUM_H

-- 
2.42.0

