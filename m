Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40910231351
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgG1UAD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 16:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbgG1UAD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 16:00:03 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D1352070A;
        Tue, 28 Jul 2020 20:00:00 +0000 (UTC)
Date:   Tue, 28 Jul 2020 20:59:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200728195957.GA31698@gaia>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728145350.GR7127@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 28, 2020 at 03:53:51PM +0100, Szabolcs Nagy wrote:
> The 07/28/2020 12:08, Dave Martin wrote:
> > On Mon, Jul 27, 2020 at 05:36:35PM +0100, Szabolcs Nagy wrote:
> > > a solution is to introduce a flag like SECCOMP_FILTER_FLAG_TSYNC
> > > that means the prctl is for all threads in the process not just
> > > for the current one. however the exact semantics is not obvious
> > > if there are inconsistent settings in different threads or user
> > > code tries to use the prctl concurrently: first checking then
> > > setting the mte state via separate prctl calls is racy. but if
> > > the userspace contract for enabling mte limits who and when can
> > > call the prctl then i think the simple sync flag approach works.
> > > 
> > > (the sync flag should apply to all prctl settings: tagged addr
> > > syscall abi, mte check fault mode, irg tag excludes. ideally it
> > > would work for getting the process wide state and it would fail
> > > in case of inconsistent settings.)
> > 
> > If going down this route, perhaps we could have sets of settings:
> > so for each setting we have a process-wide value and a per-thread
> > value, with defines rules about how they combine.
> > 
> > Since MTE is a debugging feature, we might be able to be less aggressive
> > about synchronisation than in the SECCOMP case.
> 
> separate process-wide and per-thread value
> works for me and i expect most uses will
> be process wide settings.

The problem with the thread synchronisation is, unlike SECCOMP, that we
need to update the SCTLR_EL1.TCF0 field across all the CPUs that may run
threads of the current process. I haven't convinced myself that this is
race-free without heavy locking. If we go for some heavy mechanism like
stop_machine(), that opens the kernel to DoS attacks from user. Still
investigating if something like membarrier() would be sufficient.

SECCOMP gets away with this as it only needs to set some variable
without IPI'ing the other CPUs.

> i don't think mte is less of a security
> feature than seccomp.

Well, MTE is probabilistic, SECCOMP seems to be more precise ;).

> if linux does not want to add a per process
> setting then only libc will be able to opt-in
> to mte and only at very early in the startup
> process (before executing any user code that
> may start threads). this is not out of question,
> but i think it limits the usage and deployment
> options.

There is also the risk that we try to be too flexible at this stage
without a real use-case.

-- 
Catalin
