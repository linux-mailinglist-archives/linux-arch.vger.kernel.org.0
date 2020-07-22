Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22576229606
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 12:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgGVK2w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 06:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbgGVK2v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jul 2020 06:28:51 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4BF20729;
        Wed, 22 Jul 2020 10:28:49 +0000 (UTC)
Date:   Wed, 22 Jul 2020 11:28:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v7 18/29] arm64: mte: Allow user control of the tag check
 mode via prctl()
Message-ID: <20200722102845.GA27540@gaia>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-19-catalin.marinas@arm.com>
 <e9feb87e-41a8-17e6-eeba-4038da3bdde2@arm.com>
 <20200720170050.GJ30452@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720170050.GJ30452@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 20, 2020 at 06:00:50PM +0100, Dave P Martin wrote:
> On Mon, Jul 20, 2020 at 04:30:35PM +0100, Kevin Brodsky wrote:
> > On 15/07/2020 18:08, Catalin Marinas wrote:
> > >+void mte_thread_switch(struct task_struct *next)
> > >+{
> > >+	if (!system_supports_mte())
> > >+		return;
> > >+
> > >+	/* avoid expensive SCTLR_EL1 accesses if no change */
> > >+	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
> > 
> > I think this could be improved by checking whether `next` is a kernel
> > thread, in which case thread.sctlr_tcf0 is 0 but there is no point in
> > setting SCTLR_EL1.TCF0, since there should not be any access via TTBR0.
> 
> Out of interest, do we have a nice way of testing for a kernel thread
> now?
> 
> I remember fpsimd_thread_switch() used to check for task->mm, but we
> seem to have got rid of that at some point.  set_mm() can defeat this,
> and anyway the heavy lifting for FPSIMD is now deferred until returning
> to userspace.

I think a better way is (current->flags & PF_KTHREAD). kthread_use_mm()
indeed changes current->mm.

-- 
Catalin
