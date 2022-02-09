Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E04AFCE3
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiBITHJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:07:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiBITHJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:07:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAD4C03C182;
        Wed,  9 Feb 2022 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433621; x=1675969621;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=wb1fycuK3dchIdqoxSdcM/HUFC250JplLEY4j/mimkQ=;
  b=dxSBfcTq6M8KiFSxrXmfsRE5VhF2h6dc6dTzuvbL1N5jxxrmhbp9q9wS
   7tEuS69hFA9ERyZvSkaNEZ5dXmj6ZI0VccIQc3WyXexWNEE9gaC0AfArq
   VibYDw5sjYbiuiYsr2sBJootlEWfIDn9qLwJ9pLGKB8kNgkNoWJXc59af
   ivmAj3llJxqwlaMKFhJ7y3IxYBDsR+HFneFMD9mcJjqDOycLZbm8NU/DY
   GSsFRQ/KnNRO8N+eYavKyarhKatrOkaGD/IR3qMcG4XXo+K36vNgcqn+w
   oywoZE0PcFnKmarQZAjGBFT/ZUcmLZDneNBzwxixBrOXHWQgh/d+WCyvn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249256651"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249256651"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 11:06:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="485378938"
Received: from sanvery-mobl.amr.corp.intel.com (HELO [10.212.232.139]) ([10.212.232.139])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 11:06:28 -0800
Message-ID: <528d5372-0591-857c-0c2b-eb8580f517ca@intel.com>
Date:   Wed, 9 Feb 2022 11:06:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-16-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 15/35] x86/mm: Check Shadow Stack page fault errors
In-Reply-To: <20220130211838.8382-16-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Shadow stack accesses are those that are performed by the CPU where it
> expects to encounter a shadow stack mapping.  These accesses are performed
> implicitly by CALL/RET at the site of the shadow stack pointer.  These
> accesses are made explicitly by shadow stack management instructions like
> WRUSSQ.

The passive voice is killing me.  Here's a rewrite:

	The CPU performs "shadow stack accesses" when it expects to
	encounter shadow stack mappings.  These accesses can be
	implicit (via CALL/RET instructions) or explicit (instructions
	like WRUSSQ).

Since we defined what a shadow stack access *is*, shouldn't we also
connect it to X86_PF_SHSTK?

> Shadow stacks accesses to shadow-stack mapping can see faults in normal,

					   ^ mappings

> valid operation just like regular accesses to regular mappings.  Shadow
> stacks need some of the same features like delayed allocation, swap and
> copy-on-write.

... and use faults to implement those features.

> Shadow stack accesses can also result in errors, such as when a shadow
> stack overflows, or if a shadow stack access occurs to a non-shadow-stack
> mapping.

Those two paragraphs tell a pretty good story.  Nice.

> In handling a shadow stack page fault, verify it occurs within a shadow
> stack mapping.  It is always an error otherwise.  For valid shadow stack
> accesses, set FAULT_FLAG_WRITE to effect copy-on-write.  Because clearing
> _PAGE_DIRTY (vs. _PAGE_RW) is used to trigger the fault, shadow stack read
> fault and shadow stack write fault are not differentiated and both are
> handled as a write access.

This paragraph is a rehash of what the code does.  It can go.

*But*, with or without this paragraph, the reader is left with all
background and no discussion of why this patch exists.

Even just this would be fine:

	Handle valid and invalid shadow-stack accesses in the page fault
	handler.


> diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
> index 10b1de500ab1..afa524325e55 100644
> --- a/arch/x86/include/asm/trap_pf.h
> +++ b/arch/x86/include/asm/trap_pf.h
> @@ -11,6 +11,7 @@
>   *   bit 3 ==				1: use of reserved bit detected
>   *   bit 4 ==				1: fault was an instruction fetch
>   *   bit 5 ==				1: protection keys block access
> + *   bit 6 ==				1: shadow stack access fault
>   *   bit 15 ==				1: SGX MMU page-fault
>   */
>  enum x86_pf_error_code {
> @@ -20,6 +21,7 @@ enum x86_pf_error_code {
>  	X86_PF_RSVD	=		1 << 3,
>  	X86_PF_INSTR	=		1 << 4,
>  	X86_PF_PK	=		1 << 5,
> +	X86_PF_SHSTK	=		1 << 6,
>  	X86_PF_SGX	=		1 << 15,
>  };
>  
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index d0074c6ed31a..6769134986ec 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1107,6 +1107,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>  				       (error_code & X86_PF_INSTR), foreign))
>  		return 1;
>  
> +	/*
> +	 * Verify a shadow stack access is within a shadow stack VMA.
> +	 * It is always an error otherwise.  Normal data access to a
> +	 * shadow stack area is checked in the case followed.
> +	 */

That comment needs some help.  Maybe:

	Shadow stack accesses (PF_SHSTK=1) are only permitted to
	shadow stack VMAs.  All other accesses result in an error.

I don't think we need to talk about the other cases being handled below.

> +	if (error_code & X86_PF_SHSTK) {
> +		if (!(vma->vm_flags & VM_SHADOW_STACK))
> +			return 1;
> +		return 0;
> +	}
> +
>  	if (error_code & X86_PF_WRITE) {
>  		/* write, present and write, not present: */
>  		if (unlikely(!(vma->vm_flags & VM_WRITE)))
> @@ -1300,6 +1311,14 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +	/*
> +	 * Clearing _PAGE_DIRTY is used to detect shadow stack access.
> +	 * This method cannot distinguish shadow stack read vs. write.
> +	 * For valid shadow stack accesses, set FAULT_FLAG_WRITE to effect
> +	 * copy-on-write.
> +	 */

Too much detail.  This is also rather unconnected to the code I can see:

> +	if (error_code & X86_PF_SHSTK)
> +		flags |= FAULT_FLAG_WRITE;

Also, the use of "effect" here is arguably wrong.  It's odd at best.
I'd use some alternative wording.

Let's stick to the facts:
 1. Shadow stack pages architecturally can't be read-only
 2. Don't bother with read faults, consider everything a write

BTW, what happens if we don't do this?  What breaks?
