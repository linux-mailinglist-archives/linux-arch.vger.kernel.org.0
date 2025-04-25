Return-Path: <linux-arch+bounces-11572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C752A9C49A
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8049C02E0
	for <lists+linux-arch@lfdr.de>; Fri, 25 Apr 2025 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA7522AE4E;
	Fri, 25 Apr 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6SWq6TU"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C70231A57
	for <linux-arch@vger.kernel.org>; Fri, 25 Apr 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575416; cv=none; b=GNjFI7aTUYLu0RJaDc0y87OKmXob0ZA6K3g8L76qfLaVhwbcoqwVoohOEchGiAlmWeRYGZHnEAoyxUtk1I44OHpidAMqL4Dnceoyt3oVYJK8QsEip9VORnv2UqeOGiDQEEMYPCi/H1HHgVdxn/ZhAy8aOtrYAg2QFXtBe/AwgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575416; c=relaxed/simple;
	bh=o/nSLVWz806VTnHD8gtVGrUdwMUgypfm/pnz5QKNUMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvVmrJZ0cGyHwf1Y41TfzuH3QmrP0ZPjlnBKgcpuug7+dwwR1FZJfPH0bnCdlUMgcUU6Mu2HYjf6WndEjrOXa/knuT9IwYKqIHqRMlTBR5n8ISZKxXHMp0rwqlhtpiQaLahwNfLTgigCsmv6LE/uQB5yjloieNSd/SQ3WW+jbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6SWq6TU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745575413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pdAv3L1vajERKgxSPxyO88qfXI0bDg1bbg1iV/Cff8=;
	b=f6SWq6TUTFNmOXYuveRc3vCnju3ueCsU5cX8gqyJZTOrqP1x8YakEa1uS+XErb0mDjQ6V3
	2uvP5hfjcF8lkE5G9VVVxYgdar/L2Jn3fdhM1yu+rB+pJ4JjzNapNz0IygWkMvhHS6EG9T
	TOHL6Ay8TTCODr7OSxbxYV3JcV4hdrs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-iiOFtjwAOsyB5chuhvf0uA-1; Fri, 25 Apr 2025 06:03:32 -0400
X-MC-Unique: iiOFtjwAOsyB5chuhvf0uA-1
X-Mimecast-MFC-AGG-ID: iiOFtjwAOsyB5chuhvf0uA_1745575411
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912d5f6689so1041635f8f.1
        for <linux-arch@vger.kernel.org>; Fri, 25 Apr 2025 03:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745575411; x=1746180211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pdAv3L1vajERKgxSPxyO88qfXI0bDg1bbg1iV/Cff8=;
        b=HFnNRu8H39mswhs9UkJkZWjaA/jGyHw0c09cnf4Ua0NwMhP3YiHQSwVIUzZFnsN8ss
         kg20tK/IiQ/1Xse4HqGENGWS4nlUzicqhPQ3EfC5Ihm0D6I3OsFYVbnM9UY27oZPwrD3
         mkHRVnYHxqL7qAABOqge8rzvyV3/rWqaqhRZPeujSmksn8d2Vdu30uDYRncLVQDQVhfG
         A2unsO9HHKyXZWLrG46Y5Kpj8Tn0NsUDLvuPA9Xtw47yIjzxuYrgStGS9OiXOjUZOv2S
         Y/Mqh9twxHsWaarA6E0QB5ZOZOti7Tppl8Xa2d4y6KLgW7Fw72SRspMZdhRVJ1cmQ2Rq
         Aqig==
X-Forwarded-Encrypted: i=1; AJvYcCU/FkHqGR9V1Rszc1mQKfNrwM5I9NzU9ZTnMDKixzp9reAzcuxhS5eq7VBvivnfKI2ZC4z0hn6UGdf1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Jr7OVsk4WHPrUt2mnwKY4Lo6Ex6EByEhx7jD6QNuMQzg5axv
	2HZgmKaCw68TR02WKZv0+nj3jWL5pg45oXtMFodUaVpVbegIumV58+HL24/8V1avCwleQzaMxpz
	g7qJNZm/cYCeK+N4XItgekl4cd28ephMnMmKJVcqhgdTb76TmCLFwQf4qRLYeA9OqQ4FZ8oF3TW
	ZjfuHp8IgTwvprlrs30dGDtfPiE23YFUcJqw==
X-Gm-Gg: ASbGnctFHecjHu+NqVZPKTpxpIPUNOf7XT9Kv7LjJeDSD6IXdEpx3sThpoDm9YlMb2M
	rb9pV9FbwkQWF6WueVPlGEpt9EGuKfgdane+n1rT9P1zTQ7esiAqTFqGHZzTWJmplv6U=
