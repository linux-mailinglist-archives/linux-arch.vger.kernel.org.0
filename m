Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F33119279
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 21:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfLJUxv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 15:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfLJUxv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 15:53:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D62206EC;
        Tue, 10 Dec 2019 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576011230;
        bh=fkev4MRGf9Lhg8tjRG4U3dQfBAMe6/SLbFZByzfr46g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJ+yXHaw9iREFbIOuodzq9CaRUiVqEoOvWrbIbVYlqase9BSf1E/o1d2VepJuxPi7
         HpJGb0VaGyHQqtvI3TkQSv9hCyYi13p0TSkCuatWGyaC+Em5K+XQyZQTbrlDOSL+by
         yWHyMPXWVUIXKnQdNnauCUuUp64VlKwmpHHt09r4=
Date:   Tue, 10 Dec 2019 21:53:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        fschnitzlein@suse.de, Felix Schnizlein <fschnizlein@suse.com>,
        Thomas Renninger <trenn@suse.com>
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Message-ID: <20191210205348.GA4080658@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-3-trenn@suse.de>
 <20191206163656.GC86904@kroah.com>
 <87sglroqix.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sglroqix.fsf@nanos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 10, 2019 at 09:48:54PM +0100, Thomas Gleixner wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> > On Fri, Dec 06, 2019 at 05:24:20PM +0100, Thomas Renninger wrote:
> >> From: Felix Schnizlein <fschnizlein@suse.de>
> >> ==> flags <==
> >> fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single pti ssbd ibrs ibpb fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt arat umip
> >
> > One file with all of that?  We are going to run into problems
> > eventually, that should be split up.
> >
> > Just like bugs, that's going to just grow over time and eventually
> > overflow PAGE_SIZE :(
> >
> > Make this:
> >   ├── flags
> >   │   ├── fpu
> >   │   ├── vme
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
> 
> But I still don't get the whole thing. The only "argument" I've seen so
> far is the 'proc moves to sys' mantra, but that does not make it any
> better.

That is not a valid mantra, as I tried to explain later in this thread.

I don't understand the need for this patchset either, all I was trying
to do was to at least make it sane from a sysfs-point-of-view if people
really wanted to do this type of thing.

> We won't get rid of /proc/cpuinfo for a very long time simply because
> too much userspace uses it. Introducing a mess in /sys/ in parallel just
> for following the mantra does not help much.

Again, invalid mantra, not a valid reason :)

I think this is a patchset in search of a problem, which is why it was
dropped all those years ago...

thanks,

greg k-h
