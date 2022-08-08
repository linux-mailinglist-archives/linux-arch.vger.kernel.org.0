Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1018558C3BB
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 09:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiHHHOm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiHHHOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 03:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B25412A84;
        Mon,  8 Aug 2022 00:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E9860CD4;
        Mon,  8 Aug 2022 07:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E9AC43144;
        Mon,  8 Aug 2022 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659942846;
        bh=WoY94/J8cfzum9irmyRxRUySe4AhzCRGKz56Za4j0Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dmp61UFU8SA/lRXSMwulcK8hsmZHXKxWNoltZU6J1+C0Tl1VlTX6NbEQpqhjmwwC0
         aC2JsVf6ET8hY6KdAULsOP5se+CPera0Vk+WakOUOMR2TfRuAJrA/5K2ZuXBQFJXhN
         b1vZCmK7gyPtayyCTr39QKIDO4xmLbUcZf2eYISecYjR0isYe5RDarzFsF3t8RE3rC
         F5O/b5SdogsbAuMSc5EZn5LAL3v4OSBUnsf69xe1NxDIPiRTe5IsbD1ct861I21LXy
         gt8cZJsiA/wU0qpb7KnvWYckD8OOBtFM/nIGT+ZxpzSQB79WHN0CgQNfNOrkQX70Wc
         yOkxvWPJg/ahA==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, shorne@gmail.com,
        conor.dooley@microchip.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V9 05/15] asm-generic: spinlock: Add queued spinlock support in common header
Date:   Mon,  8 Aug 2022 03:13:08 -0400
Message-Id: <20220808071318.3335746-6-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220808071318.3335746-1-guoren@kernel.org>
References: <20220808071318.3335746-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Select queued spinlock or ticket lock by CONFIG_QUEUED_SPINLOCKS in
the common header file. Define smp_mb__after_spinlock with smp_mb()
as default.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 include/asm-generic/spinlock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
index 6f5a1b838ca2..349cdb46a99c 100644
--- a/include/asm-generic/spinlock.h
+++ b/include/asm-generic/spinlock.h
@@ -3,7 +3,11 @@
 #ifndef __ASM_GENERIC_SPINLOCK_H
 #define __ASM_GENERIC_SPINLOCK_H
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock.h>
+#else
 #include <asm-generic/ticket_spinlock.h>
+#endif
 #include <asm/qrwlock.h>
 
 /* See include/linux/spinlock.h */
-- 
2.36.1