X-Received: by 2002:a05:6000:40cd:b0:39c:1257:cd3f with SMTP id ffacd0b85a97d-3a074fafc33mr1187360f8f.57.1745575410917;
        Fri, 25 Apr 2025 03:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhvPrUk8HaqVlny6U2TcGIeGC3vNg2/8Nd1SlrTxEwzCGtEum+5nJ8qw6AJbvzVU3WUz1E5bSUYJ0Yi6UnZY4=
X-Received: by 2002:a05:6000:40cd:b0:39c:1257:cd3f with SMTP id
 ffacd0b85a97d-3a074fafc33mr1187332f8f.57.1745575410491; Fri, 25 Apr 2025
 03:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
 <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de> <aApGPAoctq_eoE2g@t14ultra>
 <20250424173908-ffca1ea2-e292-4df3-9391-24bfdaab33e7@linutronix.de>
 <CAASaF6xsMOWkhPrzKQWNz5SXaROSpxzFVBz+MOA-MNiEBty7gQ@mail.gmail.com> <20250425104552-07539a73-8f56-44d2-97a2-e224c567a2fc@linutronix.de>
In-Reply-To: <20250425104552-07539a73-8f56-44d2-97a2-e224c567a2fc@linutronix.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 25 Apr 2025 12:03:14 +0200
X-Gm-Features: ATxdqUHUJyFDwXWlLrx8Ahqii0-Ktlj3kT6KX6YhOgPcoK-aAeGj4gOn-pX1-9g
Message-ID: <CAASaF6yxThX3HTHgY_AGqNr7LJ-erdG09WV5-HyfN1fYN9pStQ@mail.gmail.com>
Subject: Re: [PATCH 08/19] vdso/gettimeofday: Prepare do_hres_timens() for
 introduction of struct vdso_clock
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
	Nam Cao <namcao@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:58=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Thu, Apr 24, 2025 at 11:57:02PM +0200, Jan Stancek wrote:
> > On Thu, Apr 24, 2025 at 5:49=E2=80=AFPM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > On Thu, Apr 24, 2025 at 04:10:04PM +0200, Jan Stancek wrote:
> > > > On Mon, Mar 03, 2025 at 12:11:10PM +0100, Thomas Wei=C3=9Fschuh wro=
te:
> > > > > From: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > > >
> > > > > To support multiple PTP clocks, the VDSO data structure needs to =
be
> > > > > reworked. All clock specific data will end up in struct vdso_cloc=
k and in
> > > > > struct vdso_time_data there will be array of it. By now, vdso_clo=
ck is
> > > > > simply a define which maps vdso_clock to vdso_time_data.
> > > > >
> > > > > Prepare for the rework of these structures by adding struct vdso_=
clock
> > > > > pointer argument to do_hres_timens(), and replace the struct vdso=
_time_data
> > > > > pointer with the new pointer arugment whenever applicable.
> > > > >
> > > > > No functional change.
> > > > >
> > > > > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > > > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutroni=
x.de>
> > > > > ---
> > > > > lib/vdso/gettimeofday.c | 35 ++++++++++++++++++-----------------
> > > > > 1 file changed, 18 insertions(+), 17 deletions(-)
> > > > >
> > > >
> > > > starting with this patch, I'm seeing user-space crashes when using =
clock_gettime():
> > > >   BAD  -> 83a2a6b8cfc5 vdso/gettimeofday: Prepare do_hres_timens() =
for introduction of struct vdso_clock
> > > >   GOOD -> 64c3613ce31a vdso/gettimeofday: Prepare do_hres() for int=
roduction of struct vdso_clock
> > > >
> > > > It appears to be unique to aarch64 with 64k pages, and can be repro=
duced with
> > > > LTP clock_gettime03 [1]:
> > > >   command: clock_gettime03   tst_kconfig.c:88: TINFO: Parsing kerne=
l config '/lib/modules/6.15.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch=
64+64k/build/.config'
> > > >   tst_test.c:1903: TINFO: LTP version: 20250130-231-gd02c2aea3
> > > >   tst_test.c:1907: TINFO: Tested kernel: 6.15.0-0.rc3.20250423gitbc=
3372351d0c.30.eln147.aarch64+64k #1 SMP PREEMPT_DYNAMIC Wed Apr 23 23:23:54=
 UTC 2025 aarch64
> > > >   tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.15=
.0-0.rc3.20250423gitbc3372351d0c.30.eln147.aarch64+64k/build/.config'
> > > >   tst_test.c:1720: TINFO: Overall timeout per run is 0h 05m 24s
> > > >   clock_gettime03.c:121: TINFO: Testing variant: vDSO or syscall wi=
th libc spec
> > > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct =
10000ms
> > > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct =
0ms
> > > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct 1=
0000ms
> > > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0=
ms
> > > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_MONOTONIC) is correct =
-10000ms
> > > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_MONOTONIC) is correct =
0ms
> > > >   clock_gettime03.c:76: TPASS: Offset (CLOCK_BOOTTIME) is correct -=
10000ms
> > > >   clock_gettime03.c:86: TPASS: Offset (CLOCK_BOOTTIME) is correct 0=
ms
> > > >   tst_test.c:438: TBROK: Child (233649) killed by signal SIGSEGV
> > > >
> > > > or with:
> > > > --------------------- 8< ----------------------
> > > > #define _GNU_SOURCE
> > > > #include <sched.h>
> > > > #include <time.h>
> > > > #include <unistd.h>                                                =
                                                                           =
                                                                           =
                    #include <sys/wait.h>
