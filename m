Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168F829F7A7
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 23:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJ2WRy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Oct 2020 18:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJ2WRy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Oct 2020 18:17:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 294F7206D5;
        Thu, 29 Oct 2020 22:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604009873;
        bh=Pij6QMvKVYRjcTFJa5YdnZpKOXzgnjsSh93wKob9L7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKeDxtJOi2600iX2U96eXwIe6mWxYoI6d2PhzR5pXLlSfvubfRT/RppOHAu27IIeX
         btnfcih952yxlEzoAIAKPyqsAkEuC6NyHO2/o9C+K8RVNmAATR+ni8bbc35mLhj2P+
         Vl1v3shD4A9ywgoOIO0wMgakbICjZUVTMxQOxBKI=
Date:   Thu, 29 Oct 2020 22:17:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        kernel-team <kernel-team@android.com>,
        Elliott Hughes <enh@google.com>
Subject: Re: [PATCH 0/6] An alternative series for asymmetric AArch32 systems
Message-ID: <20201029221747.GC31375@willie-the-truck>
References: <20201027215118.27003-1-will@kernel.org>
 <CAJuCfpH2vZfH0mZMxukKvcs1jW7Udiu4P-5z4ZyDU1-JN3xMdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH2vZfH0mZMxukKvcs1jW7Udiu4P-5z4ZyDU1-JN3xMdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Suren,

On Thu, Oct 29, 2020 at 11:42:04AM -0700, Suren Baghdasaryan wrote:
> On Tue, Oct 27, 2020 at 2:51 PM Will Deacon <will@kernel.org> wrote:
> > I was playing around with the asymmetric AArch32 RFCv2 from Qais:
> >
> > https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com
> >
> > and ended up writing my own implementation this afternoon. I think it's
> > smaller, simpler and easier to work with. In particular:
> >
> >   * I got rid of the sysctl in favour of a plain cmdline parameter
> >   * I don't have a new CPU capability
> >   * I don't have a new thread flag
> >   * I expose a cpumask to userspace via sysfs to identify the 32-bit CPUs
> >
> > Anyway, I don't think we should merge this stuff (other than the first patch)
> > until we've figured out what's going on in Android, but I wanted to get
> > this out as something which we might be able to build on.
> 
> Thanks for posting this series. Just to provide some more background,
> on Android, 64-bit apps are forked from zygote64 process and 32-bit
> ones from zygote. So normally we could handle the issues with such
> asymmetric architectures using cpuset cgroup and placing zygote
> process (and consequently all its children) in a separate cgroup with
> affinity mask that includes only 32-bit capable cores. We would have
> to take care of the affinity mask for such tasks during task
> migrations, but it's still doable from userspace. However there are
> 64-bit apps which fork 32-bit processes and that is the case which is
> unclear how to handle without help from the kernel. Still discussing
> possible solutions. CC'ing more people from Android to be in the loop.

Thanks for joining in and adding others. Perhaps one thing we could do
on top of this series is to restrict the affinity mask when execve()ing
a 32-bit application. The major problem I have with that is that it
goes directly against the man page for sched_setaffinity(), which states:

  | A child created via fork(2) inherits its parent's CPU affinity mask.
  | The affinity mask is preserved across an execve(2)

so there's a risk of regression if applications rely on the mask being
preserved.

Will
