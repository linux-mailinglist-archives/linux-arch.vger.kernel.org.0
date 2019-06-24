Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E243650BCE
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFXNVJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 09:21:09 -0400
Received: from foss.arm.com ([217.140.110.172]:50218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfFXNVJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 09:21:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9B08344;
        Mon, 24 Jun 2019 06:21:07 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5F773F71E;
        Mon, 24 Jun 2019 06:21:04 -0700 (PDT)
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@openvz.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fdded1ed-9404-c80e-c74e-a61716277bda@arm.com>
Date:   Mon, 24 Jun 2019 14:21:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On 24/06/2019 01:34, Thomas Gleixner wrote:
> Vincenzo,
> 
> On Fri, 21 Jun 2019, Vincenzo Frascino wrote:
>> vDSO (virtual dynamic shared object) is a mechanism that the Linux
>> kernel provides as an alternative to system calls to reduce where
>> possible the costs in terms of cycles.
>> This is possible because certain syscalls like gettimeofday() do
>> not write any data and return one or more values that are stored
>> in the kernel, which makes relatively safe calling them directly
>> as a library function.
>>
>> Even if the mechanism is pretty much standard, every architecture
>> in the last few years ended up implementing their own vDSO library
>> in the architectural code.
> 
> ....
>  
>> This implementation contains the portings to the common library for: arm64,
>> compat mode for arm64, arm, mips, x86_64, x32, compat mode for x86_64 and
>> i386.
> 
> I picked up the core implementation and the ARM64 and x86 conversion. I did
> some refinements in several places, coding style, naming conventions,
> comments and changelogs including subject prefixes. Please double check!
>

I tested your changes and they seem OK
(git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso).

...
> As you can see from the commit dates, this has soaked for some time in a
> WIP branch and I did extensive regression testing. So far so good.
> 
> Thanks a lot for going through several iterations. It's a very much
> appreciated effort!
> 

It has been a lot of fun and I learned many many things about the vDSOs and the
kernel that I did not know before. Thanks to you for your patience and guidance.

> Especially with the upcoming time namespaces this will avoid a lot of
> duplicated and pointlessly different horrors all over the architecture
> space. Any architecture which wants to gain that support needs to convert
> to the generic VDSO first.
> 
> As you have become the dude who knows almost everything about VDSO
> including all the nasty pitfalls, I propose the patch below.
>

Thanks for this, it means a lot to me.

> Thanks,
> 
> 	tglx
> 
> 8<------------
> Subject: MAINTAINERS: Add entry for the generic VDSO library
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Mon, 24 Jun 2019 02:03:50 +0200
> 
> Asign the following folks in alphabetic order:
> 
>  - Andy for being the VDSO wizard of x86 and in general. He's also the
>    performance monitor of choice and the code in the generic library is
>    heavily influenced by his previous x86 VDSO work.
> 
>  - Thomas for being the dude who has to deal with any form of time(r)
>    nonsense anyway
> 
>  - Vincenzo for being the poor sod who went through all the different
>    architecture implementations in order to unify them. A lot of knowledge
>    gained from VDSO implementation details to the intricacies of taming the
>    build system.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  MAINTAINERS |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6665,6 +6665,18 @@ L:	kvm@vger.kernel.org
>  S:	Supported
>  F:	drivers/uio/uio_pci_generic.c
>  
> +GENERIC VDSO LIBRARY:
> +M:	Andy Lutomirksy <luto@kernel.org>
> +M:	Thomas Gleixner <tglx@linutronix.de>
> +M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
> +L:	linux-kernel@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> +S:	Maintained
> +F:	lib/vdso
> +F:	kernel/time/vsyscall.c
> +F:	include/vdso
> +F:	include/asm-generic/vdso/vsyscall.h
> +
>  GENWQE (IBM Generic Workqueue Card)
>  M:	Frank Haverkamp <haver@linux.ibm.com>
>  S:	Supported
> 

-- 
Regards,
Vincenzo
