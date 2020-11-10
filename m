Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029DD2AD42B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 11:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJK5I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 05:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgKJK5I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 05:57:08 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085F3206F1;
        Tue, 10 Nov 2020 10:57:04 +0000 (UTC)
Date:   Tue, 10 Nov 2020 10:57:02 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <X6px/gsuzIFLTIQ7@trantor>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-6-will@kernel.org>
 <X6o7euVw0QlysIPV@kroah.com>
 <X6pdSx84CWvag02r@trantor>
 <X6pfISu1PE5lelNL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6pfISu1PE5lelNL@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 10:36:33AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 10, 2020 at 09:28:43AM +0000, Catalin Marinas wrote:
> > On Tue, Nov 10, 2020 at 08:04:26AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Nov 09, 2020 at 09:30:21PM +0000, Will Deacon wrote:
> > > > Since 32-bit applications will be killed if they are caught trying to
> > > > execute on a 64-bit-only CPU in a mismatched system, advertise the set
> > > > of 32-bit capable CPUs to userspace in sysfs.
> > > > 
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > ---
> > > >  .../ABI/testing/sysfs-devices-system-cpu      |  9 +++++++++
> > > >  arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
> > > >  2 files changed, 28 insertions(+)
> > > 
> > > I still think the "kill processes that can not run on this CPU" is crazy
> > 
> > I agree it's crazy, though we try to keep the kernel support simple
> > while making it a user-space problem. The alternative is to
> > force-migrate such process to a more capable CPU, potentially against
> > the desired user cpumask. In addition, we'd have to block CPU hot-unplug
> > in case the last 32-bit capable CPU disappears.
> 
> You should block CPU hot-unplug for the last 32bit capable CPU, why
> would you not want that if there are any active 32bit processes running?

That's been done in one of the versions submitted to the Android kernel
(which also handles automatic task placement, though by overriding the
user cpumask):

https://android-review.googlesource.com/c/kernel/common/+/1437100/7

I think preventing CPU offlining makes sense only together with forcing
32-bit task placement from the kernel. If we decide to go for the
SIGKILL approach with user-driven affinity, careful CPU offlining should
also be handled by user-space.

-- 
Catalin
