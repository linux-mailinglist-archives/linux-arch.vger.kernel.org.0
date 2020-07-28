Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9A0230038
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 05:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgG1DfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 23:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgG1DfQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 23:35:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF048C061794;
        Mon, 27 Jul 2020 20:35:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t1so25462plq.0;
        Mon, 27 Jul 2020 20:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UmEzZhiPmisvbll7oEJdJkdQLeJHaSjFNwT4kfLFeI=;
        b=NBLIEBziSUKeh73IjmJleu8E8SgNKOIcKBiJPr0MC2P56V7thIUc8GQY2cVLRReF1f
         jofwolDuDOKPAnoFoNN36vVks1/7WpIslDewwf8eHfvFeuUxedsEFHXBLYMWYFx1AEdm
         nYW34dxA2YhoTMMjAp6an0Q/7b6HNgGOqY0fPYycNxAE0qKpMsrefABHPNKNNOIUbjaQ
         QgYcyxeuTJX1/5Wfc7DzrMAt5+hgUe5cmdYuRZlAnm7IjmLa8mgIQ3sxn/APLmY9+XWn
         GAOF5euTRYk3JrHP+ej5JQ/0Rw2tmbXH1PvNs4J7JNiniIG5UPP8/3tOuwLk8dNURNSZ
         U1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UmEzZhiPmisvbll7oEJdJkdQLeJHaSjFNwT4kfLFeI=;
        b=cRyXW4Oh8L5LZhOYF1sA9xD8+BRES5MjIEQR06e8jxzxDC+fbiFYEweWnfdTx+yEdi
         4Rj9RtwrRtmDv/CFnqBjm3aW7COtI4aYWivmd+Lvq3yfmydTus+t6LOhdpf9Mc9F1dHn
         nH9SxWzsM2dEDRYoGDnIIopQsi14WY7eDiJvqA3QgCXkTrnglND+GGTfzYy/EhBPOmUK
         8zDYJ5w8kGpCd+hkFnzBcy/ht/QNqBZ6KqRLWOhlCnO8Is9Crtyj7PlHy5rFcIG47GHP
         k00Bg5D1Ko9RKrcOcm146GF9uQu+WS2CDOXuEyDNRsNjg9gyxikMDkkSJSBHIyM8gPgT
         RQ4A==
X-Gm-Message-State: AOAM531hSk4Th1I9LcxxsbRNT5jqpPRInELhmLnk1uvXQqblHBEc4eAj
        RMrB+1aP0fUpHngRuBXLxxTUXpWF
X-Google-Smtp-Source: ABdhPJyxmfIxm31ZlyLcRWm1fbvoFARyVjQ9SkiBxu4lx9zz6vwRMcmi+fNZuU0y04kQFc06xx4pxw==
X-Received: by 2002:a17:90a:1589:: with SMTP id m9mr2444530pja.122.1595907315336;
        Mon, 27 Jul 2020 20:35:15 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id r4sm998707pji.37.2020.07.27.20.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 20:35:14 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH 15/24] parisc: use asm-generic/mmu_context.h for no-op implementations
Date:   Tue, 28 Jul 2020 13:33:56 +1000
Message-Id: <20200728033405.78469-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200728033405.78469-1-npiggin@gmail.com>
References: <20200728033405.78469-1-npiggin@gmail.com>
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
index 07b89c74abeb..71f8a3679b83 100644
--- a/arch/parisc/include/asm/mmu_context.h
+++ b/arch/parisc/include/asm/mmu_context.h
@@ -8,16 +8,13 @@
 #include <asm/pgalloc.h>
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
@@ -27,6 +24,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+#define destroy_context destroy_context
 static inline void
 destroy_context(struct mm_struct *mm)
 {
@@ -72,8 +70,7 @@ static inline void switch_mm(struct mm_struct *prev,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	/*
@@ -91,4 +88,7 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 
 	switch_mm(prev,next,current);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0

