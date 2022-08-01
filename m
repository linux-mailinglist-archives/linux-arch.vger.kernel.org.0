Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34B586212
	for <lists+linux-arch@lfdr.de>; Mon,  1 Aug 2022 02:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiHAAm0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 31 Jul 2022 20:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiHAAmY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 31 Jul 2022 20:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CD11477;
        Sun, 31 Jul 2022 17:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E00E60ED8;
        Mon,  1 Aug 2022 00:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D42C433B5;
        Mon,  1 Aug 2022 00:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659314541;
        bh=5okHnQMfvZWc3wOETu3ldFm+Nzm+AT7xSTHmaNUs9eA=;
        h=From:To:Cc:Subject:Date:From;
        b=qWM6zKAHOQqxiYCR6V/OhCl6X2zPMQSmr6iGzDy31162AMl0NDIwzFn77A03AtInn
         WuYlysOVFoioVBOB7XeArxY3faaLjiBtJ+svgvbt/TJunx0SLNRWP6OuPZqkR2xWom
         VRhOgoLFOYdXzyBAkj7wguXFN2CIfmzTPwRjUISyczGROPoUeli/0DPiaAdldJSvIr
         Ikg69KcmNejxIAyctXQYfhmlQHhowyAh5wQCOpgd0kr6igEFeuJojq20Wsbrh4NqeZ
         ooDqz6Ffuy07UxlklVAq6dNwYZXYEN7VG38WgBasIX8H9hf0rIaLCgmzDyjcyUYXhU
         AS4TV4bcQbLoQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Enable ARCH_INLINE_READ*/WRITE*/SPIN*
Date:   Sun, 31 Jul 2022 20:42:12 -0400
Message-Id: <20220801004212.3854362-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Enable ARCH_INLINE_READ*/WRITE*/SPIN* when !PREEMPTION, it is copied
from arch/arm64. It could reduce procedure calls and improves
performance.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 333def12faef..b23458b5c74f 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -9,6 +9,32 @@ config CSKY
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_INLINE_READ_LOCK if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
+	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
-- 
2.36.1

