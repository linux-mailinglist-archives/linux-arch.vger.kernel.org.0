Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA34774CC4E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 07:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGJFkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 01:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGJFku (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 01:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C14A8;
        Sun,  9 Jul 2023 22:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D630560DFE;
        Mon, 10 Jul 2023 05:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF2DC433C7;
        Mon, 10 Jul 2023 05:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688967648;
        bh=vTePZySJwROm5kopsmfpT+96m9V/ekc/sUd11srBFsU=;
        h=From:To:Cc:Subject:Date:From;
        b=YWmXKZSqljsSEjQnsy1OYiCfCaPh2j1hzxcY/ZLIkpotGxHgoJM5wkIKD7Go1IcRV
         cfJwcsPsQdTbXlFiDpUYgfj3lpAMuZRUEQqBuj6dOlB5Ev14XeXsfd6fsd88lLIDCm
         cVmu5BCSMYaRKXqdXfCsPmrsT+g1inMmhTyQ13so+6W6hZrMCgRHwQlhxdSnKdwCjh
         v++6Z0GP66TwoQmjwWQgAwwkbE/fiJBu7Jr0NtV5pPhs2Mdw8CFlTbC2KBA0GYIIRu
         FWGX3u0fURZZj9hQuSpEjDYgYryvisP1XPwyVJnJ3fYmI+r1vS22O/2vb/VAdUNN73
         jPXdeZ53PuEMQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        zong.li@sifive.com, atishp@atishpatra.org, alex@ghiti.fr,
        jszhang@kernel.org, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2] riscv: kexec: Fixup synchronization problem between init_mm and active_mm
Date:   Mon, 10 Jul 2023 01:40:29 -0400
Message-Id: <20230710054029.2026124-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The machine_kexec() uses set_memory_x to modify the direct mapping
attributes from RW to RWX. But set_memory_x only changes the init_mm's
attributes, not current->active_mm, so when kexec jumps into
control_buffer, the instruction page fault happens, and there is no
minor_pagefault for it, then panic.

The bug is found on an MMU_sv39 machine, and the direct mapping used a
1GB PUD, the pgd entries. Here is the bug output:

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

The solution is to fix machine_kexec() to remap control code page outside
the linear mapping.

Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>
---
Changelog:
V2:
 - Use vm_map_ram instead of modifying set_memory_x
 - Correct Fixes tag
---
 arch/riscv/include/asm/kexec.h    |  1 +
 arch/riscv/kernel/machine_kexec.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
index 2b56769cb530..17456e91476e 100644
--- a/arch/riscv/include/asm/kexec.h
+++ b/arch/riscv/include/asm/kexec.h
@@ -41,6 +41,7 @@ crash_setup_regs(struct pt_regs *newregs,
 struct kimage_arch {
 	void *fdt; /* For CONFIG_KEXEC_FILE */
 	unsigned long fdt_addr;
+	void *control_code_buffer;
 };
 
 extern const unsigned char riscv_kexec_relocate[];
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index 2d139b724bc8..eeb209775107 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -86,7 +86,14 @@ machine_kexec_prepare(struct kimage *image)
 
 	/* Copy the assembler code for relocation to the control page */
 	if (image->type != KEXEC_TYPE_CRASH) {
-		control_code_buffer = page_address(image->control_code_page);
+		control_code_buffer = vm_map_ram(&image->control_code_page,
+						 KEXEC_CONTROL_PAGE_SIZE/PAGE_SIZE,
+						 NUMA_NO_NODE);
+		if (control_code_buffer == NULL) {
+			pr_err("Failed to vm_map control page\n");
+			return -ENOMEM;
+		}
+
 		control_code_buffer_sz = page_size(image->control_code_page);
 
 		if (unlikely(riscv_kexec_relocate_size > control_code_buffer_sz)) {
@@ -97,8 +104,7 @@ machine_kexec_prepare(struct kimage *image)
 		memcpy(control_code_buffer, riscv_kexec_relocate,
 			riscv_kexec_relocate_size);
 
-		/* Mark the control page executable */
-		set_memory_x((unsigned long) control_code_buffer, 1);
+		internal->control_code_buffer = control_code_buffer;
 	}
 
 	return 0;
@@ -211,7 +217,7 @@ machine_kexec(struct kimage *image)
 	unsigned long this_cpu_id = __smp_processor_id();
 	unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
 	unsigned long fdt_addr = internal->fdt_addr;
-	void *control_code_buffer = page_address(image->control_code_page);
+	void *control_code_buffer = internal->control_code_buffer;
 	riscv_kexec_method kexec_method = NULL;
 
 #ifdef CONFIG_SMP
-- 
2.36.1

