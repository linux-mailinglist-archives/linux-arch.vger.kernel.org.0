Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B410B253244
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHZOx5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgHZOxu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E73C061574;
        Wed, 26 Aug 2020 07:53:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q3so1005715pls.11;
        Wed, 26 Aug 2020 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TcbxX+lW5qgeFyGHy3Sgew1O8jaIFOQUWGSD9fmh4Ds=;
        b=q6an9A4xnvWqk3kD2Ahthf2EBYHipvLOJq8gjmXpTdU04Nb3S0hQP/tdZJTVPB7Joq
         XC8ygVnKRZGdRLkl49eU+TNhLdVAdDiyLUgS6CwO0WwOWKgFRtDvkpYeg4/QTuxVVxMR
         VONWRTlBOJd+PhC/tDxD26+EDSkLdSTR4HxFZzt8wfkhxZ7wdbW2ZmbBlq4BlH8CT5ud
         v/9wvVpl7dYLBm6CK6vdLN6Ino1ljMHl3uUsqcdG/mukXHoW9fcHwjQn1+m4sm8eiesc
         xBr/J/RV0sgRv/bTpbQXVo3EXoECA/odOegWY8UDepBWkdlD1HoKruo+lyujzOPtRV/j
         4hsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TcbxX+lW5qgeFyGHy3Sgew1O8jaIFOQUWGSD9fmh4Ds=;
        b=WdyGUIkhhG8JNJFrP5AcyOA+M/G9aM56Qqe64/bJ7e0uWzN6FVkweU8KCIJKMbkIlA
         m4xn6iCTow2FLNRsorfwUW9BK5/sgJsetC0m/9fnvR5Ehn4NZ8cs6UCImGxNq2O0mACv
         rdQVOre8MIh0jxpeHZED5WDiALmggJdYsORP8Pe+U6Ne1d4g51VNO9rsl+pYeGWknXqJ
         bawM544jTZRRarwrTUsmJ8VhHXXPvoaVmGdGLBQrV4zJYh+amRySHTe0rsDWQYTWojat
         9FWc/5nHrkkRMbQnKHi7OGjsSBcKBlpEq74lJLJQ4QUo3OWhGfR47edlPG6XF7W2MNXg
         qO7w==
X-Gm-Message-State: AOAM531C2ZrAMA2Faj/zFhM96W40sMvtzavNMhQenPAgTR80pCMeHb4L
        1T76zkdAgkW6hurZsVq4/TjKTpoOshU=
X-Google-Smtp-Source: ABdhPJzN+aMSyEY8aUnGBKztdrqgQqKNljAox7LWDC4FKdqEOI7IHNbzRh50th/9lmPgjJlxGrT0sA==
X-Received: by 2002:a17:90a:5298:: with SMTP id w24mr6075538pjh.221.1598453629825;
        Wed, 26 Aug 2020 07:53:49 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:49 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 14/23] openrisc: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:40 +1000
Message-Id: <20200826145249.745432-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/openrisc/include/asm/mmu_context.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/openrisc/include/asm/mmu_context.h b/arch/openrisc/include/asm/mmu_context.h
index ced577542e29..a6702384c77d 100644
--- a/arch/openrisc/include/asm/mmu_context.h
+++ b/arch/openrisc/include/asm/mmu_context.h
@@ -17,13 +17,13 @@
 
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		      struct task_struct *tsk);
 
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 #define activate_mm(prev, next) switch_mm((prev), (next), NULL)
 
 /* current active pgd - this is similar to other processors pgd
@@ -32,8 +32,6 @@ extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fault.c */
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
+#include <asm-generic/mmu_context.h>
 
 #endif
-- 
2.23.0

