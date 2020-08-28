Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7E255827
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 12:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgH1KAx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 06:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgH1KAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 06:00:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF21C061264;
        Fri, 28 Aug 2020 03:00:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q3so230926pls.11;
        Fri, 28 Aug 2020 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQ1kOxEaL9FVx1zYJ6CutcXNmCnj+fa5P2Lt3GvzHyI=;
        b=bRRBgNBjutZV34MKXKG3E/VwB3IKH7AOxXMifwoUlmRbz0QhDAlR12gCR3RgEp/4kJ
         GHdQnSrAbNR0hYRWAxQJ2UTdupNx3n7YuRnohk7oeBcdDM09JguHSVOUfX2qmpfI7F7+
         u6SNJ+4RfnJrk//q1ccvcWLjfV5ugaWXI7HwDTBw9LQDMrlTpVUkfGveH3lmvTExpQu5
         O4MinePSx7ves2sQvMrRYW4Gz7PEA9nDzz3ThtjN/h3oEsPzaCd0GqRFAPTmhc0NBBu6
         98et6/pdtFvL/SFmG/Wi+MPArcGOyX2UV83ogTXzHMq71tgmKgvXDU62rTcVXUUQxflh
         6Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQ1kOxEaL9FVx1zYJ6CutcXNmCnj+fa5P2Lt3GvzHyI=;
        b=JYeo0lBnxojzo+0DlN32v3jCyI0/TN6kqcM9iica7rfD/NPqITBKBpxO6IWyfobFCV
         tFjBsyzeWT1UO3vcd9A3z4CRrmr1QvEKjSzLbeCwyCn/R5D4Z0Yq+QAv0XLM4FwL/ZlD
         WllLQa4FkCm7x564aqm5n/gAa0xS0SHXUUPF4w0nJ7UKC5eVCu0XQfid7uhPJhBTnm59
         ZmNPuei2EH+7nrmPp+7s2RF7KxRtLiN5a0Zkg///tMXHHxbqNAxnxfDldBWAGeaTmgpu
         pq+P3TrmBJ+qkRoI6rOaS+3gX9WjgadOiH7kMoTc66cVjepXjhMTMf0PeOXkUKkvr5H7
         n77w==
X-Gm-Message-State: AOAM531QAmw/bD6PIDVaIv0Mo1qexr89rNoB8AQs1KMFVKNaaOlN9x7u
        ZvX6FKjK7lKV1cbIb9O3bCg=
X-Google-Smtp-Source: ABdhPJxa/QRl5EZgnlzwuYW8jlGMI75oSzDlqSUeAaqnONi5FlxmVIhKGxJLmK+WQt5JYnUs+sDK6A==
X-Received: by 2002:a17:902:b588:: with SMTP id a8mr712053pls.96.1598608842326;
        Fri, 28 Aug 2020 03:00:42 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id 78sm1068608pfv.200.2020.08.28.03.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:00:41 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2/4] powerpc: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
Date:   Fri, 28 Aug 2020 20:00:20 +1000
Message-Id: <20200828100022.1099682-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200828100022.1099682-1-npiggin@gmail.com>
References: <20200828100022.1099682-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

powerpc uses IPIs in some situations to switch a kernel thread away
from a lazy tlb mm, which is subject to the TLB flushing race
described in the changelog introducing ARCH_WANT_IRQS_OFF_ACTIVATE_MM.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig                   | 1 +
 arch/powerpc/include/asm/mmu_context.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1f48bbfb3ce9..65cb32211574 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -149,6 +149,7 @@ config PPC
 	select ARCH_USE_QUEUED_RWLOCKS		if PPC_QUEUED_SPINLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS	if PPC_QUEUED_SPINLOCKS
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 7f3658a97384..e02aa793420b 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -244,7 +244,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  */
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
-	switch_mm(prev, next, current);
+	switch_mm_irqs_off(prev, next, current);
 }
 
 /* We don't currently use enter_lazy_tlb() for anything */
-- 
2.23.0

