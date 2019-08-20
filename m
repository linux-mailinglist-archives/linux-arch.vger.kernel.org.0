Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27899663C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2019 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfHTQYq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Aug 2019 12:24:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39076 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfHTQYp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Aug 2019 12:24:45 -0400
Received: from zn.tnic (p200300EC2F0AD10054FA108E4D195499.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:d100:54fa:108e:4d19:5499])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8094B1EC02FE;
        Tue, 20 Aug 2019 18:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566318283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NGnVqa16rPX0cXr/XJ6lkjkQU4KzhAJENarQRTbs9mo=;
        b=catOGVLhpO3GzYy5nV3vQXJJtlo1h3YS4Pi/mMV/4hPlTH9XXWCAWaHJeL2rxEjNazFTGl
        l26WRJgqQpieEb8P7tfh60zJlv5dHPzlIZQqqVGxlVqxFwdIrGKYDGTZEwC5lBlsif+JSC
        wBn1sa13tCKeoKhUWYIVCM49FOFReRc=
Date:   Tue, 20 Aug 2019 18:24:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/28] x86/asm/head: annotate data appropriatelly
Message-ID: <20190820162435.GH31607@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-12-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-12-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Subject: Re: [PATCH v8 11/28] x86/asm/head: annotate data appropriatelly

appropriately

On Thu, Aug 08, 2019 at 12:38:37PM +0200, Jiri Slaby wrote:
> Use the new SYM_DATA, SYM_DATA_START, and SYM_DATA_END in both 32 and 64
> bit heads.  In the 64-bit version, define also
> SYM_DATA_START_PAGE_ALIGNED locally using the new SYM_START. It is used
> in the code instead of NEXT_PAGE() which was defined in this file and
> has been using the obsolete macro GLOBAL().
> 
> Now, the data in the 64-bit object file look sane:
> Value   Size Type    Bind   Vis      Ndx Name
>   0000  4096 OBJECT  GLOBAL DEFAULT   15 init_level4_pgt
>   1000  4096 OBJECT  GLOBAL DEFAULT   15 level3_kernel_pgt
>   2000  2048 OBJECT  GLOBAL DEFAULT   15 level2_kernel_pgt
>   3000  4096 OBJECT  GLOBAL DEFAULT   15 level2_fixmap_pgt
>   4000  4096 OBJECT  GLOBAL DEFAULT   15 level1_fixmap_pgt
>   5000     2 OBJECT  GLOBAL DEFAULT   15 early_gdt_descr
>   5002     8 OBJECT  LOCAL  DEFAULT   15 early_gdt_descr_base
>   500a     8 OBJECT  GLOBAL DEFAULT   15 phys_base
>   0000     8 OBJECT  GLOBAL DEFAULT   17 initial_code
>   0008     8 OBJECT  GLOBAL DEFAULT   17 initial_gs
>   0010     8 OBJECT  GLOBAL DEFAULT   17 initial_stack
>   0000     4 OBJECT  GLOBAL DEFAULT   19 early_recursion_flag
>   1000  4096 OBJECT  GLOBAL DEFAULT   19 early_level4_pgt
>   2000 0x40000 OBJECT  GLOBAL DEFAULT   19 early_dynamic_pgts
>   0000  4096 OBJECT  GLOBAL DEFAULT   22 empty_zero_page
> 
> All have correct size and type.

Nice.

> 
> Note, that we can now see that it might be worth pushing
> early_recursion_flag after early_dynamic_pgts -- we are wasting almost
> 4K of .init.data.

Yes, please do in a separate patch which can even go separately. I get
here:

---
Disassembly of section .init.data:

ffffffff82684000 <early_recursion_flag>:
        ...

ffffffff82685000 <early_top_pgt>:
        ...

ffffffff82686000 <early_dynamic_pgts>:
        ...

ffffffff826c6000 <next_early_pgt>:
        ...

ffffffff826c6020 <initcall_level_names>:
---


vs


---
Disassembly of section .init.data:

ffffffff82684000 <early_top_pgt>:
        ...

ffffffff82685000 <early_dynamic_pgts>:
        ...

ffffffff826c5000 <early_recursion_flag>:
ffffffff826c5000:       00 00                   add    %al,(%rax)
        ...

ffffffff826c5004 <next_early_pgt>:
        ...

ffffffff826c5020 <initcall_level_names>:
---

That's exactly 4K saved.


> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/kernel/head_32.S | 29 ++++++++-------
>  arch/x86/kernel/head_64.S | 78 +++++++++++++++++++++------------------
>  2 files changed, 58 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
> index 0bae769b7b59..2d5390d84467 100644
> --- a/arch/x86/kernel/head_32.S
> +++ b/arch/x86/kernel/head_32.S
> @@ -502,8 +502,7 @@ ENDPROC(early_ignore_irq)
>  
>  __INITDATA
>  	.align 4
> -GLOBAL(early_recursion_flag)
> -	.long 0
> +SYM_DATA(early_recursion_flag, .long 0)
>  
>  __REFDATA
>  	.align 4
> @@ -551,7 +550,7 @@ EXPORT_SYMBOL(empty_zero_page)
>  __PAGE_ALIGNED_DATA
>  	/* Page-aligned for the benefit of paravirt? */
>  	.align PGD_ALIGN
> -ENTRY(initial_page_table)
> +SYM_DATA_START(initial_page_table)
>  	.long	pa(initial_pg_pmd+PGD_IDENT_ATTR),0	/* low identity map */
>  # if KPMDS == 3
>  	.long	pa(initial_pg_pmd+PGD_IDENT_ATTR),0
> @@ -569,17 +568,18 @@ ENTRY(initial_page_table)
>  #  error "Kernel PMDs should be 1, 2 or 3"
>  # endif
>  	.align PAGE_SIZE		/* needs to be page-sized too */
> +SYM_DATA_END(initial_page_table)
>  #endif
>  
>  .data
>  .balign 4
> -ENTRY(initial_stack)
> -	/*
> -	 * The SIZEOF_PTREGS gap is a convention which helps the in-kernel
> -	 * unwinder reliably detect the end of the stack.
> -	 */
> -	.long init_thread_union + THREAD_SIZE - SIZEOF_PTREGS - \
> -	      TOP_OF_KERNEL_STACK_PADDING;
> +/*
> + * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
> + * reliably detect the end of the stack.
> + */
> +SYM_DATA(initial_stack,
> +		.long init_thread_union + THREAD_SIZE -
> +		SIZEOF_PTREGS - TOP_OF_KERNEL_STACK_PADDING)
>  
>  __INITRODATA
>  int_msg:
> @@ -600,22 +600,25 @@ int_msg:
>  	ALIGN
>  # early boot GDT descriptor (must use 1:1 address mapping)
>  	.word 0				# 32 bit align gdt_desc.address
> -boot_gdt_descr:
> +SYM_DATA_START(boot_gdt_descr)
>  	.word __BOOT_DS+7
>  	.long boot_gdt - __PAGE_OFFSET
> +SYM_DATA_END(boot_gdt_descr)

So there's one "globl boot_gdt_descr" above already and this turns into:

 .data
.globl boot_gdt_descr
^^^^^^^^^^^^^^^^^^^^^

 .align 4,0x90
 # early boot GDT descriptor (must use 1:1 address mapping)
 .word 0 # 32 bit align gdt_desc.address
.globl boot_gdt_descr ; ; boot_gdt_descr:
^^^^^^^^^^^^^^^^^^^^^

I guess you can remove the above one.

Also, this can be made a local symbol too.

>  # boot GDT descriptor (later on used by CPU#0):
>  	.word 0				# 32 bit align gdt_desc.address
> -ENTRY(early_gdt_descr)
> +SYM_DATA_START(early_gdt_descr)
>  	.word GDT_ENTRIES*8-1
>  	.long gdt_page			/* Overwritten for secondary CPUs */
> +SYM_DATA_END(early_gdt_descr)
>  
>  /*
>   * The boot_gdt must mirror the equivalent in setup.S and is
>   * used only for booting.
>   */
>  	.align L1_CACHE_BYTES
> -ENTRY(boot_gdt)
> +SYM_DATA_START(boot_gdt)
>  	.fill GDT_ENTRY_BOOT_CS,8,0
>  	.quad 0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
>  	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
> +SYM_DATA_END(boot_gdt)
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 6fedcda37634..6661c76a2049 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -260,16 +260,14 @@ END(start_cpu0)
>  	/* Both SMP bootup and ACPI suspend change these variables */
>  	__REFDATA
>  	.balign	8
> -	GLOBAL(initial_code)
> -	.quad	x86_64_start_kernel
> -	GLOBAL(initial_gs)
> -	.quad	INIT_PER_CPU_VAR(fixed_percpu_data)
> -	GLOBAL(initial_stack)
> -	/*
> -	 * The SIZEOF_PTREGS gap is a convention which helps the in-kernel
> -	 * unwinder reliably detect the end of the stack.
> -	 */
> -	.quad  init_thread_union + THREAD_SIZE - SIZEOF_PTREGS
> +SYM_DATA(initial_code,	.quad x86_64_start_kernel)
> +SYM_DATA(initial_gs,	.quad INIT_PER_CPU_VAR(fixed_percpu_data))

<---- newline here.

> +/*
> + * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
> + * reliably detect the end of the stack.
> + */
> +SYM_DATA(initial_stack,
> +		.quad init_thread_union + THREAD_SIZE - SIZEOF_PTREGS)

No need to break that line.

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
