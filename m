Return-Path: <linux-arch+bounces-1158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE5481C44C
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 05:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B77B1F258BC
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 04:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94AF568B;
	Fri, 22 Dec 2023 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfYgaZlU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA67567E;
	Fri, 22 Dec 2023 04:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1D5C433D9;
	Fri, 22 Dec 2023 04:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703220215;
	bh=BYc4P52QVmcfkosbCiaZHm30PAhBdMV15eIFZyXrt/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gfYgaZlUKTevwbQZJYf85rCQkvZ/2dCJYNFbjX4MpLQkTDUUEUs/gP6VgkDORJWb8
	 39mKyH0Ale/2tztSN7oPpMMX8AVjmR7C80Ec+Qj7ylvDdMCuhODKMjmh5TDF4Lx3uC
	 39ErfF6Mps6iJFaHEwyXAzkQ5Nu128Yd2sJxWJ6nY/94L7qUCSZHLV5/sCN8oYauqI
	 N4dax9yGxlcrjoMrDAaNl8IZ8xR0Hgym3gVh5HxSmMIEXzMN9t6gLELtElUW7lppYm
	 5IIc6FIgr1lxlCyWzmaSZamTNwe7g9rYswUzFs4QlJqViWD7UPJhQ8/YWKRjrzaesf
	 HqqLBcybWwv9w==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so1618396a12.2;
        Thu, 21 Dec 2023 20:43:34 -0800 (PST)
X-Gm-Message-State: AOJu0YytadRPiSCTOB0XqmO/s3m45VWprQlEDvyaGXODOQIe0CytCEIY
	TCTvxTJibSkPq7cbEJu0nyBPftsm5URCyTdo52M=
X-Google-Smtp-Source: AGHT+IEUijHJ57JnutUHpUy3p1Ku8NBY/+d6W1M5E/W4tJng1EyPnpTmpp3MlXrvJ8ydAe+kadGKjzYldx2WjsB5z0k=
X-Received: by 2002:a50:935c:0:b0:553:aa33:7876 with SMTP id
 n28-20020a50935c000000b00553aa337876mr152031eda.31.1703220213485; Thu, 21 Dec
 2023 20:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com>
 <20231220-optimize_checksum-v13-2-a73547e1cad8@rivosinc.com>
 <CAJF2gTR9ZxLZwEs=TMeih+vEEuuxNHRkgLsG2ShjXPEZ-G44_w@mail.gmail.com> <ZYTobxPZVNct4toQ@ghost>
In-Reply-To: <ZYTobxPZVNct4toQ@ghost>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 12:43:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTBweJTVw1m1WuJ6LNKrB_U83sdtkiZAk-NLND6sqdMZQ@mail.gmail.com>
Message-ID: <CAJF2gTTBweJTVw1m1WuJ6LNKrB_U83sdtkiZAk-NLND6sqdMZQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] riscv: Add static key for misaligned accesses
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, David Laight <David.Laight@aculab.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Evan Green <evan@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 9:37=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Fri, Dec 22, 2023 at 08:33:18AM +0800, Guo Ren wrote:
> > On Thu, Dec 21, 2023 at 7:38=E2=80=AFAM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > Support static branches depending on the value of misaligned accesses=
.
> > > This will be used by a later patch in the series. All cpus must be
> > > considered "fast" for this static branch to be flipped.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/cpufeature.h |  2 ++
> > >  arch/riscv/kernel/cpufeature.c      | 30 +++++++++++++++++++++++++++=
+++
> > >  2 files changed, 32 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include=
/asm/cpufeature.h
> > > index a418c3112cd6..7b129e5e2f07 100644
> > > --- a/arch/riscv/include/asm/cpufeature.h
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> > > @@ -133,4 +133,6 @@ static __always_inline bool riscv_cpu_has_extensi=
on_unlikely(int cpu, const unsi
> > >         return __riscv_isa_extension_available(hart_isa[cpu].isa, ext=
);
> > >  }
> > >
> > > +DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > > +
> > >  #endif
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index b3785ffc1570..095eb6ebdcaa 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/bitmap.h>
> > >  #include <linux/cpuhotplug.h>
> > >  #include <linux/ctype.h>
> > > +#include <linux/jump_label.h>
> > >  #include <linux/log2.h>
> > >  #include <linux/memory.h>
> > >  #include <linux/module.h>
> > > @@ -728,6 +729,35 @@ void riscv_user_isa_enable(void)
> > >                 csr_set(CSR_SENVCFG, ENVCFG_CBZE);
> > >  }
> > >
> > > +DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
> > > +
> > > +static int set_unaligned_access_static_branches(void)
> > > +{
> > > +       /*
> > > +        * This will be called after check_unaligned_access_all_cpus =
so the
> > > +        * result of unaligned access speed for all cpus will be avai=
lable.
> > > +        */
> > > +
> > > +       int cpu;
> > > +       bool fast_misaligned_access_speed =3D true;
> > > +
> > > +       for_each_online_cpu(cpu) {
> > Each online_cpu? Is there any offline_cpu that is no
> > fast_misaligned_access_speed?
>
> I think instead of checking offline cpus, it would make more sense to
> adjust the static branch when offline cpus come online. Since
> riscv_online_cpu is called when a new CPU comes online, I can update the
> static branch inside of that function.
>
> >
> > Move into your riscv_online_cpu for each CPU, and use stop_machine for
> > synchronization.
> >
>
> I do not understand what you mean by "Move into your riscv_online_cpu
> for each CPU", but I am assuming you are referring to updating the
> static branch inside of riscv_online_cpu.
I mean in:
arch/riscv/kernel/cpufeature.c: riscv_online_cpu()

Yes,"adjust the static branch when offline cpus come online ..."

>
> I believe any race condition that could be solved by stop_machine will
> become irrelevent by ensuring that the static branch is updated when a
> new cpu comes online.
Em...  stop_machine may be not necessary.

>
> - Charlie
>
> > > +               int this_perf =3D per_cpu(misaligned_access_speed, cp=
u);
> > > +
> > > +               if (this_perf !=3D RISCV_HWPROBE_MISALIGNED_FAST) {
> > > +                       fast_misaligned_access_speed =3D false;
> > > +                       break;
> > > +               }
> > > +       }
> > > +
> > > +       if (fast_misaligned_access_speed)
> > > +               static_branch_enable(&fast_misaligned_access_speed_ke=
y);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +arch_initcall_sync(set_unaligned_access_static_branches);
> > > +
> > >  #ifdef CONFIG_RISCV_ALTERNATIVE
> > >  /*
> > >   * Alternative patch sites consider 48 bits when determining when to=
 patch
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren

