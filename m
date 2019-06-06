Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65A37AF3
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfFFRXv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 13:23:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51374 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfFFRXv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 13:23:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5E54374;
        Thu,  6 Jun 2019 10:23:50 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372DE3F690;
        Thu,  6 Jun 2019 10:23:48 -0700 (PDT)
Date:   Thu, 6 Jun 2019 18:23:45 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Elliott <paul.elliott@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/8] arm64: Basic Branch Target Identification support
Message-ID: <20190606172345.GD28398@e103592.cambridge.arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
 <1558693533-13465-5-git-send-email-Dave.Martin@arm.com>
 <20190524130217.GA15566@lakrids.cambridge.arm.com>
 <20190524145306.GZ28398@e103592.cambridge.arm.com>
 <20190606171155.GI56860@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606171155.GI56860@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 06, 2019 at 06:11:56PM +0100, Catalin Marinas wrote:
> On Fri, May 24, 2019 at 03:53:06PM +0100, Dave P Martin wrote:
> > On Fri, May 24, 2019 at 02:02:17PM +0100, Mark Rutland wrote:
> > > On Fri, May 24, 2019 at 11:25:29AM +0100, Dave Martin wrote:
> > > >  #endif /* _UAPI__ASM_HWCAP_H */
> > > > diff --git a/arch/arm64/include/uapi/asm/mman.h b/arch/arm64/include/uapi/asm/mman.h
> > > > new file mode 100644
> > > > index 0000000..4776b43
> > > > --- /dev/null
> > > > +++ b/arch/arm64/include/uapi/asm/mman.h
> > > > @@ -0,0 +1,9 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > +#ifndef _UAPI__ASM_MMAN_H
> > > > +#define _UAPI__ASM_MMAN_H
> > > > +
> > > > +#include <asm-generic/mman.h>
> > > > +
> > > > +#define PROT_BTI_GUARDED	0x10		/* BTI guarded page */
> > > 
> > > From prior discussions, I thought this would be PROT_BTI, without the
> > > _GUARDED suffix. Do we really need that?
> > > 
> > > AFAICT, all other PROT_* definitions only have a single underscore, and
> > > the existing arch-specific flags are PROT_ADI on sparc, and PROT_SAO on
> > > powerpc.
> > 
> > No strong opinon.  I was trying to make the name less obscure, but I'm
> > equally happy with PROT_BTI if people prefer that.
> 
> I prefer PROT_BTI as well. We are going to add a PROT_MTE at some point
> (and a VM_ARM64_MTE in the high VMA flag bits).

Ack.

Some things need attention, so I need to respin this series anyway.

skip_faulting_instruction() and kprobes/uprobes may need looking at,
plus I want to simply the ELF parsing (at least to skip some cost for
arm64).

Cheers
---Dave
