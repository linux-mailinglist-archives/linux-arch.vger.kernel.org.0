Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F663C077
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 13:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiK2M47 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Nov 2022 07:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiK2M4m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 07:56:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6060E8C;
        Tue, 29 Nov 2022 04:56:36 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9E7D91EC06C0;
        Tue, 29 Nov 2022 13:56:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669726594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AWsLPok7ViQ+W8W5j5jc7Ny6BIbEl/sE7BAZHJqUMoI=;
        b=BHCPPnysS0HVPQeJjNsZqqi9hT9kJDMWYdvBpAKwXf3E3MlbzG9wCwtk8GYdtXxbUa5pCR
        3iQdDNApBu2nlKJv+V0QyD/1M0sMFzy/B317BmWQ0+M3NKDdom0X2Nmm3+nApLH3Zj09hm
        OMpDe5wMH6a++coXw66oVTSqI8xofM0=
Date:   Tue, 29 Nov 2022 13:56:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V2 01/18] x86/sev: Pvalidate memory gab for
 decompressing kernel
Message-ID: <Y4YBfk3lyUJie4bR@zn.tnic>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-2-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221119034633.1728632-2-ltykernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 18, 2022 at 10:46:15PM -0500, Tianyu Lan wrote:
> Subject: Re: [RFC PATCH V2 01/18] x86/sev: Pvalidate memory gab for decompressing kernel

"gab"?

As in gabber? :-)

> From: Tianyu Lan <tiala@microsoft.com>
> 
> Pvalidate needed pages for decompressing kernel. The E820_TYPE_RAM

"Validate" - let's not start inventing new words. We're barely handling
the existing ones. :)

> entry includes only validated memory. The kernel expects that the
> RAM entry's addr is fixed while the entry size is to be extended

"addr"?

Commit message needs to be english - not a code/english hybrid. Pls be
more diligent here. Commit messages are not write-only.

> to cover addresses to the start of next entry. This patch increases

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Pls check your whole set.

Also, to the tone, from Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

> the RAM entry size to cover all possilble memory addresses until

Unknown word [possilble] in commit message.
Suggestions: ['possible', 'possibly', 'passable', 'plausible', 'assailable', 'pliable', 'passably']

Please introduce a spellchecker into your patch creation workflow.

> init_size.

This whole commit message doesn't tell me a whole lot. Please try
structuring it this way:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/boot/compressed/head_64.S |  8 +++
>  arch/x86/boot/compressed/sev.c     | 84 ++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index d33f060900d2..818edaf5d0cf 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -348,6 +348,14 @@ SYM_CODE_START(startup_64)
>  	cld
>  	cli
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/* pvalidate memory on demand if SNP is enabled. */

So this is going to be executed unconditionally on *every* SNP guest - not
only Hyper-V ones.

Why is that ok?

> +	pushq	%rsi
> +	movq    %rsi, %rdi
> +	call 	pvalidate_for_startup_64
> +	popq	%rsi
> +#endif
> +
>  	/* Setup data segments. */
>  	xorl	%eax, %eax
>  	movl	%eax, %ds
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 960968f8bf75..3a5a1ab16095 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -12,8 +12,10 @@
>   */
>  #include "misc.h"
>  
> +#include <asm/msr-index.h>
>  #include <asm/pgtable_types.h>
>  #include <asm/sev.h>
> +#include <asm/svm.h>
>  #include <asm/trapnr.h>
>  #include <asm/trap_pf.h>
>  #include <asm/msr-index.h>
> @@ -21,6 +23,7 @@
>  #include <asm/ptrace.h>
>  #include <asm/svm.h>
>  #include <asm/cpuid.h>
> +#include <asm/e820/types.h>
>  
>  #include "error.h"
>  #include "../msr.h"
> @@ -117,6 +120,22 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
>  /* Include code for early handlers */
>  #include "../../kernel/sev-shared.c"
>  
> +/* Check SEV-SNP via MSR */
> +static bool sev_snp_runtime_check(void)

Functions need to have a verb in the name.

