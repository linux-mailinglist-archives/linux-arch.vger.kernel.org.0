Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D496E2AEF2C
	for <lists+linux-arch@lfdr.de>; Wed, 11 Nov 2020 12:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKKLHm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Nov 2020 06:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgKKLHl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Nov 2020 06:07:41 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21CC0613D1;
        Wed, 11 Nov 2020 03:07:41 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id k7so805731plk.3;
        Wed, 11 Nov 2020 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9QuJLEjIPLpDeuvL6cggUWm+kIo+T8XFZuMVw3L5OE=;
        b=eGYwfQVYMWlAeg1rJiTF6BgSFNuFxWfjnStIkSCh3ghGiJ5LRQ4+acK9lN8qdE+YHi
         KRGeNNjgbVzznUCqy9/CLybZMT9+o5cOykz8iBxcZSJ6bDFNbL/81S8/WhKwejAjt1uR
         57hjA36rzhWWwof23dU+U+Id5oDepo2753RBTq9PF2+mwbKcPhNLuTrIibXVJcqXOorH
         5uNA1Iili2Rxg+H5NxyIIB6cu7EfXSSCnGIe9fminLaYZ7SL+GXp2SIQ+FJG4m+yCIBy
         y2HtxDSDPDayXiDd7W3Yxr8MHZAybkTVZD9PMIXbCm8svJDZSoh2j7TL9K33XfemsfOy
         NJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9QuJLEjIPLpDeuvL6cggUWm+kIo+T8XFZuMVw3L5OE=;
        b=iVZpvwmy4nH4bjXn6MTlYFHMGMqOn1tNPC3JCrTy8ZgqrFLSnjLE+H5ME/Iu1FrcTA
         7F4POfCLaLC6ZexzXi0OulKJQi3TBGmm+nvRGnq0MZFYkkKp5wnfp0CN863O4TUZk8a3
         9XSr7vwYnScbIh6KKW7cjARD3bsRoVQAr3XKUCk5gSqmY9ejhBFbknm8V6vyJFKsKKiF
         nm+6aY9nRfJWA3qjeDfxg1YvHd71zRs1ZlP0WfUCJGLFL7ZsOhvz8Zyc3/y8OwzMPHCV
         LcYmOMhpuffTB4l785Tx9v0eYA6A3WDlVi5ni/rxyk6Cw0XhSW7B1issyq+4Ile1pBSR
         DOqQ==
X-Gm-Message-State: AOAM5311//TFzQWLmmgceuEvcOmmQ3AMn/F5CLZNTBFDvuXpzYRI+0kH
        IYLlgy4iyn6UgLOOke9VF2c=
X-Google-Smtp-Source: ABdhPJwaXv990DxU17tDbiasD9ZoY0rRxQ452QK0z4AJVdpOnJ0xgah0UQo8IYOY/9879g2TvzstLQ==
X-Received: by 2002:a17:902:fe81:b029:d6:8677:6741 with SMTP id x1-20020a170902fe81b02900d686776741mr20695174plm.79.1605092861472;
        Wed, 11 Nov 2020 03:07:41 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
        by smtp.gmail.com with ESMTPSA id 9sm2154943pfp.102.2020.11.11.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 03:07:41 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/3] powerpc/64s/iommu: don't use atomic_ function on atomic64_t type
Date:   Wed, 11 Nov 2020 21:07:22 +1000
Message-Id: <20201111110723.3148665-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201111110723.3148665-1-npiggin@gmail.com>
References: <20201111110723.3148665-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/book3s64/iommu_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
index 563faa10bb66..685d7bb3d26f 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -263,7 +263,7 @@ long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 		goto unlock_exit;
 
 	/* Are there still mappings? */
-	if (atomic_cmpxchg(&mem->mapped, 1, 0) != 1) {
+	if (atomic64_cmpxchg(&mem->mapped, 1, 0) != 1) {
 		++mem->used;
 		ret = -EBUSY;
 		goto unlock_exit;
-- 
2.23.0

