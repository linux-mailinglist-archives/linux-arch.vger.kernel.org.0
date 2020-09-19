Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1802270AE1
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 07:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgISFfY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 01:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgISFfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 01:35:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB1FC0613CE;
        Fri, 18 Sep 2020 22:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AZ5J02emP96hkxwwIZvaGJSlov2Zl69mgyTKweGj88I=; b=n/wLunKwP9C0ro7PVAQJwTG4AH
        h/w8NYX8rrNoIO1HvIJJYWqcZ1TmUKAOyNiijz8b0Kck62FxlekFwIAtpCJIDrx60+/bBDXDSeia7
        ZL5zLLxVtfxIj8UmRcfsBYIv1HBAt4YUUjLCLJAHOuIVr/g4tGVcwJKYWkYcM3I8msB7pQPA6j3CR
        4VZ3qpWXaeTYzrGLPDTRiMJkwy+VR7TocFM5LxXG+FdLkYJfBMSJ6TzZ4NuoTQhjgjwVG8DgRpLPf
        Gh9+aiUj3R3Dwc5JOi+7D3vVu4rtjiU+ltN6HmXAC+Zt6OTc0wTPIEFZN0KSks+UNTB/VTPsgNgCG
        pf5Lzy0g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJVWk-0000mQ-Dl; Sat, 19 Sep 2020 05:35:14 +0000
Date:   Sat, 19 Sep 2020 06:35:14 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH 1/4] x86: add __X32_COND_SYSCALL() macro
Message-ID: <20200919053514.GI30063@infradead.org>
References: <20200918132439.1475479-1-arnd@arndb.de>
 <20200918132439.1475479-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918132439.1475479-2-arnd@arndb.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 03:24:36PM +0200, Arnd Bergmann wrote:
> sys_move_pages() is an optional syscall, and once we remove
> the compat version of it in favor of the native one with an
> in_compat_syscall() check, the x32 syscall table refers to
> a __x32_sys_move_pages symbol that may not exist when the
> syscall is disabled.
> 
> Change the COND_SYSCALL() definition on x86 to also include
> the redirection for x32.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Adding the x86 maintainers and Brian Gerst.  Brian proposed another
problem to the mess that most of the compat syscall handlers used by
x32 here:

   https://lkml.org/lkml/2020/6/16/664

hpa didn't particularly like it, but with your and my pending series
we'll soon use more native than compat syscalls for x32, so something
will need to change..

> ---
>  arch/x86/include/asm/syscall_wrapper.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index a84333adeef2..5eacd35a7f97 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -171,12 +171,16 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>  	__SYS_STUBx(x32, compat_sys##name,				\
>  		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))
>  
> +#define __X32_COND_SYSCALL(name)					\
> +	__COND_SYSCALL(x32, sys_##name)
> +
>  #define __X32_COMPAT_COND_SYSCALL(name)					\
>  	__COND_SYSCALL(x32, compat_sys_##name)
>  
>  #define __X32_COMPAT_SYS_NI(name)					\
>  	__SYS_NI(x32, compat_sys_##name)
>  #else /* CONFIG_X86_X32 */
> +#define __X32_COND_SYSCALL(name)
>  #define __X32_COMPAT_SYS_STUB0(name)
>  #define __X32_COMPAT_SYS_STUBx(x, name, ...)
>  #define __X32_COMPAT_COND_SYSCALL(name)
> @@ -253,6 +257,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>  	static long __do_sys_##sname(const struct pt_regs *__unused)
>  
>  #define COND_SYSCALL(name)						\
> +	__X32_COND_SYSCALL(name)					\
>  	__X64_COND_SYSCALL(name)					\
>  	__IA32_COND_SYSCALL(name)
>  
> -- 
> 2.27.0
> 
---end quoted text---
