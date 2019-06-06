Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD39937B4D
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 19:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfFFRmY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 13:42:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:37402 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbfFFRmY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 13:42:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 10:42:23 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga001.jf.intel.com with ESMTP; 06 Jun 2019 10:42:22 -0700
Message-ID: <5f92e89a5823a3265fa0b389a19452ba995e9406.camel@intel.com>
Subject: Re: [PATCH 4/8] arm64: Basic Branch Target Identification support
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Elliott <paul.elliott@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Kristina =?UTF-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 06 Jun 2019 10:34:22 -0700
In-Reply-To: <20190606172345.GD28398@e103592.cambridge.arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
         <1558693533-13465-5-git-send-email-Dave.Martin@arm.com>
         <20190524130217.GA15566@lakrids.cambridge.arm.com>
         <20190524145306.GZ28398@e103592.cambridge.arm.com>
         <20190606171155.GI56860@arrakis.emea.arm.com>
         <20190606172345.GD28398@e103592.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2019-06-06 at 18:23 +0100, Dave Martin wrote:
> On Thu, Jun 06, 2019 at 06:11:56PM +0100, Catalin Marinas wrote:
> > On Fri, May 24, 2019 at 03:53:06PM +0100, Dave P Martin wrote:
> > > On Fri, May 24, 2019 at 02:02:17PM +0100, Mark Rutland wrote:
> > > > On Fri, May 24, 2019 at 11:25:29AM +0100, Dave Martin wrote:
> > > > >  #endif /* _UAPI__ASM_HWCAP_H */
> > > > > diff --git a/arch/arm64/include/uapi/asm/mman.h
> > > > > b/arch/arm64/include/uapi/asm/mman.h
> > > > > new file mode 100644
> > > > > index 0000000..4776b43
> > > > > --- /dev/null
> > > > > +++ b/arch/arm64/include/uapi/asm/mman.h
> > > > > @@ -0,0 +1,9 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > +#ifndef _UAPI__ASM_MMAN_H
> > > > > +#define _UAPI__ASM_MMAN_H
> > > > > +
> > > > > +#include <asm-generic/mman.h>
> > > > > +
> > > > > +#define PROT_BTI_GUARDED	0x10		/* BTI guarded
> > > > > page */
> > > > 
> > > > From prior discussions, I thought this would be PROT_BTI, without the
> > > > _GUARDED suffix. Do we really need that?
> > > > 
> > > > AFAICT, all other PROT_* definitions only have a single underscore, and
> > > > the existing arch-specific flags are PROT_ADI on sparc, and PROT_SAO on
> > > > powerpc.
> > > 
> > > No strong opinon.  I was trying to make the name less obscure, but I'm
> > > equally happy with PROT_BTI if people prefer that.
> > 
> > I prefer PROT_BTI as well. We are going to add a PROT_MTE at some point
> > (and a VM_ARM64_MTE in the high VMA flag bits).
> 
> Ack.
> 
> Some things need attention, so I need to respin this series anyway.
> 
> skip_faulting_instruction() and kprobes/uprobes may need looking at,
> plus I want to simply the ELF parsing (at least to skip some cost for
> arm64).

Can we add a case in the 'consistency checks for the interpreter' (right above
where you add arch_parse_property()) for PT_NOTE?  That way you can still use
part of the same parser.

Yu-cheng

