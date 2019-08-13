Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789CE8B28F
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 10:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfHMIdq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 04:33:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54850 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfHMIdo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 04:33:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so679817wme.4
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 01:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=i0/UjSTsRJKJbyjXWi8yfVIZ9WUaTfbBMXtRMChek+4=;
        b=AyILH2KDdVHxO0Hb8XIyZ0M+dHkYJf5Pf+U/rvAVEKhUcmOGQNGKAtojaX+4KY1Gw8
         WbtmdfnvFh4hjKbeTl7GwWXq1fSC0SnBB3ZNk0M5Bg80psUtZ2H8kk4+eiLar1ch4n9q
         Z3hQ2DzTwj+pgSq5kGkPVod0uHxlnGKxy/rTrdXsfYpYuM9O6URRte9H6PvVUAlztdQB
         J4dFHD/a7VZ7NOz3srpfw0ymf3poJNdvh5DrtXb/XC/q4GnW2CdYzgE2kpohMfue1RBg
         b35KQGGC44/FrqklWYAB6Iv4EWprz8efIidSnL4j4Cv+8Zu/XwGp/woEfC0m1uoAuJPF
         zSOQ==
X-Gm-Message-State: APjAAAU9z4bJhqULOKaKaZe/xKXMyPVm9EgiJ/LSR3vxD0qtXI6Bd7A7
        Sp2eVI3H6AoaKG3dKd+VWz/4Mw==
X-Google-Smtp-Source: APXvYqyUfqZfLtR2Esa+Td8DFXYYAp7MU1a2o74SoqdyLzHA14yv0VpukFvmQdgqpzYxsXYqDLPgnA==
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr1658378wmk.148.1565685221880;
        Tue, 13 Aug 2019 01:33:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 4sm1438988wmd.26.2019.08.13.01.33.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 01:33:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <lantianyu1986@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger kernel org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "ashal\@kernel.org" <ashal@kernel.org>
Subject: RE: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
In-Reply-To: <DM5PR21MB0137E03AAD8C2EA61EC81ED7D7D30@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com> <87zhkxksxd.fsf@vitty.brq.redhat.com> <20190729110927.GC31398@hirez.programming.kicks-ass.net> <87wog1kpib.fsf@vitty.brq.redhat.com> <CAOLK0py6ngy9kAnZcRMBK8U45s2L5Wo4X0NP_qPM0zv7WjeVQQ@mail.gmail.com> <DM5PR21MB0137E03AAD8C2EA61EC81ED7D7D30@DM5PR21MB0137.namprd21.prod.outlook.com>
Date:   Tue, 13 Aug 2019 10:33:37 +0200
Message-ID: <87sgq5a2hq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Tianyu Lan <lantianyu1986@gmail.com> Sent: Tuesday, July 30, 2019 6:41 AM
>> 
>> On Mon, Jul 29, 2019 at 8:13 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >
>> > Peter Zijlstra <peterz@infradead.org> writes:
>> >
>> > > On Mon, Jul 29, 2019 at 12:59:26PM +0200, Vitaly Kuznetsov wrote:
>> > >> lantianyu1986@gmail.com writes:
>> > >>
>> > >> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> > >> >
>> > >> > Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
>> > >> > on x86.  But native_sched_clock() directly uses the raw TSC value, which
>> > >> > can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
>> > >> > to set the sched clock function appropriately.  On x86, this sets
>> > >> > pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
>> > >> > scaled and adjusted to be continuous.
>> > >>
>> > >> Hypervisor can, in theory, disable TSC page and then we're forced to use
>> > >> MSR-based clocksource but using it as sched_clock() can be very slow,
>> > >> I'm afraid.
>> > >>
>> > >> On the other hand, what we have now is probably worse: TSC can,
>> > >> actually, jump backwards (e.g. on migration) and we're breaking the
>> > >> requirements for sched_clock().
>> > >
>> > > That (obviously) also breaks the requirements for using TSC as
>> > > clocksource.
>> > >
>> > > IOW, it breaks the entire purpose of having TSC in the first place.
>> >
>> > Currently, we mark raw TSC as unstable when running on Hyper-V (see
>> > 88c9281a9fba6), 'TSC page' (which is TSC * scale + offset) is being used
>> > instead. The problem is that 'TSC page' can be disabled by the
>> > hypervisor and in that case the only remaining clocksource is MSR-based
>> > (slow).
>> >
>> 
>> Yes, that will be slow if Hyper-V doesn't expose hv tsc page and
>> kernel uses MSR based
>> clocksource. Each MSR read will trigger one VM-EXIT. This also happens on other
>> hypervisors (e,g, KVM doesn't expose KVM clock). Hypervisor should
>> take this into
>> account and determine which clocksource should be exposed or not.
>> 
>
> We've confirmed with the Hyper-V team that the TSC page is always available
> on Hyper-V 2016 and later, and on Hyper-V 2012 R2 when the physical
> hardware presents an InvariantTSC.

Currently we check that TSC page is valid on every read and it seems
this is redundant, right? It is either available on boot or not. I can
only imagine migrating a VM to a non-InvariantTSC host when Hyper-V will
likely disable the page (and we can get reenlightenment notification
then).

>  But the Linux Kconfig's are set up so
> the TSC page is not used for 32-bit guests -- all clock reads are synthetic MSR
> reads.  For 32-bit, this set of changes will add more overhead because the
> sched clock reads will now be MSR reads.
>
> I would be inclined to fix the problem, even with the perf hit on 32-bit Linux.
> I don’t have any data on 32-bit Linux being used in a Hyper-V guest, but it's not
> supported in Azure so usage is pretty small.  The alternative would be to continue
> to use the raw TSC value on 32-bit, even with the risk of a discontinuity in case of
> live migration or similar scenarios.

The issue needs fixing, I agree, however using MSR based clocksource as
sched clock may give us too big of a performance hit (not sure who cares
about 32 bit guest performance nowadays but still). What stops us from
enabling TSC page for 32 bit guests if it is available?

-- 
Vitaly
