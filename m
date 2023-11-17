Return-Path: <linux-arch+bounces-240-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB77EFAEB
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 22:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E79B2139C
	for <lists+linux-arch@lfdr.de>; Fri, 17 Nov 2023 21:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B384F88A;
	Fri, 17 Nov 2023 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0zHNfDaX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746031735
	for <linux-arch@vger.kernel.org>; Fri, 17 Nov 2023 13:28:13 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ce2c71c61fso1376382a34.1
        for <linux-arch@vger.kernel.org>; Fri, 17 Nov 2023 13:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700256492; x=1700861292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIPzAeBpfFKCf/gy5vzaJ56BSGUsbLFdz2SU2WRo3X0=;
        b=0zHNfDaX0kqMvQF3VGxGhlPNhN1ze/6hIeuzHNB1dDpxChP42748c5SHLokR4Ieuem
         hPlhq9pvE1ezma2EgvAbGiuqFwTQrxov9axawoKOPqiuhlgGKTa/lO4plk8loFCtpeLr
         c9aAvdDA6060J4p2oF4Wy6qdgEjwmJZtUrF76/LbdxUf47IcuTw/lyzvHsp2sCywPDaF
         vDPg/57YL9COZGQYVCAbE4xynTyU+YvM6l1Uxjrxs1tMmukv3ArzR8MQeaQ/lb+fSINl
         0iOnNJn7p38/aLFx9v2ggQ2H2LIsd2vl1c3nXaV5w7RCurBZq127YBtEcBOYxFKyEQTm
         326g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700256492; x=1700861292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIPzAeBpfFKCf/gy5vzaJ56BSGUsbLFdz2SU2WRo3X0=;
        b=syawNLhgu2TzqzelNsp8QiEMqIiryzNA4umN7bV8iSyAQ0c338UpdmTtJTS9i3gJpa
         /zsG4XE+KEpH+zJ89NZ1ffdTPpTLbovdadM1OnvFOKPLgtQ1dkEzgDbhOJrDv9xfFQLm
         UmA5rjLJVOYjqjXgX5VtHldi/y9Lt7r5zhr5B6A4kXym5XCtI3rOp9unAqRHc3NvjYQG
         xom69n+JtH4YeVnNW9qKNJsDSphwOsmUR/9jSQ+B0+kk9umMforTZ/8ba0d+b0GAqqd1
         g1kYYd0AFAqBk7KCKEZd7PLM5onQBR0aR6eQy3fMInk6vo1Rb7lujd/AL0g3RNoCPTGP
         JXIQ==
X-Gm-Message-State: AOJu0YxZAqTn3itWeVw7CVGn0DbRQhDieCusa5hH9/Bo3Qtc42KKty+I
	cGV7TGJS0mka8AtdrJ8Rm121wA==
X-Google-Smtp-Source: AGHT+IFIIBVAsV+kXtymjmu0UMkaBI6XOoR2jmWzVQU/FDClYBpgbgiDERNrQVZezxkwjW1wgE724A==
X-Received: by 2002:a9d:6310:0:b0:6d6:54ce:cad with SMTP id q16-20020a9d6310000000b006d654ce0cadmr434912otk.5.1700256492772;
        Fri, 17 Nov 2023 13:28:12 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e2-20020a05683013c200b006d3127234d7sm365677otq.8.2023.11.17.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:28:12 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 17 Nov 2023 13:28:01 -0800
Subject: [PATCH v11 3/5] riscv: Add checksum header
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-optimize_checksum-v11-3-7d9d954fe361@rivosinc.com>
References: <20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com>
In-Reply-To: <20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com>
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

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/checksum.h | 82 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..2fcf864186e7
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,82 @@
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
+/**
+ * Quickly compute an IP checksum with the assumption that IPv4 headers will
+ * always be in multiples of 32-bits, and have an ihl of at least 5.
+ *
+ * @ihl: the number of 32 bit segments and must be greater than or equal to 5.
+ * @iph: assumed to be word aligned given that NET_IP_ALIGN is set to 2 on
+ *  riscv, defining IP headers to be aligned.
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


