Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2352590EB
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgIAOli (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgIAOQq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE299C061260;
        Tue,  1 Sep 2020 07:16:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t9so861829pfq.8;
        Tue, 01 Sep 2020 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0vzoL+VsrIPHuqh1rtEB2SuTababb460vueko2jTOo4=;
        b=XxxGJfPETQ7BZiIuZPtIZTdbh7ieNNvvgRcIjzPetj4CA6WlA6eQmTamnSI4ThlLOp
         I7Bwm5vBwBcLIzkRWQszNO5+mqimneWWmxfugSbuIDaZBS1IFgcKiHHRPoGqQ9F0f1Co
         EtKxeYYXyyTeeVAotBk5cJhyUZaR4+HBsL5QEX1us7JCul4yTuZkY6ldhldS6dO979lI
         6GMBbSl5F4bzmlOnmQPmXLMDigRNfA8+tv59CLpLU2rwgaSkfRh0VzP3KXE3IfkGNyw9
         zEyx5WAdD5EPiTaL9zeyWyu9rVYM327qiAvJMWhWZCNi3jRtlhh4RqwMP6Y+qcdURY6h
         n5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0vzoL+VsrIPHuqh1rtEB2SuTababb460vueko2jTOo4=;
        b=Jy8y74+5R27O5h+T6o0x8S5i4Qu/hVE3Egcr6m44BWGoS2C6mk2rZ1UbeC6IGlhWH6
         b+sc8Ev4hIlv/NLjaDLSAWR54QwZt9vjmWr7o9Ms5l6DMKDMLOTQqZ0uofOWHqF2UFSD
         RtXrj6qcs8fu2TMxBGM06AMChtLMnUAL9t3o51iBx4Nffa+9EK6I1HeKWcB57taWMCtE
         KjndyB5X5lPlGuioeFiIJKnH7GL9VyuGgdJMUg4npVFepWJdQEW1cGbIXs6ncwb81WTC
         4hrrcz9w1kKsZNoFPdPmDtngSmgC2zkbs8y+cSCu2L/8GU0Kp0PhzPE+wgriGwEribFA
         mztw==
X-Gm-Message-State: AOAM5309f1hlRTYkWCQ8rENJKI0kF/8KG7texWgyh3PW/y7Rw+aAnSf+
        HvOXQfcT1ao08aE281cgzmYNQezsM3o=
X-Google-Smtp-Source: ABdhPJxhdXGBFtIiSfY5hgzmizcaBGI6SG79Dre9MXBlOMApIf1kkDG0o9XLXTCLh5Pm5ekdjZE4cg==
X-Received: by 2002:a65:5689:: with SMTP id v9mr1729375pgs.271.1598969802057;
        Tue, 01 Sep 2020 07:16:42 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:41 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 14/23] openrisc: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:30 +1000
Message-Id: <20200901141539.1757549-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
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

Please ack or nack if you object to this being mered via
Arnd's tree.

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

