Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677F5253273
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHZO4I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgHZOyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:54:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D100C061574;
        Wed, 26 Aug 2020 07:54:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kx11so973822pjb.5;
        Wed, 26 Aug 2020 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CT6s1M0q19YFhy+cBpQPX3nn1CscA8mpaTfBdcn8vdo=;
        b=u9wJQQt5hW3qa3ya9qPXmEQyMDTWMQZHbSO3RwJdp2sKyqS30CDXWxqirn98P9bvjq
         5k9b4obnh5IAZeF3n7nfI5cHz7FVY+P1pluo2c6rNimHuQV8OYtaeX/V4Cced3rL7xFH
         NCmQH0Rh0EknPo8Tvnt6+BRX7xfXxLWINB6359wCNE+lf1Khs+fny6WA4kqbxPx7sPP2
         4Wu6b2bDlHb8ThVwsTbMsR4G4gOOz15ZBN+OjgIx4lyrvVzbF9xPrFpaYgkafvJyfa3m
         0kzpltobbXHAvhfSdg/A1z2zfQnA54cJJtn0xYgsVjEazuZMO04Q6WmKCtnX2fM2uoeQ
         xN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CT6s1M0q19YFhy+cBpQPX3nn1CscA8mpaTfBdcn8vdo=;
        b=XSpH4Ujdth5XR5wRmjVWM/8Ng6l6uSnjMYduhaphXl5VMHkzsMxXX1R0E0Gw1/oCf8
         jBP41LuUdbbWbVNV6QQ911GxAT1bA8maNqhAMEn+/Ww5qm8C29yoLU5GO77Vno8Tpls5
         /4zncNVxpbJc7w8633/R4+59Hp3pvqlZDNUiIqRxes4qo28Ah0wnKIFkZai15gI2hgHU
         18mJXbbhTTkHb9MWplNzAvoOcDUq8nqktyqa4Fjm0lxGi/8yJQQn3FFCp/hd06x4o08N
         fhI+AmiVZwlLLSgzOzw+PUqlAtCVsdKJLJ3cj1zFIlh7r4CaO66Iy0QyDAcRDpJ9t9ZN
         FCvg==
X-Gm-Message-State: AOAM531BTo9YYHPPd40s6o+ny0n68aw5NtRDMIys0WZj0QGUwO+wspky
        uEJiaiy+kvJ7hI9LSdbU/+O/u24vNAg=
X-Google-Smtp-Source: ABdhPJxvkuoGl75ZVpNr1RgzK005jvzedZlnd2QDmA+7r0p3ng9I2IdwjyZLrFMe98sls8FJaqrpYA==
X-Received: by 2002:a17:902:c395:: with SMTP id g21mr12112718plg.264.1598453642763;
        Wed, 26 Aug 2020 07:54:02 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:54:02 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v2 17/23] riscv: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:43 +1000
Message-Id: <20200826145249.745432-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/riscv/include/asm/mmu_context.h | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 67c463812e2d..250defa06f3a 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -13,34 +13,16 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *task)
-{
-}
-
-/* Initialize context-related info for a new mm_struct */
-static inline int init_new_context(struct task_struct *task,
-	struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task);
 
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
 			       struct mm_struct *next)
 {
 	switch_mm(prev, next, NULL);
 }
 
-static inline void deactivate_mm(struct task_struct *task,
-	struct mm_struct *mm)
-{
-}
+#include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
-- 
2.23.0

