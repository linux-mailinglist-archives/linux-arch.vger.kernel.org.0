Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20B0F1823
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 15:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbfKFOOB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 09:14:01 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36069 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731911AbfKFONj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 09:13:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so3547316wmd.1
        for <linux-arch@vger.kernel.org>; Wed, 06 Nov 2019 06:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0srGooF0rUVSStaoSaPVl4d3tRFVDopwGFjT5DN+Wg=;
        b=Zt7Gm1T+U7ZFk4dp2KJZ4ivQM/cx3tQpRMnDTSvYsTCPaOs14OPmmARgBVQFEc+lD0
         wYz0WNdI63E1W72X/zcnwS74mw7NVDXzTtQkjtu03sHH5Tm2+jJJn8rorasVu2SPgGSa
         FXCvlLKDVIhnLqiwjxdmyrineQ1dQ8I/2Byaia80R9wHg/FW+fui6G2yTLgOEMsGu+94
         M+8Z2PiVw8Kk3wLLnI9gVlIlrXpzhhk5KjTYVkMAqTNit8YehzmBakPJCHH0g0XOT5+r
         EvOn6Zv32u5W8323sPpA6JDD/iM0DyWGqIGVDMHA+zaXXVcYLV1HROnbbjEYRp4JYyfT
         BHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0srGooF0rUVSStaoSaPVl4d3tRFVDopwGFjT5DN+Wg=;
        b=UjGa6TUjhuRBrtMT7h1S/KMCusjHDDTInTsl+PCIw4nVB3Xh7/m/8lHvmPstulFWDk
         4/Qt+sCjY1tVKrc2vL4bAy0EbJ1TA1koBD4d8P+e2vNJW42/m+JraYER9FyUhA9Nfe7T
         yedlyMIgHK0z3ChTGwbH5nL1ZCkEFsTYi3xpscII+G+AEh6AdP4X+SdG/ljAiqzrU2ae
         XZ3rvvsDL7e+CNm3GRBa/SRpczwwblbVIaWsPl+cRmWgiO520tMcA5T83f9yY8yOn96x
         fOxbwwXj4gtBQ2NofNgfqcMJJi5gSggNYDMzUa1DsiLhdqaBXpTmbjTb7dExq/wWPjvq
         9m7w==
X-Gm-Message-State: APjAAAV5bD2jVe61HVvA9gZw4taRe2fVOWowlxkoLv1QFitQfM2Utf6y
        ZO0O85JmFiyDLQ/0K0ZdP0yQbFd32IoFQQ==
X-Google-Smtp-Source: APXvYqxNBDVKYhSw+hLyjEH+eUfDn+GxBE+Ubwz+XzjWaTbr9XmBN5lE9yxYUoj4EN0dp1g806RW4w==
X-Received: by 2002:a1c:2b82:: with SMTP id r124mr2757815wmr.112.1573049617471;
        Wed, 06 Nov 2019 06:13:37 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:37 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 09/10] powerpc: Mark archrandom.h functions __must_check
Date:   Wed,  6 Nov 2019 15:13:07 +0100
Message-Id: <20191106141308.30535-10-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We must not use the pointer output without validating the
success of the random read.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 arch/powerpc/include/asm/archrandom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 7766812e2355..60b8ad798743 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -6,17 +6,17 @@
 
 #include <asm/machdep.h>
 
-static inline bool arch_get_random_long(unsigned long *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_int(unsigned int *v)
+static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_seed_long(unsigned long *v)
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
 	if (ppc_md.get_random_seed)
 		return ppc_md.get_random_seed(v);
@@ -24,7 +24,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
 	return false;
 }
 
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	unsigned long val;
 	bool rc;
-- 
2.17.1

