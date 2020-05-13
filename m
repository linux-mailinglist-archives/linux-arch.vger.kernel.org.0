Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C891D0F83
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbgEMKQc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733003AbgEMKQ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 06:16:28 -0400
Received: from localhost.localdomain (unknown [42.120.72.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C6E20769;
        Wed, 13 May 2020 10:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589364988;
        bh=kPJfTLH4cJgtB3+hTFdqwjihaAyGLyGKbDupSrhDR+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IF99eMTGiJXDyzLay7tygbAWSSMnq2pwWgYj9npUFVc8NvYhjUJ99Gaj4y+HAzKYe
         pWT1C/EN1aqLvuamVDaty7UHV4epKoJCRB5cfba+UKzbyDOy2NPUn+XjSD8WiSID45
         euVUvtqrO5Wwbt3mSGXVQov7onEuEdumcEnoHot0=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@kernel.org,
        Liu Yibin <jiulong@linux.alibaba.com>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 3/4] csky: Fixup remove duplicate irq_disable
Date:   Wed, 13 May 2020 18:16:16 +0800
Message-Id: <20200513101617.11588-3-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200513101617.11588-1-guoren@kernel.org>
References: <20200513101617.11588-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Liu Yibin <jiulong@linux.alibaba.com>

Interrupt has been disabled in __schedule() with local_irq_disable()
and enabled in finish_task_switch->finish_lock_switch() with
local_irq_enabled(), So needn't to disable irq here.

Signed-off-by: Liu Yibin <jiulong@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/entry.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 364819536f2e..6a468ff75432 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -332,8 +332,6 @@ ENTRY(__switch_to)
 
 	mfcr	a2, psr			/* Save PSR value */
 	stw	a2, (a3, THREAD_SR)	/* Save PSR in task struct */
-	bclri	a2, 6			/* Disable interrupts */
-	mtcr	a2, psr
 
 	SAVE_SWITCH_STACK
 
-- 
2.17.0

