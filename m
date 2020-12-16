Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC8E2DC62B
	for <lists+linux-arch@lfdr.de>; Wed, 16 Dec 2020 19:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgLPSWM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Dec 2020 13:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgLPSWM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Dec 2020 13:22:12 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178DC06179C
        for <linux-arch@vger.kernel.org>; Wed, 16 Dec 2020 10:21:31 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i9so24133880wrc.4
        for <linux-arch@vger.kernel.org>; Wed, 16 Dec 2020 10:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XVp1+1L8yfFD+Z9hI15tYMAq5imsksGhA8xqZCoyVo=;
        b=rF+mVlYbp6k/Zgfx+czzVyTTFQqGWbvyHC9QuUYoM3k6a2L+gAnkj7VpIRylQTg/XY
         WgFNgkJ1mPYUd+pNGmwWvveKwM/K6zIKPrmhLbVe9qPDSogxY0LWKWJ/L7qskmRCfKna
         37AvcIpfwS7a4XHJEnujDgJq2NUHvf6pemhbo8ErjUutldlMJbSHM8AFGPD/ykkqTMRi
         6tV7MYd2TxGsOvTLIGMSczohkXUffWNDxUvatPz5Bmo+oHrjv4sLd12dvYAPo92HraP5
         GVRpqTv+/jDtCfC7sQBs+LJ6Q6sile1LU+aipR2DPcgTAU0vRkctA6DQVTQRfd/IKJzK
         AIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XVp1+1L8yfFD+Z9hI15tYMAq5imsksGhA8xqZCoyVo=;
        b=GqhVadbEovjL8XaEkxk5vmZO/tsEKv3Z3byLKAFNeNpFE38RPRwRp0bkjrlE7uPFve
         9y7SydrweYWqOQeg6uuU3v4GcZtV7zlOnMZHrFxrtnM5Q7FEyvRlclTwgBl6GHliAANG
         qlKUI4XvOjv2+rn00iQtaCV66kzYqqYpiBJ7BTXN6QQM/Z9/WjVMfUbogGmoDwWF1qA8
         SWCHKpG9yiJW5VnqxJ/t99+2dUe1gIBF3Rek8bINW6wpKk3b2z5/TUpoPvfl8BC50X8i
         jZaR3qz+6EOm/42sixkz7FC0vlUZKE8lAqU7/j7t/1g1Yhx2wxAzuIGs3eeaeVFcLwXe
         N5KQ==
X-Gm-Message-State: AOAM532CFv637jNsXNQZQcpXKJVcKoaYIaXYpOQmhgkXeaqFpUkIMeRg
        tgSl/bhmYzXWuV/f2i7ElvXBfvWUwG3wzQy08uTjkA==
X-Google-Smtp-Source: ABdhPJxQqlhnS8VRUS0S1dzwDSY46eD57TT6CmoISR6Wqk/zwqYZ8sob3y3+CAb8TTpOFcKedX9HaL3mJ6n9AK3PAnk=
X-Received: by 2002:a5d:4704:: with SMTP id y4mr33314624wrq.358.1608142889933;
 Wed, 16 Dec 2020 10:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20201208132835.6151-1-will@kernel.org> <20201216111646.omrxyhbobejzqprh@e107158-lin.cambridge.arm.com>
 <20201216141450.GA16421@willie-the-truck> <20201216164845.qakwbuhety73lmvr@e107158-lin.cambridge.arm.com>
