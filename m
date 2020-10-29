Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1320229F438
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 19:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgJ2SmR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Oct 2020 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJ2SmQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Oct 2020 14:42:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAC2C0613CF
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2020 11:42:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y12so3896508wrp.6
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2020 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IjhLdSLe/LavGMCZ4vHD0wPPfdIdrDX2u7wxDkmaBI=;
        b=nC3kL7EXNjlCxZ5fyCQwz66wSubz4eFY44c4dKVNHCp71+0Pc7+DFoDQerD9MwjKPL
         Ig+ukPtPkNfnFGLbXrWk3TWSKssrXx61GFjZ/eJ0qiE94d3K6g5mrr+xB14Fkjum4Rts
         TVAfYze0T+UjD4eEjgo+kWueaXifSyKDy7UAyhak0vh9f7Id/RfP/kW2tvNTYSoIzEBx
         Tc47gtZNSrpfwkCbm0W0ea4TKpzfwnpRF315nynCzqkxvdeiShB6ZDeaEDhyUGYNhCg2
         TJRnPGZC5UGuDWtpECohcovDy0TyB24Bs6TM9son9EGBaPItJq4to4JXRag+N3nUhNGz
         pzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IjhLdSLe/LavGMCZ4vHD0wPPfdIdrDX2u7wxDkmaBI=;
        b=feBFInnY0/ruRTDwhv+t0FvMQ6ES0LsJMpmbFaEY8AWapLjQWKvQIWBPNeiLIRuMWV
         Ad/Irw+51u3nBCjpLNHt0BAiG17d/uD4YH7K2K7xUG3iFCzPFnq/6ScoQaa5ZZohz11a
         NxGc4vaAEU+IK8Y9yLPoxsThAnRVJf1M2El/riAvwBpnPhItSvwgrgUOMcG4rhzVQXdH
         JUQiSJPUgPROMj6RJFaKZC2GY81tTG5vcLwpdqi2UI3Mmsu5waslAMVy6g87r+L0JMNK
         2tVP2Y1z/ymW4fwm9wuMMEwiRt0JYBajlm/e7Gk17NLJzMHVUwfrUk9N5gB9qUjldD/P
         c/yQ==
X-Gm-Message-State: AOAM5318F+zEIHEmz40EqMWRAgbuCOlxS7JZKIWoRKv96hq5a5ZMc6nP
        09LFTWTSgG1E3uKxG4/nbwk7PpVgNMTFZtj4oCM/Rw==
X-Google-Smtp-Source: ABdhPJzF46qLisRXwWE0HiqUMd5M4SLfi4O4R4LrZJIsIDeAQ7gb00nNta8hxu2hVOftmTNRqQLh5mjlDAaeAXhhxTM=
X-Received: by 2002:a5d:498a:: with SMTP id r10mr7531866wrq.106.1603996935096;
 Thu, 29 Oct 2020 11:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201027215118.27003-1-will@kernel.org>
In-Reply-To: <20201027215118.27003-1-will@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 29 Oct 2020 11:42:04 -0700
Message-ID: <CAJuCfpH2vZfH0mZMxukKvcs1jW7Udiu4P-5z4ZyDU1-JN3xMdg@mail.gmail.com>
Subject: Re: [PATCH 0/6] An alternative series for asymmetric AArch32 systems
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        kernel-team <kernel-team@android.com>,
        Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 2:51 PM Will Deacon <will@kernel.org> wrote:
>
> Hi all,
>
> I was playing around with the asymmetric AArch32 RFCv2 from Qais:
>
> https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com
>
> and ended up writing my own implementation this afternoon. I think it's
> smaller, simpler and easier to work with. In particular:
>
>   * I got rid of the sysctl in favour of a plain cmdline parameter
>   * I don't have a new CPU capability
>   * I don't have a new thread flag
>   * I expose a cpumask to userspace via sysfs to identify the 32-bit CPUs
>
> Anyway, I don't think we should merge this stuff (other than the first patch)
> until we've figured out what's going on in Android, but I wanted to get
> this out as something which we might be able to build on.

Hi Will,
Thanks for posting this series. Just to provide some more background,
on Android, 64-bit apps are forked from zygote64 process and 32-bit
ones from zygote. So normally we could handle the issues with such
asymmetric architectures using cpuset cgroup and placing zygote
process (and consequently all its children) in a separate cgroup with
affinity mask that includes only 32-bit capable cores. We would have
to take care of the affinity mask for such tasks during task
migrations, but it's still doable from userspace. However there are
64-bit apps which fork 32-bit processes and that is the case which is
unclear how to handle without help from the kernel. Still discussing
possible solutions. CC'ing more people from Android to be in the loop.
Thanks,
Suren.



>
> Cheers,
>
> Will
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: Qais Yousef <qais.yousef@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: kernel-team@android.com
>
> --->8
>
> Qais Yousef (1):
>   KVM: arm64: Handle Asymmetric AArch32 systems
>
> Will Deacon (5):
>   arm64: Allow mismatched 32-bit EL0 support
>   KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
>   arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
>   arm64: Advertise CPUs capable of running 32-bit applcations in sysfs
>   arm64: Hook up cmdline parameter to allow mismatched 32-bit EL0
>
>  .../ABI/testing/sysfs-devices-system-cpu      |  8 ++
>  .../admin-guide/kernel-parameters.txt         |  7 ++
>  arch/arm64/include/asm/cpufeature.h           |  3 +
>  arch/arm64/kernel/cpufeature.c                | 80 ++++++++++++++++++-
>  arch/arm64/kernel/process.c                   | 21 ++++-
>  arch/arm64/kernel/signal.c                    | 26 ++++++
>  arch/arm64/kvm/arm.c                          | 27 +++++++
>  7 files changed, 168 insertions(+), 4 deletions(-)
>
> --
> 2.29.0.rc2.309.g374f81d7ae-goog
>
