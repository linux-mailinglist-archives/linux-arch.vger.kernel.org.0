Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB182D9373
	for <lists+linux-arch@lfdr.de>; Mon, 14 Dec 2020 08:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407124AbgLNHC1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Dec 2020 02:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407140AbgLNHCL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2020 02:02:11 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B34C061793;
        Sun, 13 Dec 2020 23:01:30 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id lb18so5749347pjb.5;
        Sun, 13 Dec 2020 23:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qp8PGJSLWU/dwswnH2/0kSDHsb+wln5XeqPaVW1B5Z8=;
        b=ah+DQFnviIYaiwW61xx/7aV1EqG6uLPtWc0d5mLXZjof3NJGVQvvrolW/w4GehwsgZ
         Kjz865XZJBwN7csGduekgiDndqDQMMkH63AuRBe60gEq1+3hlOynV/QU29ZZHZy1dmuh
         YqRxTfXSx5g3thhMEubi88ti01h4X/dvY+gl6HB5vRVVk6SEJFY/EpUIEzlpW+qFxvL1
         6VFFiBv7G2JdHMZs/8xBYZm9YzaSgcsZobouuYIA4wRKopgoW2tqi62eQTCOoAhaLIT0
         TK2G/9I2Juvg1hOJVBo51rMWp21v+CNQuh5UMCEp6vNrXNmhMcDRWV0pR3qyedE7yxgr
         oXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qp8PGJSLWU/dwswnH2/0kSDHsb+wln5XeqPaVW1B5Z8=;
        b=E+znByKNgfyX4uJ3T+RVbEmSbxWpC5yu4yyBezVb/kcNYA3T4gHr6uM/Cr9PzfshiP
         8oVZ92yZXUSuCm+f9vtoIUqrI18R/jzhNOIOFAUZ2MJ8SAdTgrMGLjvav47VCHu3XikQ
         LhjmKvVBKp8Xgni7kMWYQmWTtR61KCJt6ac/8qkVQU3UX647k7RI8txs5/nGciRRqs9O
         f0NKEbjUZ5Gt7WeRJXqyRuzUQw3QUocCgQ/PQCWXaOuhcnm7KvhZ4166i25BDcWOJOB7
         zvyAAsDL7Hta8Avhl4u8Dc3drLVLY+ywa8+R00OfKTyE2JLX2vEe6RaOq/bDl/MxE5WB
         gUoA==
X-Gm-Message-State: AOAM533m9lwk45uEEDpO605oHuCWc3CYOzdyrxawI4sNGCr8XBOMvPeI
        DOBJS8uBdAjlH2djybKW0v1VqZ4YYDQ=
X-Google-Smtp-Source: ABdhPJxhvHk5cUvHX6rAbQVwgg8ik+gRYQYw+Z++uVUyjX085PL81mc1MQ6kNeatmpvgR9yE7EELWw==
X-Received: by 2002:a17:90a:3841:: with SMTP id l1mr5029772pjf.3.1607929290263;
        Sun, 13 Dec 2020 23:01:30 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id 84sm19570018pfy.9.2020.12.13.23.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 23:01:29 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 4/5] powerpc: use lazy mm refcount helper functions
Date:   Mon, 14 Dec 2020 16:53:11 +1000
Message-Id: <20201214065312.270062-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201214065312.270062-1-npiggin@gmail.com>
References: <20201214065312.270062-1-npiggin@gmail.com>
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

