Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9997329
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 09:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfHUHP2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 03:15:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfHUHP2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 03:15:28 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D0DB6412B
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2019 07:15:27 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id d64so793678wmc.7
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2019 00:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HFnfif7OukcKvdx4VkLNRrmZNGEoDZzmzWqgb909eYs=;
        b=lmuQ2crkKXQ2m5Ju1cRxOI6/5ZSq0GodjsHvBspuy95wPzwfXNRBgBUF+809wJVlVL
         R9dZggU+tWNj/Dw59OJg1SZUeTk5uX6qk1mNY4grqpbq8+1t6Ri1Be42v+QSMj5LipLR
         XkZjyzR77YKa4Bxy38udNKVve+OWUaUvOFbPtP4PijvHqIKrTBJpU+Iys8iCbWRdRtc7
         MAW7vAixQ14cdpiK1q1PriogYAt/OyIAuNe0dZeIKSEoF+nBAqo/EMT06VUQdqrUWXQD
         qIp8rBwXo1Dwf2LcjPOnhqUYXH1IyWjGjSLsQtFCzA93MZqVfIFmQwJ/9Y/oyJl5Evx9
         M0Jw==
X-Gm-Message-State: APjAAAU+kyZ0ulQmzEIkvZgdUwtM4ASF7ggRtBaUdBP+F7S4lXBObN+z
        L2BWTjutp9DtBBhsnG2cMBjXxMV6875eeV69lbROPAe0PoOf55uzF0vNT2a/J6OJc6L328WlNhR
        qNUR3S6no+U6rQOceInWnlw==
X-Received: by 2002:a1c:ca11:: with SMTP id a17mr4295688wmg.45.1566371725989;
        Wed, 21 Aug 2019 00:15:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyvehOUicp74Hfpp4tQ3w5j1/CXQEEjkRsScH+FXEPTgjBgUnMz3qRVov0any+uTrIahokbQ==
