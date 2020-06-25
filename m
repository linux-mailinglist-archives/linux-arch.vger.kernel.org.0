Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0B120A418
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 19:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405004AbgFYReH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 13:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404938AbgFYReG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 13:34:06 -0400
Received: from gaia (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B952320789;
        Thu, 25 Jun 2020 17:34:04 +0000 (UTC)
Date:   Thu, 25 Jun 2020 18:34:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v5 11/25] mm: Introduce arch_calc_vm_flag_bits()
Message-ID: <20200625173344.GF14812@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-12-catalin.marinas@arm.com>
 <20200624113611.2cf12da3a325d03a862c0adf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624113611.2cf12da3a325d03a862c0adf@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 11:36:11AM -0700, Andrew Morton wrote:
> On Wed, 24 Jun 2020 18:52:30 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > From: Kevin Brodsky <Kevin.Brodsky@arm.com>
> > Similarly to arch_calc_vm_prot_bits(), introduce a dummy
> > arch_calc_vm_flag_bits() invoked from calc_vm_flag_bits(). This macro
> > can be overridden by architectures to insert specific VM_* flags derived
> > from the mmap() MAP_* flags.
> > 
> > ...
> >
> > --- a/include/linux/mman.h
> > +++ b/include/linux/mman.h
> > @@ -74,13 +74,17 @@ static inline void vm_unacct_memory(long pages)
> >  }
> >  
> >  /*
> > - * Allow architectures to handle additional protection bits
> > + * Allow architectures to handle additional protection and flag bits
> >   */
> >  
> >  #ifndef arch_calc_vm_prot_bits
> >  #define arch_calc_vm_prot_bits(prot, pkey) 0
> >  #endif
> >  
> > +#ifndef arch_calc_vm_flag_bits
> > +#define arch_calc_vm_flag_bits(flags) 0
> > +#endif
> 
> It would be helpful to add a comment specifying which arch header file
> is responsible for defining arch_calc_vm_flag_bits.  Because in the
> past we've messed this sort of thing up and had different architectures
> define things in different header files, resulting in build issues as
> code evolves.

I'll add a comment that the overriding definitions need to go in the
arch asm/mman.h file.

Thanks.

-- 
Catalin
