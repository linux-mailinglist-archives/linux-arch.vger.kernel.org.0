Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9624B001A
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 23:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiBIWYA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 17:24:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiBIWXz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 17:23:55 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77F9E00E5B7;
        Wed,  9 Feb 2022 14:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644445437; x=1675981437;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=xkpFBXYQrPgtUiGsMKx5OqlH/pGeqV2L1Ykn/ZtyOSU=;
  b=YGbc47ASftPxIwFd2kxXZYK63tZmGW0thBn1KD+ynYIc434TWmP3Etu/
   +PUeQ81/uJ+1y9DiTFHR7SC1vkGd1E8cjLkzdnrFGdkV4LdQmiHtnucTq
   wJEFJyOgAwrMJpPzqZ8+l6iH7L2Cb4EW+Goy6DHMSnbIh5aSpk6eYP52H
   KV3l7aLXuxBta92d/rdsD1EhWoYkgZe0vrVVt0mAZcw5+aDgbeate9uB4
   tbTmeSajgeXcAn2R5tZLql2BGBnFlE59sn0oPYWW8KBvzSQRzHGN5JBU+
   OWYqC79xyhUcfg9ih/Xp0owIgt/P7tLBgTIi1QH4B/H3P5GqxYdANOqIn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="312646845"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="312646845"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 14:23:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="585744181"
Received: from sanvery-mobl.amr.corp.intel.com (HELO [10.212.232.139]) ([10.212.232.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 14:23:55 -0800
Message-ID: <f92c5110-7d97-b68d-d387-7e6a16a29e49@intel.com>
Date:   Wed, 9 Feb 2022 14:23:51 -0800
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
 <20220130211838.8382-19-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 18/35] mm: Add guard pages around a shadow stack.
In-Reply-To: <20220130211838.8382-19-rick.p.edgecombe@intel.com>
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
> INCSSP(Q/D) increments shadow stack pointer and 'pops and discards' the
> first and the last elements in the range, effectively touches those memory
> areas.

This is a pretty close copy of the instruction reference text for
INCSSP.  I'm feeling rather dense today, but that's just not making any
sense.

The pseudocode is more sensible in the SDM.  I think this needs a better
explanation:

	The INCSSP instruction increments the shadow stack pointer.  It
	is the shadow stack analog of an instruction like:

		addq	$0x80, %rsp

	However, there is one important difference between an ADD on
	%rsp and INCSSP.  In addition to modifying SSP, INCSSP also
	reads from the memory of the first and last elements that were
	"popped".  You can think of it as acting like this:

	READ_ONCE(ssp);       // read+discard top element on stack
	ssp += nr_to_pop * 8; // move the shadow stack
	READ_ONCE(ssp-8);     // read+discard last popped stack element
	

> The maximum moving distance by INCSSPQ is 255 * 8 = 2040 bytes and
> 255 * 4 = 1020 bytes by INCSSPD.  Both ranges are far from PAGE_SIZE.

... That maximum distance, combined with an a guard pages at the end of
a shadow stack ensures that INCSSP will fault before it is able to move
across an entire guard page.

> Thus, putting a gap page on both ends of a shadow stack prevents INCSSP,
> CALL, and RET from going beyond.

> 
> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
> index a506a411474d..e1533fdc08b4 100644
> --- a/arch/x86/include/asm/page_types.h
> +++ b/arch/x86/include/asm/page_types.h
> @@ -73,6 +73,13 @@ bool pfn_range_is_mapped(unsigned long start_pfn, unsigned long end_pfn);
>  
>  extern void initmem_init(void);
>  
> +#define vm_start_gap vm_start_gap
> +struct vm_area_struct;
> +extern unsigned long vm_start_gap(struct vm_area_struct *vma);
> +
> +#define vm_end_gap vm_end_gap
> +extern unsigned long vm_end_gap(struct vm_area_struct *vma);
> +
>  #endif	/* !__ASSEMBLY__ */
>  
>  #endif	/* _ASM_X86_PAGE_DEFS_H */
> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index f3f52c5e2fd6..81f9325084d3 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -250,3 +250,49 @@ bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
>  		return false;
>  	return true;
>  }
> +
> +/*
> + * Shadow stack pointer is moved by CALL, RET, and INCSSP(Q/D).  INCSSPQ
> + * moves shadow stack pointer up to 255 * 8 = ~2 KB (~1KB for INCSSPD) and
> + * touches the first and the last element in the range, which triggers a
> + * page fault if the range is not in a shadow stack.  Because of this,
> + * creating 4-KB guard pages around a shadow stack prevents these
> + * instructions from going beyond.
> + */
> +#define SHADOW_STACK_GUARD_GAP PAGE_SIZE
> +
> +unsigned long vm_start_gap(struct vm_area_struct *vma)
> +{
> +	unsigned long vm_start = vma->vm_start;
> +	unsigned long gap = 0;
> +
> +	if (vma->vm_flags & VM_GROWSDOWN)
> +		gap = stack_guard_gap;
> +	else if (vma->vm_flags & VM_SHADOW_STACK)
> +		gap = SHADOW_STACK_GUARD_GAP;
> +
> +	if (gap != 0) {
> +		vm_start -= gap;
> +		if (vm_start > vma->vm_start)
> +			vm_start = 0;
> +	}
> +	return vm_start;
> +}
> +
> +unsigned long vm_end_gap(struct vm_area_struct *vma)
> +{
> +	unsigned long vm_end = vma->vm_end;
> +	unsigned long gap = 0;
> +
> +	if (vma->vm_flags & VM_GROWSUP)
> +		gap = stack_guard_gap;
> +	else if (vma->vm_flags & VM_SHADOW_STACK)
> +		gap = SHADOW_STACK_GUARD_GAP;
> +
> +	if (gap != 0) {
> +		vm_end += gap;
> +		if (vm_end < vma->vm_end)
> +			vm_end = -PAGE_SIZE;
> +	}
> +	return vm_end;
> +}

First of all, __weak would be a lot better than these #ifdefs.

Second, I have the same basic objection to this as the maybe_mkwrite()
mess.  This is a forked copy of the code.  Instead of refactoring, it's
just copied-pasted-and-#ifdef'd.  Not so nice.

Isn't this just a matter of overriding 'stack_guard_gap' for
VM_SHADOW_STACK?  Why don't we just do this:

unsigned long stack_guard_gap(struct vm_area_struct *vma)
{
	if (vma->vm_flags & VM_SHADOW_STACK)
		return SHADOW_STACK_GUARD_GAP;

	return __stack_guard_gap;
}

Or, worst-case if people don't want 2 easily compiled-out lines added to
generic code, define:

unsigned long __weak stack_guard_gap(struct vm_area_struct *vma)
{
	return __stack_guard_gap;
}

in generic code, and put the top definition in arch/x86.
