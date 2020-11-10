Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3952AD276
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 10:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgKJJ2s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 04:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgKJJ2s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 04:28:48 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A184320781;
        Tue, 10 Nov 2020 09:28:45 +0000 (UTC)
Date:   Tue, 10 Nov 2020 09:28:43 +0000
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
Message-ID: <X6pdSx84CWvag02r@trantor>
References: <20201109213023.15092-1-will@kernel.org>
 <20201109213023.15092-6-will@kernel.org>
 <X6o7euVw0QlysIPV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6o7euVw0QlysIPV@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 08:04:26AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 09, 2020 at 09:30:21PM +0000, Will Deacon wrote:
> > Since 32-bit applications will be killed if they are caught trying to
> > execute on a 64-bit-only CPU in a mismatched system, advertise the set
> > of 32-bit capable CPUs to userspace in sysfs.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  .../ABI/testing/sysfs-devices-system-cpu      |  9 +++++++++
> >  arch/arm64/kernel/cpufeature.c                | 19 +++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> 
> I still think the "kill processes that can not run on this CPU" is crazy

I agree it's crazy, though we try to keep the kernel support simple
while making it a user-space problem. The alternative is to
force-migrate such process to a more capable CPU, potentially against
the desired user cpumask. In addition, we'd have to block CPU hot-unplug
in case the last 32-bit capable CPU disappears.

The only sane thing is not to allow 32-bit processes at all on such
hardware but I think we lost that battle ;).

-- 
Catalin
