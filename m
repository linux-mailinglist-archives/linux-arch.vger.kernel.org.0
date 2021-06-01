Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA7396D4D
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jun 2021 08:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhFAGZS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Jun 2021 02:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhFAGZJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jun 2021 02:25:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3267BC061574;
        Mon, 31 May 2021 23:23:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g24so7759729pji.4;
        Mon, 31 May 2021 23:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZkiKtXqsSUWsFPxoaMD52BWVXcB9txjh0r70N9gfwg=;
        b=TMuuo1b+x5/KjM8834zLhSTP9eYuo7t0tW46rm7j4SnXrgLEDWE0TOlUaFMqu8a+wI
         vbs8XSGlHrRcHcTNztnJ6FzCBPFzIdXlEHvPisjfSNJtPoi22YsCPwpfGpRVCfOzBEyA
         qIpgYtAQFvdrhvVyPuJFVlv69Dqy2++lkPLlvSfYFcFCmgn46h+CL735k7uWPO2iR6ib
         F/kGzqky6oCb6NGOI9e7WIPMpMGVye8FitjlLICcOtIpc9ld3zB5Wx8ELsL60gT36dHI
         97jMnbIhzGPVji0u7wu9KoHMx8MMSH5LNriPf5FvHIo0aVVgBAQXAvYl2+p+Q7UssMwq
         afpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZkiKtXqsSUWsFPxoaMD52BWVXcB9txjh0r70N9gfwg=;
        b=ob53DnyrCmqwppvvmYaPjt0yvUtLWkN4oxxsde74nszKBsUmNv9y0yBvl9Uz1dmJMe
         5UpedMwXJvOaHAxuxrlYpvbSJV848jDLpC5me7gl7HK1PRVDp7nRlmMjdzHz2qKnHSfu
         2QWn2Xa4MTjfKpkCiNL32QHR47MB7s5t6/kulvy239lzNYZpCIpo9vDZqYuXRoV3q86F
         gFYbQWHWTewYVr5jmMGUHA3W5nBm5dguM23flE6ssS6/sWfEB/2LVJAYO+N2HAcrBvQh
         deyXL6ukBc4lcee4SA/sHsX0bQ0MJJPT3U8Si2zJ+biO41xVCX6I8GmH+bm1c007uxXH
         jVOg==
X-Gm-Message-State: AOAM530kpmdwdL032FOleAPPtmUnbVmi67RFsZoxVRntvDjbQggziBNL
        NdFF2nXE9WdPZQC3HI0zAJU=
X-Google-Smtp-Source: ABdhPJzO7M0Hh974CEgDAeZuPzkos1it6HgA9FTrTsKtUq98J+3jqEoDd6tOI7VI/NdE9fIIB6URYw==
X-Received: by 2002:a17:90b:1094:: with SMTP id gj20mr14135765pjb.45.1622528607822;
        Mon, 31 May 2021 23:23:27 -0700 (PDT)
Received: from bobo.ibm.com (60-241-69-122.static.tpgi.com.au. [60.241.69.122])
        by smtp.gmail.com with ESMTPSA id h1sm12519100pfh.72.2021.05.31.23.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 23:23:27 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 4/4] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Date:   Tue,  1 Jun 2021 16:23:03 +1000
Message-Id: <20210601062303.3932513-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210601062303.3932513-1-npiggin@gmail.com>
References: <20210601062303.3932513-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On a 16-socket 192-core POWER8 system, a context switching benchmark
with as many software threads as CPUs (so each switch will go in and
out of idle), upstream can achieve a rate of about 1 million context
switches per second. After this patch it goes up to 118 million.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 088dd2afcfe4..8a092eedc692 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -252,6 +252,7 @@ config PPC
 	select IRQ_FORCED_THREADING
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
+	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
 	select NEED_SG_DMA_LENGTH
-- 
2.23.0

