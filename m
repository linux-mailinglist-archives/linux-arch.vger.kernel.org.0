Return-Path: <linux-arch+bounces-11571-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390B8A9C29A
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 11:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EE9179220
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D323BCF5;
	Fri, 25 Apr 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HU4R34XW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7XArD6Wj"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87323F41F;
	Fri, 25 Apr 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571511; cv=none; b=ZxykBwUzn2M8pLwLnnyeDizaiip97mL6WtBwDtn6vsT/QvhQ0SzV5XdJlGCm8IEePYP1Khez8RLhoZa+8I+6537Tci2Ser1czMf3XfJ6KVUMiMDoHMdlZjlc6zignz674vA4hI6Wh9XLDDyumHLzCdynNLixTHKEnP/RUvW4qQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571511; c=relaxed/simple;
	bh=dc28QunALwtgDomZWTpPqR9PMaToUApaK8joh3lNzbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leZVa/ytICrxjOcFwP0qh0n2zS7taA19wND6VQr3pmMCaQNcTbCf8+Lk8VkI6EzUXF8UKB3SDYiQZXznE8qoZmxqTxK0vlmVaDBWr7lBpG1wYRAHRHHBP+Xv8MUgOKtWDIKpqdTAXC97hp2aKu+7WATW9yL3xW4lNJX0MvT/njk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HU4R34XW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7XArD6Wj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Apr 2025 10:58:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745571507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATfcjqmEpZVuHsa5QpDh67huEWYjcYeodgb6v929ags=;
	b=HU4R34XWPsRtuS+3Zwu+6pVRQWVMFmxkaCcTmym9py7QNM++iH/bagLUa0+oEik1YKv2gc
	UHbotcL98O9ikjHmMU/44dLq1bIzLbodJnWaWplbnLjKP2l5Jp7pMctgPld3nhULvx2xjq
	SSpVMBpo3+Ny8GJqDZoAujkPlS4CFvZS/XoAUr3TVGIyqqV/ewAqbtWjY6cXVcfcUkK1cY
	kl+5OVrKKLXBSvbEBVsNXdQvlyeE14HQtEiu6InpADVeXWWCL/eflTyGhNgSsIBrgjKwM9
	WEk22FPX16vSHQ/F6WOftfJSbKHADUV4E8pt5BgDripLSHkasGrISR4oOEMFmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745571507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATfcjqmEpZVuHsa5QpDh67huEWYjcYeodgb6v929ags=;
	b=7XArD6WjX4uOO9tTtLNvnmGGElYoy9J1l9VWBSDKN7R0iSfDuSVzvyX20AxViBwVjXd0ou
	kK8BmCvOyct1fWBw==
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
Message-ID: <20250425104552-07539a73-8f56-44d2-97a2-e224c567a2fc@linutronix.de>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
 <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de>
 <aApGPAoctq_eoE2g@t14ultra>
 <20250424173908-ffca1ea2-e292-4df3-9391-24bfdaab33e7@linutronix.de>
 <CAASaF6xsMOWkhPrzKQWNz5SXaROSpxzFVBz+MOA-MNiEBty7gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAASaF6xsMOWkhPrzKQWNz5SXaROSpxzFVBz+MOA-MNiEBty7gQ@mail.gmail.com>

