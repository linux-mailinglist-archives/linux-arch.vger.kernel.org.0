Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BF78948D
	for <lists+linux-arch@lfdr.de>; Sat, 26 Aug 2023 09:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjHZHwz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Aug 2023 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjHZHwz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Aug 2023 03:52:55 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAB22701;
        Sat, 26 Aug 2023 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1693036356; bh=IFoYkf9fzSapG1XLKYIAL15Uu/RdIf8Jfzku7YLWtZ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g2ocIZzkMykzHJKVmZnJ4WMK9j6ZPEgJ8ahMqXA1vdXi+TNqxReYdp5vn8EaKskvf
         vhSO+X2zSJU4+fL31dlC5Szgd0XIaHg3SjHNw1wup9nXYSsHd66saFA4Fhwzo/UdtR
         OUOOWOIzVUAta26YmWXoQeGmwpMGsiJUY2WmmJf8=
Received: from [192.168.9.172] (unknown [101.88.24.218])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 00863600DA;
        Sat, 26 Aug 2023 15:52:35 +0800 (CST)
Message-ID: <0b509186-bf01-2151-0954-d669075c1f71@xen0n.name>
Date:   Sat, 26 Aug 2023 15:52:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] LoongArch: Ensure FP/SIMD registers in the core dump file
 is up to date
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230825114224.3886577-1-chenhuacai@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230825114224.3886577-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/25/23 19:42, Huacai Chen wrote:
> This is a port of commit 379eb01c21795edb4c ("riscv: Ensure the value
> of FP registers in the core dump file is up to date").
>
> The values of FP/SIMD registers in the core dump file come from the
> thread.fpu. However, kernel saves the FP/SIMD registers only before
> scheduling out the process. If no process switch happens during the
> exception handling, kernel will not have a chance to save the latest
> values of FP/SIMD registers. So it may cause their values in the core
> dump file incorrect. To solve this problem, force fpr_get()/simd_get()
> to save the FP/SIMD registers into the thread.fpu if the target task
> equals the current task.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/fpu.h | 22 ++++++++++++++++++----
>   arch/loongarch/kernel/ptrace.c   |  4 ++++
>   2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
> index b541f6248837..08a45e9fd15c 100644
> --- a/arch/loongarch/include/asm/fpu.h
> +++ b/arch/loongarch/include/asm/fpu.h
> @@ -173,16 +173,30 @@ static inline void restore_fp(struct task_struct *tsk)
>   		_restore_fp(&tsk->thread.fpu);
>   }
>   
> -static inline union fpureg *get_fpu_regs(struct task_struct *tsk)
> +static inline void get_fpu_regs(struct task_struct *tsk)
Removing the return value from the signature means the function is no 
longer a getter, so maybe the name should get changed as well? Like 
"save_fpu_regs"?
>   {
> +	unsigned int euen;
> +
>   	if (tsk == current) {
>   		preempt_disable();
> -		if (is_fpu_owner())
> +
> +		euen = csr_read32(LOONGARCH_CSR_EUEN);
> +
> +#ifdef CONFIG_CPU_HAS_LASX
> +		if (euen & CSR_EUEN_LASXEN)
> +			_save_lasx(&current->thread.fpu);
> +		else
> +#endif
> +#ifdef CONFIG_CPU_HAS_LSX
> +		if (euen & CSR_EUEN_LSXEN)
> +			_save_lsx(&current->thread.fpu);
> +		else
> +#endif
> +		if (euen & CSR_EUEN_FPEN)
>   			_save_fp(&current->thread.fpu);
> +
>   		preempt_enable();
>   	}
> -
> -	return tsk->thread.fpu.fpr;
>   }
>   
>   static inline int is_simd_owner(void)
> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
> index 2bb5ec55ae1e..209e3d29e0b2 100644
> --- a/arch/loongarch/kernel/ptrace.c
> +++ b/arch/loongarch/kernel/ptrace.c
> @@ -148,6 +148,8 @@ static int fpr_get(struct task_struct *target,
>   {
>   	int r;
>   
> +	get_fpu_regs(target);
> +
>   	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
>   		r = gfpr_get(target, &to);
>   	else
> @@ -279,6 +281,8 @@ static int simd_get(struct task_struct *target,
>   {
>   	const unsigned int wr_size = NUM_FPU_REGS * regset->size;
>   
> +	get_fpu_regs(target);
> +
>   	if (!tsk_used_math(target)) {
>   		/* The task hasn't used FP or LSX, fill with 0xff */
>   		copy_pad_fprs(target, regset, &to, 0);

Otherwise this should be fine. (I don't know why that helper is 
previously unused though...)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

