Return-Path: <linux-arch+bounces-419-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B87F59F2
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 09:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9601C209EF
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C30199D1;
	Thu, 23 Nov 2023 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmvgx+oZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660CD1944A
	for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 08:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0560AC433CB
	for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 08:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700727948;
	bh=jUIdp/9BcMtKh3Z19LjJP9rOcQ1+wrzarOVQsitui6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hmvgx+oZPf+9OHNcOZMm6eDfUb4B3NV5Xee5dG5Pq3hax3eZ7TgNIn7nnQSFIfzVW
	 y8ed1wgBqGqvcSGiu3hhhAsN9YzBNYBGP0n4SjOZgv6b+qb4HJ6zKaKZU9ONAGCVXF
	 UCU+pdtPWHhX3K/Deo3br+IPxC76q5bTgtX5VZRuocsltb+qfblF9fxMKYaT9no/uR
	 CkHEf21++quxrBuKBLF3SUuU+dIccbrwtFWs/71Soe2dmgyXN8KP0QtoKAkAeRM5Wc
	 p6nlN0cjA9+HpEW6DVtyixLENdjveTLXTle+H9a7NL4geGOWbNdQ37xrLOy1ZzAwmA
	 sNDW4WRM77aJg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9ffef4b2741so70100766b.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 00:25:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yzf6gg4UAI90CruijcHXcV6WwdRHrr4699HjVi/LlfW83P1kSRf
	G3jLWyihczj4YL8akKZwSEiOXryuChQ62ge+7pI=
X-Google-Smtp-Source: AGHT+IHHt3cfnr7XY/q/xgVhbGYoEca1wB3RPU4KHjmEPgubJT6b+eoHRFn55lEboyOIlcMplRu4HFx3KmmEHlUHvPs=
X-Received: by 2002:a17:906:f88e:b0:9d2:63ab:6d4f with SMTP id
 lg14-20020a170906f88e00b009d263ab6d4fmr1650295ejb.55.1700727946298; Thu, 23
 Nov 2023 00:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121070209.210934-1-hengqi.chen@gmail.com>
 <CAAhV-H7SwSRDh8Ui2xVb1ncoaEQVd=dugphcBemkeaPNGQX2qw@mail.gmail.com>
 <CAEyhmHRYghT5iFiLByUmC=AjdygiBWU8TH3joSyyWibu0Ki2xw@mail.gmail.com>
 <CAAhV-H4Jr_a4j+Qnitd7ay9Vkcw5g0W_W3LNJwUzQ1BWXoGpoA@mail.gmail.com>
 <CAEyhmHRFZqH=4K8WUO6tPFd0NoWMHm_iLan+4EPiqovO03w1xw@mail.gmail.com>
 <CAAhV-H53YNH_trJmgcp-=PjdTSXuyzvmxWVaeUg++yYiXd=1Kg@mail.gmail.com> <CAEyhmHSPwjWQ=KJKskQHTjNKfMV3WG6r8sHihqtbBsZeKUQzUg@mail.gmail.com>
In-Reply-To: <CAEyhmHSPwjWQ=KJKskQHTjNKfMV3WG6r8sHihqtbBsZeKUQzUg@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 23 Nov 2023 16:25:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6xtawO3kMtJtzMAbGELTO=RieY3B2mM77Uk8rB73Ppqw@mail.gmail.com>
Message-ID: <CAAhV-H6xtawO3kMtJtzMAbGELTO=RieY3B2mM77Uk8rB73Ppqw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, loongarch@lists.linux.dev, 
	kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 4:09=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> On Thu, Nov 23, 2023 at 2:13=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Hengqi,