On Thu, Apr 24, 2025 at 11:57:02PM +0200, Jan Stancek wrote:
> On Thu, Apr 24, 2025 at 5:49 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > On Thu, Apr 24, 2025 at 04:10:04PM +0200, Jan Stancek wrote:
> > > On Mon, Mar 03, 2025 at 12:11:10PM +0100, Thomas Weißschuh wrote:
> > > > From: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > >
> > > > To support multiple PTP clocks, the VDSO data structure needs to be
> > > > reworked. All clock specific data will end up in struct vdso_clock and in
> > > > struct vdso_time_data there will be array of it. By now, vdso_clock is
> > > > simply a define which maps vdso_clock to vdso_time_data.
> > > >
> > > > Prepare for the rework of these structures by adding struct vdso_clock
> > > > pointer argument to do_hres_timens(), and replace the struct vdso_time_data
> > > > pointer with the new pointer arugment whenever applicable.
> > > >
> > > > No functional change.
> > > >
> > > > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > > > ---
> > > > lib/vdso/gettimeofday.c | 35 ++++++++++++++++++-----------------
> > > > 1 file changed, 18 insertions(+), 17 deletions(-)
> > > >
> > >
> > > starting with this patch, I'm seeing user-space crashes when using clock_gettime():
> > >   BAD  -> 83a2a6b8cfc5 vdso/gettimeofday: Prepare do_hres_timens() for introduction of struct vdso_clock
> > >   GOOD -> 64c3613ce31a vdso/gettimeofday: Prepare do_hres() for introduction of struct vdso_clock
> > >
> > > It appears to be unique to aarch64 with 64k pages, and can be reproduced with
> > > LTP clock_gettime03 [1]:
> > >   command: clock_gettime03   tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k/build/.config'
> > >   tst_test.c:1903: TINFO: LTP version: 20250130-231-gd02c2aea3
> > >   tst_test.c:1907: TINFO: Tested kernel: 6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k #1 SMP PREEMPT_DYNAMIC Wed Apr 23 23:23:54 UTC 2025 aarch64
> > >   tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k/build/.config'
> > >   tst_test.c:1720: TINFO: Overall timeout per run is 0h 05m 24s
> > >   clock_gettime03.c:121: TINFO: Testing variant: vDSO or syscall with libc spec
> > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct 10000ms
> > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct 0ms
> > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct 10000ms
> > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0ms
> > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct -10000ms
> > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct 0ms
> > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct -10000ms
> > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0ms
> > >   tst_test.c:438: TBROK: Child (233649) killed by signal SIGSEGV
> > >
> > > or with:
> > > --------------------- 8< ----------------------
> > > #define _GNU_SOURCE
> > > #include <sched.h>
> > > #include <time.h>
> > > #include <unistd.h>                                                                                                                                                                                                                          #include <sys/wait.h>
> > >
> > > int main(void)
> > > {
> > >         struct timespec tp;
> > >         pid_t child;
> > >         int status;
> > >
> > >         unshare(CLONE_NEWTIME);
> > >
> > >         child = fork();
> > >         if (child == 0) {
> > >                 clock_gettime(CLOCK_MONOTONIC_RAW, &tp);
> > >         }
> > >
> > >         wait(&status);
> > >         return status;
> > > }
> > >
> > > # ./a.out ; echo $?
> > > 139
> > > --------------------- >8 ----------------------
> > >
> > > RPMs and configs can be found at Fedora koji, latest build is at [2] (look for kernel-64k).
> >
> > Hi Jan,
> >
> > Thanks for the great error report.
> >
> > Can you try the following change (on top of v6.15-rc1, should also work with current master)?
> >
> > diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> > index 93ef801a97ef..867ce53cca94 100644
> > --- a/lib/vdso/gettimeofday.c
> > +++ b/lib/vdso/gettimeofday.c
> > @@ -85,14 +85,18 @@ static __always_inline
> >  int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> >                    clockid_t clk, struct __kernel_timespec *ts)
> >  {
> > -       const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
> >         const struct timens_offset *offs = &vcns->offset[clk];
> > -       const struct vdso_clock *vc = vd->clock_data;
> > +       const struct vdso_time_data *vd;
> > +       const struct vdso_clock *vc;
> >         const struct vdso_timestamp *vdso_ts;
> >         u64 cycles, ns;
> >         u32 seq;
> >         s64 sec;
> >
> > +       vd = vdns - (clk == CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_COARSE);
> > +       vd = __arch_get_vdso_u_timens_data(vd);
> > +       vc = vd->clock_data;
> > +
> >         if (clk != CLOCK_MONOTONIC_RAW)
> >                 vc = &vc[CS_HRES_COARSE];
> >         else
> >
> >
> > I'll do some proper testing tomorrow.
> 
> That does seem to work for the 2 reproducers I have.

Thanks for testing.

> But why is this change needed?

So far the only thing that I can say is that this logic was there before the
patch and was removed accidentally, so it should be restored.
Why the logic was there in the first place I'll have to investigate.

> Isn't 'vdns' here equal to 'vdso_u_time_data'?

That is true, but in a time namespace the namespaced time structure is mapped
in place of the normal structure and vice-versa.
So __arch_get_vdso_u_timens_data() will get the "real" time datastructure based
on a namespaced one.

I can't explain the special logic for CLOCK_MONOTONIC_RAW yet.
To me it looks wrong to calculate on a 'struct vdso_time_data *' in terms of
CS_RAW/CS_HRES_COARSE.


Another change that "fixes" the crash for me is:

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 93ef801a97ef..cdc3988a0ace 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -93,6 +118,8 @@ int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *v
        u32 seq;
        s64 sec;
 
+       OPTIMIZER_HIDE_VAR(vc);
+
        if (clk != CLOCK_MONOTONIC_RAW)
                vc = &vc[CS_HRES_COARSE];
        else


This is obviously not an actual fix but indicates that something weird is going on.
Could you run this second change also through LTP to see if it would pass?


Thomas

> > > [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
> > > [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=2704401
> >

