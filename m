Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966151E3FA1
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbgE0LQg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 07:16:36 -0400
Received: from foss.arm.com ([217.140.110.172]:36198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387397AbgE0LQf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 07:16:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17E4455D;
        Wed, 27 May 2020 04:16:35 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A609B3F305;
        Wed, 27 May 2020 04:16:33 -0700 (PDT)
Date:   Wed, 27 May 2020 12:16:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 15/26] arm64: mte: Allow user control of the tag check
 mode via prctl()
Message-ID: <20200527111631.GC28101@gaia>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-16-catalin.marinas@arm.com>
 <20200527074658.GB9887@willie-the-truck>
 <20200527083218.GS5031@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527083218.GS5031@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 27, 2020 at 09:32:20AM +0100, Dave P Martin wrote:
> On Wed, May 27, 2020 at 08:46:59AM +0100, Will Deacon wrote:
> > On Fri, May 15, 2020 at 06:16:01PM +0100, Catalin Marinas wrote:
> > > By default, even if PROT_MTE is set on a memory range, there is no tag
> > > check fault reporting (SIGSEGV). Introduce a set of option to the
> > > exiting prctl(PR_SET_TAGGED_ADDR_CTRL) to allow user control of the tag
> > > check fault mode:
> > > 
> > >   PR_MTE_TCF_NONE  - no reporting (default)
> > >   PR_MTE_TCF_SYNC  - synchronous tag check fault reporting
> > >   PR_MTE_TCF_ASYNC - asynchronous tag check fault reporting
> > > 
> > > These options translate into the corresponding SCTLR_EL1.TCF0 bitfield,
> > > context-switched by the kernel. Note that uaccess done by the kernel is
> > > not checked and cannot be configured by the user.
> > > 
> > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > ---
> > > 
> > > Notes:
> > >     v3:
> > >     - Use SCTLR_EL1_TCF0_NONE instead of 0 for consistency.
> > >     - Move mte_thread_switch() in this patch from an earlier one. In
> > >       addition, it is called after the dsb() in __switch_to() so that any
> > >       asynchronous tag check faults have been registered in the TFSR_EL1
> > >       registers (to be added with the in-kernel MTE support.
> > >     
> > >     v2:
> > >     - Handle SCTLR_EL1_TCF0_NONE explicitly for consistency with PR_MTE_TCF_NONE.
> > >     - Fix SCTLR_EL1 register setting in flush_mte_state() (thanks to Peter
> > >       Collingbourne).
> > >     - Added ISB to update_sctlr_el1_tcf0() since, with the latest
> > >       architecture update/fix, the TCF0 field is used by the uaccess
> > >       routines.
> > > 
> > >  arch/arm64/include/asm/mte.h       | 14 ++++++
> > >  arch/arm64/include/asm/processor.h |  3 ++
> > >  arch/arm64/kernel/mte.c            | 77 ++++++++++++++++++++++++++++++
> > >  arch/arm64/kernel/process.c        | 26 ++++++++--
> > >  include/uapi/linux/prctl.h         |  6 +++
> > >  5 files changed, 123 insertions(+), 3 deletions(-)
> > 
> > Dave is working on man pages for prctl() (and I think also ptrace). I think
> > it would be /very/ useful for us to have some RFC patches on top of his work
> > adding documentation for the MTE interactions, as we found some other minor
> > issues/inconsistencies as a direct result of writing and reviewing the man
> > page for our existing interfaces.
> 
> I have a local draft for the address tagging and MTE prctls already btw.
> I hadn't posted them yet so as to focus on nailing the "easy" stuff down
> ;)

That's great Dave. Thanks!

> If I have time I'll try and get them posted today so that people can
> take a look before next week.

Feel free to post them whenever you can. I'll include them in v5 (likely
to be posted after the merging window).

-- 
Catalin