In-Reply-To: <20201216164845.qakwbuhety73lmvr@e107158-lin.cambridge.arm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 16 Dec 2020 10:21:18 -0800
Message-ID: <CAJuCfpGFCgN+q42-HeMNkdhMC9+3h2M0rzqAV-W8UwtRYX-6Vg@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] An alternative series for asymmetric AArch32 systems
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 16, 2020 at 8:48 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 12/16/20 14:14, Will Deacon wrote:
> > Hi Qais,
> >
> > On Wed, Dec 16, 2020 at 11:16:46AM +0000, Qais Yousef wrote:
> > > On 12/08/20 13:28, Will Deacon wrote:
> > > > Changes in v5 include:
> > > >
> > > >   * Teach cpuset_cpus_allowed() about task_cpu_possible_mask() so that
> > > >     we can avoid returning incompatible CPUs for a given task. This
> > > >     means that sched_setaffinity() can be used with larger masks (like
> > > >     the online mask) from userspace and also allows us to take into
> > > >     account the cpuset hierarchy when forcefully overriding the affinity
> > > >     for a task on execve().
> > > >
> > > >   * Honour task_cpu_possible_mask() when attaching a task to a cpuset,
> > > >     so that the resulting affinity mask does not contain any incompatible
> > > >     CPUs (since it would be rejected by set_cpus_allowed_ptr() otherwise).
> > > >
> > > >   * Moved overriding of the affinity mask into the scheduler core rather
> > > >     than munge affinity masks directly in the architecture backend.
> > > >
> > > >   * Extended comments and documentation.
> > > >
> > > >   * Some renaming and cosmetic changes.
> > > >
> > > > I'm pretty happy with this now, although it still needs review and will
> > > > require rebasing to play nicely with the SCA changes in -next.
> > >
> > > I still have concerns about the cpuset v1 handling. Specifically:
> > >
> > >     1. Attaching a 32bit task to 64bit only cpuset is allowed.
> > >
> > >        I think the right behavior here is to prevent that as the
> > >        intersection will appear as offline cpus for the 32bit tasks. So it
> > >        shouldn't be allowed to move there.
> >
> > Suren or Quantin can correct me if I'm wrong I'm here, but I think Android
> > relies on this working so it's not an option for us to prevent the attach.
>
> I don't think so. It's just a matter who handles the error. ie: kernel fix it
> up silently and effectively make the cpuset a NOP since we don't respect the
> affinity of the cpuset, or user space pick the next best thing. Since this
> could return an error anyway, likely user space already handles this.

Moving a 32bit task around the hierarchy when it lost the last 32bit
capable CPU in its affinity mask would not work for Android. We move
the tasks in the hierarchy only when they change their role
(background/foreground/etc) and does not expect the tasks to migrate
by themselves. I think the current approach of adjusting affinity
without migration while not ideal is much better. Consistency with
cgroup v2 is a big plus as well.
We do plan on moving cpuset controller to cgroup v2 but the transition
is slow, so my guess is that we will stick to it for another Android
release.

> > I also don't think it really achieves much, since as you point out, the same
> > problem exists in other cases such as execve() of a 32-bit binary, or
> > hotplugging off all 32-bit CPUs within a mixed cpuset. Allowing the attach
> > and immediately reparenting would probably be better, but see below.
>
> I am just wary that we're introducing a generic asymmetric ISA support, so my
> concerns have been related to making sure the behavior is sane generally. When
> this gets merged, I can bet more 'fun' hardware will appear all over the place.
> We're opening the flood gates I'm afraid :p
>
> > >     2. Modifying cpuset.cpus could result with empty set for 32bit tasks.
> > >
> > >        It is a variation of the above, it's just the cpuset transforms into
> > >        64bit only after we attach.
> > >
> > >        I think the right behavior here is to move the 32bit tasks to the
> > >        nearest ancestor like we do when all cpuset.cpus are hotplugged out.
> > >
> > >        We could too return an error if the new set will result an empty set
> > >        for the 32bit tasks. In a similar manner to how it fails if you
> > >        write a cpu that is offline.
> > >
> > >     3. If a 64bit task belongs to 64bit-only-cpuset execs a 32bit binary,
> > >        the 32 tasks will inherit the cgroup setting.
> > >
> > >        Like above, we should move this to the nearest ancestor.
> >
> > I considered this when I was writing the patches, but the reality is that
> > by allowing 32-bit tasks to attach to a 64-bit only cpuset (which is required
> > by Android), we have no choice but to expose a new ABI to userspace. This is
> > all gated behind a command-line option, so I think that's fine, but then why
> > not just have the same behaviour as cgroup v2? I don't see the point in
> > creating two new ABIs (for cgroup v1 and v2 respectively) if we don't need
>
> Ultimately it's up to Tejun and Peter I guess. I thought we need to preserve
> the v1 behavior for the new class of tasks. I won't object to the new ABI
> myself. Maybe we just need to make the commit messages and cgroup-v1
> documentation reflect that explicitly.
>
> > to. If it was _identical_ to the hotplug case, then we would surely just
> > follow the existing behaviour, but it's really quite different in this
> > situation because the cpuset is not empty.
>
> It is actually effectively empty for those tasks. But I see that one could look
> at it from two different angles.
>
> > One thing we should definitely do though is add this to the documentation
> > for the command-line option.
>
> +1
>
> By the way, should the command-line option be renamed to something more
> generic? This has already grown beyond just enabling the support for one
> isolated case. No strong opinion, just a suggestion.
>
> Thanks
>
> --
> Qais Yousef
