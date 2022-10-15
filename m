Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4449E5FF9F2
	for <lists+linux-arch@lfdr.de>; Sat, 15 Oct 2022 13:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJOLwZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Oct 2022 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJOLv4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2022 07:51:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9374BA70;
        Sat, 15 Oct 2022 04:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D68A4B803F1;
        Sat, 15 Oct 2022 11:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD418C4347C;
        Sat, 15 Oct 2022 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665834694;
        bh=fh15OHJHy3R3yR29pio/F1HO3nxfSUxW0UFKeoOvuqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jvax/d0VnemxcgAQYxdfl97c3+5pwbgiw0RwzL1R6BR3JazB1Iv59l9B2SqfZ20Pv
         3zHqItoiWniPZhIPqC0P6H/O1FOrWHMGmC9VFSWE1MPrk0Nvd4OLYkRQfobrQDTYU9
         uKLaIQ8uz2dZoQXFuOw6BGf3zMNFnVQ01/vqdJPMX3529Jq07eSFzvyjOqSjapTSx9
         bbcecYUxlwPnDnCJBb7CY0aemxRfQiPl5Rf+ZTDzXcEasdA6eyZYHSh2bTm83PseeX
         sZY3w62Cglk7kvL8gae55OpoOtOxlpzF0fMmWz0fY1hdgwnoqNQKR1qrt6zjJITvVU
         y5Y5Xo6psV3Kg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V7 12/12] riscv: Typo fixup for addi -> andi in comment
Date:   Sat, 15 Oct 2022 07:47:02 -0400
Message-Id: <20221015114702.3489989-13-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221015114702.3489989-1-guoren@kernel.org>
References: <20221015114702.3489989-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Correct typo for addi -> andi in comment, although the immediate[11:0]
are the same.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 167ae41ae4a8..b1babad5f829 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -138,7 +138,7 @@ ENTRY(ret_from_exception)
 	REG_L s0, PT_STATUS(sp)
 
 #ifdef CONFIG_RISCV_M_MODE
-	/* the MPP value is too large to be used as an immediate arg for addi */
+	/* the MPP value is too large to be used as an immediate arg for andi */
 	li t0, SR_MPP
 	and s0, s0, t0
 #else
-- 
2.36.1