> +{
> +	unsigned long low, high;
> +	u64 val;
> +
> +	asm volatile("rdmsr\n" : "=a" (low), "=d" (high) :
> +			"c" (MSR_AMD64_SEV));
> +
> +	val = (high << 32) | low;
> +	if (val & MSR_AMD64_SEV_SNP_ENABLED)
> +		return true;

There already is a sev_snp_enabled() in that very same file. Did you not
see it?

Why are you even adding such a function?!

> +	return false;
> +}
> +
>  static inline bool sev_snp_enabled(void)
>  {
>  	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
> @@ -456,3 +475,68 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
>  
>  	sev_verify_cbit(top_level_pgt);
>  }
> +
> +static void extend_e820_on_demand(struct boot_e820_entry *e820_entry,
> +				  u64 needed_ram_end)
> +{
> +	u64 end, paddr;
> +	unsigned long eflags;
> +	int rc;
> +
> +	if (!e820_entry)
> +		return;
> +
> +	/* Validated memory must be aligned by PAGE_SIZE. */
> +	end = ALIGN(e820_entry->addr + e820_entry->size, PAGE_SIZE);
> +	if (needed_ram_end > end && e820_entry->type == E820_TYPE_RAM) {
> +		for (paddr = end; paddr < needed_ram_end; paddr += PAGE_SIZE) {
> +			rc = pvalidate(paddr, RMP_PG_SIZE_4K, true);
> +			if (rc) {
> +				error("Failed to validate address.n");
> +				return;
> +			}
> +		}
> +		e820_entry->size = needed_ram_end - e820_entry->addr;
> +	}
> +}
> +
> +/*
> + * Explicitly pvalidate needed pages for decompressing the kernel.
> + * The E820_TYPE_RAM entry includes only validated memory. The kernel
> + * expects that the RAM entry's addr is fixed while the entry size is to be
> + * extended to cover addresses to the start of next entry.
> + * The function increases the RAM entry size to cover all possible memory

Similar issue as above: you don't need to say "this function" above this
function. IOW, it should say:

"Increase the RAM entry size..."

I.e., imperative mood above.

> + * addresses until init_size.
> + * For example,  init_end = 0x4000000,
> + * [RAM: 0x0 - 0x0],                       M[RAM: 0x0 - 0xa0000]
> + * [RSVD: 0xa0000 - 0x10000]                [RSVD: 0xa0000 - 0x10000]
> + * [ACPI: 0x10000 - 0x20000]      ==>       [ACPI: 0x10000 - 0x20000]
> + * [RSVD: 0x800000 - 0x900000]              [RSVD: 0x800000 - 0x900000]
> + * [RAM: 0x1000000 - 0x2000000]            M[RAM: 0x1000000 - 0x2001000]
> + * [RAM: 0x2001000 - 0x2007000]            M[RAM: 0x2001000 - 0x4000000]

What is this trying to tell me?

That the end range 0x2007000 gets raised to 0x4000000?

Why?

This all sounds like there is some requirement somewhere but nothing
says what that requirement is and why.

> + * Other RAM memory after init_end is pvalidated by ms_hyperv_init_platform
> + */
> +__visible void pvalidate_for_startup_64(struct boot_params *boot_params)

This doesn't do any validation. And yet it has "pvalidate" in the name.

> +{
> +	struct boot_e820_entry *e820_entry;
> +	u64 init_end =
> +		boot_params->hdr.pref_address + boot_params->hdr.init_size;

Nope, we never break lines like that.

> +	u8 i, nr_entries = boot_params->e820_entries;
> +	u64 needed_end;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

> +	if (!sev_snp_runtime_check())
> +		return;
> +
> +	for (i = 0; i < nr_entries; ++i) {
> +		/* Pvalidate memory holes in e820 RAM entries. */
> +		e820_entry = &boot_params->e820_table[i];
> +		if (i < nr_entries - 1) {
> +			needed_end = boot_params->e820_table[i + 1].addr;
> +			if (needed_end < e820_entry->addr)
> +				error("e820 table is not sorted.\n");
> +		} else {
> +			needed_end = init_end;
> +		}
> +		extend_e820_on_demand(e820_entry, needed_end);

Now *this* function does call pvalidate() and yet it doesn't have
"pvalidate" in the name. This all looks real confused.

So first of all, you need to explain *why* you're doing this.

It looks like it is because the guest needs to do the memory validation
by itself because nobody else does that.

If so, this needs to be explained in detail in the commit message.

Also, why is that ok for SNP guests on other hypervisors which get the
memory validated by the boot loader or firmware?

And so on and so on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
