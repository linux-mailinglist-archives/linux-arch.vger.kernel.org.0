Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A922750B36
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGLOny (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 10:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjGLOnw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 10:43:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58EF1992
        for <linux-arch@vger.kernel.org>; Wed, 12 Jul 2023 07:43:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso4202834b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 12 Jul 2023 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689173030; x=1691765030;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceMjwisW+ab8NqZ500BBUyHWe9aEsqGZ9FsaMuVtg+Y=;
        b=jkPcgt5Dy+IC0k/EsLIi7/BcYygeQIjWSbV3+3FmrgcKalXgnhmVXLStYiDmAmpySG
         CFqzwdTGJs5rP6AR/MAGZMNaDmi0Sxa19w22SHUDVEKNyHGRkpjPh904WKNDQDG0/HSY
         65KTXNDO4fqdbccpflanCIA2p1sBQzjLgtOf2Zee39crPyJHZzPcklKJmcd2CLu4vJXo
         mwKg+TFXzpLYNXO/nRbzaxokRzNw0Iz4KzC6uvGhYrfnR2y/9NCfumiFK3A1xvxMvL65
         dtKG+1Uqo87VGHpMvK7MZSPCZbxkP/mO+MTrVnZNO4cYwKJugMAETlRYG08uU8L4SYY/
         qasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173030; x=1691765030;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceMjwisW+ab8NqZ500BBUyHWe9aEsqGZ9FsaMuVtg+Y=;
        b=f/bXv6e9XG+fhzLzoa8+hfl3BklR6z4L+nxsFBf6hIziZJzApZV7vebEmUbiqDCdz3
         IzTqKwqVzQ9LmkJLkXlliLF4uQdLiPTiBowjLyMor2w2qnkProsO8tlG/LgtQ/SKP6JB
         7o659X0dNU9VVwUhLy5zqszXYMSNaNYtLsqcAEi7TKIzsBypRw11TDCRQsH+vQg8V2D7
         IVFoCM2nFM8xMiZeOVCl4f0vnqbIwzSG6z3PEKq1TZGsRCnBxbxVKdCMzOshTcuwWO36
         /ZiTpyvOZwgz8xX+j0zwS4JPir2THyVmZQwlAgzuyDwU3xwCSU/PIQhsTyT3kOEmoaYW
         8pDA==
X-Gm-Message-State: ABy/qLaT8gdG0cMrARq76w3UDUViv34/HLm9BOaqf+l7a6nsyZF81WDU
        37FzkeoNzBKhcumtYXk470Vo5Q==
X-Google-Smtp-Source: APBJJlGBwe2qfhUnKQIlzRfXecJ9MpSW3/DQVLGNsTikl9RzTTpPOfZ4GrFHGm0hpMEFF17vPLlNog==
X-Received: by 2002:a05:6a20:729f:b0:132:7fb3:3325 with SMTP id o31-20020a056a20729f00b001327fb33325mr4105171pzk.59.1689173030066;
        Wed, 12 Jul 2023 07:43:50 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id d9-20020a639909000000b0054f9936accesm3652942pge.55.2023.07.12.07.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:43:49 -0700 (PDT)
Date:   Wed, 12 Jul 2023 07:43:49 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jul 2023 07:43:02 PDT (-0700)
Subject:     Re: [PATCH V2] riscv: kexec: Fixup synchronization problem between init_mm and active_mm
In-Reply-To: <95c4e875-02f1-6239-bb62-41b709d21541@ghiti.fr>
CC:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        zong.li@sifive.com, atishp@atishpatra.org, jszhang@kernel.org,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     alex@ghiti.fr
Message-ID: <mhng-5d9d9723-1dc1-4429-a477-eb4ece20bb87@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 11 Jul 2023 04:07:22 PDT (-0700), alex@ghiti.fr wrote:
> Hi Guo,
>
>
> On 10/07/2023 07:40, guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> The machine_kexec() uses set_memory_x to modify the direct mapping
>> attributes from RW to RWX. But set_memory_x only changes the init_mm's
>> attributes, not current->active_mm, so when kexec jumps into
>> control_buffer, the instruction page fault happens, and there is no
>> minor_pagefault for it, then panic.
>
>
> I think it needs more details like this:
>
> "The current implementation of set_memory_x does not split hugepages in
> the linear mapping and then when a PGD mapping is used, the whole PGD is
> marked as executable. But changing the permissions at the PGD level must
> be propagated to all the page tables."
>
>
>>
>> The bug is found on an MMU_sv39 machine, and the direct mapping used a
>> 1GB PUD, the pgd entries. Here is the bug output:
>>
>>   kexec_core: Starting new kernel
>>   Will call new kernel at 00300000 from hart id 0
>>   FDT image at 747c7000
>>   Bye...
>>   Unable to handle kernel paging request at virtual address ffffffda23b0d000
>>   Oops [#1]
>>   Modules linked in:
>>   CPU: 0 PID: 53 Comm: uinit Not tainted 6.4.0-rc6 #15
>>   Hardware name: Sophgo Mango (DT)
>>   epc : 0xffffffda23b0d000
>>    ra : machine_kexec+0xa6/0xb0
>>   epc : ffffffda23b0d000 ra : ffffffff80008272 sp : ffffffc80c173d10
>>    gp : ffffffff8150e1e0 tp : ffffffd9073d2c40 t0 : 0000000000000000
>>    t1 : 0000000000000042 t2 : 6567616d69205444 s0 : ffffffc80c173d50
>>    s1 : ffffffd9076c4800 a0 : ffffffd9076c4800 a1 : 0000000000300000
>>    a2 : 00000000747c7000 a3 : 0000000000000000 a4 : ffffffd800000000
>>    a5 : 0000000000000000 a6 : ffffffd903619c40 a7 : ffffffffffffffff
>>    s2 : ffffffda23b0d000 s3 : 0000000000300000 s4 : 00000000747c7000
>>    s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
>>    s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
>>    s11: 0000003f940001a0 t3 : ffffffff815351af t4 : ffffffff815351af
>>    t5 : ffffffff815351b0 t6 : ffffffc80c173b50
>>   status: 0000000200000100 badaddr: ffffffda23b0d000 cause: 000000000000000c
>>
>> The solution is to fix machine_kexec() to remap control code page outside
>> the linear mapping.
>
>
> "Given the current flaw in the set_memory_x implementation, the simplest
> solution is to ..."
>
>
>>
>> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> Cc: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>> Changelog:
>> V2:
>>   - Use vm_map_ram instead of modifying set_memory_x
>>   - Correct Fixes tag
>> ---
>>   arch/riscv/include/asm/kexec.h    |  1 +
>>   arch/riscv/kernel/machine_kexec.c | 14 ++++++++++----
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
>> index 2b56769cb530..17456e91476e 100644
>> --- a/arch/riscv/include/asm/kexec.h
>> +++ b/arch/riscv/include/asm/kexec.h
>> @@ -41,6 +41,7 @@ crash_setup_regs(struct pt_regs *newregs,
>>   struct kimage_arch {
>>   	void *fdt; /* For CONFIG_KEXEC_FILE */
>>   	unsigned long fdt_addr;
>> +	void *control_code_buffer;
>>   };
>>
>>   extern const unsigned char riscv_kexec_relocate[];
>> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
>> index 2d139b724bc8..eeb209775107 100644
>> --- a/arch/riscv/kernel/machine_kexec.c
>> +++ b/arch/riscv/kernel/machine_kexec.c
>> @@ -86,7 +86,14 @@ machine_kexec_prepare(struct kimage *image)
>>
>>   	/* Copy the assembler code for relocation to the control page */
>>   	if (image->type != KEXEC_TYPE_CRASH) {
>> -		control_code_buffer = page_address(image->control_code_page);
>> +		control_code_buffer = vm_map_ram(&image->control_code_page,
>> +						 KEXEC_CONTROL_PAGE_SIZE/PAGE_SIZE,
>> +						 NUMA_NO_NODE);
>> +		if (control_code_buffer == NULL) {
>> +			pr_err("Failed to vm_map control page\n");
>> +			return -ENOMEM;
>> +		}
>> +
>>   		control_code_buffer_sz = page_size(image->control_code_page);
>>
>>   		if (unlikely(riscv_kexec_relocate_size > control_code_buffer_sz)) {
>> @@ -97,8 +104,7 @@ machine_kexec_prepare(struct kimage *image)
>>   		memcpy(control_code_buffer, riscv_kexec_relocate,
>>   			riscv_kexec_relocate_size);
>>
>> -		/* Mark the control page executable */
>> -		set_memory_x((unsigned long) control_code_buffer, 1);
>> +		internal->control_code_buffer = control_code_buffer;
>
>
> Where is this mapping marked as executable? I see that vm_map_ram() maps
> the pages as PAGE_KERNEL, which does not set PAGE_EXEC.
>
>
>>   	}
>>
>>   	return 0;
>> @@ -211,7 +217,7 @@ machine_kexec(struct kimage *image)
>>   	unsigned long this_cpu_id = __smp_processor_id();
>>   	unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
>>   	unsigned long fdt_addr = internal->fdt_addr;
>> -	void *control_code_buffer = page_address(image->control_code_page);
>> +	void *control_code_buffer = internal->control_code_buffer;
>>   	riscv_kexec_method kexec_method = NULL;
>>
>>   #ifdef CONFIG_SMP
>
>
> Otherwise, you can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks,
>
> Alex

Thanks for looking at this.  Guo: do you have a re-spit that fixes the 
issues Alex pointed out?  Sorry if I just missed it.
