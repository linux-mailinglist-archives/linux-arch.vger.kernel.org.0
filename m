Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04590230024
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgG1Den (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgG1Dem (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:34:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58AC061794;
        Mon, 27 Jul 2020 20:34:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so10190283pfu.1;
        Mon, 27 Jul 2020 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CJ5pLUNj5CNYiJwzkvMW2lqb7Q/oa/023gCjAl7Yjo=;
        b=Vc3EuyrtZlTxBVYXaWLv4HsOBpE/JC48K5IOkbUrzdd1iuoTif1YkuuIkaxDOly59V
         141KydHb6s1o11WJolYISeqKXd2TVmTgB1OoU24xAQjETivwJWCCcP6XWhJyZMSOuuGO
         X0hG6b+9gV5qqgl4Wk1CE3lZiTQTT3EaSLFgG1X61P/T5J2Ea3kuYyygTDlgyQt3gGLD
         7v2q4qyUeCNBQMAfSEU0mSO0W0WP+OpjeuM6szp63gXLI/iyCNVH/zNuF+xIXRv9IRN5
         G20TbqJ2sxbepnQI1zVm4PTwSO/LWJd3QhIv9TEwC21BtlZ2F5UZzxHAvXW2tlx1s0On
         BPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CJ5pLUNj5CNYiJwzkvMW2lqb7Q/oa/023gCjAl7Yjo=;
        b=GLQNDdxI6Rr5azx+dD8Uv5RubQUDhEpnWxuJXcwEzbN7DHot8Rsnp/dbyu/eLhIgqA
         Pe716RoeXFhtuxKxYOultYE9uhlY/dcUw+UUrPcwkxa+KVjFBj1MD2a6Ty88GksNCa+Z
         hUOnPPUrFcAGdCiINY8OJ3CqKCFbI+cimEMzCbIKB4vZ1t8hrzOp5cL9ffov8sMa0RRq
         CLiS91UNnDD3Rv2yOuqhYFQBgF4ji8bVyo/M6hNQV/XKGgFn6Im2O+yR6flUBdQnlN4e
         Se0Ow8zoAQbPZbwI9JbfmXiw4dGefRlUgvTOUp628BLRq/pNVrdaS13R9e9xMFRARRy2
         jXqA==
X-Gm-Message-State: AOAM530AGBNlRld9rZXxFXbF/2gZ8+Du7ye8iDvZjlnQPZsmlXBKOedf
        /tZZVmmoYQaYysYn0imkh2hH+Koq
X-Google-Smtp-Source: ABdhPJwlYuThuwrcQ4rOZSpcW7L1u70L9KCqBU3RF2TC1IQonzCv4DT+AGzLtfUsDAICSgXhJXLo/A==
X-Received: by 2002:a05:6a00:224f:: with SMTP id i15mr23996525pfu.241.1595907281973;
        Mon, 27 Jul 2020 20:34:41 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:34:41 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH 06/24] csky: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:47 +1000
Message-Id: <20200728033405.78469-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/csky/include/asm/mmu_context.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index abdf1f1cb6ec..b227d29393a8 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -24,11 +24,6 @@
 #define cpu_asid(mm)		(atomic64_read(&mm->context.asid) & ASID_MASK)
 
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.asid, 0); 0; })
-#define activate_mm(prev,next)		switch_mm(prev, next, current)
-
-#define destroy_context(mm)		do {} while (0)
-#define enter_lazy_tlb(mm, tsk)		do {} while (0)
-#define deactivate_mm(tsk, mm)		do {} while (0)
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
@@ -46,4 +41,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	flush_icache_deferred(next);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif /* __ASM_CSKY_MMU_CONTEXT_H */
-- 
2.23.0

