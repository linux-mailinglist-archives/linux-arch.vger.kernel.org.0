Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B336548A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2019 12:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfGKKem (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Jul 2019 06:34:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49530 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfGKKel (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 06:34:41 -0400
Received: from [5.158.153.55] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlWPJ-0003zg-TT; Thu, 11 Jul 2019 12:34:34 +0200
Date:   Thu, 11 Jul 2019 12:34:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Will Deacon <will@kernel.org>
cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        andre.przywara@arm.com, arnd@arndb.de, huw@codeweavers.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        will.deacon@arm.com, linux@armlinux.org.uk, ralf@linux-mips.org,
        salyzyn@android.com, luto@kernel.org, paul.burton@mips.com,
        john.stultz@linaro.org, 0x7f454c46@gmail.com,
        linux@rasmusvillemoes.dk, sthotton@marvell.com, pcc@google.com
Subject: Re: [PATCH v2] arm64: vdso: Fix ABI regression in compat vdso
In-Reply-To: <20190711094505.rwy6t6wu2cvmvwr6@willie-the-truck>
Message-ID: <alpine.DEB.2.21.1907111232000.1889@nanos.tec.linutronix.de>
References: <20190621095252.32307-11-vincenzo.frascino@arm.com> <20190710140119.23417-1-vincenzo.frascino@arm.com> <20190711094505.rwy6t6wu2cvmvwr6@willie-the-truck>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 11 Jul 2019, Will Deacon wrote:

> On Wed, Jul 10, 2019 at 03:01:19PM +0100, Vincenzo Frascino wrote:
> > Prior to the introduction of Unified vDSO support and compat layer for
> > vDSO on arm64, AT_SYSINFO_EHDR was not defined for compat tasks.
> > In the current implementation, AT_SYSINFO_EHDR is defined even if the
> > compat vdso layer is not built and this causes a regression in the
> > expected behavior of the ABI.
> > 
> > Restore the ABI behavior making sure that AT_SYSINFO_EHDR for compat
> > tasks is defined only when CONFIG_COMPAT_VDSO is enabled.
> > 
> > Reported-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  arch/arm64/include/asm/elf.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> > index 3c7037c6ba9b..b618017205a3 100644
> > --- a/arch/arm64/include/asm/elf.h
> > +++ b/arch/arm64/include/asm/elf.h
> > @@ -202,7 +202,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
> >  ({									\
> >  	set_thread_flag(TIF_32BIT);					\
> >   })
> > -#ifdef CONFIG_GENERIC_COMPAT_VDSO
> > +#ifdef CONFIG_COMPAT_VDSO
> >  #define COMPAT_ARCH_DLINFO						\
> >  do {									\
> >  	/*								\
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> I can take this at -rc1 via arm64 unless tglx plans to send it during the
> rest of the merge window. Please let me know.

I had no plan to pick it up, but if you want I can route it through timer
urgents so it hits Linus tree before rc1.

Thanks,

	tglx
