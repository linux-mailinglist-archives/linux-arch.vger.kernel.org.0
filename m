Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832427A9E2
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2019 15:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfG3Nl3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jul 2019 09:41:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44507 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfG3Nl3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 09:41:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so30086316pgl.11;
        Tue, 30 Jul 2019 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSgq/fD+P+rJo3Ns20w7XwQgKGCjUSyYL1C9ZWUZ8k4=;
        b=aV19mrfTmufBP+IaE4zpZ0PfrlGyZWT7SSlh7eVd04uUXyfekYS9CEjJqFaC7HFfjC
         vgG3zgnX44j/OUU7FhV5QUKxCoGJcC/8sg3aZm2zWImX2GzQkiS0EF5uTlUjto/zD30C
         18mm3ALVMt/UKK3lVBX0LKp37LAmPtP3irtGTYqiiFNs9SwuSN+9r9q/3pT8MkQq1m7L
         S+cawaleE7BlxPkqQgeyTvnFDQhHIRY5RWwd2L7EL4+usa21oVPF8wU5E8Il8xrbgv2q
         h6zgC09VatuHKKgWi5TaqB4L404Px7CeQmRYp+E+FobtKSLqoE4KMLtSewikwyGm/b6+
         Ahhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSgq/fD+P+rJo3Ns20w7XwQgKGCjUSyYL1C9ZWUZ8k4=;
        b=m5KyiKoJ8ocTc2ByqSBPS2OIdJ2QdfEaflBmbOMlmeS08AWmOPAsVADsouWVymD1eo
         muUKNr9jRrpz45TZQRB88AqAczrzH9f1cpaoq2+LANzA60ddAOaH/MDpUVALbyB8xJX9
         9MaZ5VnTHVvZNEgPa8ANSwD2/m5Zg4H6IVXoYxYPQAcEOylSLPiG+GFB/Mv1IOJm+1oG
         WZri3ncE2voIaemzmdFRZm130m1ox3P90qlY20+Wz9N2GhbhFmOwB3x+VjsQOFEh9OKT
         cy9FsA6RzSe7+NFTzrjtaEhL5SoYo32fZpg5g6Hr6IF8eVMm+FhvLy92w6C4JjHBkjcF
         sffQ==
X-Gm-Message-State: APjAAAVOf4VCXMkwV1t7/AfxeWM2fzjHn6oOyg2O2E38pOfFuaEWgm21
        Ic7cZYMsGo7Tbwz+vDW7xH2W6BeDLajTYXtmFW8=
X-Google-Smtp-Source: APXvYqzZb/ELUa9g80/oG8nq13RLGHppU8JM7lvJ6Xfw3oCoo929U1DYHRMzJryNtYgiQuuhyTVWoG+rEQKu5TlxwKQ=
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr113194849pjh.40.1564494088815;
 Tue, 30 Jul 2019 06:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <87zhkxksxd.fsf@vitty.brq.redhat.com> <20190729110927.GC31398@hirez.programming.kicks-ass.net>
 <87wog1kpib.fsf@vitty.brq.redhat.com>
In-Reply-To: <87wog1kpib.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Tue, 30 Jul 2019 21:41:18 +0800
Message-ID: <CAOLK0py6ngy9kAnZcRMBK8U45s2L5Wo4X0NP_qPM0zv7WjeVQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, michael.h.kelley@microsoft.com,
        ashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vitaly & Peter:
    Thanks for your review.

On Mon, Jul 29, 2019 at 8:13 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Peter Zijlstra <peterz@infradead.org> writes:
>
> > On Mon, Jul 29, 2019 at 12:59:26PM +0200, Vitaly Kuznetsov wrote:
> >> lantianyu1986@gmail.com writes:
> >>
> >> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >> >
> >> > Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
> >> > on x86.  But native_sched_clock() directly uses the raw TSC value, which
> >> > can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
> >> > to set the sched clock function appropriately.  On x86, this sets
> >> > pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
> >> > scaled and adjusted to be continuous.
> >>
> >> Hypervisor can, in theory, disable TSC page and then we're forced to use
> >> MSR-based clocksource but using it as sched_clock() can be very slow,
> >> I'm afraid.
> >>
> >> On the other hand, what we have now is probably worse: TSC can,
> >> actually, jump backwards (e.g. on migration) and we're breaking the
> >> requirements for sched_clock().
> >
> > That (obviously) also breaks the requirements for using TSC as
> > clocksource.
> >
> > IOW, it breaks the entire purpose of having TSC in the first place.
>
> Currently, we mark raw TSC as unstable when running on Hyper-V (see
> 88c9281a9fba6), 'TSC page' (which is TSC * scale + offset) is being used
> instead. The problem is that 'TSC page' can be disabled by the
> hypervisor and in that case the only remaining clocksource is MSR-based
> (slow).
>

Yes, that will be slow if Hyper-V doesn't expose hv tsc page and
kernel uses MSR based
clocksource. Each MSR read will trigger one VM-EXIT. This also happens on other
hypervisors (e,g, KVM doesn't expose KVM clock). Hypervisor should
take this into
account and determine which clocksource should be exposed or not.

-- 
Best regards
Tianyu Lan
