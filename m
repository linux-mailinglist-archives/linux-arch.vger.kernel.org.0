Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E203552F3
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbhDFL6y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 07:58:54 -0400
Received: from foss.arm.com ([217.140.110.172]:41984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243397AbhDFL6x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 07:58:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0742012FC;
        Tue,  6 Apr 2021 04:58:44 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF273F73D;
        Tue,  6 Apr 2021 04:58:38 -0700 (PDT)
Date:   Tue, 6 Apr 2021 12:58:36 +0100
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
Subject: Re: [PATCH v5 16/18] arm64: ftrace: use function_nocfi for
 ftrace_call
Message-ID: <20210406115836.GF96480@C02TD0UTHF1T.local>
References: <20210401233216.2540591-1-samitolvanen@google.com>
 <20210401233216.2540591-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401233216.2540591-17-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 04:32:14PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function pointers with
> jump table addresses, which breaks dynamic ftrace as the address of
> ftrace_call is replaced with the address of ftrace_call.cfi_jt. Use
> function_nocfi() to get the address of the actual function instead.
> 
> Suggested-by: Ben Dai <ben.dai@unisoc.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kernel/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 86a5cf9bc19a..b5d3ddaf69d9 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -55,7 +55,7 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>  	unsigned long pc;
>  	u32 new;
>  
> -	pc = (unsigned long)&ftrace_call;
> +	pc = (unsigned long)function_nocfi(ftrace_call);

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

>  	new = aarch64_insn_gen_branch_imm(pc, (unsigned long)func,
>  					  AARCH64_INSN_BRANCH_LINK);
>  
> -- 
> 2.31.0.208.g409f899ff0-goog
> 
