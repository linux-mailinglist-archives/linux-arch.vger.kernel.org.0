Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848192C72A8
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgK1VuO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgK1Sc6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:32:58 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D71C0258FD;
        Sat, 28 Nov 2020 08:02:24 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so7069895pfg.12;
        Sat, 28 Nov 2020 08:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qp8PGJSLWU/dwswnH2/0kSDHsb+wln5XeqPaVW1B5Z8=;
        b=ssXbLd8YUR2ZIFy9Jd8hXHpF+Y+ZgoHlIRFX9zhsrsp+ZLU7bKlg7EuG2lSdedrjvR
         wE/qE7l+MWwYSzP1wi8Op9LZacYNj0TFM33blDINJeQw3k661TnuMoVq1P9kWsUpYm2L
         GU+Rh70ojG5i/bX6AWDs/ACxCKMtupmq6KLpdZta42wvOGpj65dxqcLBcKS1XebjeT2g
         HWp9e3wV/L0EXL2Ys40bmy1FkuapWC6KRItPGmNgSBbEo8WylcMXRQEawZThlVjdjrJU
         +e772jc+1LXeLO7pSn+jmxQ4ISH3MsydjpyvNtpmhbzBrVbHsQbAlOUzcGpBsv2LoBoI
         u0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qp8PGJSLWU/dwswnH2/0kSDHsb+wln5XeqPaVW1B5Z8=;
        b=Zd27p6H1b6AdNbJ4h0ROjRl6iMfZyJ7AaRshxf09pY5VlP/LI5L1jcxkYT750vbbLC
         PRu5SOdT43r427VARWZOt6XnaAxcMFKzVlu0aUUEo/AjThoqMAiZ+nKKJUKOE/iOkB0a
         7LZq4DexkZQ5VBMScxugNFO4WTAufPdtu3DWlr9AJhzmhW15VYbzv68u5chQaHcnkrOB
         5x/IUI7I1WqlXbq/wLe8IVncF9T36L/hNKlzthPBddLQm6a3+HPi475s1JmGJEDX5G3L
         aXVBn88R7irkjYM/MdgHfghmMiYOLsGbDzlywlSV9Etq/55vXQACVuY7bbrgJ0QvA/st
         6Dcg==
X-Gm-Message-State: AOAM533J6jJ/VPyHD5jwNDbr+VRSC+UyWBKSgierbt0/BBlbuU0ezsd3
        VYKTryY8snH6QGDbbl1JDkwki9A+MLo=
X-Google-Smtp-Source: ABdhPJw9UtKcgVJk5VujOdxJVrz6MfFXjvC+/8I9Mi89OeiWtMkzRMjtujCg4EGW63Zc1A5/CzokHQ==
X-Received: by 2002:a63:4956:: with SMTP id y22mr11011753pgk.266.1606579343363;
        Sat, 28 Nov 2020 08:02:23 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:02:23 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 7/8] powerpc: use lazy mm refcount helper functions
Date:   Sun, 29 Nov 2020 02:01:40 +1000
Message-Id: <20201128160141.1003903-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128160141.1003903-1-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use _lazy_tlb functions for lazy mm refcounting in powerpc, to prepare
to move to MMU_LAZY_TLB_SHOOTDOWN.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8c2857cbd960..93c0eaa6f4bf 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1395,7 +1395,7 @@ void start_secondary(void *unused)
 {
 	unsigned int cpu = raw_smp_processor_id();
 
-	mmgrab(&init_mm);
+	mmgrab_lazy_tlb(&init_mm);
 	current->active_mm = &init_mm;
 
 	smp_store_cpu_info(cpu);
-- 
2.23.0

