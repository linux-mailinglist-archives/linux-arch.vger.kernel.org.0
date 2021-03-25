Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A7F348E1B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 11:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCYKiQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 06:38:16 -0400
Received: from foss.arm.com ([217.140.110.172]:46110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCYKiF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 077AA1424;
        Thu, 25 Mar 2021 03:38:05 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 023E23F718;
        Thu, 25 Mar 2021 03:38:00 -0700 (PDT)
Date:   Thu, 25 Mar 2021 10:37:57 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/17] arm64: implement __va_function
Message-ID: <20210325103757.GD36570@C02TD0UTHF1T.local>
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323203946.2159693-13-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 23, 2021 at 01:39:41PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function addresses in
> instrumented C code with jump table addresses. This change implements
> the __va_function() macro, which returns the actual function address
> instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Is there really no attribute or builtin that can be used to do this
without assembly?

IIUC from other patches the symbol tables will contain the "real"
non-cfi entry points (unless we explciitly asked to make the jump table
address canonical), so AFAICT here the compiler should have all the
necessary information to generate either the CFI or non-CFI entry point
addresses, even if it doesn't expose an interface for that today.

It'd be a lot nicer if we could get the compiler to do this for us.

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/memory.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0aabc3be9a75..9a4887808681 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -321,6 +321,21 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
>  #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
>  
> +#ifdef CONFIG_CFI_CLANG
> +/*
> + * With CONFIG_CFI_CLANG, the compiler replaces function address
> + * references with the address of the function's CFI jump table
> + * entry. The __va_function macro always returns the address of the
> + * actual function instead.
> + */
> +#define __va_function(x) ({						\
> +	void *addr;							\
> +	asm("adrp %0, " __stringify(x) "\n\t"				\
> +	    "add  %0, %0, :lo12:" __stringify(x) : "=r" (addr));	\
> +	addr;								\
> +})
> +#endif
> +
>  /*
>   *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
>   *  virt_addr_valid(x)	indicates whether a virtual address is valid
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
