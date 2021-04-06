Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E12A35526F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 13:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbhDFLhP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 07:37:15 -0400
Received: from foss.arm.com ([217.140.110.172]:41426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241774AbhDFLhO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 07:37:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF9C9101E;
        Tue,  6 Apr 2021 04:37:05 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 243363F73D;
        Tue,  6 Apr 2021 04:37:00 -0700 (PDT)
Date:   Tue, 6 Apr 2021 12:36:57 +0100
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
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5 12/18] arm64: implement function_nocfi
Message-ID: <20210406113657.GC96480@C02TD0UTHF1T.local>
References: <20210401233216.2540591-1-samitolvanen@google.com>
 <20210401233216.2540591-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401233216.2540591-13-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 04:32:10PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function addresses in
> instrumented C code with jump table addresses. This change implements
> the function_nocfi() macro, which returns the actual function address
> instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

I think that it's unfortunate that we have to drop to assembly here, but
given this is infrequent I agree it's not the end of the world, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  arch/arm64/include/asm/memory.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0aabc3be9a75..b55410afd3d1 100644
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
> + * entry. The function_nocfi macro always returns the address of the
> + * actual function instead.
> + */
> +#define function_nocfi(x) ({						\
> +	void *addr;							\
> +	asm("adrp %0, " __stringify(x) "\n\t"				\
> +	    "add  %0, %0, :lo12:" __stringify(x) : "=r" (addr));	\

If it's not too painful, could we please move the asm constrain onto its
own line? That makes it slightly easier to read, and aligns with what
we've (mostly) done elsewhere in arm64.

Not a big deal either way, and the ack stands regardless.

Thanks,
Mark.

> +	addr;								\
> +})
> +#endif
> +
>  /*
>   *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
>   *  virt_addr_valid(x)	indicates whether a virtual address is valid
> -- 
> 2.31.0.208.g409f899ff0-goog
> 
