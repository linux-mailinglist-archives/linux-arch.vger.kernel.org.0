Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0071253272
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHZO4I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgHZOxy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:53:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32939C061756;
        Wed, 26 Aug 2020 07:53:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a8so792956plm.2;
        Wed, 26 Aug 2020 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8+XEx65ih5RYTqzxYTgKflRaIZKD/7jhLd8hvjKhoA=;
        b=FGy4UDYo6m6GBc2xXeUMxJap23UMwNdjY7eL7lGlWn9KfQkpaS6sESmgITWra6DZWm
         /Mi97hnvE4hUwic1kShBHCbSYLi9ZFJsPz03Xeu0qGaYv5HxF2dJqkk3yhQTkdWSFlPp
         th/meyADJ+ihbqDWHsVSOV0gf872gpLJoyNzaA7xYGYJnlkyct+Dmp9VmScC4LHjsit7
         tF0/fMFPxL9KmUBHWldmPbDCLnpMNAHrPrSidGnVKtes9JoAwZfB4HDN7IQCNYoBOgYm
         0EHrvoANNw8g1VgaYJW/DA+RY0dAEcb0xX4JPILHib0sQ4UO26ugArAdKVANsYAp5Q65
         gZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8+XEx65ih5RYTqzxYTgKflRaIZKD/7jhLd8hvjKhoA=;
        b=b6iAWrOswA8tI5bkhXy8q8OvV5N5gWye2yPSStsFjv0KHCO7ZfCaPd+RhFkwcTgdZm
         Hi9KIkI7srxEU6kHjYkaVkUwhe8Wmu9VVcibFmkLvLKT2Q0UwLKYdeUH3y5bIlwHZ8fc
         M5aOYA/NXx7DRy9ib6Sz7WkR+e0l++RcqG4WtAcqP3MBRrMVjJZGIf2ys7HpBbPwq2jP
         fgx4GVmiHPwHjGxBl7pkLy3Yzv2Vro/JipoY/i0NAF/KQ2oX8qLfk5f+NW9rDjWeCKlM
         gWxv2gl2OrUeZ0qid5r9QZOR814kZypUfvRaAWtcWgF/lS9/DxRTmnSobSsdroH0x0wp
         A6JA==
X-Gm-Message-State: AOAM531TLXA/do7NCqr0IHeXMcpn5mAyH7kwlEa4ywChhlYsToyGJTlq
        HoyhKUk4tmv+2vHUGzZVugaM8dr/NVw=
X-Google-Smtp-Source: ABdhPJyqVaB3WiBe6Kt/rHoBpwVXo+qfNE5apFM8ZRbLHw2soLnSS1xm7aEAeYy53WlJjsaefeOdgQ==
X-Received: by 2002:a17:90a:d594:: with SMTP id v20mr6749324pju.227.1598453633587;
        Wed, 26 Aug 2020 07:53:53 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:53:53 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH v2 15/23] parisc: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:41 +1000
Message-Id: <20200826145249.745432-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/parisc/include/asm/mmu_context.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/include/asm/mmu_context.h b/arch/parisc/include/asm/mmu_context.h
index cb5f2f730421..46f8c22c5977 100644
--- a/arch/parisc/include/asm/mmu_context.h
+++ b/arch/parisc/include/asm/mmu_context.h
@@ -7,16 +7,13 @@
 #include <linux/atomic.h>
 #include <asm-generic/mm_hooks.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /* on PA-RISC, we actually have enough contexts to justify an allocator
  * for them.  prumpf */
 
 extern unsigned long alloc_sid(void);
 extern void free_sid(unsigned long);
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -26,6 +23,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+#define destroy_context destroy_context
 static inline void
 destroy_context(struct mm_struct *mm)
 {
@@ -71,8 +69,7 @@ static inline void switch_mm(struct mm_struct *prev,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	/*
@@ -90,4 +87,7 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 
 	switch_mm(prev,next,current);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0

