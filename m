Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39A16AB7F0
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 09:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCFIIQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 03:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCFIIP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 03:08:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8959286A6;
        Mon,  6 Mar 2023 00:08:11 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1E6E1EC0554;
        Mon,  6 Mar 2023 09:08:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678090090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SCgxwhfA8a2XzbeTj8pvN/P7ji/tBRIr/iWcDVYJ/Qg=;
        b=hT6yTUHCM7iuFYwq3kiPpevrJfbf4NruRD+AiFavDW1R6kYkHTKRc/xTU5hzHlHM6vNlww
        7jJxJGZh0qVyTqFR6adcA6K1PvN+XdSFZAVoo3V++d05KbDQ6rcktqT4oC+5k+UJO7/RW9
        PC9GbmSz3dUK8wPBfDmFSPsylMM0BzE=
Date:   Mon, 6 Mar 2023 09:08:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v7 21/41] mm: Add guard pages around a shadow stack.
Message-ID: <ZAWfZcJLXUfNt1Fs@zn.tnic>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-22-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-22-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Just typos:

On Mon, Feb 27, 2023 at 02:29:37PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> The architecture of shadow stack constrains the ability of userspace to
> move the shadow stack pointer (SSP) in order to  prevent corrupting or
> switching to other shadow stacks. The RSTORSSP can move the ssp to
						^
						instruction

s/ssp/SSP/g


> different shadow stacks, but it requires a specially placed token in order
> to do this. However, the architecture does not prevent incrementing the
> stack pointer to wander onto an adjacent shadow stack. To prevent this in
> software, enforce guard pages at the beginning of shadow stack vmas, such

VMAs

> that there will always be a gap between adjacent shadow stacks.
> 
> Make the gap big enough so that no userspace SSP changing operations
> (besides RSTORSSP), can move the SSP from one stack to the next. The
> SSP can increment or decrement by CALL, RET  and INCSSP. CALL and RET

"can be incremented or decremented"

> can move the SSP by a maximum of 8 bytes, at which point the shadow
> stack would be accessed.
> 
> The INCSSP instruction can also increment the shadow stack pointer. It
> is the shadow stack analog of an instruction like:
> 
> 	addq    $0x80, %rsp
> 
> However, there is one important difference between an ADD on %rsp and
> INCSSP. In addition to modifying SSP, INCSSP also reads from the memory
> of the first and last elements that were "popped". It can be thought of
> as acting like this:
> 
> READ_ONCE(ssp);       // read+discard top element on stack
> ssp += nr_to_pop * 8; // move the shadow stack
> READ_ONCE(ssp-8);     // read+discard last popped stack element
> 
> The maximum distance INCSSP can move the SSP is 2040 bytes, before it
> would read the memory. Therefore a single page gap will be enough to
				  ^
				  ,


> prevent any operation from shifting the SSP to an adjacent stack, since
> it would have to land in the gap at least once, causing a fault.
> 
> This could be accomplished by using VM_GROWSDOWN, but this has a
> downside. The behavior would allow shadow stack's to grow, which is

s/stack's/stacks/

> unneeded and adds a strange difference to how most regular stacks work.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> v5:
>  - Fix typo in commit log
> 
> v4:
>  - Drop references to 32 bit instructions
>  - Switch to generic code to drop __weak (Peterz)
> 
> v2:
>  - Use __weak instead of #ifdef (Dave Hansen)
>  - Only have start gap on shadow stack (Andy Luto)
>  - Create stack_guard_start_gap() to not duplicate code
>    in an arch version of vm_start_gap() (Dave Hansen)
>  - Improve commit log partly with verbiage from (Dave Hansen)
> 
> Yu-cheng v25:
>  - Move SHADOW_STACK_GUARD_GAP to arch/x86/mm/mmap.c.
> ---
>  include/linux/mm.h | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 097544afb1aa..6a093daced88 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3107,15 +3107,36 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
>  	return mtree_load(&mm->mm_mt, addr);
>  }
>  
> +static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & VM_GROWSDOWN)
> +		return stack_guard_gap;
> +
> +	/*
> +	 * Shadow stack pointer is moved by CALL, RET, and INCSSPQ.
> +	 * INCSSPQ moves shadow stack pointer up to 255 * 8 = ~2 KB
> +	 * and touches the first and the last element in the range, which
> +	 * triggers a page fault if the range is not in a shadow stack.
> +	 * Because of this, creating 4-KB guard pages around a shadow
> +	 * stack prevents these instructions from going beyond.

I'd prefer the equivalant explanation above from the commit message - it
is more precise.

> +	 *
> +	 * Creation of VM_SHADOW_STACK is tightly controlled, so a vma
> +	 * can't be both VM_GROWSDOWN and VM_SHADOW_STACK
> +	 */
> +	if (vma->vm_flags & VM_SHADOW_STACK)
> +		return PAGE_SIZE;
> +
> +	return 0;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
