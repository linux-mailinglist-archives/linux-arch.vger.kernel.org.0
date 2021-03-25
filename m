Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D7348DE9
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 11:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCYKYN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 06:24:13 -0400
Received: from foss.arm.com ([217.140.110.172]:45976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhCYKXv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 06:23:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB4BD13D5;
        Thu, 25 Mar 2021 03:23:50 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2603F718;
        Thu, 25 Mar 2021 03:23:46 -0700 (PDT)
Date:   Thu, 25 Mar 2021 10:23:43 +0000
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
Subject: Re: [PATCH v3 11/17] psci: use __pa_function for cpu_resume
Message-ID: <20210325102343.GC36570@C02TD0UTHF1T.local>
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323203946.2159693-12-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 23, 2021 at 01:39:40PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function pointers with
> jump table addresses, which results in __pa_symbol returning the
> physical address of the jump table entry. As the jump table contains
> an immediate jump to an EL1 virtual address, this typically won't
> work as intended. Use __pa_function instead to get the address to
> cpu_resume.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/firmware/psci/psci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index f5fc429cae3f..facd3cce3244 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -326,7 +326,7 @@ static int psci_suspend_finisher(unsigned long state)
>  {
>  	u32 power_state = state;
>  
> -	return psci_ops.cpu_suspend(power_state, __pa_symbol(cpu_resume));
> +	return psci_ops.cpu_suspend(power_state, __pa_function(cpu_resume));

As mentioned on the patch adding __pa_function(), I'd prefer to keep the
whatever->phys conversion separate from the CFI removal, since we have a
number of distinct virtual address ranges with differing conversions to
phys, and I don't think it's clear that __pa_function() only works for
kernel symbols (rather than module addresses, linear map addresses,
etc).

Other than that, I'm happy in principle with wrapping this. I suspect
that for clarity we should add an intermediate variable, e.g.

| phys_addr_t pa_cpu_resume = pa_symbol(function_nocfi(cpu_resume));
| return psci_ops.cpu_suspend(power_state, pa_cpu_resume)

Thanks,
Mark.

>  }
>  
>  int psci_cpu_suspend_enter(u32 state)
> @@ -345,7 +345,7 @@ int psci_cpu_suspend_enter(u32 state)
>  static int psci_system_suspend(unsigned long unused)
>  {
>  	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
> -			      __pa_symbol(cpu_resume), 0, 0);
> +			      __pa_function(cpu_resume), 0, 0);
>  }
>  
>  static int psci_system_suspend_enter(suspend_state_t state)
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
