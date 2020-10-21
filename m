Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC81294F95
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444075AbgJUPKL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 11:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443920AbgJUPKL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 11:10:11 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A3B20BED;
        Wed, 21 Oct 2020 15:10:08 +0000 (UTC)
Date:   Wed, 21 Oct 2020 16:10:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-arch@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021151005.GF3976@gaia>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021133316.GF8004@e123083-lin>
 <20201021140945.GD3976@gaia>
 <20201021144542.GB17912@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021144542.GB17912@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 03:45:43PM +0100, Will Deacon wrote:
> On Wed, Oct 21, 2020 at 03:09:46PM +0100, Catalin Marinas wrote:
> > Anyway, if the task placement is entirely off the table, the next thing
> > is asking applications to set their own mask and kill them if they do
> > the wrong thing. Here I see two possibilities for killing an app:
> > 
> > 1. When it ends up scheduled on a non-AArch32-capable CPU
> 
> That sounds fine to me. If we could do the exception return and take a
> SIGILL, that's what we'd do, but we can't so we have to catch it before.

Indeed, the illegal ERET doesn't work for this scenario.

> > 2. If the user cpumask (bar the offline CPUs) is not a subset of the
> >    aarch32_mask
> > 
> > Option 1 is simpler but 2 would be slightly more consistent.
> 
> I disagree -- if we did this for something like fpsimd, then the consistent
> behaviour would be to SIGILL on the cores without the instructions.

For fpsimd it makes sense since the main ISA is still available and the
application may be able to do something with the signal. But here we
can't do much since the entire AArch32 mode is not supported. That's why
we went for SIGKILL instead of SIGILL but thinking of it, after execve()
the signals are reset to SIG_DFL so SIGILL cannot be ignored.

I think it depends on whether you look at this fault as a part of ISA
not being available or as the overall application not compatible with
the system it is running on. If the latter, option 2 above makes more
sense.

> > There's also the question on whether the kernel should allow an ELF32 to
> > be loaded (and potentially killed subsequently) if the user mask is not
> > correct on execve().
> 
> I don't see the point in distinguishing between "you did execve() on a core
> without 32-bit" and "you did execve() on a core with 32-bit and then
> migrated to a core without 32-bit".

In the context of option 2 above, its more about whether execve()
returns -ENOEXEC or the process gets a SIGKILL immediately.

-- 
Catalin
