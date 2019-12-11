Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543F211A91E
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 11:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfLKKmi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 11 Dec 2019 05:42:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:59534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728030AbfLKKmi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 05:42:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 376F6B13E;
        Wed, 11 Dec 2019 10:42:36 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Felix Schnizlein <fschnizlein@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Date:   Wed, 11 Dec 2019 11:42:35 +0100
Message-ID: <4737004.4U1sY2OxSp@skinner.arch.suse.de>
In-Reply-To: <87sglroqix.fsf@nanos.tec.linutronix.de>
References: <20191206162421.15050-1-trenn@suse.de> <20191206163656.GC86904@kroah.com> <87sglroqix.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tuesday, December 10, 2019 9:48:54 PM CET Thomas Gleixner wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> > On Fri, Dec 06, 2019 at 05:24:20PM +0100, Thomas Renninger wrote:
> >> From: Felix Schnizlein <fschnizlein@suse.de>
> >> ==> flags <==
> >> fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36
> >> clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc
> >> rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq ssse3 fma
> >> cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave
> >> avx f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single pti
> >> ssbd ibrs ibpb fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
> >> xsaveopt arat umip> 
> > One file with all of that?  We are going to run into problems
> > eventually, that should be split up.
> > 
> > Just like bugs, that's going to just grow over time and eventually
> > overflow PAGE_SIZE :(
> > 
> > Make this:
> >   ├── flags
> >   │   ├── fpu
> >   │   ├── vme
> > 
> > ...
> > 
> > Much simpler to parse, right?
> 
> Well, I'm not really sure whether 100+ files are simpler to parse.
> 
> Aside of that I really don't see the value for 100+ files per CPU which
> are just returning 1 or True or whatever as long as you are not
> suggesting to provide real feature files which have 0/1 or True/False
> content.

I also do not like the one file per cpu flag approach.
This still is one "data"/"info" per sysfs file.
Similar to:
cpu/cpufreq/policy1/scaling_available_governors
and probably a lot others. If PAGE_SIZE overflow has to be cared for, then be 
it.
 
> But I still don't get the whole thing. The only "argument" I've seen so
> far is the 'proc moves to sys' mantra, but that does not make it any
> better.
> 
> We won't get rid of /proc/cpuinfo for a very long time simply because
> too much userspace uses it.

The reason we will never get rid of it is:
Newly written userspace tools still (have to) make use it.
This is because of a small set of remaining info which is convenient
to have in userspace but which is not avail in sysfs yet.

Therefore only x of the 26 /proc/cpuinfo data has been picked up.

For decades unused info like:
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
power management:

shall die at (long but) some point of time.

It's quite some years ago when acpi and cpufreq proc info first got
deprecated and duplicated in sys.
It has been said that it needs years of deprecation that the event file
on which damons were listening for acpi events can ever be removed...
It has been 2013 when the removal has been done, more than 5 years ago:
1696d9dc57e062ce5200f6a42a6aaada15b434bb
ACPI: Remove the old /proc/acpi/event interface

/proc/cpuinfo may need some years more, but there should be no
reason it is still getting used.

> Introducing a mess in /sys/ in parallel just
> for following the mantra does not help much.
 
> Also IF we ever expose feature flags in sys then this needs to be a
> split ino
> 
>   cpu/common_features
> 
> and
> 
>   cpu/CPU$N/unique_features

Makes sense.
feature (without common/unique) is also a better naming than flags.

If Greg (and others) are ok, I would add "page size exceeding" handling.
Hm, quick searching for an example I realize that debugfs can exceed page 
size. Is it that hard to expose a sysfs file larger than page size?

> On most systems unique_features wont exist, but there is such stuff on
> the horizon.

I still wait a bit before doing work for nothing.
I hope everybody agrees, that remaining useful info in /proc/cpuinfo should
show up in /sys if that did not happen yet. And that userspace tools should
not (need to) make use of /proc/cpuinfo anymore.

    Thomas