> > > >
> > > > int main(void)
> > > > {
> > > >         struct timespec tp;
> > > >         pid_t child;
> > > >         int status;
> > > >
> > > >         unshare(CLONE_NEWTIME);
> > > >
> > > >         child =3D fork();
> > > >         if (child =3D=3D 0) {
> > > >                 clock_gettime(CLOCK_MONOTONIC_RAW, &tp);
> > > >         }
> > > >
> > > >         wait(&status);
> > > >         return status;
> > > > }
> > > >
> > > > # ./a.out ; echo $?
> > > > 139
> > > > --------------------- >8 ----------------------
> > > >
> > > > RPMs and configs can be found at Fedora koji, latest build is at [2=
] (look for kernel-64k).
> > >
> > > Hi Jan,
> > >
> > > Thanks for the great error report.
> > >
> > > Can you try the following change (on top of v6.15-rc1, should also wo=
rk with current master)?
> > >
> > > diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> > > index 93ef801a97ef..867ce53cca94 100644
> > > --- a/lib/vdso/gettimeofday.c
> > > +++ b/lib/vdso/gettimeofday.c
> > > @@ -85,14 +85,18 @@ static __always_inline
> > >  int do_hres_timens(const struct vdso_time_data *vdns, const struct v=
dso_clock *vcns,
> > >                    clockid_t clk, struct __kernel_timespec *ts)
> > >  {
> > > -       const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_=
data(vdns);
> > >         const struct timens_offset *offs =3D &vcns->offset[clk];
> > > -       const struct vdso_clock *vc =3D vd->clock_data;
> > > +       const struct vdso_time_data *vd;
> > > +       const struct vdso_clock *vc;
> > >         const struct vdso_timestamp *vdso_ts;
> > >         u64 cycles, ns;
> > >         u32 seq;
> > >         s64 sec;
> > >
> > > +       vd =3D vdns - (clk =3D=3D CLOCK_MONOTONIC_RAW ? CS_RAW : CS_H=
RES_COARSE);
> > > +       vd =3D __arch_get_vdso_u_timens_data(vd);
> > > +       vc =3D vd->clock_data;
> > > +
> > >         if (clk !=3D CLOCK_MONOTONIC_RAW)
> > >                 vc =3D &vc[CS_HRES_COARSE];
> > >         else
> > >
> > >
> > > I'll do some proper testing tomorrow.
> >
> > That does seem to work for the 2 reproducers I have.
>
> Thanks for testing.
>
> > But why is this change needed?
>
> So far the only thing that I can say is that this logic was there before =
the
> patch and was removed accidentally, so it should be restored.
> Why the logic was there in the first place I'll have to investigate.

I think it paired with "vd advancing" based on "clock" in original code:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib=
/vdso/gettimeofday.c?h=3Dv6.14#n264
and to get back to "base", you needed to subtract same value:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib=
/vdso/gettimeofday.c?h=3Dv6.14#n82

After this series, "vd" isn't manipulated this way, so the removal of
that subtraction seemed deliberate to me.

>
> > Isn't 'vdns' here equal to 'vdso_u_time_data'?
>
> That is true, but in a time namespace the namespaced time structure is ma=
pped
> in place of the normal structure and vice-versa.
> So __arch_get_vdso_u_timens_data() will get the "real" time datastructure=
 based
> on a namespaced one.
>
> I can't explain the special logic for CLOCK_MONOTONIC_RAW yet.
> To me it looks wrong to calculate on a 'struct vdso_time_data *' in terms=
 of
> CS_RAW/CS_HRES_COARSE.
>
>
> Another change that "fixes" the crash for me is:
>
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 93ef801a97ef..cdc3988a0ace 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -93,6 +118,8 @@ int do_hres_timens(const struct vdso_time_data *vdns, =
const struct vdso_clock *v
>         u32 seq;
>         s64 sec;
>
> +       OPTIMIZER_HIDE_VAR(vc);
> +
>         if (clk !=3D CLOCK_MONOTONIC_RAW)
>                 vc =3D &vc[CS_HRES_COARSE];
>         else
>
>
> This is obviously not an actual fix but indicates that something weird is=
 going on.
> Could you run this second change also through LTP to see if it would pass=
?

Agreed, this does "fixes" it for me as well.

>
>
> Thomas
>
> > > > [1] https://github.com/linux-test-project/ltp/blob/master/testcases=
/kernel/syscalls/clock_gettime/clock_gettime03.c
> > > > [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=3D2704401
> > >
>


