Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810E42683C6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgINEw4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 00:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgINEwq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 00:52:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD97BC061787;
        Sun, 13 Sep 2020 21:52:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so10521018pgo.13;
        Sun, 13 Sep 2020 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhSlIbBbaKajKS/IeKMTbHGZ3Q2g5fhRWyCc6GgGFOw=;
        b=ZhI/Ifh3Hh6S9ezSZcFBjkvaYu4u3PPYdLMSfBHM9LS26Zi7yErlcuHKgA3qBwnTfV
         iGDS/wM/bY3O58Mf9zXr4CxP6mSXYPzQgzApyoZV2tEVf9gLml7tNnK38HNgZ9lhZ1PJ
         O/UmN55TOjc2KeHwMoARlpP1+PF+6o7rHRkXoljfAxCOBNXpYx5t3IZz46zUM3pG8DuF
         GExC97I0wWEvqfV3A1vzgIZUAUrYlPpZAi9y12aoahe8F0r4WS6opEhiQVoBywwgh1vW
         kd74xEfqE4D83mFc0YL7uL6vFIp+rLW+oHi7rtFTbHgufUqXHYwzY4kr7WBnW0BHfBbx
         zhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhSlIbBbaKajKS/IeKMTbHGZ3Q2g5fhRWyCc6GgGFOw=;
        b=oQW5R/YBs+EeCGNF8NQiDTYtqXN7hgozjIBT1op3NUSFtZ76hescDHTUZ1xeGxPyIq
         ILaiN05y0hwcNK7/yAzUF/iyLdQhwXaQfWyjPklQXcv3D7xXTw7sFMSlCw6q3z4tUQaS
         A3Z4JVoI1H4F48EdJeUq2UT0sLHWHrnVSzALvb/2kfTM6zca5Gjxjd/84mfqkuNasR/+
         +T1NMFbXvQ8/ObVnaOAmRXXe0Rgse2+3wQC2Bw/yD35gFYrFMLQg/wSKe7jo7M49XiRL
         Xgf+KN9KRRonevggOTwwhsn4J3cpysCuKOd0530wz/AFO8AMXUhZb+7pbUZjDqh/SWjx
         eYMQ==
X-Gm-Message-State: AOAM5307wVvnbskwad4/txTLyg7dwcK/3DtqDOYM9YNGpR402O6Gpl54
        wGfQQw6tgKtOdn94oJ6iFX0=
X-Google-Smtp-Source: ABdhPJxbiaPuklpxkmh3T4+ZXi9ibcsoZFsVvSnpom8ez8y/HozIvGy1egzT8jlrpKnmg5m7ICoLVQ==
X-Received: by 2002:a17:902:7883:: with SMTP id q3mr840986pll.117.1600059165913;
        Sun, 13 Sep 2020 21:52:45 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id a13sm6945312pgq.41.2020.09.13.21.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 21:52:45 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     "linux-mm @ kvack . org" <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v2 2/4] powerpc: select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
Date:   Mon, 14 Sep 2020 14:52:17 +1000
Message-Id: <20200914045219.3736466-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200914045219.3736466-1-npiggin@gmail.com>
References: <20200914045219.3736466-1-npiggin@gmail.com>
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
index 65bed1fdeaad..587ba8352d01 100644
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
index a3a12a8341b2..b42813359f49 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -244,7 +244,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
-	switch_mm(prev, next, current);
+	switch_mm_irqs_off(prev, next, current);
 }
 
 /* We don't currently use enter_lazy_tlb() for anything */
-- 
2.23.0

