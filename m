Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10434343E1E
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhCVKjI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 06:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhCVKix (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 06:38:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00996C061763
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 03:38:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i26so4606025lfl.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4hC27dQ/u288m0lvIAqx0tpRb+YwDiUGxv3BPznT+sI=;
        b=aG4CCQmbLb1GnZ6XtEGpwTGDwEDwL2zlf2cTCSr+JZswGfljVFAduiKDUNiHIBi622
         MrBTtUORsoxUb1IuMEA5gBt7Tsghrdp4iXJZrQxtbROBmzwXXiwuRviIJs/8iMiZW9X1
         UyXFoJhobLPxFpMrd6dAKytTdo5FoAzwnt2btLeNLaUz2l8B9qzYMewI3XojtnKMMJry
         iD1BVjkZEKIBVeTPGZxRZ7MlabUdx7vAFGzrWr4YwcpQ+rjCEhWbuCSciM/tCHcC07BF
         K/OHzUt5f04kquzgVob+i5QS5cUaF94dCWZHah0jwolZFj5tSn1B2VyNmH7kve5Dav56
         ftzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4hC27dQ/u288m0lvIAqx0tpRb+YwDiUGxv3BPznT+sI=;
        b=lUijW/cnTXA3e0SrVQve2gxpkjpBIOP717BsAnfES60oI3cKh/4979fVL4Q9RIUTHD
         8tDTfLURn+mg03zwoA+RuTVdF6oREpL+bynTBBCChVAiTmbyv8xpUX7KREIJn9/QSuAv
         UzllQgrHBHOBFFO2Jz+w5lZYnUPZ6XTtdNCBfFnDiaSRdXQByeS6ucdf4ZzsjFLdMX+O
         mi/kQdCwLXfgrcdz8+FJVwjZ5chVrSxd/qlub4EWGQEzGygHY3f65Jw2CQAttpgyAEdu
         vk1Srd4TGIAvGdKuRoCVi6wHFNBB9Q/GSB4P4MS69qz+85tWB1+Hp6KYCMC1hpyA96u4
         NjYw==
X-Gm-Message-State: AOAM530Ayo0TzfDet6OWODWpxb9nQ5DwXKqHm1ugYxkePlZLc2IOinbu
        o4RFWj+hZRJapgkGu8KZnj4DjQ==
X-Google-Smtp-Source: ABdhPJwUXaWMh/7Jvw00YeWGfYQNsZQnygvvxQt2sYRhrPBaMYhh0Y5PdawcjG6A2A8jca1Jqv+VBw==
X-Received: by 2002:a05:6512:324d:: with SMTP id c13mr8815993lfr.165.1616409531363;
        Mon, 22 Mar 2021 03:38:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x1sm1527966lff.97.2021.03.22.03.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:38:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 48DDE101DEB; Mon, 22 Mar 2021 13:38:58 +0300 (+03)
Date:   Mon, 22 Mar 2021 13:38:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 14/28] x86/mm: Shadow Stack page fault error checking
Message-ID: <20210322103858.evxun5bhw2i5sio6@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-15-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-15-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:40AM -0700, Yu-cheng Yu wrote:
> Shadow stack accesses are those that are performed by the CPU where it
> expects to encounter a shadow stack mapping.  These accesses are performed
> implicitly by CALL/RET at the site of the shadow stack pointer.  These
> accesses are made explicitly by shadow stack management instructions like
> WRUSSQ.
> 
> Shadow stacks accesses to shadow-stack mapping can see faults in normal,
> valid operation just like regular accesses to regular mappings.  Shadow
> stacks need some of the same features like delayed allocation, swap and
> copy-on-write.
> 
> Shadow stack accesses can also result in errors, such as when a shadow
> stack overflows, or if a shadow stack access occurs to a non-shadow-stack
> mapping.
> 
> In handling a shadow stack page fault, verify it occurs within a shadow
> stack mapping.  It is always an error otherwise.  For valid shadow stack
> accesses, set FAULT_FLAG_WRITE to effect copy-on-write.  Because clearing
> _PAGE_DIRTY (vs. _PAGE_RW) is used to trigger the fault, shadow stack read
> fault and shadow stack write fault are not differentiated and both are
> handled as a write access.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/trap_pf.h |  2 ++
>  arch/x86/mm/fault.c            | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
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
> index a73347e2cdfc..4316732a18c6 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1100,6 +1100,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>  				       (error_code & X86_PF_INSTR), foreign))
>  		return 1;
>  
> +	/*
> +	 * Verify a shadow stack access is within a shadow stack VMA.
> +	 * It is always an error otherwise.  Normal data access to a
> +	 * shadow stack area is checked in the case followed.
> +	 */
> +	if (error_code & X86_PF_SHSTK) {
> +		if (!(vma->vm_flags & VM_SHSTK))
> +			return 1;
> +		return 0;

Any reason to return 0 here? I would rather keep the single return 0 in
the function, after all checks are done.

> +	}
> +
>  	if (error_code & X86_PF_WRITE) {
>  		/* write, present and write, not present: */
>  		if (unlikely(!(vma->vm_flags & VM_WRITE)))
> @@ -1293,6 +1304,14 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +	/*
> +	 * Clearing _PAGE_DIRTY is used to detect shadow stack access.
> +	 * This method cannot distinguish shadow stack read vs. write.
> +	 * For valid shadow stack accesses, set FAULT_FLAG_WRITE to effect
> +	 * copy-on-write.
> +	 */
> +	if (error_code & X86_PF_SHSTK)
> +		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_WRITE)
>  		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_INSTR)
> -- 
> 2.21.0
> 

-- 
 Kirill A. Shutemov
