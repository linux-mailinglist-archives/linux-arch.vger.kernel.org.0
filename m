Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE337BA4
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfFFR4Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 13:56:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51846 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbfFFR4Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 13:56:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D07CC374;
        Thu,  6 Jun 2019 10:56:24 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50F413F690;
        Thu,  6 Jun 2019 10:56:22 -0700 (PDT)
Date:   Thu, 6 Jun 2019 18:56:19 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Elliott <paul.elliott@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/8] arm64: Basic Branch Target Identification support
Message-ID: <20190606175619.GE28398@e103592.cambridge.arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
 <1558693533-13465-5-git-send-email-Dave.Martin@arm.com>
 <20190524130217.GA15566@lakrids.cambridge.arm.com>
 <20190524145306.GZ28398@e103592.cambridge.arm.com>
 <20190606171155.GI56860@arrakis.emea.arm.com>
 <20190606172345.GD28398@e103592.cambridge.arm.com>
 <5f92e89a5823a3265fa0b389a19452ba995e9406.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f92e89a5823a3265fa0b389a19452ba995e9406.camel@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 06, 2019 at 10:34:22AM -0700, Yu-cheng Yu wrote:
> On Thu, 2019-06-06 at 18:23 +0100, Dave Martin wrote:
> > On Thu, Jun 06, 2019 at 06:11:56PM +0100, Catalin Marinas wrote:
> > > On Fri, May 24, 2019 at 03:53:06PM +0100, Dave P Martin wrote:
> > > > On Fri, May 24, 2019 at 02:02:17PM +0100, Mark Rutland wrote:
> > > > > On Fri, May 24, 2019 at 11:25:29AM +0100, Dave Martin wrote:
> > > > > >  #endif /* _UAPI__ASM_HWCAP_H */
> > > > > > diff --git a/arch/arm64/include/uapi/asm/mman.h
> > > > > > b/arch/arm64/include/uapi/asm/mman.h
> > > > > > new file mode 100644
> > > > > > index 0000000..4776b43
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/include/uapi/asm/mman.h
> > > > > > @@ -0,0 +1,9 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > > +#ifndef _UAPI__ASM_MMAN_H
> > > > > > +#define _UAPI__ASM_MMAN_H
> > > > > > +
> > > > > > +#include <asm-generic/mman.h>
> > > > > > +
> > > > > > +#define PROT_BTI_GUARDED	0x10		/* BTI guarded
> > > > > > page */
> > > > > 
> > > > > From prior discussions, I thought this would be PROT_BTI, without the
> > > > > _GUARDED suffix. Do we really need that?
> > > > > 
> > > > > AFAICT, all other PROT_* definitions only have a single underscore, and
> > > > > the existing arch-specific flags are PROT_ADI on sparc, and PROT_SAO on
> > > > > powerpc.
> > > > 
> > > > No strong opinon.  I was trying to make the name less obscure, but I'm
> > > > equally happy with PROT_BTI if people prefer that.
> > > 
> > > I prefer PROT_BTI as well. We are going to add a PROT_MTE at some point
> > > (and a VM_ARM64_MTE in the high VMA flag bits).
> > 
> > Ack.
> > 
> > Some things need attention, so I need to respin this series anyway.
> > 
> > skip_faulting_instruction() and kprobes/uprobes may need looking at,
> > plus I want to simply the ELF parsing (at least to skip some cost for
> > arm64).
> 
> Can we add a case in the 'consistency checks for the interpreter' (right above
> where you add arch_parse_property()) for PT_NOTE?  That way you can still use
> part of the same parser.

I think for arm64 that we can skip searching all the notes by checking
for a PT_GNU_PROPERTY entry; once that's found, the actual
NT_GNU_PROPERTY_TYPE_0 parsing should be common.  If there's no
PT_GNU_PROPERTY entry, we can immediately give up.

For x86, would it makes sense to use PT_GNU_PROPERTY if it's there,
and fall back to scanning all the notes otherwise?  Ideally we
wouldn't need the fallback, but if there are binaries in the wild with
NT_GNU_PROPERTY_TYPE_0 that lack a PT_GNU_PROPERTY entry, we may be
stuck with that.

Thoughts?

Cheers
---Dave
