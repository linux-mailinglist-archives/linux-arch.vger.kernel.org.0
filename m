Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9742AD291
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 10:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgKJJfh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 04:35:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgKJJfg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 04:35:36 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7327A20780;
        Tue, 10 Nov 2020 09:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605000936;
        bh=9MdFHeB2bNIr015cgY11oRfLVJ4BDEFfQ1Nc6iS/ffg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIhXIl7lGSIWPBFGFivtW+0mpp6v1hrW2h2g8210U7HOR1c1R6kRRBt+3VAjQP0j+
         oIcG4XIcjqmgiTOXuHhfp9RWrFpJWmaL55chifFHPjMYGkIZd1PnK+1SLyrGdX5bLg
         Aa/2nJMGNt/sHZgnK5xgbUeSALPAeOH0x3d687i4=
Date:   Tue, 10 Nov 2020 10:36:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 5/6] arm64: Advertise CPUs capable of running 32-bit
 applications in sysfs
Message-ID: <X6pfISu1PE5lelNL@kroah.com>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-6-will@kernel.org>
 <X6o7euVw0QlysIPV@kroah.com>
 <X6pdSx84CWvag02r@trantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6pdSx84CWvag02r@trantor>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 09:28:43AM +0000, Catalin Marinas wrote:
> On Tue, Nov 10, 2020 at 08:04:26AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 09, 2020 at 09:30:21PM +0000, Will Deacon wrote:
> > > Since 32-bit applications will be killed if they are caught trying to
> > > execute on a 64-bit-only CPU in a mismatched system, advertise the set
> > > of 32-bit capable CPUs to userspace in sysfs.
> > > 
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  .../ABI/testing/sysfs-devices-system-cpu      |  9 +++++++++
> > >  arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
> > >  2 files changed, 28 insertions(+)
> > 
> > I still think the "kill processes that can not run on this CPU" is crazy
> 
> I agree it's crazy, though we try to keep the kernel support simple
> while making it a user-space problem. The alternative is to
> force-migrate such process to a more capable CPU, potentially against
> the desired user cpumask. In addition, we'd have to block CPU hot-unplug
> in case the last 32-bit capable CPU disappears.

You should block CPU hot-unplug for the last 32bit capable CPU, why
would you not want that if there are any active 32bit processes running?

And how is userspace going to know that it is creating a 32bit process?
Are you now going to force all calls to exec() to be mediated somehow by
putting an ELF parser in the init process?

> The only sane thing is not to allow 32-bit processes at all on such
> hardware but I think we lost that battle ;).

That was a hardware decision that was made for some specific reason, so
supporting it in the best way seems to be our best option given that
people obviously must want this crazy type of system otherwise they
wouldn't be paying for it!

While punting the logic out to userspace is simple for the kernel, and
of course my first option, I think this isn't going to work in the
long-run and the kernel will have to "know" what type of process it is
scheduling in order to correctly deal with this nightmare as userspace
can't do that well, if at all.

thanks,

greg k-h
