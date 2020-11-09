Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8002ABDE6
	for <lists+linux-arch@lfdr.de>; Mon,  9 Nov 2020 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKINy6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Nov 2020 08:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388241AbgKINxF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Nov 2020 08:53:05 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204372068D;
        Mon,  9 Nov 2020 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604929984;
        bh=dGEP64QAs0jF31VMA1gle5O8mu3T3WNCs6sCLQqqCOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ierO7sc+8bF0DatFyV5a312oSxI3bV9XhDsUjF6zi2oVmK1/pat5AfruqcBd2lIP/
         +EgN/kyq0cLJ3rQ3xPOmavc+FChwpYf9cntg95axQvsMpijPOZ0IeplvDMqoB9CEP7
         E6KU+x84RPNcSGv+/nuR/kb40hlP15AWDNCVGepc=
Date:   Mon, 9 Nov 2020 13:52:59 +0000
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [PATCH 2/6] arm64: Allow mismatched 32-bit EL0 support
Message-ID: <20201109135259.GA14526@willie-the-truck>
References: <20201028124049.GC28091@willie-the-truck>
 <20201028185620.GK13345@gaia>
 <20201029222048.GD31375@willie-the-truck>
 <20201030111846.GC23196@gaia>
 <20201030161353.GC32582@willie-the-truck>
 <20201102114444.GC21082@gaia>
 <20201105213846.GA8600@willie-the-truck>
 <20201106125425.u6qoswsjfskyxtoo@e107158-lin.cambridge.arm.com>
 <20201106130007.GA10605@willie-the-truck>
 <20201106144835.q363ezyse4vc5kdg@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106144835.q363ezyse4vc5kdg@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 06, 2020 at 02:48:35PM +0000, Qais Yousef wrote:
> On 11/06/20 13:00, Will Deacon wrote:
> > On Fri, Nov 06, 2020 at 12:54:25PM +0000, Qais Yousef wrote:
> > > FWIW I have my v3 over here in case it's of any help. It solves the problem of
> > > HWCAP discovery when late AArch32 CPU is booted by populating boot_cpu_date
> > > with 32bit features then.
> > > 
> > > 	git clone https://git.gitlab.arm.com/linux-arm/linux-qy.git -b asym-aarch32-upstream-v3 origin/asym-aarch32-upstream-v3
> > 
> > Cheers, I've done something similar. I was hoping to post it today, but I've
> > been side-tracked with bug fixing this morning. The main headache I ended up
> > with was allowing late-onlining of 64-bit-only CPUs if all the boot CPUs
> > are 32-bit capable. What do you do in that case?
> 
> Do you mean if CPUs 0-3 were 32bit capable and we boot with maxcpus=4 then
> attempt to bring the remaining 64bit-only cpus online later?

Right. I think we will refuse to online them. I'll post my attempt at
handling that shortly.

> Haven't tried that tbh. What symptoms do you expect to see? I can try it out.
> I'm off for the remainder of the day, but can spend few mins to run an
> experiment for sure.

No probs; I've been taking Friday afternoons off to burn holiday anyway, so
you didn't miss anything!

Will
