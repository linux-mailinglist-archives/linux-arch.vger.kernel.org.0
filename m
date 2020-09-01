Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7372590E9
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgIAOl1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgIAOQr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 10:16:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE2C061261;
        Tue,  1 Sep 2020 07:16:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so594209plk.10;
        Tue, 01 Sep 2020 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4GBbdasJ+e4fXYSTpkmty5k9s9dG8wP/iD9sZCcgX8=;
        b=dH53FvbwzWxDPpzL9QLv3ud71sC04i3yZyx9BEpedyXYGMjxGjGFMSmDwQcpfzAEEy
         vpSo5/Ssw929AdvF66gJ4EUjNg01+rqWJADkqajPmugZI1cbQAXmVSj6ATR4mATxYZqH
         StOhG2/Q59wO/SBRFJMcUkKHyQoQdbKQJlED2G3mJ7htzmdI0Zh2Zdhs0Cv3n/p+oH/1
         kE0qTNQ3Bqmrx7ekV15OYdhIAub17fAkyfseKS7B2buMfZ/qQBoGhcxLveEZcA75ymJP
         y6PMCBs43bHoN7cVjZVwPskK2amXulF6VSw3I15761Sa+g80a4BKj9qIorWICbpQQ+KC
         ENKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4GBbdasJ+e4fXYSTpkmty5k9s9dG8wP/iD9sZCcgX8=;
        b=VhXuys2v/ThF5qXYTKGqrf3JyQLlwfA+acmUGH8TW2rW7geHuhodS0DB0fyYjoHZFk
         o4wa/Ilop5Dfw7gRwt008JrveAH7FU7QOh6FDCRNriCkde3jcvpDCKHcb3m89K/RP6w1
         c1xfCaS2nZT6AZOpCaYK17y7r4xtU+jgLq8eMrTX2g/1l8OboNDNysTy2pHzylgscCqB
         52OftpUOpmuqN3Ln53uqA01F/0PpFLe66w/IIK/GGjqYJktF3dNAEmPDYdQ/ZTUE0uk1
         j6wTR4/N7Sg2deBd1kCrB2qLiUdBlk6lOD+dPWFVqA/yTp7shSs7nRZQF+KsWmnuoVTJ
         DOGg==
X-Gm-Message-State: AOAM531wGDli4t8BYddsSIhLVrnhMXXMVPOPylFwcs89EIzIH1/z5jEC
        LCyEkv5Eq3MM9EaH1mVUqP0B4mO0pns=
X-Google-Smtp-Source: ABdhPJzG/volX6VbEzTef+Kk6CT0A/sPbJrNNCyu6DH4e9IuiAX8jzUmomEjOSXABzmiyGq1oa2Vnw==
X-Received: by 2002:a17:902:7d85:: with SMTP id a5mr1644916plm.148.1598969805983;
        Tue, 01 Sep 2020 07:16:45 -0700 (PDT)
Received: from bobo.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id w9sm2212816pgg.76.2020.09.01.07.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:16:45 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH v3 15/23] parisc: use asm-generic/mmu_context.h for no-op implementations
Date:   Wed,  2 Sep 2020 00:15:31 +1000
Message-Id: <20200901141539.1757549-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200901141539.1757549-1-npiggin@gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org
Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/parisc/include/asm/mmu_context.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/include/asm/mmu_context.h b/arch/parisc/include/asm/mmu_context.h
index cb5f2f730421..46f8c22c5977 100644
--- a/arch/parisc/include/asm/mmu_context.h
+++ b/arch/parisc/include/asm/mmu_context.h
@@ -7,16 +7,13 @@
 #include <linux/atomic.h>
 #include <asm-generic/mm_hooks.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /* on PA-RISC, we actually have enough contexts to justify an allocator
  * for them.  prumpf */
 
 extern unsigned long alloc_sid(void);
 extern void free_sid(unsigned long);
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -26,6 +23,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+#define destroy_context destroy_context
 static inline void
 destroy_context(struct mm_struct *mm)
 {
@@ -71,8 +69,7 @@ static inline void switch_mm(struct mm_struct *prev,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	/*
@@ -90,4 +87,7 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 
 	switch_mm(prev,next,current);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
-- 
2.23.0

