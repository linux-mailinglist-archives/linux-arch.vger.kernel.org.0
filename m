Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4694E0457
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2019 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbfJVM7u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Oct 2019 08:59:50 -0400
Received: from [217.140.110.172] ([217.140.110.172]:51986 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731281AbfJVM7u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Oct 2019 08:59:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19CE1168F;
        Tue, 22 Oct 2019 05:59:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48AF3F71F;
        Tue, 22 Oct 2019 05:59:24 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:59:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, npiggin@gmail.com,
        paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 8/8] x86, kcsan: Enable KCSAN for x86
Message-ID: <20191022125921.GD11583@lakrids.cambridge.arm.com>
References: <20191017141305.146193-1-elver@google.com>
 <20191017141305.146193-9-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017141305.146193-9-elver@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 17, 2019 at 04:13:05PM +0200, Marco Elver wrote:
> This patch enables KCSAN for x86, with updates to build rules to not use
> KCSAN for several incompatible compilation units.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Document build exceptions where no previous above comment explained
>   why we cannot instrument.
> ---
>  arch/x86/Kconfig                      | 1 +
>  arch/x86/boot/Makefile                | 2 ++
>  arch/x86/boot/compressed/Makefile     | 2 ++
>  arch/x86/entry/vdso/Makefile          | 3 +++
>  arch/x86/include/asm/bitops.h         | 6 +++++-
>  arch/x86/kernel/Makefile              | 7 +++++++
>  arch/x86/kernel/cpu/Makefile          | 3 +++
>  arch/x86/lib/Makefile                 | 4 ++++
>  arch/x86/mm/Makefile                  | 3 +++
>  arch/x86/purgatory/Makefile           | 2 ++
>  arch/x86/realmode/Makefile            | 3 +++
>  arch/x86/realmode/rm/Makefile         | 3 +++
>  drivers/firmware/efi/libstub/Makefile | 2 ++
>  13 files changed, 40 insertions(+), 1 deletion(-)

> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 0460c7581220..693d0a94b118 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -31,7 +31,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>  				   -D__DISABLE_EXPORTS
>  
>  GCOV_PROFILE			:= n
> +# Sanitizer runtimes are unavailable and cannot be linked here.
>  KASAN_SANITIZE			:= n
> +KCSAN_SANITIZE			:= n
>  UBSAN_SANITIZE			:= n
>  OBJECT_FILES_NON_STANDARD	:= y

Not a big deal, but it might make sense to move the EFI stub exception
to patch 3 since it isn't x86 specific (and will also apply for arm64).

Otherwise this looks good to me.

Thanks,
Mark.
