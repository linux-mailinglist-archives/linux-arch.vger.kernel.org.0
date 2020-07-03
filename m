Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17084213513
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 09:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGCHfe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 03:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCHfe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jul 2020 03:35:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE51C08C5C1;
        Fri,  3 Jul 2020 00:35:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a14so9071081pfi.2;
        Fri, 03 Jul 2020 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3+TUO0b9VV9VdTNyuHlA2h8v8EGxg7Uc2Jzn7JHwh8=;
        b=LPJ9kOrR/DVOvIvwHOyv2EvxvH2mWm1cTxw9pMagbdFf9Yf/o5YqVhwLZxlm4zMzB0
         BupvO34NgK3WU5FusVXN3LG1KZEmguQH+5WTUWXoEsEr0RjWXGLP0Ixc8TEqeeT6lVZN
         WsPOzbDKE4F33Gwek0i4ekNv+nVM6tYRDmjW4ojHXc4ANZghx4n39tGew1CqNAPQKTMw
         YLAag0hi/6/ZIqQRe4jaFochEOd0Hjq4hDBYBwaui6RvinZrC2mtHhJfIZ/yrLu1gwor
         mCQwkmxixNVC8IyJn8QQbryDYT5OUMEzfJcaRC7zrD+8ntI7y8IhZGKDc/ADG9oGWhN1
         1vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3+TUO0b9VV9VdTNyuHlA2h8v8EGxg7Uc2Jzn7JHwh8=;
        b=DjbkOmbLC1sqkErMQipMOu0asvDEaEsnF1/5O7UOoH+j1jnhjvvyDWiEoNk1vNBRPw
         iaA9XldIfIJ0xikinDX8Fv07SEatP9+cNShQJCBh5f+5eK+lfcO54QfK1ZsHusGG3JBa
         7aDoZdZT0ZkI2gU2hZqzdmm06OEvcNMKyNDum7dT8BQyl2by/U9qmRMDHrflQ6FOGJS3
         uyIuBtYEI2UEvE9FEuPiqMjRF35j5Xewg36jnhmBrnKPxHZFnK+bSmIctT2svW6W1hhI
         qWOppoUhjlUzuRqD5wRLum6crx3+HOi+/sIs43uiCRQdnbk+TuMUEn3NIfdzXT6bgNZ7
         phcQ==
X-Gm-Message-State: AOAM5324Tw50fRuSjYr5EltqAF1EANOKjj2NoTAbKTDruXvePQbvr9Jc
        Y691AfAft7JjcOPXRSsxuho=
X-Google-Smtp-Source: ABdhPJxSb50XzIXPJCZ5aFL/fPOkGNSVYnLGWYBsj4lJ5hpdQfsLdm3sGDjF2UwCTSWxhcuQ8/5rHw==
X-Received: by 2002:a63:b06:: with SMTP id 6mr27000920pgl.116.1593761733846;
        Fri, 03 Jul 2020 00:35:33 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id y7sm10218499pgk.93.2020.07.03.00.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 00:35:33 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 1/6] powerpc/powernv: must include hvcall.h to get PAPR defines
Date:   Fri,  3 Jul 2020 17:35:11 +1000
Message-Id: <20200703073516.1354108-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200703073516.1354108-1-npiggin@gmail.com>
References: <20200703073516.1354108-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

