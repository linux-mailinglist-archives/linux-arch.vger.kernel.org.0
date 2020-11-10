Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2369B2AD406
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 11:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKJKql (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 05:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJKql (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 05:46:41 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE0CB205CB;
        Tue, 10 Nov 2020 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605005200;
        bh=J/g3qFcVhEVqYT9C8+xytbWfhE+9Ug3/6PuaDXh4v1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hVuwxGyZEx7fI9GTZbiIc5+FD/IIcqFmiGNtCE3OU8NrPKpoVBwCX+psZoLaifDzz
         xr8CpOEjqp/HiWcK9oxzW0iwaHmvT9dlZ73FRkroGYnvcPrfscw/W4ZvOdtuHdc+Ey
         7buviADtRhdEN+ITyNRqSiu/i6kuesiaI/gJ5yYo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcRAb-009QCB-OV; Tue, 10 Nov 2020 10:46:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 10:46:37 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
In-Reply-To: <X6pnFgD5NT9smHG5@kroah.com>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-6-will@kernel.org> <X6o7euVw0QlysIPV@kroah.com>
 <X6pdSx84CWvag02r@trantor> <X6pfISu1PE5lelNL@kroah.com>
 <e09e755dd5058103241c1c919d6af076@kernel.org> <X6pnFgD5NT9smHG5@kroah.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <93df8d6ed8842b83d76fa57ad1ef5bb4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, peterz@infradead.org, morten.rasmussen@arm.com, qais.yousef@arm.com, surenb@google.com, qperret@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-11-10 10:10, Greg Kroah-Hartman wrote:
> On Tue, Nov 10, 2020 at 09:53:53AM +0000, Marc Zyngier wrote:
>> On 2020-11-10 09:36, Greg Kroah-Hartman wrote:
>> 
>> [...]
>> 
>> > While punting the logic out to userspace is simple for the kernel, and
>> > of course my first option, I think this isn't going to work in the
>> > long-run and the kernel will have to "know" what type of process it is
>> > scheduling in order to correctly deal with this nightmare as userspace
>> > can't do that well, if at all.
>> 
>> For that to happen, we must first decide which part of the userspace
>> ABI we are prepared to compromise on. The most obvious one would be to
>> allow overriding the affinity on exec, but I'm pretty sure it has bad
>> interactions with cgroups, on top of violating the existing ABI which
>> mandates that the affinity is inherited across exec.
> 
> So you are saying that you have to violate this today with this patch
> set?  Or would have to violate that if the scheduler got involved?

Doing nothing (as with this series) doesn't result in an ABI breakage.
It "only" results in an unreliable system. If you start making decisions
behind userspace's back for the sake of making things reliable (which
is a commendable goal), you break the ABI.

Rock, please meet A Hard Place.

And that's the real issue: there is no good solution to this problem.
Only a different set of ugly compromises.

> How is userspace going to "know" how to do all of this properly?  Who 
> is
> going to write that code?
> 
>> There may be other options (always make at least one 32bit-capable CPU
>> part of the process affinity?), but they all imply some form of 
>> userspace
>> visible regressions.
>> 
>> Pick your poison... :-/
> 
> What do the system designers and users of this hardware recommend?  
> They
> are the ones that dreamed up this, and seem to somehow want this.  What
> do they think the correct solution is here as obviously they must have
> thought this through when designing such a beast, right?
> 
> And if they didn't think any of this through then why are they wanting
> to run Linux on this thing?

At this stage, I'll reach out for some Bombay mix (I dislike pop corn).

         M.
-- 
Jazz is not dead. It just smells funny...
