Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FAD7DD991
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 01:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbjKAATa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 20:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345063AbjKAATP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 20:19:15 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3EFF5
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 17:19:13 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b512dd7d5bso4312987b6e.1
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698797952; x=1699402752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed3AceHMZkBHW3Y7G0fWRXKUFOz+aro++Yp4kYAVXuk=;
        b=b3wrNZMigBwzBB3l8ZnunB5lH/gUOTU2Y8snqzkVKaDFBMGoV2sJhzUsQ9o3PkgQqg
         vM9jekAH2ZzZ7IdNreldtwnvaYPpoig/GvTFtItqh7S5YVM0MEMscd1F6NjCH6qZ3h8O
         9aBchPyc9HkYezwwEQAJyIdLI59l1wmpYEP4644NQkQXwaiSzBh/Oe+xoJwzLeeJdHoT
         2gO122+WdzbaFG32iZPRO9VlJCQyplRdO63wLiP74anWSmNBURPA6v3AB8Tayc3SS7Hd
         rEYvlrTTbSY4FnZKdYIyOqzF6gi+1Z4HyqBxXvxfrXzmwcUJegtWQ0vMNKsJ9i1LSq/u
         EgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698797952; x=1699402752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed3AceHMZkBHW3Y7G0fWRXKUFOz+aro++Yp4kYAVXuk=;
        b=FEXnIvc+rrLrGZf+nzeVuaGHOZcKJX335ukEASJpRVe6pM4vrK1uvPIlxK8GWfiVLt
         IMV19UCqCXaDyYT5ZlDTEtUDB6vTlnVWfPAKQ7WeO5ZqnQ0pnYwfLJUXHeAJDV0fhovs
         rL8cQ/vzoyYmfu/b2MiCjc9Ivg+bO2esDcicucjDdFnOwzqC3zFYPxgjLUNj7Vs75kDB
         N34m52P9jCGcprIrH8K0ypKrQJdtg6O+jjNhpPNMnujiv3hgU1rtT7ALpFvl+MxcrNqg
         Dfv0Fu1YeC/sNtbiVLAC+lVq4a6oPf6g8xgvjrv3bAT+BTS6zLFyCLw8pvwGJ6w+zkvz
         XyMw==
X-Gm-Message-State: AOJu0Yz7NWvDiXlO9JKdMyoCo6tHJ1tz7jgRlXhGJbzAygoX/hxvFoX+
        mI6ulLzvV5boajbvAohbbGokQg==
X-Google-Smtp-Source: AGHT+IEB78/S9W6MdSMygN0kmC+MuUDJddUs0YHy5/K3oMHwNtqdO89EEGoqfKE4JXDSmVHIACKBbg==
X-Received: by 2002:a05:6808:1293:b0:3b0:daf8:954 with SMTP id a19-20020a056808129300b003b0daf80954mr20274613oiw.49.1698797952751;
        Tue, 31 Oct 2023 17:19:12 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n21-20020aca2415000000b003af638fd8e4sm65309oic.55.2023.10.31.17.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:19:12 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 31 Oct 2023 17:18:53 -0700
Subject: [PATCH v9 3/5] riscv: Checksum header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-optimize_checksum-v9-3-ea018e69b229@rivosinc.com>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
In-Reply-To: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
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

