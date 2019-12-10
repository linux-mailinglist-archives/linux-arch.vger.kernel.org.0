Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3664011926A
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 21:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfLJUtL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 10 Dec 2019 15:49:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41808 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfLJUtL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Dec 2019 15:49:11 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iemRD-0001LA-IR; Tue, 10 Dec 2019 21:48:55 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8BB1A101DEC; Tue, 10 Dec 2019 21:48:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        fschnitzlein@suse.de, Felix Schnizlein <fschnizlein@suse.com>,
        Thomas Renninger <trenn@suse.com>
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
In-Reply-To: <20191206163656.GC86904@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de> <20191206162421.15050-3-trenn@suse.de> <20191206163656.GC86904@kroah.com>
Date:   Tue, 10 Dec 2019 21:48:54 +0100
Message-ID: <87sglroqix.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:
> On Fri, Dec 06, 2019 at 05:24:20PM +0100, Thomas Renninger wrote:
>> From: Felix Schnizlein <fschnizlein@suse.de>
>> ==> flags <==
>> fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single pti ssbd ibrs ibpb fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt arat umip
>
> One file with all of that?  We are going to run into problems
> eventually, that should be split up.
>
> Just like bugs, that's going to just grow over time and eventually
> overflow PAGE_SIZE :(
>
> Make this:
>   ├── flags
>   │   ├── fpu
>   │   ├── vme
> ...
>
> Much simpler to parse, right?

Well, I'm not really sure whether 100+ files are simpler to parse.

Aside of that I really don't see the value for 100+ files per CPU which
are just returning 1 or True or whatever as long as you are not
suggesting to provide real feature files which have 0/1 or True/False
content.

But I still don't get the whole thing. The only "argument" I've seen so
far is the 'proc moves to sys' mantra, but that does not make it any
better.

We won't get rid of /proc/cpuinfo for a very long time simply because
too much userspace uses it. Introducing a mess in /sys/ in parallel just
for following the mantra does not help much.

Also IF we ever expose feature flags in sys then this needs to be a
split ino

  cpu/common_features

and

  cpu/CPU$N/unique_features

On most systems unique_features wont exist, but there is such stuff on
the horizon.

Thanks,

        tglx
