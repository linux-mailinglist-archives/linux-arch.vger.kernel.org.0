Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5535520E
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbhDFL1v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 07:27:51 -0400
Received: from foss.arm.com ([217.140.110.172]:41214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245532AbhDFL1u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 07:27:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5792DED1;
        Tue,  6 Apr 2021 04:27:42 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC5943F73D;
        Tue,  6 Apr 2021 04:27:37 -0700 (PDT)
Date:   Tue, 6 Apr 2021 12:27:35 +0100
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
Subject: Re: [PATCH v5 11/18] psci: use function_nocfi for cpu_resume
Message-ID: <20210406112735.GB96480@C02TD0UTHF1T.local>
References: <20210401233216.2540591-1-samitolvanen@google.com>
 <20210401233216.2540591-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401233216.2540591-12-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 04:32:09PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function pointers with
> jump table addresses, which results in __pa_symbol returning the
> physical address of the jump table entry. As the jump table contains
> an immediate jump to an EL1 virtual address, this typically won't
> work as intended. Use function_nocfi to get the actual address of
> cpu_resume.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/firmware/psci/psci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index f5fc429cae3f..64344e84bd63 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -325,8 +325,9 @@ static int __init psci_features(u32 psci_func_id)
>  static int psci_suspend_finisher(unsigned long state)
>  {
>  	u32 power_state = state;
> +	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
>  
> -	return psci_ops.cpu_suspend(power_state, __pa_symbol(cpu_resume));
> +	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
>  }
>  
>  int psci_cpu_suspend_enter(u32 state)
> @@ -344,8 +345,10 @@ int psci_cpu_suspend_enter(u32 state)
>  
>  static int psci_system_suspend(unsigned long unused)
>  {
> +	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
> +
>  	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
> -			      __pa_symbol(cpu_resume), 0, 0);
> +			      pa_cpu_resume, 0, 0);
>  }
>  
>  static int psci_system_suspend_enter(suspend_state_t state)
> -- 
> 2.31.0.208.g409f899ff0-goog
> 
