Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617952C725C
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgK1VuT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbgK1TIH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 14:08:07 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E77C09B04E;
        Sat, 28 Nov 2020 07:27:10 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w187so7047718pfd.5;
        Sat, 28 Nov 2020 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DNjSlcfmF+OHlo4gVLmadoYUI7t/ZPA6392s3YiGIWc=;
        b=ZhyQyF3xqUCTfNzTWjnt5F47H7u0baAN9fFtRmD3iym4ZXUMOqum0cQhh3hWOctZwj
         gPht2kBh0BvlDlTsq8TVE/kd5SPzqm9X89p6ZfrT7H3C/ioyQY5tgO574Ym+INLe4FYc
         s21mRxDd6DGVyMY1fWbws1Pq/YhrjXB32LaWupdtbDbaxsW0QfJbAiHeuVFfQKfuXwL4
         4JshxsnUfWHqQSkk+FnO+m1Flu7Wg1g/bOkeKaOJwHSdKSQC2TLM6Ybi/1wfBU+oOXqX
         Ncoe8p+vMg2cCr2cs0+3oYuDvraNpEh/P6BLPY5BbX1hBeAPkFfbcGcv4oiBi8Qqp35b
         wWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DNjSlcfmF+OHlo4gVLmadoYUI7t/ZPA6392s3YiGIWc=;
        b=hpToaxFilG1HP9rpvu+QEXihaYA2Dqt9DGAVkoZzIu2pn/yYfAUoPT8ZXo0WfyQghJ
         hX1tcyngkhKr7WNfis+eV5lS5qSQ8fhdZ4Bk33ZnSurvD+YgX6IYXkFcyxwJdxZ2r5p/
         kqgpZ10f+GNHetZeErewPDUSg4DUX31wsbTuRVFTJmals/Oth4yGj9S2JhLnE1vvheZ3
         kBdIsMHDVdsz/RgbQd+rZpxwkAIvhZSpugSqE2oN/6rfZOcqhr65ykHFNnNHGhkUOGba
         UGVb+6XummAzCO4r5YgOW4xvke0qo1gKHWVHNVCvAx4p0th3F0eiIkl5/TO1sg4+8p9n
         +fcg==
X-Gm-Message-State: AOAM531iEzUzXwbwSgjsnu54tpYm8RppwKSvXC62Sxatp3V7NjNjc/W0
        y10AZn8k2fmK4olBI1zOIP4=
X-Google-Smtp-Source: ABdhPJyr33fJ1cRT/CXJUB52w14TzTSG2z78e+wqJpSmyHM7mMK5eJZP/z+qSOVYdPM5WOeIlQODnQ==
X-Received: by 2002:a17:90a:1b6f:: with SMTP id q102mr16974828pjq.9.1606577229927;
        Sat, 28 Nov 2020 07:27:09 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d22sm15500173pjw.11.2020.11.28.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 07:27:09 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v8 12/12] powerpc/64s/radix: Enable huge vmalloc mappings
Date:   Sun, 29 Nov 2020 01:25:59 +1000
Message-Id: <20201128152559.999540-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128152559.999540-1-npiggin@gmail.com>
References: <20201128152559.999540-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 44fde25bb221..3538c750c583 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3220,6 +3220,8 @@
 
 	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
 
+	nohugevmalloc	[PPC] Disable kernel huge vmalloc mappings.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e9f13fe08492..ae10381dd324 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -178,6 +178,7 @@ config PPC
 	select GENERIC_TIME_VSYSCALL
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
+	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
-- 
2.23.0

