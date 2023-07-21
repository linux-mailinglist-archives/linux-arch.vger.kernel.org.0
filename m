Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1545375CAA2
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGUOvb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjGUOvb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 10:51:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C839E121;
        Fri, 21 Jul 2023 07:51:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 528A661B41;
        Fri, 21 Jul 2023 14:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546FEC433C7;
        Fri, 21 Jul 2023 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689951088;
        bh=teEmtYEsH6k5Iwt6X7YjCMB9QeYgw9y0NVMCGBaKrl4=;
        h=From:To:Cc:Subject:Date:From;
        b=Xz2t5+4X9HazUHd9/xryPgURXzr38k9iRATggk0gJ3d1QbDQZGv/2kMj02DOVSLVs
         LRNUqA3v+aRwQ6NuqcRsLxVhBSocmLaLHcx/T3MOoywstOkT85YlM9BKmiReS0kx28
         IcH8igEhid+qNWvhewXoS+PDRQNrVS/yEsVDKJWCyrkC63qgIy8AAt2qHFGVUUGdlH
         XnLxLKT/5VwE30ZbODFZspOJOO8Aspgxitv0xga9tXcSjMvAEEu3tamVi8e8Tilzqn
         nj/YJmKytqtaEl98gISwPPwM3Ha6Iwl+h3vYvGtAcRBECmDKcNrFHLjhUFQYUe8SiR
         EFi5MTUTuNkeA==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        falcon@tinylab.org, bjorn@kernel.org, conor.dooley@microchip.com,
        alex@ghiti.fr
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: mm: Fixup spurious fault of kernel vaddr
Date:   Fri, 21 Jul 2023 10:51:21 -0400
Message-Id: <20230721145121.1854104-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

RISC-V specification permits the caching of PTEs whose V (Valid)
bit is clear. Operating systems must be written to cope with this
possibility, but implementers are reminded that eagerly caching
invalid PTEs will reduce performance by causing additional page
faults.

So we must keep vmalloc_fault for the spurious page faults of kernel
virtual address from an OoO machine.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/mm/fault.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 85165fe438d8..f662c9eae7d4 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -258,8 +258,7 @@ void handle_page_fault(struct pt_regs *regs)
 	 * only copy the information from the master page table,
 	 * nothing more.
 	 */
-	if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
-	    unlikely(addr >= VMALLOC_START && addr < VMALLOC_END)) {
+	if (unlikely(addr >= TASK_SIZE)) {
 		vmalloc_fault(regs, code, addr);
 		return;
 	}
-- 
2.36.1

