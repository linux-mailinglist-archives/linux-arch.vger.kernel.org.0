Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6659C617811
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 08:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKCHyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 03:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKCHw4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 03:52:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7276366;
        Thu,  3 Nov 2022 00:52:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEF89B8269B;
        Thu,  3 Nov 2022 07:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1799EC4347C;
        Thu,  3 Nov 2022 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667461963;
        bh=ePRIEbfh2FK+8Vi6mmFkfLNcMAL4qY01TOTMEoLzQek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5N1gQV6eCaNMfYMEzcic0MZuFFkZUgWijvKflhcaKrBQ9tVfrR0Yxsu0HKDbZK9g
         cOaIEy9GqWYfRwhBH1byh0nnj137yo9Rrt9ik9ftEkJq+k6/Go8TLJk1dxfvfZK0LP
         vkesDkJIqAe/vN3fFN+I7IsqUQlZ/X3Sk/2/xGQ1XfHPz2E5zEdII3QYOQa35qYMDK
         8/5giMWEOQAkmjtxA/HBZ2RbPYnvLE6/QBV0vaxeuM3G7VDJeaFr4tEjxoCUZWTHom
         wIqZ8t+C/6EpB0i1EVw4CTaV5HH9+D+AzXfbrHVTbljbGbxHcIYnFjtIJld4B2s3sB
         fcGiqiGZtGHjw==
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
Subject: [PATCH -next V8 10/14] riscv: Typo fixup for addi -> andi in comment
Date:   Thu,  3 Nov 2022 03:50:43 -0400
Message-Id: <20221103075047.1634923-11-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221103075047.1634923-1-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 9864e784d6a6..03655577e26f 100644
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

