Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66FA259100
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgIAOnX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgIAOQg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E73C06125E;
        Tue,  1 Sep 2020 07:16:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so149277plp.1;
        Tue, 01 Sep 2020 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84583yIct+fNxRagU/I0oUzZetXb7oFAI3KOXHJQqUA=;
        b=GU7uDdqVLUXKlAy3ozm0T+bJe+nzKjD23SlxSVkft4wTgJRBROxw7gJGPyomn8qCwH
         u/cEKVj5SDdbQtMOphIetJLDAXtVhGEVZYMjphPH4q2SjibPLqfI6aH4tu0nWrhJfrVT
         h+KHgrPqM9JGdcOd38ddmSABNGjq6eHsvwlZrukUBwxIQxqkW96szQrDOlrA0KEB1RxL
         ATvyadvYsOzbc0e9JCQ2hxmfvjHCp286ulKqOps1nhFNRdnEZzxUukT/XiUyojXwTmCx
         ip76YWxjruQL6DgAdQyS5JZwqmcfv7f07ZD11p6WJqYYcFCCGuMr6V4niCSWI5Ydk+yS
         gd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84583yIct+fNxRagU/I0oUzZetXb7oFAI3KOXHJQqUA=;
        b=VxrYEVSAhN9V8k6wYM3hYEuzXWmATtU8CHGFfg5NlCQPP/0rWEQCIMHA+xWkZ8tUND
         Sfhhacxlkcibhos95u6jEgZiTX2hto6myBDO4AFh8qPtydoFKw8+BQv6hpUcNYXUv49s
         rL1d2fogUQ9iKcTzNzaN/3RbRHQ1DCSmCjhWYmRNDktIbQcT8WLd85HMc552tTaH3cS+
         Vs1reZTeNGyqeqbgBGjLMpBmk8TyL2zZQGdg2wmRnENXKRuEMaG6hUNf4aWZtoSHl6be
         cs10KrQdWrjjUivNMQpKF8F7qvb6vhp5a957vks6gcg+4jad1+nNcQqUC/Rucm/QDopv
         ziOQ==
X-Gm-Message-State: AOAM530TbpH0EJMoviG1Ev1sarXkt/dtcs2twozNv4BleP/CCCq0v+Gl
        1Q9o2GiOgk9RqpZffUQ/MNZbJxQw6tk=
X-Google-Smtp-Source: ABdhPJwajm1nSgccZzMMxt7Yj7FhrjQ9hT6dRyc0q9bLokojEP4AQzrC4eZEP48WKDdjvYfQFasvFg==
X-Received: by 2002:a17:90b:4b89:: with SMTP id lr9mr1848777pjb.126.1598969794412;
        Tue, 01 Sep 2020 07:16:34 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:34 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v3 12/23] nds32: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:28 +1000
Message-Id: <20200901141539.1757549-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Nick Hu <nickhu@andestech.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Acked-by: Greentime Hu <green.hu@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/nds32/include/asm/mmu_context.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/asm/mmu_context.h
index b8fd3d189fdc..c651bc8cacdc 100644
--- a/arch/nds32/include/asm/mmu_context.h
+++ b/arch/nds32/include/asm/mmu_context.h
@@ -9,6 +9,7 @@
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -16,8 +17,6 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
-#define destroy_context(mm)	do { } while(0)
-
 #define CID_BITS	9
 extern spinlock_t cid_lock;
 extern unsigned int cpu_last_cid;
@@ -47,10 +46,6 @@ static inline void check_context(struct mm_struct *mm)
 		__new_context(mm);
 }
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
@@ -62,7 +57,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	}
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, NULL)
+#include <asm-generic/mmu_context.h>
 
 #endif
-- 
2.23.0

