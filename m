Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE31DDA63
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 00:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgEUWmL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 18:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgEUWmK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 May 2020 18:42:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB72C05BD43
        for <linux-arch@vger.kernel.org>; Thu, 21 May 2020 15:42:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so4027645pgm.0
        for <linux-arch@vger.kernel.org>; Thu, 21 May 2020 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jw/xqa3g89q51hDnYa5jOhsO4JnUA2E12TXYJqQM6yo=;
        b=n8XMg3aD467ovZaJ8YnSYN6LVan287tt4sBIOgRs82WugtI/HdxyJhYnlWCKPHqCgO
         ill8z/e4VVxGXzzKkIW5NVLJ/1f4x5cJ61kn/qqwkHTnEqz/Vz/IZRFU0R8q/IEQ2Qf7
         lId3+6YrFd3uIlEkXBncI8CDs9k/oH/CLKIsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jw/xqa3g89q51hDnYa5jOhsO4JnUA2E12TXYJqQM6yo=;
        b=JE+psQShZkX71f1a7eibB1mdu5GWax1YpZHCIsJvMwirLiBcVS2zFbSHQaoZwFNxsR
         KEsHj0cLyaMoAeKBSYaDxgfgTL0YKav4kGbrLwR8Zl2+YAdTys5jQF1qfZk3dqhWj9dj
         tA0hODkbLn0A9efLRaRnTZeiCybYO1g8CDS7wAZ64O3k+8ISfaSZqCBDcFOIGG3TWKBP
         EQL+eD2berWo+TYDd+tmjsu8sol3I/hhRq4AHgGUeIdgAdTivn8/eAzA+JMLhD2ybcf3
         m02FgAclEy6UsYkD59qh/QaXT+OBWL9I/3bo0OAbqxasVKu7dY1KrhyL6oDi4kRGLIqG
         wHNw==
X-Gm-Message-State: AOAM533vb4maPJjCYBYHJzp7EoZzwnQvfiaahkByJnkTbg/KqyxNfnfW
        ePjEXnpTvr2YZM9Q6Ra1ViPUGlQt/ElCRQ==
X-Google-Smtp-Source: ABdhPJwXOoPao/Ck/VlSSNAkUg8UNcEFO1e6LSxmA5hGfbn/TjlhNOkzmuwUAXLHuks+nAYhj1nmlg==
X-Received: by 2002:a65:4908:: with SMTP id p8mr10684191pgs.214.1590100929772;
        Thu, 21 May 2020 15:42:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n10sm5395236pfd.192.2020.05.21.15.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:42:08 -0700 (PDT)
Date:   Thu, 21 May 2020 15:42:07 -0700
From:   Kees Cook <keescook@chromium.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v10 26/26] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
Message-ID: <202005211528.A12B4AD@keescook>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-27-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429220732.31602-27-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 29, 2020 at 03:07:32PM -0700, Yu-cheng Yu wrote:
> arch_prctl(ARCH_X86_CET_STATUS, u64 *args)
>     Get CET feature status.
> 
>     The parameter 'args' is a pointer to a user buffer.  The kernel returns
>     the following information:
> 
>     *args = shadow stack/IBT status
>     *(args + 1) = shadow stack base address
>     *(args + 2) = shadow stack size
> 
> arch_prctl(ARCH_X86_CET_DISABLE, u64 features)
>     Disable CET features specified in 'features'.  Return -EPERM if CET is
>     locked.
> 
> arch_prctl(ARCH_X86_CET_LOCK)
>     Lock in CET features.
> 
> arch_prctl(ARCH_X86_CET_ALLOC_SHSTK, u64 *args)
>     Allocate a new shadow stack.
> 
>     The parameter 'args' is a pointer to a user buffer containing the
>     desired size to allocate.  The kernel returns the allocated shadow
>     stack address in *args.