> >
> > On Thu, Nov 23, 2023 at 1:49=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.=
com> wrote:
> > >
> > > On Wed, Nov 22, 2023 at 3:58=E2=80=AFPM Huacai Chen <chenhuacai@kerne=
l.org> wrote:
> > > >
> > > > Hi, Hengqi,
> > > >
> > > > On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <hengqi.chen@gm=
ail.com> wrote:
> > > > >
> > > > > Hi, Huacai,
> > > > >
> > > > > On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <chenhuacai@k=
ernel.org> wrote:
> > > > > >
> > > > > > Hi, Hengqi,
> > > > > >
> > > > > > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <hengqi.che=
n@gmail.com> wrote:
> > > > > > >
> > > > > > > Currently, we store syscall number in pt_regs::regs[11] and i=
t may be
> > > > > > > changed during syscall execution. Take `execve` as an example=
:
> > > > > > >
> > > > > > >     sys_execve
> > > > > > >       -> do_execve
> > > > > > >         -> do_execveat_common
> > > > > > >           -> bprm_execve
> > > > > > >             -> exec_binprm
> > > > > > >               -> search_binary_handler
> > > > > > >                 -> load_elf_binary
> > > > > > >                   -> ELF_PLAT_INIT
> > > > > > >
> > > > > > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall_exit_to_u=
ser_mode
> > > > > > > we get a wrong syscall nr.
> > > > > > >
> > > > > > > Known affected syscalls includes execve/execveat/rt_sigreturn=
. Tools
> > > > > > > like execsnoop do not work properly because the sys_exit_* tr=
acepoints
> > > > > > > does not trigger at all.
> > > > > > >
> > > > > > > Let's store syscall nr in thread_info instead.
> > > > > > Can we just modify ELF_PLAT_INIT and not clear regs[11]?
> > > > > >
> > > > >
> > > > > I am uncertain about the side effects of changing ELF_PLAT_INIT.
> > > > > From a completeness perspective, changing ELF_PLAT_INIT is subopt=
imal,
> > > > > rt_sigreturn is affected in another code path, and there may be o=
ther
> > > > > syscalls that I am unaware of.
> > > > Save syscall number in thread_info has more side effects, because
> > > > ptrace allows us to change the number during syscall, then we shoul=
d
> > > > keep consistency between syscall and regs[11].
> > > >
> > >
> > > How about the change below:
> > >
> > > diff --git a/arch/loongarch/include/asm/syscall.h
> > > b/arch/loongarch/include/asm/syscall.h
> > > index e286dc58476e..954ba53bcc9a 100644
> > > --- a/arch/loongarch/include/asm/syscall.h
> > > +++ b/arch/loongarch/include/asm/syscall.h
> > > @@ -23,7 +23,9 @@ extern void *sys_call_table[];
> > >  static inline long syscall_get_nr(struct task_struct *task,
> > >                                   struct pt_regs *regs)
> > >  {
> > > -       return regs->regs[11];
> > > +       long nr =3D task_thread_info(task)->syscall;
> > > +
> > > +       return nr ? : regs->regs[11];
> > >  }
> > >
> > >  static inline void syscall_rollback(struct task_struct *task,
> > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/=
syscall.c
> > > index b4c5acd7aa3b..553ab0d624cb 100644
> > > --- a/arch/loongarch/kernel/syscall.c
> > > +++ b/arch/loongarch/kernel/syscall.c
> > > @@ -53,6 +53,7 @@ void noinstr do_syscall(struct pt_regs *regs)
> > >         regs->regs[4] =3D -ENOSYS;
> > >
> > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > +       current_thread_info()->syscall =3D nr;
> > >
> > >         if (nr < NR_syscalls) {
> > >                 syscall_fn =3D sys_call_table[nr];
> > > @@ -61,4 +62,5 @@ void noinstr do_syscall(struct pt_regs *regs)
> > >         }
> > >
> > >         syscall_exit_to_user_mode(regs);
> > > +       current_thread_info()->syscall =3D 0;
> > >  }
> > >
> > > * allow ptrace to change syscall nr
> > > * sys_exit_* will also see the right syscall nr
> > > * this works even if rt_sigreturn clobbers all pt_regs::regs
> > No, I still prefer to modify ELF_PLAT_INIT, we can wait Arnd's comments=
.
> >
>
> OK, I am not eager, anyway, we know the root cause. :)
>
> > And, do you mean modifying ELF_PLAT_INIT cannot solve the
> > rt_sigreturn's problem?
> >
>
> Right, see https://elixir.bootlin.com/linux/latest/source/arch/loongarch/=
kernel/signal.c#L807
Is this the expected behavior for rt_sigreturn()? Otherwise I think
RISC-V has the same problem. And if we really need the 'correct'
syscall number, we can overwrite regs[11] in sys_rt_sigreturn().

And another question: do you have any updates about the BPF system
hang problem? :)

Huacai

>
> > Huacai
> >
> > >
> > > > And about ELF_PLAT_INIT, maybe Arnd can give us some more informati=
on.
> > > >
> > > > Hi, Arnd,
> > > >
> > > > I found some new architectures, such as ARM64 and RISC-V, just do
> > > > nearly nothing in ELF_PLAT_INIT, while some old architectures, such=
 as
> > > > x86 and MIPS, clear most of the registers, do you know why?
> > > >
> > > > Huacai
> > > >
> > > > >
> > > > > > Huacai
> > > > > >
> > > > > > >
> > > > > > > Fixes: be769645a2aef ("LoongArch: Add system call support")
> > > > > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > > > > ---
> > > > > > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > > > > > >  arch/loongarch/kernel/syscall.c      | 1 +
> > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loon=
garch/include/asm/syscall.h
> > > > > > > index e286dc58476e..2317d674b92a 100644
> > > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > > > > > >  static inline long syscall_get_nr(struct task_struct *task,
> > > > > > >                                   struct pt_regs *regs)
> > > > > > >  {
> > > > > > > -       return regs->regs[11];
> > > > > > > +       return task_thread_info(task)->syscall;
> > > > > > >  }
> > > > > > >
> > > > > > >  static inline void syscall_rollback(struct task_struct *task=
,
> > > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch=
/kernel/syscall.c
> > > > > > > index b4c5acd7aa3b..2783e33cf276 100644
> > > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt_regs *reg=
s)
> > > > > > >         regs->orig_a0 =3D regs->regs[4];
> > > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > > >
> > > > > > > +       task_thread_info(current)->syscall =3D nr;
> > > > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > > > >
> > > > > > >         if (nr < NR_syscalls) {
> > > > > > > --
> > > > > > > 2.42.0
> > > > > > >
> > >

