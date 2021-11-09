Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E4244A5AA
	for <lists+linux-arch@lfdr.de>; Tue,  9 Nov 2021 05:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhKIEOc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Nov 2021 23:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbhKIEO3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Nov 2021 23:14:29 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF639C061205;
        Mon,  8 Nov 2021 20:11:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v20so18554933plo.7;
        Mon, 08 Nov 2021 20:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aQc0DqPPO6kMsrpf1a2eMeG1Oqju7se8HtSuYmathZ0=;
        b=U7/JfyAqiO2MKMCYeQeqbbijFBcQVa5T0EkptTY/YLTW8QWwlexKfEOnJ2omEegvxB
         uF1/wE3YW1h247SpMruInOTDxwNMEHNxRUM8ZwHj2wTdxRKoG/gi5vhVbwzr4AR5BUIA
         TYAJHzhWN5PU5gktO9OyGWzMn74UepthW2QsG30UPTkL3g+BF53XW2m/LIEqD2I96WAW
         xgbt/dMqW6IQ8BU/BqiZ4glQm3cFt7qyiLtWRvORZ3DXfSaifWFIfeBi23oSWLSqgIHe
         e6abn8XTCHj+m4MpBFH2mmclMDomCC25gGe8Vrd/npO31J7O4U9IUPbRVWrbsuGbRQU0
         t+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQc0DqPPO6kMsrpf1a2eMeG1Oqju7se8HtSuYmathZ0=;
        b=nFiF2g5C6lw/sSAl2GTKILWzdK9KSdRxY635pDfAcSGeUfwkLMRDfBqydvQC2oE1XV
         g15vSWfrN0NfRpsztsUUAdIZ6uHN77AglLIaF/yE1sN+yG03xLQGh/gP6OsWib0mWF/H
         LnxLorBU+XVsFq5GOyXAqRqXqFVSWi5mgCVNtGh6c4d77MdDa0qp3F0K/TiAeLbk2kDM
         UjGJ6UcdimVqP3p7MCcGddUEp00XnOm+E53kCs8qsa/+P7aKRqbXNfFLBjHFyVBo5QlH
         mxD7uE66WuPEZAOtf/xXIDujlqZA74y4GtFkiW/YRZOi2xNUxacAZF2We5nvlBFoFj8L
         5QZA==
X-Gm-Message-State: AOAM533He2zwJV90kPJkNYULeVOYdzS5yWBtRpWCs7aUwZ7EcBV1vG3X
        t8N62r1zEg0R7HrUowqAt9twPkNZCzI=
X-Google-Smtp-Source: ABdhPJw5RAMBfn9DIjw2V4w3ZE2Oc2Ma5DmxWxSIog1/aLYNvg78RdgoN/I55DMnJioBaGhBoQdvSg==
X-Received: by 2002:a17:90a:b382:: with SMTP id e2mr3827572pjr.119.1636431101310;
        Mon, 08 Nov 2021 20:11:41 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id o19sm18278063pfu.56.2021.11.08.20.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 20:11:41 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 4/4] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Date:   Tue,  9 Nov 2021 14:11:19 +1000
Message-Id: <20211109041119.1972927-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211109041119.1972927-1-npiggin@gmail.com>
References: <20211109041119.1972927-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On a 16-socket 192-core POWER8 system, a context switching benchmark
with as many software threads as CPUs (so each switch will go in and
out of idle), upstream can achieve a rate of about 1 million context
switches per second, due to contention on the mm refcount.

powerpc/64s meets the prerequisites for CONFIG_MMU_LAZY_TLB_SHOOTDOWN,
so enable the option. This increases the above benchmark to 118 million.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ba5b66189358..8a584414ef67 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -249,6 +249,7 @@ config PPC
 	select IRQ_FORCED_THREADING
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
+	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
 	select NEED_SG_DMA_LENGTH
-- 
2.23.0

