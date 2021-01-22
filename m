Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48E3005BB
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jan 2021 15:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbhAVOmp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jan 2021 09:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbhAVOm0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Jan 2021 09:42:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 183BA23444;
        Fri, 22 Jan 2021 14:41:43 +0000 (UTC)
Date:   Fri, 22 Jan 2021 14:41:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Message-ID: <20210122144141.GE8567@gaia>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <CAAeHK+y=8iD_nvXFFerXcZbH=pjLFQbUP_+Ftayj-t9r9h8Ghg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+y=8iD_nvXFFerXcZbH=pjLFQbUP_+Ftayj-t9r9h8Ghg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 21, 2021 at 08:37:18PM +0100, Andrey Konovalov wrote:
> On Fri, May 15, 2020 at 7:17 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > For performance analysis it may be desirable to disable MTE altogether
> > via an early param. Introduce arm64.mte_disable and, if true, filter out
> > the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> > user.
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >
> > Notes:
> >     New in v4.
> >
> >  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> >  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2a93c8679e8..7436e7462b85 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -373,6 +373,10 @@
> >         arcrimi=        [HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> >                         Format: <io>,<irq>,<nodeID>
> >
> > +       arm64.mte_disable=
> > +                       [ARM64] Disable Linux support for the Memory
> > +                       Tagging Extension (both user and in-kernel).
> > +
> >         ataflop=        [HW,M68k]
> >
> >         atarimouse=     [HW,MOUSE] Atari Mouse
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index aaadc1cbc006..f7596830694f 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -126,12 +126,23 @@ static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
> >  static bool __system_matches_cap(unsigned int n);
> >
> >  #ifdef CONFIG_ARM64_MTE
> > +static bool mte_disable;
> > +
> > +static int __init arm64_mte_disable(char *buf)
> > +{
> > +       return strtobool(buf, &mte_disable);
> > +}
> > +early_param("arm64.mte_disable", arm64_mte_disable);
> > +
> >  s64 mte_ftr_filter(const struct arm64_ftr_bits *ftrp, s64 val)
> >  {
> >         struct device_node *np;
> >         static bool memory_checked = false;
> >         static bool mte_capable = true;
> >
> > +       if (mte_disable)
> > +               return ID_AA64PFR1_MTE_NI;
> > +
> >         /* EL0-only MTE is not supported by Linux, don't expose it */
> >         if (val < ID_AA64PFR1_MTE)
> >                 return ID_AA64PFR1_MTE_NI;
> 
> While this patch didn't land upstream, we need an MTE kill-switch for
> Android GKI. Is this patch OK to take as is? Is it still valid?

As you noticed, this code no longer exists. The CPUID is checked early
during boot in proc.S, before the MMU is enabled, as you need to set up
the MAIR register.

Now, what do you mean by kill switch? There are multiple levels at which
one can disable MTE or some of its effects: memory type (MAIR) level,
tag allocation (TCR_EL1.ATA), tag checking (SCTLR_EL1.TCF). Apart from
the latter, all the other bits are cached in the TLB which make them
more problematic to toggle at run-time.

For the kernel, we can currently disable tag checking via the kasan
command line options. For user-space, we don't have a kill switch
specific to MTE, however one can disable the tagged addr ABI and
presumably the C library will avoid generating tagged heap pointers.

-- 
Catalin
