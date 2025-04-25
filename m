Return-Path: <linux-arch+bounces-11576-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0D4A9CAB3
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 15:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F884A14CA
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656BE253338;
	Fri, 25 Apr 2025 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0BXU4AQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aumYIEdW"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671825228B;
	Fri, 25 Apr 2025 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588461; cv=none; b=U4TO37x7BeN6LpQM2Xhgkn+fwp/akX8oVoYBlNXfJI6QKCZjlSKqEsbt7F98v291DIEf61jaRS7IFL6f3DPoLdprh4NTo13yFuOtLdTTHMRfj0QTHzTVP8u6iu2HZE0eeC7zFMZ/bMNM7S8//NyoZOUO4ug1EyzytB6a26fI0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588461; c=relaxed/simple;
	bh=PUhyQuqMGLYre7fLZ1LFsgfI6xIsDJ1XIAZEsEI7pOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4JNVnV1DkE5U+qdu/JyFrhVNEekWh6qcu68browpwbE0TZUfCmHkSb5Vo+ybhVMfPDyp2NwmFiWn0oz9JAAvxCxM7pOoAgpMnfHOWSDb0TbKLiNrWZpnCugi2YEZYjOTtchyyP8PZ7c+eVjHhF7JHXd08BtL0zRfbuUBk7eHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0BXU4AQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aumYIEdW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Apr 2025 15:40:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745588457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tK9StlpDYAp08qW4tTKOct1Yb3+IgiVio9GxX2VqMMU=;
	b=n0BXU4AQVKORmqE6oDe8REQpn+OId76jh34c1y2J85KvGy+0JgyXnbnNA8dbK/1Kwa1CDT
	sbSEqwIvqW01LXg14hRV9fDwZ9Qts+4Qrjb7rGVqTvuvwk5tDmmtUyX7J4lnswSZNo4Pu8
	4zE1j6HQwy0xBMNI2MOy/HYt9fUoDkrgGOvOnkfhkG58+KWqFQfOw9zNXKqBs39vUYfj1G
	lRi3Kx+/aao3QyztH/HJpZsokym+ja3sX00jZx9jMe+jv+SBTkSLJKptf2yW5Anlw39F6T
	i5mnW6JC1P9uZ4KNk5cUtfjfkmtXxfaHU1SyFcMZsEzlpGIzILof42ezhR64vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745588457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tK9StlpDYAp08qW4tTKOct1Yb3+IgiVio9GxX2VqMMU=;
	b=aumYIEdWhsA7beLGGtF+wZHthOSDwSHnVvccyzZ/yEYbkfNRCWQ9tbLDcmD1BpTu09y/1v
	hGbzB7rnw72Yb4Dg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jan Stancek <jstancek@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 08/19] vdso/gettimeofday: Prepare do_hres_timens() for
 introduction of struct vdso_clock
Message-ID: <20250425152733-0ff10421-b716-4a55-9b60-cb0a71769e56@linutronix.de>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
 <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de>
 <aApGPAoctq_eoE2g@t14ultra>
 <20250424173908-ffca1ea2-e292-4df3-9391-24bfdaab33e7@linutronix.de>
 <CAASaF6xsMOWkhPrzKQWNz5SXaROSpxzFVBz+MOA-MNiEBty7gQ@mail.gmail.com>
 <20250425104552-07539a73-8f56-44d2-97a2-e224c567a2fc@linutronix.de>
 <CAASaF6yxThX3HTHgY_AGqNr7LJ-erdG09WV5-HyfN1fYN9pStQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAASaF6yxThX3HTHgY_AGqNr7LJ-erdG09WV5-HyfN1fYN9pStQ@mail.gmail.com>

