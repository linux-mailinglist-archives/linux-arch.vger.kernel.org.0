Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6212AD32E
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 11:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgKJKJe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 05:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgKJKJd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 05:09:33 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD9E20780;
        Tue, 10 Nov 2020 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605002973;
        bh=U5aaL8w8vpGKmDmBS/BPhY5OijCIpFEEL7zAO1zMJgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=exnBnWXD2u+O8LraGvXH6k7vWm/iKAsF4nwhXAI4she7UvOxo52piNAy+7Up7zemw
         lHNCOMqzygDIc/Ji3CZ4KEf1xs7O2eOZ/qB5M0m4j6tX+e4PZwBXx6Y9n/JyrHd3K/
         zKVpc5AXqKAc5yzIzwqyag4jxDmmA+cfyV1ikl8o=
Date:   Tue, 10 Nov 2020 11:10:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 5/6] arm64: Advertise CPUs capable of running 32-bit
 applications in sysfs
Message-ID: <X6pnFgD5NT9smHG5@kroah.com>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-6-will@kernel.org>
 <X6o7euVw0QlysIPV@kroah.com>
 <X6pdSx84CWvag02r@trantor>
 <X6pfISu1PE5lelNL@kroah.com>
 <e09e755dd5058103241c1c919d6af076@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09e755dd5058103241c1c919d6af076@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 09:53:53AM +0000, Marc Zyngier wrote:
> On 2020-11-10 09:36, Greg Kroah-Hartman wrote:
> 
> [...]
> 
> > While punting the logic out to userspace is simple for the kernel, and
> > of course my first option, I think this isn't going to work in the
> > long-run and the kernel will have to "know" what type of process it is
> > scheduling in order to correctly deal with this nightmare as userspace
> > can't do that well, if at all.
> 
> For that to happen, we must first decide which part of the userspace
> ABI we are prepared to compromise on. The most obvious one would be to
> allow overriding the affinity on exec, but I'm pretty sure it has bad
> interactions with cgroups, on top of violating the existing ABI which
> mandates that the affinity is inherited across exec.

So you are saying that you have to violate this today with this patch
set?  Or would have to violate that if the scheduler got involved?

How is userspace going to "know" how to do all of this properly?  Who is
going to write that code?

> There may be other options (always make at least one 32bit-capable CPU
> part of the process affinity?), but they all imply some form of userspace
> visible regressions.
> 
> Pick your poison... :-/

What do the system designers and users of this hardware recommend?  They
are the ones that dreamed up this, and seem to somehow want this.  What
do they think the correct solution is here as obviously they must have
thought this through when designing such a beast, right?

And if they didn't think any of this through then why are they wanting
to run Linux on this thing?

thanks,

greg k-h
