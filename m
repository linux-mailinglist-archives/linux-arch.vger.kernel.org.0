Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBE929D5AA
	for <lists+linux-arch@lfdr.de>; Wed, 28 Oct 2020 23:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgJ1WH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 18:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbgJ1WHX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:23 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF6FD2474F;
        Wed, 28 Oct 2020 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603899363;
        bh=wHsCbiDe/qhudX6Zti2IFuMsNRMvpNSZBq+nyahvtYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vsiiPL1x1DFxGcJ6AzZk/38uVHuL2ihjns5//nPQqbjAG1PzwNSZnNwQilgNqZRCG
         ZwyEJ5xLuKnBX/En/dWqQ1OLfqaa7A3jDDJQyTsmZKdDmGHZ/hAcd1zTL2f+pOqehU
         tyqKTMVZ+X4eCNPhvz172GhIzzJNklg86KYoJFsU=
Date:   Wed, 28 Oct 2020 15:35:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>, kernel-team@android.com
Subject: Re: [PATCH 5/6] arm64: Advertise CPUs capable of running 32-bit
 applcations in sysfs
Message-ID: <20201028153557.GA29024@willie-the-truck>
References: <20201027215118.27003-1-will@kernel.org>
 <20201027215118.27003-6-will@kernel.org>
 <20201028121506.GG13345@gaia>
 <20201028122759.GA28091@willie-the-truck>
 <20201028151442.GI13345@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028151442.GI13345@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 28, 2020 at 03:14:43PM +0000, Catalin Marinas wrote:
> On Wed, Oct 28, 2020 at 12:27:59PM +0000, Will Deacon wrote:
> > On Wed, Oct 28, 2020 at 12:15:07PM +0000, Catalin Marinas wrote:
> > > On Tue, Oct 27, 2020 at 09:51:17PM +0000, Will Deacon wrote:
> > > > diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > > > index b555df825447..19893fb8e870 100644
> > > > --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> > > > +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> > > > @@ -472,6 +472,14 @@ Description:	AArch64 CPU registers
> > > >  		'identification' directory exposes the CPU ID registers for
> > > >  		 identifying model and revision of the CPU.
> > > >  
> > > > +What:		/sys/devices/system/cpu/aarch32_el0
> > > 
> > > Nitpick: should we call this aarch32_el0_present? It's not exactly
> > > present as we populate it as CPUs come online but it's closer to this
> > > mask than to the online one.
> > 
> > I don't think so, because a CPU could be set in this mask but not in the
> > present mask, which is hugely confusing it it has "present" in the name!
> 
> How can it end up here but not in the present mask? We populate present
> early if they have a corresponding DT entry.

I was under the impression that physical CPU hotplug with ACPI would clear
the entry in the present mask, but I can't say I have any machines that I
can test that with and it looks like it might only be implemented for x86
at the moment.

That said, it looks like cpu_die_early() also marks CPUs as not being
present and this can happen due to a late capability conflict.

Will
