Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B50211D5B
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 09:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGBHtB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 03:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBHs7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 03:48:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB11C08C5C1;
        Thu,  2 Jul 2020 00:48:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l6so8996920pjq.1;
        Thu, 02 Jul 2020 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3+TUO0b9VV9VdTNyuHlA2h8v8EGxg7Uc2Jzn7JHwh8=;
        b=n2X2tl2t1Z2jMbL8ftjNC8UfbtwIZAGcSuTp5qN1FvmOYuwgjX5KnJtALwmUyd5wHW
         HuWBDqPjKQ3jhWx7H0ve063UAbqIvU5T7BGPTxwObqeD3U77dQibTYtK7uFzOozjPGfj
         bqB8JF4dxa4GjyuRRMYu5EMlwn3xeK0QOSdBMDCvw8FDXDVxaVEpDX8z3F6bD427EoFk
         NGrFGc4CXku52XHrp65RvqF6vcc9sga6E2Jes0IIyw6uUSeZxHAJK37keYVe0X3ky8Ft
         4wfJ8U29IEzSKtDV/aWIswgU/itkss0JJydb1Xz5o6YooNXTyY/jjqd8bfdVUb1nuhum
         iHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3+TUO0b9VV9VdTNyuHlA2h8v8EGxg7Uc2Jzn7JHwh8=;
        b=nn/cpIONbNJglyj7qQzI7f6kZGZMJ7CHzHhKQ1spg6EoulqIxp83nyVTdFYcR91aWb
         OaDtyq0jHs47zI9c+VIjSigtb6aqk2YnUB9ClFq6DZ4EHGmBIK79KUi4t79eel43CSpS
         RFqQbczR6O6Lc0u5S9XSE6+t/dPjqVcLhzD8v+HqRObAD0z7I9GL1nnf3hHBhaIXnaEX
         3JcbAF9jumPmCNoGeqGCd0TOu6KDflXp7tYiUEt6cIv7aTrv2hmktb9/xenm0YZpKgDZ
         HcqDt8sTxQQDPvWSVe3L6sw3DyGWtpY0ZNjhuZGx3G46Qs1EV/QBgm8VIuRTMiBYYFXQ
         Ubew==
X-Gm-Message-State: AOAM531+85DvMwBS4qZuwmO1Ks6Q5BT8lMStCeooR9HK8GzpgALQQ6sk
        A/4XttLxL/JlwlK//mRMkE0=
X-Google-Smtp-Source: ABdhPJyrX8ZqLoSxDfScS/c0oudlkWwFEh6ZwhILTvmdjNw4QT7UUZQ1EYJPbV20RtW1fhoz7YmYKg==
X-Received: by 2002:a17:902:b205:: with SMTP id t5mr13521549plr.7.1593676139118;
        Thu, 02 Jul 2020 00:48:59 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id 17sm6001953pfv.16.2020.07.02.00.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:48:58 -0700 (PDT)
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
Subject: [PATCH 1/8] powerpc/powernv: must include hvcall.h to get PAPR defines
Date:   Thu,  2 Jul 2020 17:48:32 +1000
Message-Id: <20200702074839.1057733-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200702074839.1057733-1-npiggin@gmail.com>
References: <20200702074839.1057733-1-npiggin@gmail.com>
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

