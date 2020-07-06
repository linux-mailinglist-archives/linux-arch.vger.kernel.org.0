Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9149B2151B3
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 06:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgGFEgA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 00:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFEf7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 00:35:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66911C061794;
        Sun,  5 Jul 2020 21:35:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so39321975wrw.5;
        Sun, 05 Jul 2020 21:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3+TUO0b9VV9VdTNyuHlA2h8v8EGxg7Uc2Jzn7JHwh8=;
        b=r0qcJkYVBFZ2S/jjHBZPVsifAxriF1l6iC8Ws0UsFZny73sUoKEE9CqbKDZno2z2QG
         lg6fKKT35QjJ1DLpp/JSMynDpogNIz+CCh26h60gza9Fn1XW1CPzO+duWz9PPxscS0Eb
         vw4OkSGUhtsi9uUYSZAVD0Fm71aRBdhL8TFksRO07dbOCZi7jwsZyHvumnn9UThLXS9F
         dhx26XZ2iJKpywfeIYj1DPc5gbdIv/pGsjQv1hoszdSJ84ULU/6Xa6kzr6ZEJR5nC2WH
         o0n7Cdw948tbLx+ElRVsC7tDSY3LK4R/8XPNEvq0RVIBeixVmu5oTXl8wkLrUOXbpkxi
         /JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3+TUO0b9VV9VdTNyuHlA2h8v8EGxg7Uc2Jzn7JHwh8=;
        b=oGY23Gmh6SBtVYgZV/S7k/sLJCc5SKBMwct97eWTHWnffZLhA7mybzqh8ZSOckX0SW
         iUEykfsjYuGDbvcLwlxjIv3142uSBlTNGSbNJThlZTORxyV4MVHM7J+hVkQ6jn7q6WKX
         ZL2qYCIDmNTQmsA+WYHqRKJyuAYTFyPbX2FykiENiUPsIU4T3JUox4hgp/KR1WOjQRFq
         rqvY6/Qn3k9N5KpARkKJDAagqiNmSE08+hjZMsOB2WZ6sWg0+OyXZ5zFz3v/ozNFTPBJ
         XyVrnjvA+BLlBGK8ae5uyxWP7vY2O6hEU6UxmbhXpoQ4w9JhNm0iqdxMemMl4scW4PnK
         3x9g==
X-Gm-Message-State: AOAM533bcGJ+3aPX5rvxQeS3s9nzK5Z9Y2ogxT0JFve0A5IWmM/cqjmJ
        U5CFCO3yLocuWxIxtRB22WA=
X-Google-Smtp-Source: ABdhPJy47TWafr98nA5kPAewPrXPzWqc1AM5FjP4Ab0wPcRF+By6mw6/WW3J5fbQja0fcsMN77GF+w==
X-Received: by 2002:adf:df10:: with SMTP id y16mr47302000wrl.225.1594010158173;
        Sun, 05 Jul 2020 21:35:58 -0700 (PDT)
Received: from bobo.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id r10sm22202309wrm.17.2020.07.05.21.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 21:35:57 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 1/6] powerpc/powernv: must include hvcall.h to get PAPR defines
Date:   Mon,  6 Jul 2020 14:35:35 +1000
Message-Id: <20200706043540.1563616-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200706043540.1563616-1-npiggin@gmail.com>
References: <20200706043540.1563616-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An include goes away in future patches which breaks compilation
without this.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index f923359d8afc..8eba6ece7808 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -15,6 +15,7 @@
 
 #include <asm/iommu.h>
 #include <asm/tce.h>
+#include <asm/hvcall.h> /* share error returns with PAPR */
 #include "pci.h"
 
 unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
-- 
2.23.0

