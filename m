Return-Path: <linux-arch+bounces-334-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FE7F3F5C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 08:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D4EB20DBC
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 07:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3223820B1A;
	Wed, 22 Nov 2023 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5RWB0za"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782220B19
	for <linux-arch@vger.kernel.org>; Wed, 22 Nov 2023 07:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CE1C433C9
	for <linux-arch@vger.kernel.org>; Wed, 22 Nov 2023 07:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700639905;
	bh=TSjw9JHMBHe5Fok2w0/uBfI+0oxAFjy8dkw2a06Jmg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h5RWB0zaJ1wH4Z9oR+P0oKmBF1aBuN5qllDOg0mpr0huC1/bIits5k/57O49Z5/fc
	 diHr3Uz/SXMtSGFs6FQv/XXz0Sgl4MJwTQifgRnf270636nOxgVDzkgLXegTiJLJib
	 qIAnA2xL8ZchHkdV9RKJuS0pJB8dicngRjYj8+ftvXMUBNGWBewWyGzX08X0Bho6J6
	 KVTSGOrvhKcUhcSL1JiurM0CM3o8moONO8ejyvXA9CbkhHfmgH/PdBqUoB75m3eS06
	 9EiwSggh+5NwL+ZyW3xh7ejDlFOdlKJdr7sZj6l9gf5BIBKYEuPMzt8ZHWWzITry6/
	 z3OWGas8Zr7pQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-548f6f3cdc9so2624525a12.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Nov 2023 23:58:25 -0800 (PST)
X-Gm-Message-State: AOJu0YxiOwzt5vq6qmI4kqsB9bi1aMijAyMjHKiQCSXJ61MmXRGjxaIw
	nhnK0J0TaT2c03WWp/mCfrfV7djJqZHvhg3ADCc=
X-Google-Smtp-Source: AGHT+IEZMw4hpym7GPvn/jpG/VAFv2/TjUkvtNr2nYSzA9tWWzFpr3nwjjRTy95SPiijIV09Am4vQAgDpi6VGgvNKow=
X-Received: by 2002:a17:907:9443:b0:9fd:9616:c48e with SMTP id
 dl3-20020a170907944300b009fd9616c48emr995537ejc.27.1700639904103; Tue, 21 Nov
 2023 23:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121070209.210934-1-hengqi.chen@gmail.com>
 <CAAhV-H7SwSRDh8Ui2xVb1ncoaEQVd=dugphcBemkeaPNGQX2qw@mail.gmail.com> <CAEyhmHRYghT5iFiLByUmC=AjdygiBWU8TH3joSyyWibu0Ki2xw@mail.gmail.com>
In-Reply-To: <CAEyhmHRYghT5iFiLByUmC=AjdygiBWU8TH3joSyyWibu0Ki2xw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 22 Nov 2023 15:58:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Jr_a4j+Qnitd7ay9Vkcw5g0W_W3LNJwUzQ1BWXoGpoA@mail.gmail.com>
Message-ID: <CAAhV-H4Jr_a4j+Qnitd7ay9Vkcw5g0W_W3LNJwUzQ1BWXoGpoA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Hengqi Chen <hengqi.chen@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch <linux-arch@vger.kernel.org>
Cc: loongarch@lists.linux.dev, kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Hi, Huacai,
>
> On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Hengqi,
> >
> > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.=
com> wrote:
> > >
> > > Currently, we store syscall number in pt_regs::regs[11] and it may be
> > > changed during syscall execution. Take `execve` as an example:
> > >
> > >     sys_execve
> > >       -> do_execve
> > >         -> do_execveat_common
> > >           -> bprm_execve
> > >             -> exec_binprm
> > >               -> search_binary_handler
> > >                 -> load_elf_binary
> > >                   -> ELF_PLAT_INIT
> > >
> > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall_exit_to_user_mode
> > > we get a wrong syscall nr.
> > >
> > > Known affected syscalls includes execve/execveat/rt_sigreturn. Tools
> > > like execsnoop do not work properly because the sys_exit_* tracepoint=
s
> > > does not trigger at all.
> > >
> > > Let's store syscall nr in thread_info instead.
> > Can we just modify ELF_PLAT_INIT and not clear regs[11]?
> >
>
> I am uncertain about the side effects of changing ELF_PLAT_INIT.
> From a completeness perspective, changing ELF_PLAT_INIT is suboptimal,
> rt_sigreturn is affected in another code path, and there may be other
> syscalls that I am unaware of.
Save syscall number in thread_info has more side effects, because
ptrace allows us to change the number during syscall, then we should
keep consistency between syscall and regs[11].

And about ELF_PLAT_INIT, maybe Arnd can give us some more information.

Hi, Arnd,

I found some new architectures, such as ARM64 and RISC-V, just do
nearly nothing in ELF_PLAT_INIT, while some old architectures, such as
x86 and MIPS, clear most of the registers, do you know why?

Huacai

>
> > Huacai
> >
> > >
> > > Fixes: be769645a2aef ("LoongArch: Add system call support")
> > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > ---
> > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > >  arch/loongarch/kernel/syscall.c      | 1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/in=
clude/asm/syscall.h
> > > index e286dc58476e..2317d674b92a 100644
> > > --- a/arch/loongarch/include/asm/syscall.h
> > > +++ b/arch/loongarch/include/asm/syscall.h
> > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > >  static inline long syscall_get_nr(struct task_struct *task,
> > >                                   struct pt_regs *regs)
> > >  {
> > > -       return regs->regs[11];
> > > +       return task_thread_info(task)->syscall;
> > >  }
> > >
> > >  static inline void syscall_rollback(struct task_struct *task,
> > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/=
syscall.c
> > > index b4c5acd7aa3b..2783e33cf276 100644
> > > --- a/arch/loongarch/kernel/syscall.c
> > > +++ b/arch/loongarch/kernel/syscall.c
> > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt_regs *regs)
> > >         regs->orig_a0 =3D regs->regs[4];
> > >         regs->regs[4] =3D -ENOSYS;
> > >
> > > +       task_thread_info(current)->syscall =3D nr;
> > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > >
> > >         if (nr < NR_syscalls) {
> > > --
> > > 2.42.0
> > >

