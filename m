Return-Path: <linux-arch+bounces-1147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C4981AB1E
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 00:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21972833C7
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 23:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77484C3AC;
	Wed, 20 Dec 2023 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tNXAtkBB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A224B5D8
	for <linux-arch@vger.kernel.org>; Wed, 20 Dec 2023 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so96218fac.2
        for <linux-arch@vger.kernel.org>; Wed, 20 Dec 2023 15:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703115466; x=1703720266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlBR54Ho+Y1o3mIpBCBVXs2u+7/gciH5xwmXB5mwVNU=;
        b=tNXAtkBBXh4A2FnNy/BjMdhkTaLufaeSw91dleVWRQArN5Ac88AZ5IBkbBlOHKWji1
         omB9+b9wMzhWdSVquaDDo/F1O5PMNteticSQhRmQj+ijcJvor6IsXu+BLi8IxMlSJLp6
         HmhSTxqJAnx4vqcLaKLoqaUS1F9xeFPlBY7NDyOU6Yr9jmnwSfRJDVX2fGFDmRvHixQ2
         vkfgNSK6ib9sLv/xgdNzvINrgJBq5T8tQwLidbIS8uc+WIBvLNGF6fFbE23jmGOTQJWk
         Q0a44e0Aj1nG+2DKj9wcGFvNorTomvYSrDOl2VcNszEnNqJhrSLzNaezXMvhQA5JB/D8
         m4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115466; x=1703720266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlBR54Ho+Y1o3mIpBCBVXs2u+7/gciH5xwmXB5mwVNU=;
        b=HkT23i1mGa6+JXKF46NrJy3gNoFn+6lJ0Y+yK+EDsvkqSh7QKMfE2AqqShmYMjeHxA
         XUcy9J26AAO1GEg8SEtm1KtRUOa8Mq/W/g1nOWuzjO4BzZBLwQnFqy2k6QZ+hjTmDzh0
         sBfvELTAexDI7pN3ZxCoSTXuMVPOR71V3QWamvZdH6iwPJdH+d/tf5JM/ERmzduoMk+A
         NgCYVxJlcHFHkDD/fpLWL8BQHDJLn4eGeEtXSRl+/iFguGsH5e/zd0K9gNtIjCiQYAhc
         t8/Qw+2G+h6YdDoL0YmlalEodkEU7A7ogToHZZpzZtjCLYdAKcnUaWl0oCh0QBkAn2ya
         n+cw==
X-Gm-Message-State: AOJu0YzpNFZdAC19LLEsq5mgdznm8U/dsO+6HwxyEU84xrzsgQj+7bty
	cKovJIgjzhkYSKOIwgMZT6qEqw==
X-Google-Smtp-Source: AGHT+IFDlmKkwq7WN9bCzarmiTtQ2Vf4puWRd38+cllalRd5/tjdlHPjcQo/XN/KyB1GfH4goY6qKA==
X-Received: by 2002:a05:6870:41d0:b0:204:2bd9:7e89 with SMTP id z16-20020a05687041d000b002042bd97e89mr76457oac.88.1703115466262;
        Wed, 20 Dec 2023 15:37:46 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k5-20020a056830150500b006d87e38f91asm132834otp.56.2023.12.20.15.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:37:45 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 20 Dec 2023 15:37:41 -0800
Subject: [PATCH v13 3/5] riscv: Add checksum header
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-optimize_checksum-v13-3-a73547e1cad8@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703115460; l=3093;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=5kLrZ5pIGOixKzGlevacL81yKd58H4/jGvyu52ss5bM=;
 b=izPJP+daFTVa6yKitNFbRPSPqqaIpZZN3OPtfRsjg/7/qxUEKNV8pETfxzSLQSd5dlIq+5wE7
 jG2yJAy6TI7Ak8DLgtvL3OF7ExUWAwC38RVzTUCYSkFYv8VrBuQWrfH
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/include/asm/checksum.h | 82 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..5a810126aac7
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
+		return (__force __sum16)(csum >> 16);
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
2.43.0


