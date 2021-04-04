Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA323538B2
	for <lists+linux-arch@lfdr.de>; Sun,  4 Apr 2021 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhDDPyp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Apr 2021 11:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhDDPyo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 4 Apr 2021 11:54:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BDF561368;
        Sun,  4 Apr 2021 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617551680;
        bh=Y+EXlFwOcupRcJHejpzX9O0l3XK9lB+QcIyNrCwXUZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwqnVFHquFYuCIg7xJmXG5NoG4GTtS3nhGBRNZQq9WvMNiHQ4ULTf9bkymZx+Kd7j
         ENn7ChaWWxdC2UvBl8qajs2NkEln3JuqbCR4LFbfRYrIPpCs4XEaLfe+SbDODSBexz
         930qW/iWzfaIkJtlUDqBln4fecgjZVgKidnqkdABU/GD7yNkwNzBnZV/esL3K7D8SB
         8BHevk1he7oHwcuvEk9l/Kk2ZzhFILOcCHWEIi2H9b1eHY9vZctMXPP/oaPNjb3+JR
         VP7dlUhnhpLGrXXiXslFWQGV1lj62lK1ajJjDSttB64ZjSQ/1h96ngUCM4oPiKSV37
         L4c7QJ5hxJaQw==
Date:   Sun, 4 Apr 2021 18:54:37 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
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
Subject: Re: [PATCH v24 9/9] x86/vdso: Add ENDBR to __vdso_sgx_enter_enclave
Message-ID: <YGnhPc8USFh/AnqJ@kernel.org>
References: <20210401221403.32253-1-yu-cheng.yu@intel.com>
 <20210401221403.32253-10-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221403.32253-10-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 03:14:03PM -0700, Yu-cheng Yu wrote:
> ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
> component of CET.  IBT prevents attacks by ensuring that (most) indirect
> branches and function calls may only land at ENDBR instructions.  Branches
> that don't follow the rules will result in control flow (#CF) exceptions.
> 
> ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
> instructions are inserted automatically by the compiler, but branch
> targets written in assembly must have ENDBR added manually.
> 
> Add ENDBR to __vdso_sgx_enter_enclave() branch targets.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  arch/x86/entry/vdso/vsgx.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
> index 86a0e94f68df..c63eafa54abd 100644
> --- a/arch/x86/entry/vdso/vsgx.S
> +++ b/arch/x86/entry/vdso/vsgx.S
> @@ -4,6 +4,7 @@
>  #include <asm/export.h>
>  #include <asm/errno.h>
>  #include <asm/enclu.h>
> +#include <asm/vdso.h>
>  
>  #include "extable.h"
>  
> @@ -27,6 +28,7 @@
>  SYM_FUNC_START(__vdso_sgx_enter_enclave)
>  	/* Prolog */
>  	.cfi_startproc
> +	ENDBR
>  	push	%rbp
>  	.cfi_adjust_cfa_offset	8
>  	.cfi_rel_offset		%rbp, 0
> @@ -62,6 +64,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>  .Lasync_exit_pointer:
>  .Lenclu_eenter_eresume:
>  	enclu
> +	ENDBR
>  
>  	/* EEXIT jumps here unless the enclave is doing something fancy. */
>  	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
> @@ -91,6 +94,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>  	jmp	.Lout
>  
>  .Lhandle_exception:
> +	ENDBR
>  	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
>  
>  	/* Set the exception info. */
> -- 
> 2.21.0
> 
> 

/Jarkko
