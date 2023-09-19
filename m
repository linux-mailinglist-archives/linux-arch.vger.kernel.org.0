Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757AD7A6AD2
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 20:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjISSpK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjISSpG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 14:45:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A43E9E
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:45:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-577fb90bb76so3306767a12.2
        for <linux-arch@vger.kernel.org>; Tue, 19 Sep 2023 11:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695149100; x=1695753900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1k75qxIvoyjoXO7i5f1b9o5ew6JdXdHy21zFkpaW4Nc=;
        b=IFhhoGu+M64abnPeiZDAzqKOKytYu/j/DOCTSfKK3hqT/ryiV1Vs33YRGUxrnXgiLT
         XWuHBzhPUUNEE+ke4klLvt7lJMpVlMDFxdyXdCp1zXIZq4xvBQjUT9B/u0GsQZbd/l6D
         BczNw4C9Vq3McNMhhZ7I3MSPJQXvqcmYJaLSiiioJsL3kcx6525uEh380j52n0uxj+D6
         tQjO6HCb0jMVHgiXUVwp+5k1NuhIcB9Dpyyjo8n8og+4UVBXrpjNi/9tT5pujVwRZ9qj
         3RUpKesaV5hDu47nYMxAcSDhjb2ZCrtWmp+EEdZylptKWT/5/Kgb255jxo/889OVQYa4
         HPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149100; x=1695753900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k75qxIvoyjoXO7i5f1b9o5ew6JdXdHy21zFkpaW4Nc=;
        b=qOJgaSO9OdcYkSnXFUD9T/Yf1ThLolccQKK8b2Yk6UDLSo9Kg+eBoeuW4YMKwyuzig
         mhsB2M8UKECwUj14j5ixQIE9ZtTsNJrTsXTrzCEnSmZ84WTATVFHnMpckjHA60yaoEqq
         MjZ6Tkm4l5+Ip1lxmNUvz1wkIhh7sKd4bilqoKqVUGfBL0C9LEwZLQ19vlJTWK0jiCyG
         TX3QfCaJMnJqvN6qFci1XtgGL3SDztx/vh4Usq8f3WpPhqQk5haBqES3Ve/sJnCD17+o
         Na059mdhX9EBTF014Z1q9Rp0x1cQRnAUNUI1Vvtv7Nk35xn9Ic7u7i25ZmAZgH8MFzW5
         VKhQ==
X-Gm-Message-State: AOJu0YxdBwmJJ7vxomLWYqB4fXWnVV4cf83MkF9KnE9Ad2tlUFKITuPQ
        DFQ1Rw8OfvzY2SBRYjIZR/AjVg==
X-Google-Smtp-Source: AGHT+IHIuMItP7ki+ND8LtZC/i6RDtB9Ixd4YfHGOBLKB5Sa0nuvQmvXL4zokBHV2JLJM1FVxjK1Yg==
X-Received: by 2002:a17:90a:f308:b0:26f:4685:5b69 with SMTP id ca8-20020a17090af30800b0026f46855b69mr617613pjb.7.1695149100481;
        Tue, 19 Sep 2023 11:45:00 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090b068500b0026309d57724sm3876846pjz.39.2023.09.19.11.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 11:45:00 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 19 Sep 2023 11:44:31 -0700
Subject: [PATCH v7 2/4] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-optimize_checksum-v7-2-06c7d0ddd5d6@rivosinc.com>
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