On Fri, Apr 25, 2025 at 12:03:14PM +0200, Jan Stancek wrote:
> On Fri, Apr 25, 2025 at 10:58 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > On Thu, Apr 24, 2025 at 11:57:02PM +0200, Jan Stancek wrote:
> > > On Thu, Apr 24, 2025 at 5:49 PM Thomas Weißschuh
> > > <thomas.weissschuh@linutronix.de> wrote:
> > > >
> > > > On Thu, Apr 24, 2025 at 04:10:04PM +0200, Jan Stancek wrote:
> > > > > On Mon, Mar 03, 2025 at 12:11:10PM +0100, Thomas Weißschuh wrote:
> > > > > > From: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > > > >
> > > > > > To support multiple PTP clocks, the VDSO data structure needs to be
> > > > > > reworked. All clock specific data will end up in struct vdso_clock and in
> > > > > > struct vdso_time_data there will be array of it. By now, vdso_clock is
> > > > > > simply a define which maps vdso_clock to vdso_time_data.
> > > > > >
> > > > > > Prepare for the rework of these structures by adding struct vdso_clock
> > > > > > pointer argument to do_hres_timens(), and replace the struct vdso_time_data
> > > > > > pointer with the new pointer arugment whenever applicable.
> > > > > >
> > > > > > No functional change.
> > > > > >
> > > > > > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > > > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > > > > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > > > > > ---
> > > > > > lib/vdso/gettimeofday.c | 35 ++++++++++++++++++-----------------
> > > > > > 1 file changed, 18 insertions(+), 17 deletions(-)
> > > > > >
> > > > >
> > > > > starting with this patch, I'm seeing user-space crashes when using clock_gettime():
> > > > >   BAD  -> 83a2a6b8cfc5 vdso/gettimeofday: Prepare do_hres_timens() for introduction of struct vdso_clock
> > > > >   GOOD -> 64c3613ce31a vdso/gettimeofday: Prepare do_hres() for introduction of struct vdso_clock
> > > > >
> > > > > It appears to be unique to aarch64 with 64k pages, and can be reproduced with
> > > > > LTP clock_gettime03 [1]:
> > > > >   command: clock_gettime03   tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k/build/.config'
> > > > >   tst_test.c:1903: TINFO: LTP version: 20250130-231-gd02c2aea3
> > > > >   tst_test.c:1907: TINFO: Tested kernel: 6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k #1 SMP PREEMPT_DYNAMIC Wed Apr 23 23:23:54 UTC 2025 aarch64
> > > > >   tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k/build/.config'
> > > > >   tst_test.c:1720: TINFO: Overall timeout per run is 0h 05m 24s
> > > > >   clock_gettime03.c:121: TINFO: Testing variant: vDSO or syscall with libc spec
> > > > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct 10000ms
> > > > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct 0ms
> > > > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct 10000ms
> > > > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0ms
> > > > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct -10000ms
> > > > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct 0ms
> > > > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct -10000ms
> > > > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0ms
> > > > >   tst_test.c:438: TBROK: Child (233649) killed by signal SIGSEGV
> > > > >
> > > > > or with:
> > > > > --------------------- 8< ----------------------
> > > > > #define _GNU_SOURCE
> > > > > #include <sched.h>
> > > > > #include <time.h>
> > > > > #include <unistd.h>                                                                                                                                                                                                                          #include <sys/wait.h>
> > > > >
> > > > > int main(void)
> > > > > {
> > > > >         struct timespec tp;
> > > > >         pid_t child;
> > > > >         int status;
> > > > >
> > > > >         unshare(CLONE_NEWTIME);
> > > > >
> > > > >         child = fork();
> > > > >         if (child == 0) {
> > > > >                 clock_gettime(CLOCK_MONOTONIC_RAW, &tp);
> > > > >         }
> > > > >
> > > > >         wait(&status);
> > > > >         return status;
> > > > > }
> > > > >
> > > > > # ./a.out ; echo $?
> > > > > 139
> > > > > --------------------- >8 ----------------------
> > > > >
> > > > > RPMs and configs can be found at Fedora koji, latest build is at [2] (look for kernel-64k).
> > > >
> > > > Hi Jan,
> > > >
> > > > Thanks for the great error report.
> > > >
> > > > Can you try the following change (on top of v6.15-rc1, should also work with current master)?
> > > >
> > > > diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> > > > index 93ef801a97ef..867ce53cca94 100644
> > > > --- a/lib/vdso/gettimeofday.c
> > > > +++ b/lib/vdso/gettimeofday.c
> > > > @@ -85,14 +85,18 @@ static __always_inline
> > > >  int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> > > >                    clockid_t clk, struct __kernel_timespec *ts)
> > > >  {
> > > > -       const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
> > > >         const struct timens_offset *offs = &vcns->offset[clk];
> > > > -       const struct vdso_clock *vc = vd->clock_data;
> > > > +       const struct vdso_time_data *vd;
> > > > +       const struct vdso_clock *vc;
> > > >         const struct vdso_timestamp *vdso_ts;
> > > >         u64 cycles, ns;
> > > >         u32 seq;
> > > >         s64 sec;
> > > >
> > > > +       vd = vdns - (clk == CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_COARSE);
> > > > +       vd = __arch_get_vdso_u_timens_data(vd);
> > > > +       vc = vd->clock_data;
> > > > +
> > > >         if (clk != CLOCK_MONOTONIC_RAW)
> > > >                 vc = &vc[CS_HRES_COARSE];
> > > >         else
> > > >
> > > >
> > > > I'll do some proper testing tomorrow.
> > >
> > > That does seem to work for the 2 reproducers I have.
> >
> > Thanks for testing.
> >
> > > But why is this change needed?
> >
> > So far the only thing that I can say is that this logic was there before the
> > patch and was removed accidentally, so it should be restored.
> > Why the logic was there in the first place I'll have to investigate.
> 
> I think it paired with "vd advancing" based on "clock" in original code:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/vdso/gettimeofday.c?h=v6.14#n264
> and to get back to "base", you needed to subtract same value:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/vdso/gettimeofday.c?h=v6.14#n82
> 
> After this series, "vd" isn't manipulated this way, so the removal of
> that subtraction seemed deliberate to me.

Indeed. This change "works" because vsdo_clocksource_ok() rejects the clock and
instead falls backs to the syscall.

> > > Isn't 'vdns' here equal to 'vdso_u_time_data'?
> >
> > That is true, but in a time namespace the namespaced time structure is mapped
> > in place of the normal structure and vice-versa.
> > So __arch_get_vdso_u_timens_data() will get the "real" time datastructure based
> > on a namespaced one.
> >
> > I can't explain the special logic for CLOCK_MONOTONIC_RAW yet.
> > To me it looks wrong to calculate on a 'struct vdso_time_data *' in terms of
> > CS_RAW/CS_HRES_COARSE.
> >
> >
> > Another change that "fixes" the crash for me is:
> >
> > diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> > index 93ef801a97ef..cdc3988a0ace 100644
> > --- a/lib/vdso/gettimeofday.c
> > +++ b/lib/vdso/gettimeofday.c
> > @@ -93,6 +118,8 @@ int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *v
> >         u32 seq;
> >         s64 sec;
> >
> > +       OPTIMIZER_HIDE_VAR(vc);
> > +
> >         if (clk != CLOCK_MONOTONIC_RAW)
> >                 vc = &vc[CS_HRES_COARSE];
> >         else
> >
> >
> > This is obviously not an actual fix but indicates that something weird is going on.
> > Could you run this second change also through LTP to see if it would pass?
> 
> Agreed, this does "fixes" it for me as well.

Some more information:

The crash comes from the address arithmetic in "vc = &vc[CS_RAW]" going wrong.
This should just do "vc = vc + 1", advancing the pointer by sizeof(*vc).
But I get these example values of "vc" before and after the arithmetic:
0x00ffffbc060000 -> 0xfffffffffffd00e8
Which is obviously wrong.

The arithmetic can be fixed with any one of the following changes:
* OPTIMIZER_HIDE_VAR() as above
* Replacement of -mcmodel=tiny with -mcmode=small in arch/arm64/kernel/vdso/Makefile
  -mcmodel=tiny is supposed to cover 1MiB programs, the vDSO only needs 300KiB here
* Removal of the (clk != CLOCK_MONOTONIC_RAW) case

Shuffling code around, even without any impact on semantics, sometimes fixes
the issue. Compiling the vDSO with UBSAN didn't show anything.


Thomas

> > > > > [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
> > > > > [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=2704401
> > > >
> >
> 

