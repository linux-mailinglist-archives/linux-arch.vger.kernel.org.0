Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F222D22972C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGVLJ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 07:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVLJz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jul 2020 07:09:55 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB55206F5;
        Wed, 22 Jul 2020 11:09:53 +0000 (UTC)
Date:   Wed, 22 Jul 2020 12:09:51 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 18/29] arm64: mte: Allow user control of the tag check
 mode via prctl()
Message-ID: <20200722110950.GB27540@gaia>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-19-catalin.marinas@arm.com>
 <e9feb87e-41a8-17e6-eeba-4038da3bdde2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9feb87e-41a8-17e6-eeba-4038da3bdde2@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 20, 2020 at 04:30:35PM +0100, Kevin Brodsky wrote:
> On 15/07/2020 18:08, Catalin Marinas wrote:
> > +void mte_thread_switch(struct task_struct *next)
> > +{
> > +	if (!system_supports_mte())
> > +		return;
> > +
> > +	/* avoid expensive SCTLR_EL1 accesses if no change */
> > +	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
> 
> I think this could be improved by checking whether `next` is a kernel
> thread, in which case thread.sctlr_tcf0 is 0 but there is no point in
> setting SCTLR_EL1.TCF0, since there should not be any access via TTBR0.

It's not about kernel or user thread here. kthread_use_mm() (just
use_mm() in older kernels) would set an mm on a kernel thread,
temporarily making it behave as a user one. Since the sctlr_tcf0 is per
thread, not per mm, we need to switch to the default TCF0 for kthreads
so that user accesses (if use_mm() is called) don't generate any tag
check faults. Note that switch_mm() does not touch TCF0.

If we did allow a global, per-mm TCF0 setting, such kthreads could only
handle synchronous faults and no SIGSEGV generated (as we do with
copy_{from,to}_user() for normal threads).

If we want to revisit per-thread vs per-mm TCF0 setting, now is the
time.

-- 
Catalin
