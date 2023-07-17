Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00F756440
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jul 2023 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGQNSK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGQNRn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 09:17:43 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BE1268E;
        Mon, 17 Jul 2023 06:16:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30331E0011;
        Mon, 17 Jul 2023 13:16:51 +0000 (UTC)
Message-ID: <ad6e6873-5555-624b-6050-dbbcefb91e5a@ghiti.fr>
Date:   Mon, 17 Jul 2023 15:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4] riscv: kexec: Fixup synchronization problem between
 init_mm and active_mm
Content-Language: en-US
To:     guoren@kernel.org, palmer@rivosinc.com, paul.walmsley@sifive.com,
        zong.li@sifive.com, atishp@atishpatra.org, jszhang@kernel.org,
        bjorn@kernel.org, xingxg2008@163.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20230714103659.3146949-1-guoren@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230714103659.3146949-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 14/07/2023 12:36, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The machine_kexec() uses set_memory_x to modify the direct mapping
> attributes from RW to RWX. The current implementation of set_memory_x
> does not split hugepages in the linear mapping and then when a PGD
> mapping is used, the whole PGD is marked as executable. But changing
> the permissions at the PGD level must be propagated to all the page
> tables. When kexec jumps into control_buffer, the instruction page
> fault happens, and there is no minor_pagefault for it, then panic.
>
> The bug is found on an MMU_sv39 machine, and the direct mapping used a
> 1GB PUD, the pgd entries. Here is the bug output:
>
>   kexec_core: Starting new kernel
>   Will call new kernel at 00300000 from hart id 0
>   FDT image at 747c7000
>   Bye...
>   Unable to handle kernel paging request at virtual address ffffffda23b0d000
>   Oops [#1]
>   Modules linked in:
>   CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
>   Hardware name: Sophgo Mango (DT)
>   epc : 0xffffffda23b0d000
>    ra : machine_kexec+0xa6/0xb0
>   epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173d10
>    gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000000
>    t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173d50
>    s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300000
>    a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000000
>    a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : ffffffffffffffff
>    s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7000
>    s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
>    s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
>    s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff815351af
>    t5 : ffffffff815351b0 t6 : ffffffc80c173b50
>   status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 000000000000000c
>
> Given the current flaw in the set_memory_x implementation, the simplest
> solution is to fix machine_kexec() to remap control code page outside
> the linear mapping. Because the control code buffer was moved from the
> direct mapping area to the vmalloc location, we need an additional
> va_va_offset to fix up va_pa_offset.
>
> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reported-by: Xing XiaoGuang <xingxg2008@163.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
> Changelog:
> V4:
>   - Fixup va_pa_offset with additional va_va_offset.
>   - Add Reported-by tag.
>
> V3:
>   - Resume set_memory_x to set the _PAGE_EXEC attribute
>   - Optimize the commit log with Alexandre advice
>
> V2:
>   - Use vm_map_ram instead of modifying set_memory_x
>   - Correct Fixes tag
> ---
>   arch/riscv/include/asm/kexec.h    |  1 +
>   arch/riscv/kernel/machine_kexec.c | 18 +++++++++++++++---
>   2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> index 2b56769cb530..17456e91476e 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -41,6 +41,7 @@ crash_setup_regs(struct pt_regs *newregs,
>   struct kimage_arch {
>   	void *fdt; /* For CONFIG_KEXEC_FILE */
>   	unsigned long fdt_addr;
> +	void *control_code_buffer;
>   };
>   
>   extern const unsigned char riscv_kexec_relocate[];
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index 2d139b724bc8..60c1ef3c2232 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -86,7 +86,14 @@ machine_kexec_prepare(struct kimage *image)
>   
>   	/* Copy the assembler code for relocation to the control page */
>   	if (image->type != KEXEC_TYPE_CRASH) {
> -		control_code_buffer = page_address(image->control_code_page);
> +		control_code_buffer = vm_map_ram(&image->control_code_page,
> +						 KEXEC_CONTROL_PAGE_SIZE/PAGE_SIZE,
> +						 NUMA_NO_NODE);
> +		if (control_code_buffer == NULL) {
> +			pr_err("Failed to vm_map control page\n");
> +			return -ENOMEM;
> +		}
> +
>   		control_code_buffer_sz = page_size(image->control_code_page);
>   
>   		if (unlikely(riscv_kexec_relocate_size > control_code_buffer_sz)) {
> @@ -99,6 +106,8 @@ machine_kexec_prepare(struct kimage *image)
>   
>   		/* Mark the control page executable */
>   		set_memory_x((unsigned long) control_code_buffer, 1);
> +
> +		internal->control_code_buffer = control_code_buffer;
>   	}
>   
>   	return 0;
> @@ -211,7 +220,10 @@ machine_kexec(struct kimage *image)
>   	unsigned long this_cpu_id = __smp_processor_id();
>   	unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
>   	unsigned long fdt_addr = internal->fdt_addr;
> -	void *control_code_buffer = page_address(image->control_code_page);
> +	void *control_code_buffer = internal->control_code_buffer;
> +	unsigned long va_va_offset =
> +			(unsigned long) page_address(image->control_code_page)
> +		      - (unsigned long) control_code_buffer;
>   	riscv_kexec_method kexec_method = NULL;
>   
>   #ifdef CONFIG_SMP
> @@ -234,6 +246,6 @@ machine_kexec(struct kimage *image)
>   	/* Jump to the relocation code */
>   	pr_notice("Bye...\n");
>   	kexec_method(first_ind_entry, jump_addr, fdt_addr,
> -		     this_hart_id, kernel_map.va_pa_offset);
> +		     this_hart_id, kernel_map.va_pa_offset - va_va_offset);
>   	unreachable();
>   }


I started working on the set_memory fix and the first thing to do is to 
prevent the use of PGD mapping, it's too cumbersome to propagate changes 
at this level: IIRC x86 keeps a list of page tables to go through 
whenever that happens, that's why Bjorn pre-allocated all the PGD 
entries to cover the vmalloc region.

So, to me, the simple fix for this issue is to prevent the use of PGD 
mapping. What do you think? Does the following patch work?


diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 70fb31960b63..6dd12443bfa4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -662,13 +662,12 @@ void __init create_pgd_mapping(pgd_t *pgdp,
  static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
                                       phys_addr_t size)
  {
-       if (!(pa & (PGDIR_SIZE - 1)) && !(va & (PGDIR_SIZE - 1)) && size 
 >= PGDIR_SIZE)
-               return PGDIR_SIZE;
-
-       if (!(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= 
P4D_SIZE)
+       if (pgtable_l5_enabled &&
+           !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= 
P4D_SIZE)
                 return P4D_SIZE;

-       if (!(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= 
PUD_SIZE)
+       if (pgtable_l4_enabled &&
+           !(pa & (PUD_SIZE - 1)) && !(va & (PUD_SIZE - 1)) && size >= 
PUD_SIZE)
                 return PUD_SIZE;

         if (!(pa & (PMD_SIZE - 1)) && !(va & (PMD_SIZE - 1)) && size >= 
PMD_SIZE)


Thanks,

Alex

