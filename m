Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD08742209
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 10:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjF2IXL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 04:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjF2IWb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 04:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C032974;
        Thu, 29 Jun 2023 01:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65640614FE;
        Thu, 29 Jun 2023 08:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53985C433C0;
        Thu, 29 Jun 2023 08:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688026847;
        bh=eix3asqgstSKaRDosqnGq1xt2TLM2YGz1j/+D6LUbUw=;
        h=From:To:Cc:Subject:Date:From;
        b=Li0ft4GpCx4QdjFx8Bu0MQQmbfINFOTqPW1UsMc2jx6iV2r5mI+jgoR1BT03Ekiv/
         rNAh00T4LGxnPFaYaFYEJUeYMpjSkM5eX2vu5W5RYeqDDNG1/Nwsmts9edq2mbUxik
         2uGZJVbqK6FnUezh+J1lnsFy8p8nF1VXy67qHcTGIT5vX6x04UmwLVNE5klSIvdTgS
         Jh+kWdtbvGhEfTkZeUOBpuAJkliug8/4V1T5aYfNC4MlsAPttJU9rx5yNjIfFO/6K0
         FPky9KXaVEq7VJgeg0KfUuKVP77C0qgeTgSoy67ARCVZPu84Qz8U3d4utxOdoV9n2t
         nWYqdv2ygrGxg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.co,
        zong.li@sifive.com, atishp@atishpatra.org, alex@ghiti.fr,
        jszhang@kernel.org, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: pageattr: Fixup synchronization problem between init_mm and active_mm
Date:   Thu, 29 Jun 2023 04:20:32 -0400
Message-Id: <20230629082032.3481237-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The machine_kexec() uses set_memory_x to add the executable attribute to the
page table entry of control_code_buffer. It only modifies the init_mm but not
the current->active_mm. The current kexec process won't use init_mm directly,
and it depends on minor_pagefault, which is removed by commit 7d3332be011e4
("riscv: mm: Pre-allocate PGD entries for vmalloc/modules area") of 64BIT. So,
when it met pud mapping on an MMU_SV39 machine, it caused the following:

 kexec_core: Starting new kernel
 Will call new kernel at 00300000 from hart id 0
 FDT image at 747c7000
 Bye...
 Unable to handle kernel paging request at virtual address ffffffda23b0d000
 Oops [#1]
 Modules linked in:
 CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
 Hardware name: Sophgo Mango (DT)
 epc : 0xffffffda23b0d000
  ra : machine_kexec+0xa6/0xb0
 epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173d10
  gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000000
  t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173d50
  s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300000
  a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000000
  a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : ffffffffffffffff
  s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7000
  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
  s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff815351af
  t5 : ffffffff815351b0 t6 : ffffffc80c173b50
 status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 000000000000000c

Yes, Using set_memory_x API after boot has the limitation, and at least we
should synchronize the current->active_mm to fix the problem.

Fixes: d3ab332a5021 ("riscv: add ARCH_HAS_SET_MEMORY support")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/mm/pageattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index ea3d61de065b..23d169c4ee81 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -123,6 +123,13 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 				     &masks);
 	mmap_write_unlock(&init_mm);
 
+	if (current->active_mm != &init_mm) {
+		mmap_write_lock(current->active_mm);
+		ret =  walk_page_range_novma(current->active_mm, start, end,
+					     &pageattr_ops, NULL, &masks);
+		mmap_write_unlock(current->active_mm);
+	}
+
 	flush_tlb_kernel_range(start, end);
 
 	return ret;
-- 
2.36.1