X-Received: by 2002:a1c:ca11:: with SMTP id a17mr4295632wmg.45.1566371725677;
        Wed, 21 Aug 2019 00:15:25 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-161-20.net.upcbroadband.cz. [89.176.161.20])
        by smtp.gmail.com with ESMTPSA id v124sm3534648wmf.23.2019.08.21.00.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 00:15:25 -0700 (PDT)
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
In-Reply-To: <DM5PR21MB013730EB79A17AF02C170BD7D7AB0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com> <87zhkxksxd.fsf@vitty.brq.redhat.com> <20190729110927.GC31398@hirez.programming.kicks-ass.net> <87wog1kpib.fsf@vitty.brq.redhat.com> <CAOLK0py6ngy9kAnZcRMBK8U45s2L5Wo4X0NP_qPM0zv7WjeVQQ@mail.gmail.com> <DM5PR21MB0137E03AAD8C2EA61EC81ED7D7D30@DM5PR21MB0137.namprd21.prod.outlook.com> <87sgq5a2hq.fsf@vitty.brq.redhat.com> <DM5PR21MB013730EB79A17AF02C170BD7D7AB0@DM5PR21MB0137.namprd21.prod.outlook.com>
Date:   Wed, 21 Aug 2019 09:15:23 +0200
Message-ID: <87o90jq99w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, August 13, 2019 1:34 AM
>> 
>> Michael Kelley <mikelley@microsoft.com> writes:
>> 
>> > From: Tianyu Lan <lantianyu1986@gmail.com> Sent: Tuesday, July 30, 2019 6:41 AM
>> >>
>> >> On Mon, Jul 29, 2019 at 8:13 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> >> >
>> >> > Peter Zijlstra <peterz@infradead.org> writes:
>> >> >
>> >> > > On Mon, Jul 29, 2019 at 12:59:26PM +0200, Vitaly Kuznetsov wrote:
>> >> > >> lantianyu1986@gmail.com writes:
>> >> > >>
>> >> > >> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> >> > >> >
>> >> > >> > Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
>> >> > >> > on x86.  But native_sched_clock() directly uses the raw TSC value, which
>> >> > >> > can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
>> >> > >> > to set the sched clock function appropriately.  On x86, this sets
>> >> > >> > pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
>> >> > >> > scaled and adjusted to be continuous.
>> >> > >>
>> >> > >> Hypervisor can, in theory, disable TSC page and then we're forced to use
>> >> > >> MSR-based clocksource but using it as sched_clock() can be very slow,
>> >> > >> I'm afraid.
>> >> > >>
>> >> > >> On the other hand, what we have now is probably worse: TSC can,
>> >> > >> actually, jump backwards (e.g. on migration) and we're breaking the
>> >> > >> requirements for sched_clock().
>> >> > >
>> >> > > That (obviously) also breaks the requirements for using TSC as
>> >> > > clocksource.
>> >> > >
>> >> > > IOW, it breaks the entire purpose of having TSC in the first place.
>> >> >
>> >> > Currently, we mark raw TSC as unstable when running on Hyper-V (see
>> >> > 88c9281a9fba6), 'TSC page' (which is TSC * scale + offset) is being used
>> >> > instead. The problem is that 'TSC page' can be disabled by the
>> >> > hypervisor and in that case the only remaining clocksource is MSR-based
>> >> > (slow).
>> >> >
>> >>
>> >> Yes, that will be slow if Hyper-V doesn't expose hv tsc page and
>> >> kernel uses MSR based
>> >> clocksource. Each MSR read will trigger one VM-EXIT. This also happens on other
>> >> hypervisors (e,g, KVM doesn't expose KVM clock). Hypervisor should
>> >> take this into
>> >> account and determine which clocksource should be exposed or not.
>> >>
>> >
>> > We've confirmed with the Hyper-V team that the TSC page is always available
>> > on Hyper-V 2016 and later, and on Hyper-V 2012 R2 when the physical
>> > hardware presents an InvariantTSC.
>> 
>> Currently we check that TSC page is valid on every read and it seems
>> this is redundant, right? It is either available on boot or not. I can
>> only imagine migrating a VM to a non-InvariantTSC host when Hyper-V will
>> likely disable the page (and we can get reenlightenment notification
>> then).
>
> I think Hyper-V can have brief intervals when the TSC page is not valid, so
> the code checks for the "sequence" value being zero.   Otherwise, yes, it
> should always be there or not be there.  Is there some other validity
> check on every read that you are thinking of?
>

No, it's this one. In case these 'invalidity periods' are real there's
nothing to improve in the current code.

>> 
>> >  But the Linux Kconfig's are set up so
>> > the TSC page is not used for 32-bit guests -- all clock reads are synthetic MSR
>> > reads.  For 32-bit, this set of changes will add more overhead because the
>> > sched clock reads will now be MSR reads.
>> >
>> > I would be inclined to fix the problem, even with the perf hit on 32-bit Linux.
>> > I don’t have any data on 32-bit Linux being used in a Hyper-V guest, but it's not
>> > supported in Azure so usage is pretty small.  The alternative would be to continue
>> > to use the raw TSC value on 32-bit, even with the risk of a discontinuity in case of
>> > live migration or similar scenarios.
>> 
>> The issue needs fixing, I agree, however using MSR based clocksource as
>> sched clock may give us too big of a performance hit (not sure who cares
>> about 32 bit guest performance nowadays but still). What stops us from
>> enabling TSC page for 32 bit guests if it is available?
>
> I talked to KY Srinivasan for any history about TSC page on 32-bit.  He said
> there was no technical reason not to implement it, but our focus was always
> 64-bit Linux, so the 32-bit was much less important.  Also, on 32-bit Linux,
> the required 64x64 multiply and shift is more complex and takes more
> more cycles (compare 32-bit implementation of mul_u64_u64_shr vs.
> the 64-bit implementation), so the win over a MSR read is less.  I
> don't know of any actual measurements being made to compare vs.
> MSR read.

VMExit is 1000 CPU cycles or so, I would guess that TSC page
calculations are better. Let me try to build 32bit kernel and do some
quick measurements.

-- 
Vitaly
