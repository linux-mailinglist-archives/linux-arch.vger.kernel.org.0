Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B39E58C3DC
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 09:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiHHHQb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiHHHPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 03:15:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E54617E;
        Mon,  8 Aug 2022 00:15:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A29A4B80E06;
        Mon,  8 Aug 2022 07:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45698C43140;
        Mon,  8 Aug 2022 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659942905;
        bh=PhULA4jDsByMhb+wbohiUiRVZy/cDd8Zyeeyl+ikEoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ij7fgoAK4RLF2jeypOvXde6SXvGiYiFhg2010qwe0MdJ9Drq0uk6JyUrUGSk0qmpo
         lSuJlh3/uII5ljQLythYRGYHzJGx/bkutxshAqJngPETLEfN7pi9ht4TkTwlrjU9gF
         CGhuJfdqMH3ve2+ybv38bhEYh/shj/NyvqKy5RAKg1zOFi8c/NGOKIL3pnhJ2eE2dE
         sQBC9QyOCN2MmpycM+wVlOJbGY2VdSQWZmcMBdGbWU6FAcQRYQabrN820IvJuQgwmD
         UUcTZa54wde3tJLkR4S1jq0R+3kLM6xY6kDrJTLO5hfp7HA65zoGFDpjrA7vn1mHVo
         z9CiOGLJiZ5mQ==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, shorne@gmail.com,
        conor.dooley@microchip.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V9 15/15] csky: spinlock: Use the generic header files
Date:   Mon,  8 Aug 2022 03:13:18 -0400
Message-Id: <20220808071318.3335746-16-guoren@kernel.org>
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

There is no difference between csky and generic, so use the generic
header.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/include/asm/Kbuild           |  2 ++
 arch/csky/include/asm/spinlock.h       | 12 ------------
 arch/csky/include/asm/spinlock_types.h |  9 ---------
 3 files changed, 2 insertions(+), 21 deletions(-)
 delete mode 100644 arch/csky/include/asm/spinlock.h
 delete mode 100644 arch/csky/include/asm/spinlock_types.h

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 1117c28cb7e8..c08050fc0cce 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -7,6 +7,8 @@ generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
 generic-y += qspinlock.h
+generic-y += spinlock_types.h
+generic-y += spinlock.h
 generic-y += parport.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/spinlock.h b/arch/csky/include/asm/spinlock.h
deleted file mode 100644
index 83a2005341f5..000000000000
--- a/arch/csky/include/asm/spinlock.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_CSKY_SPINLOCK_H
-#define __ASM_CSKY_SPINLOCK_H
-
-#include <asm/qspinlock.h>
-#include <asm/qrwlock.h>
-
-/* See include/linux/spinlock.h */
-#define smp_mb__after_spinlock()	smp_mb()
-
-#endif /* __ASM_CSKY_SPINLOCK_H */
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/spinlock_types.h
deleted file mode 100644
index 75bdf3af80ba..000000000000
--- a/arch/csky/include/asm/spinlock_types.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_CSKY_SPINLOCK_TYPES_H
-#define __ASM_CSKY_SPINLOCK_TYPES_H
-
-#include <asm-generic/qspinlock_types.h>
-#include <asm-generic/qrwlock_types.h>
-
-#endif /* __ASM_CSKY_SPINLOCK_TYPES_H */
-- 
2.36.1

