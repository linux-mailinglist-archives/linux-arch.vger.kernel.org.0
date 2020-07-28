Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860EC230047
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgG1Dfm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgG1Dfl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A3C061794;
        Mon, 27 Jul 2020 20:35:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e22so3589017pjt.3;
        Mon, 27 Jul 2020 20:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLftXOcS4N1axvHYvNR3psZ5Pupt2KMXRpE+cNBZQz4=;
        b=XTAT2W9xVAEdxPx12CzvhppNlwZ0hzt/SYaFY5rJ3dCSKLOLR8CAqSHIFuVlt7/Xb6
         F9Fn2vkw4pUXDtNDLPFSMplefchB6IyCS6P8/rHX5bm05R+8tTqZD5N3RjoQ9fI8PKAV
         zTw3u3P6oJZ3p4H8gwlGGEQY4hjYdxGNh7S2tVeO20P6twAjpGXDyfdBDZu5YYJVr8Rs
         s46y6s3J25x60ZZmownnjaSZD0IBunDLLqdY4Cg1PHWbjTcTnuxI/1cXzVRNtyEISVll
         +8dO3wmxUxXTDI8UzjNrMZrcxH9pF7jwn7BZKN33ci/Ztgp1pQd5HdJl85YgMkk0L8w4
         1o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLftXOcS4N1axvHYvNR3psZ5Pupt2KMXRpE+cNBZQz4=;
        b=Wpi4EiK5rm4w2lu77bW1fVLknlc/+FYtbfKovPFDmp2k/aQRHA8jB7/37jRYnVIQi1
         K2SmxcSzhSGGXP8wn94kNuZ64cv1Qavvw1abHsI3ihXB963K9R34+/eNC3xoEfiwnajJ
         B6JguQU1OmAE6lwOAcdOAxPk6gDOgmpOi0/FZNM7UUBYH3ceKFxfbYOCARt3SZ4gztJm
         a2rQY7Hfd+w2Ask7BfSkhvhzMukKDUtcPyvPYFZ90moEADnSGDrrb+o9iNmJktO6m0ul
         0R2TZr4ItYuz9vtc0nXcWC8PVUJ8i4p8IQvnmSZE0uoXNrmYuck3kyUrraf69OP4uA+0
         rUYQ==
X-Gm-Message-State: AOAM531W2BIprS6OPKKM/44MJwJ87/byxvJIfLZUDtGK2PeYlAdkCbyf
        7hxdyD8fl4pJLmDPLrFjotKNquEf
X-Google-Smtp-Source: ABdhPJwXQjQ8pz3kBBmkwoCFV2YejbrW7QrgMg3M669wPuvfWrlPdTisJntkLY193QGFUj3UCsVvPA==
X-Received: by 2002:a17:90a:d249:: with SMTP id o9mr2215860pjw.233.1595907341037;
        Mon, 27 Jul 2020 20:35:41 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:40 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH 21/24] um: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:34:02 +1000
Message-Id: <20200728033405.78469-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/um/include/asm/mmu_context.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 17ddd4edf875..f8a100770691 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -37,10 +37,9 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
  * end asm-generic/mm_hooks.h functions
  */
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 extern void force_flush_all(void);
 
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 {
 	/*
@@ -66,13 +65,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	}
 }
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, 
-				  struct task_struct *tsk)
-{
-}
-
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
 
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0

