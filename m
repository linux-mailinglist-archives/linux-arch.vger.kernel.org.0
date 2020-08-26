Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108A0253268
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHZOzT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgHZOyT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:54:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFC9C061574;
        Wed, 26 Aug 2020 07:54:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ls14so977339pjb.3;
        Wed, 26 Aug 2020 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLftXOcS4N1axvHYvNR3psZ5Pupt2KMXRpE+cNBZQz4=;
        b=h+8as9tlv5ux5IQCqr3hscD6N/pmC+Wc6VPju2QFl5v6kzwYhPJO8RsIQeyHOC1fVz
         QUYdiNwWE4QXeckcOsqZG69lZPhwPQDudhfDHA1FP9NTmIO0H+IX1WhmIdK+AGVzIIGg
         Or4/4wk1ovFXTUAZ3toDQIJaDHtFE3g3ML9dw/autaPYxIqbhomd8G7KuJ71s2d+72E5
         o/du8hS0FBQ8RrHQ2AdwV7bpyG2xmiGu+yWLrmMiirIZMzRI80FeKjrxehK9LBFqMaUT
         cTUB3tFOIqrTt9ve2dUNm8QuGY3LfiVxWte5OaYHMIjBIpU53SOb+1NaYg/N3Q1DMB55
         T0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLftXOcS4N1axvHYvNR3psZ5Pupt2KMXRpE+cNBZQz4=;
        b=HSXAP1OOutvsrZgP7oZZC3MJVkVT2bXa7ABuGdI+b2Z6jWc8AHKCX5JgH1ufFCBnuD
         AaIH9AP+C9a5b3ay+HovUlyw05vR4LnRU5F+yg31ZrBSci20CYrrbbI9rmeGMx4sa+oP
         omF+eMV9nlR091q4S4f4Iw5kdJo+pzLMH/PkYXLw+/1ozJHrDD5QqBOVk4eEPVbCeZ4M
         kA+/f5Hzhm8ZW5x+dHyHZIvahP+M87XO5B8UF1F7wH1EI7a5cFD9xki5nmpEDkLHsAGM
         WREdFqSYKVUwyvQ257+RdYD20YFPqWNo35YJvpSx87vq2vOAjzo3M9lvKJ+xfwvJIk4C
         YP6Q==
X-Gm-Message-State: AOAM532KNys9gklqaEbG+iT9xi5hiqrILgjcBH0ooucP0M/5c17k52vw
        4n4GxXLpdxlKAJ5ZcCWE5nL3JxvSXN8=
X-Google-Smtp-Source: ABdhPJxeCSFNxaEs0Oh6/0xBgDvajE9o11K0FGBreVXQ5pkS9c155AGVPSg8XPWxEkMerUrM1eKtEA==
X-Received: by 2002:a17:90a:4586:: with SMTP id v6mr5935973pjg.152.1598453658525;
        Wed, 26 Aug 2020 07:54:18 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id r7sm3327140pfl.186.2020.08.26.07.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:54:18 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH v2 21/23] um: use asm-generic/mmu_context.h for no-op implementations
Date:   Thu, 27 Aug 2020 00:52:47 +1000
Message-Id: <20200826145249.745432-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200826145249.745432-1-npiggin@gmail.com>
References: <20200826145249.745432-1-npiggin@gmail.com>
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