Hi! Just a quick note about getting these designs right -- prctl() (and
similar APIs) needs to make sure they're examining all "unknown" flags
as zero, or we run the risk of breaking sloppy userspace callers who
accidentally set flags and then later the kernel gives meaning to those
flags. Notes below...

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
> v10:
> - Verify CET is enabled before handling arch_prctl.
> - Change input parameters from unsigned long to u64, to make it clear they
>   are 64-bit.
> 
>  arch/x86/include/asm/cet.h        |  4 ++
>  arch/x86/include/uapi/asm/prctl.h |  5 ++
>  arch/x86/kernel/Makefile          |  2 +-
>  arch/x86/kernel/cet.c             | 29 +++++++++++
>  arch/x86/kernel/cet_prctl.c       | 87 +++++++++++++++++++++++++++++++
>  arch/x86/kernel/process.c         |  4 +-
>  6 files changed, 128 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/kernel/cet_prctl.c
> 
> diff --git a/arch/x86/include/asm/cet.h b/arch/x86/include/asm/cet.h
> index 71dc92acd2f2..99e6e741d28c 100644
> --- a/arch/x86/include/asm/cet.h
> +++ b/arch/x86/include/asm/cet.h
> @@ -14,16 +14,20 @@ struct sc_ext;
>  struct cet_status {
>  	unsigned long	shstk_base;
>  	unsigned long	shstk_size;
> +	unsigned int	locked:1;
>  };
>  
>  #ifdef CONFIG_X86_INTEL_CET
> +int prctl_cet(int option, u64 arg2);
>  int cet_setup_shstk(void);
>  int cet_setup_thread_shstk(struct task_struct *p);
> +int cet_alloc_shstk(unsigned long *arg);
>  void cet_disable_free_shstk(struct task_struct *p);
>  int cet_verify_rstor_token(bool ia32, unsigned long ssp, unsigned long *new_ssp);
>  void cet_restore_signal(struct sc_ext *sc);
>  int cet_setup_signal(bool ia32, unsigned long rstor, struct sc_ext *sc);
>  #else
> +static inline int prctl_cet(int option, u64 arg2) { return -EINVAL; }
>  static inline int cet_setup_thread_shstk(struct task_struct *p) { return 0; }
>  static inline void cet_disable_free_shstk(struct task_struct *p) {}
>  static inline void cet_restore_signal(struct sc_ext *sc) { return; }
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 5a6aac9fa41f..d962f0ec9ccf 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -14,4 +14,9 @@
>  #define ARCH_MAP_VDSO_32	0x2002
>  #define ARCH_MAP_VDSO_64	0x2003
>  
> +#define ARCH_X86_CET_STATUS		0x3001
> +#define ARCH_X86_CET_DISABLE		0x3002
> +#define ARCH_X86_CET_LOCK		0x3003
> +#define ARCH_X86_CET_ALLOC_SHSTK	0x3004
> +
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index e9cc2551573b..0b621e2afbdc 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -144,7 +144,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
>  obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
>  obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
>  
> -obj-$(CONFIG_X86_INTEL_CET)		+= cet.o
> +obj-$(CONFIG_X86_INTEL_CET)		+= cet.o cet_prctl.o
>  
>  ###
>  # 64 bit specific files
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index 121552047b86..c1b9b540c03e 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
> @@ -145,6 +145,35 @@ static int create_rstor_token(bool ia32, unsigned long ssp,
>  	return 0;
>  }
>  
> +int cet_alloc_shstk(unsigned long *arg)
> +{
> +	unsigned long len = *arg;
> +	unsigned long addr;
> +	unsigned long token;
> +	unsigned long ssp;
> +
> +	addr = alloc_shstk(round_up(len, PAGE_SIZE));
> +
> +	if (IS_ERR((void *)addr))
> +		return PTR_ERR((void *)addr);
> +
> +	/* Restore token is 8 bytes and aligned to 8 bytes */
> +	ssp = addr + len;
> +	token = ssp;
> +
> +	if (!in_ia32_syscall())
> +		token |= TOKEN_MODE_64;
> +	ssp -= 8;
> +
> +	if (write_user_shstk_64(ssp, token)) {
> +		vm_munmap(addr, len);
> +		return -EINVAL;
> +	}
> +
> +	*arg = addr;
> +	return 0;
> +}
> +
>  int cet_setup_shstk(void)
>  {
>  	unsigned long addr, size;
> diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
> new file mode 100644
> index 000000000000..0139c48f2215
> --- /dev/null
> +++ b/arch/x86/kernel/cet_prctl.c
> @@ -0,0 +1,87 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/errno.h>
> +#include <linux/uaccess.h>
> +#include <linux/prctl.h>
> +#include <linux/compat.h>
> +#include <linux/mman.h>
> +#include <linux/elfcore.h>
> +#include <asm/processor.h>
> +#include <asm/prctl.h>
> +#include <asm/cet.h>
> +
> +/* See Documentation/x86/intel_cet.rst. */
> +
> +static int handle_get_status(u64 arg2)
> +{
> +	struct cet_status *cet = &current->thread.cet;
> +	u64 buf[3] = {0, 0, 0};
> +
> +	if (cet->shstk_size) {
> +		buf[0] |= GNU_PROPERTY_X86_FEATURE_1_SHSTK;
> +		buf[1] = (u64)cet->shstk_base;
> +		buf[2] = (u64)cet->shstk_size;
> +	}
> +
> +	return copy_to_user((u64 __user *)arg2, buf, sizeof(buf));
> +}
> +
> +static int handle_alloc_shstk(u64 arg2)
> +{
> +	int err = 0;
> +	unsigned long arg;
> +	unsigned long addr = 0;
> +	unsigned long size = 0;
> +
> +	if (get_user(arg, (unsigned long __user *)arg2))
> +		return -EFAULT;
> +
> +	size = arg;
> +	err = cet_alloc_shstk(&arg);
> +	if (err)
> +		return err;
> +
> +	addr = arg;
> +	if (put_user((u64)addr, (u64 __user *)arg2)) {
> +		vm_munmap(addr, size);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +int prctl_cet(int option, u64 arg2)
> +{
> +	struct cet_status *cet;
> +
> +	if (!IS_ENABLED(CONFIG_X86_INTEL_CET))
> +		return -EINVAL;

Using -EINVAL here means userspace can't tell the difference between an
old kernel and a kernel not built with CONFIG_X86_INTEL_CET. Perhaps
-ENOTSUPP?

> +
> +	if (option == ARCH_X86_CET_STATUS)
> +		return handle_get_status(arg2);
> +
> +	if (!static_cpu_has(X86_FEATURE_SHSTK))
> +		return -EINVAL;

Similar case: though this is now a kernel that knows how, but a CPU that
doesn't.

> +
> +	cet = &current->thread.cet;

You get this both here and in handle_get_status(). Why not just get it
once and pass it into handle_get_status()? (And perhaps rename it to
"copy_status_to_user" or so?

> +
> +	switch (option) {
> +	case ARCH_X86_CET_DISABLE:

This must check for unknown flags before doing anything else:

		if (arg & ~(GNU_PROPERTY_X86_FEATURE_1_SHSTK))
			return -EINVAL;

> +		if (cet->locked)
> +			return -EPERM;
> +		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
> +			cet_disable_free_shstk(current);
> +
> +		return 0;
> +
> +	case ARCH_X86_CET_LOCK:

Same here.

> +		cet->locked = 1;
> +		return 0;
> +
> +	case ARCH_X86_CET_ALLOC_SHSTK:
> +		return handle_alloc_shstk(arg2);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index ef1c2b8086a2..de6773dd6a16 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -996,7 +996,7 @@ long do_arch_prctl_common(struct task_struct *task, int option,
>  		return get_cpuid_mode();
>  	case ARCH_SET_CPUID:
>  		return set_cpuid_mode(task, cpuid_enabled);
> +	default:
> +		return prctl_cet(option, cpuid_enabled);
>  	}

This is weird, but yeah, there's only the cpuid and cet handlers... I
think do_arch_prctrl_common() should call the second arg "arg2" and
there should be a series of calls:

	ret = prctl_cpuid(task, option, args);
	if (ret != -EINVAL)
		return ret;
	return prctl_cet(option, args);

But that's just a style nit, I guess.

And really, why is x86's arch prtcl return EINVAL for unknown options?
It should use -ENOSYS for unknown options and -EINVAL for bad arguments,
but I guess it's too late for that. :)

-- 
Kees Cook
