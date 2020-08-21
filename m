Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE6824D82E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHUPNk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgHUPNi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 11:13:38 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCE4C061573;
        Fri, 21 Aug 2020 08:13:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u128so1207318pfb.6;
        Fri, 21 Aug 2020 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gv+PP/wjBFW/QutbN7MDl66u1IlF9/srIH5l1WMUz8Y=;
        b=ABKo10djrnU4pGClhFKavAXdh54V4mnbGrFg88b4z5GAyvOzXK9Eatymo9uLkZeCkl
         2KeYeAal4TC74hqFqtqWVYr+S9XoSTUei+yPXR1nwbKG2HskYDeK468qveJL66dPV04W
         CRRc30oZdDSysRKYpri0vtoFTrTe8+adB1CPOGf48fZZSRnz4o0sJ5mf6x5a6cA0ofL4
         19YSrxZrL+fkPQUkLYIOkcXIc3/ENsTQpySXISI/iwWDCu4uxqzoye8zVjzI82fpwiuK
         4hZfxA7JJWC/dklgIjV7wahwIdIgahUUgl+QKLx6L3g/KymHmFwij0sKPdvlpJphHxxv
         4L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gv+PP/wjBFW/QutbN7MDl66u1IlF9/srIH5l1WMUz8Y=;
        b=LC155gY1a3Yi/w7DOWdi3LhS5yqDz2eapn5dBStXpuCcDqbxomQ3GebSDAvJSDNnof
         J17DPQoxh+pZVDk09PthLUczsKvma1b3iFpy7nNbNXrNkhb1kwmyl/N1QHZH8kOVr3f4
         OqfZstrHeXOIP/lknhvkaTk9TF/UfLYDSCS8K9dKzCUsJxcRC2OaBxB6pVlvhEahvctx
         j9HV0H6ilPxjEIy3gOMufJSQkMHqYO5HEN9COUdTz38iHmcGhdExiiEETBqa79lGadOg
         9eJLTQLTAsZPRgVUfTSfDz3/hnosUZJmZ7zGDlYxhpHSKECx8nCejbrSQZJtMDCIR7Do
         0AJg==
X-Gm-Message-State: AOAM533PTZXbI8V26lkT2vUnltuGpKYGTo5cRS2jWj00jUjFCU4uimq+
        mkZ2/g2H43lyQZztpocriT4=
X-Google-Smtp-Source: ABdhPJwItWdQvR8DxTON4DygzvNWnRtG1VJd3vYg6XhNeG9Dmt4XVNKDtCB8WfPdSWvlVqPVfP71sA==
X-Received: by 2002:a63:584e:: with SMTP id i14mr2637896pgm.433.1598022815728;
        Fri, 21 Aug 2020 08:13:35 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:13:35 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v6 12/12] powerpc/64s/radix: Enable huge vmalloc mappings
Date:   Sat, 22 Aug 2020 01:12:16 +1000
Message-Id: <20200821151216.1005117-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821151216.1005117-1-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 arch/powerpc/Kconfig                            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33fd3d1..6f0b41289a90 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3190,6 +3190,8 @@
 
 	nohugeiomap	[KNL,X86,PPC] Disable kernel huge I/O mappings.
 
+	nohugevmalloc	[PPC] Disable kernel huge vmalloc mappings.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1f48bbfb3ce9..9171d25ad7dc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -175,6 +175,7 @@ config PPC
 	select GENERIC_TIME_VSYSCALL
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
+	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
-- 
2.23.0

