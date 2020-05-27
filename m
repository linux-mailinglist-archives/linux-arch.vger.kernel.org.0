Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB31E3AE0
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgE0HrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 03:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387487AbgE0HrE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 03:47:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A0BD207CB;
        Wed, 27 May 2020 07:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590565624;
        bh=/FVQ3sLZUY/KzEKvgBXodRAdsyRqYRRArkYuCnMkydY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVeFzpVdK/UfgPBIOmXoKNIzgx0gyeybY/yzjW9JfmshAD076tdIm8WEbWr9uII4S
         WXSdBD994NaKD8njjZAuYD4+sQJyHg9UtzIEBh5m8MWiUyZS/QNILopeSK3OP2I3IP
         FABRqUXF/55oL2QMxAZ5l3ouZLJiePenMtgCn6/c=
Date:   Wed, 27 May 2020 08:46:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH v4 15/26] arm64: mte: Allow user control of the tag check
 mode via prctl()
Message-ID: <20200527074658.GB9887@willie-the-truck>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-16-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515171612.1020-16-catalin.marinas@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 15, 2020 at 06:16:01PM +0100, Catalin Marinas wrote:
> By default, even if PROT_MTE is set on a memory range, there is no tag
> check fault reporting (SIGSEGV). Introduce a set of option to the
> exiting prctl(PR_SET_TAGGED_ADDR_CTRL) to allow user control of the tag
> check fault mode:
> 
>   PR_MTE_TCF_NONE  - no reporting (default)
>   PR_MTE_TCF_SYNC  - synchronous tag check fault reporting
>   PR_MTE_TCF_ASYNC - asynchronous tag check fault reporting
> 
> These options translate into the corresponding SCTLR_EL1.TCF0 bitfield,
> context-switched by the kernel. Note that uaccess done by the kernel is
> not checked and cannot be configured by the user.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> 
> Notes:
>     v3:
>     - Use SCTLR_EL1_TCF0_NONE instead of 0 for consistency.
>     - Move mte_thread_switch() in this patch from an earlier one. In
>       addition, it is called after the dsb() in __switch_to() so that any
>       asynchronous tag check faults have been registered in the TFSR_EL1
>       registers (to be added with the in-kernel MTE support.
>     
>     v2:
>     - Handle SCTLR_EL1_TCF0_NONE explicitly for consistency with PR_MTE_TCF_NONE.
>     - Fix SCTLR_EL1 register setting in flush_mte_state() (thanks to Peter
>       Collingbourne).
>     - Added ISB to update_sctlr_el1_tcf0() since, with the latest
>       architecture update/fix, the TCF0 field is used by the uaccess
>       routines.
> 
>  arch/arm64/include/asm/mte.h       | 14 ++++++
>  arch/arm64/include/asm/processor.h |  3 ++
>  arch/arm64/kernel/mte.c            | 77 ++++++++++++++++++++++++++++++
>  arch/arm64/kernel/process.c        | 26 ++++++++--
>  include/uapi/linux/prctl.h         |  6 +++
>  5 files changed, 123 insertions(+), 3 deletions(-)

Dave is working on man pages for prctl() (and I think also ptrace). I think
it would be /very/ useful for us to have some RFC patches on top of his work
adding documentation for the MTE interactions, as we found some other minor
issues/inconsistencies as a direct result of writing and reviewing the man
page for our existing interfaces.

Cheers,

Will
