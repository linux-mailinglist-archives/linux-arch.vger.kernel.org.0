Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51A57DE849
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 23:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347455AbjKAWsc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 18:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347347AbjKAWsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 18:48:30 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CA6119
        for <linux-arch@vger.kernel.org>; Wed,  1 Nov 2023 15:48:18 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b4145e887bso181973b6e.3
        for <linux-arch@vger.kernel.org>; Wed, 01 Nov 2023 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698878898; x=1699483698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed3AceHMZkBHW3Y7G0fWRXKUFOz+aro++Yp4kYAVXuk=;
        b=eWZTmUduVSomkhh3bkxKmV6Flq4imYMsrDpMo+CF1yIf3CGRKSjlY4K5gS+oU1fKhl
         OWM2tiSOKmluHLEQjSQyCgoDDUGuNT2FvFe2SGR0iBj03QuLOBzFang8DeLMR1CSI2y1
         Cu/8FIta1Wau0NqbIbTysZFtDwbVJRl1i1pGvvLasuPpOgc0EJvqDDMeC2DHMhtYxokb
         OTRgP4E2IZohu5o4ufjU5KJJ9Dz0jDXoSlJDeZIKbCZPecTd8mqGd2ThIS0LXxOwRuwe
         heds4Vr7uDq9HLEY89KG4dLFIXjiWxLceV7wyLQ2DlTYU2TAetF/NzThM0is0kRwpDgL
         VNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698878898; x=1699483698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed3AceHMZkBHW3Y7G0fWRXKUFOz+aro++Yp4kYAVXuk=;
        b=kvwv3kMiROkJWWaBpg+h51liRVdbuHqU8rkHEsmdq011IXit/N6SOJfi/kuiF/Cy3y
         K3thLkk1T08kvZI94/AbbwMXp7HtMyMnT9lIMqL3y2Ru6+DiRKObh/A23hPS6HxUI4G/
         S0p2JQbpekcc+hu1huFHpdNmSaK3e8uYRPXQpWlqXeWgveVcsLVZ06oVfhlcstLDtD5W
         GSYhdR181mX6lTU1QybbrxMAOpvf4KV+oX5D8n2ODW2RPCNF7eMOdYiuZ++Tpr0hNheH
         n9n1xO1wflZ3Zrepiq76tW+l2QmtA9i//EscERzLAmCrVKUvbSWuMtKF86g/Ojk+THgQ
         Mvhw==
X-Gm-Message-State: AOJu0YwCzZbGjgcg7MulOzsMZOIyzfksSrpTV+c1KFckd4QAAKDQ+eao
        TUSKlqigiuxR9m/ySI7heWs5iQ==
X-Google-Smtp-Source: AGHT+IHopUzoXmnmWd14ia19E+/4HILvhDaQ9lTPnrMCLKpAh1AzG9vNZBvySp5as5cAaQjvBxPEhQ==
X-Received: by 2002:a05:6808:1920:b0:3b5:64c9:5146 with SMTP id bf32-20020a056808192000b003b564c95146mr7234179oib.42.1698878898191;
        Wed, 01 Nov 2023 15:48:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id be24-20020a056808219800b003b274008e46sm376580oib.0.2023.11.01.15.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:48:17 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 01 Nov 2023 15:48:13 -0700
Subject: [PATCH v10 3/5] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-optimize_checksum-v10-3-a498577bb969@rivosinc.com>
References: <20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com>
In-Reply-To: <20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/riscv/include/asm/checksum.h | 81 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..3d77cac338fe
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Checksum routines
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
+	csum += ror64(csum, 32);
+	csum >>= 32;
+#endif
+	return csum_fold((__force __wsum)csum);
+}
+
+#endif /* __ASM_RISCV_CHECKSUM_H */

-- 
2.34.1

