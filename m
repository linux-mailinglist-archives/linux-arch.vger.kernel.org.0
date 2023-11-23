Return-Path: <linux-arch+bounces-417-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977827F580B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 07:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CEFEB20A4E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABF2C2D8;
	Thu, 23 Nov 2023 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqOXrOrW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F0CA47
	for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 06:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372C5C433C8
	for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 06:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700720034;
	bh=Dl0h76HI3NiIQm8XV4CtuYLnvUlzNQGfrTVIvzSfT1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bqOXrOrWlcJ5f5hg82eM8IBcS2zuBUcMAw2NaNeemS0VUL5GfbaFQ2Y1SqTuxINl3
	 YRmEVQanvZdU4IEReZ/SuJo2bbk5z/7Wf9XpYo8l0Yo1B1gdTc+pnPUkvE10upt638
	 72wB2QvoK9QyGAdNaE7kmLBtwdIdypQhInHGMjlHq5b29xyo/70zvE9AwHKYRAXc+B
	 kT/qlWdmnfM0a+LkdN8T/CHeUnEutbcyiviqkiB4DBTCF6/H8elFhBu4yQTsuVRreC
	 OhZcpwn5Mk/+nK/cWD9K9IdTXFRSpDkJAqY9CeADqVZXe/oopgbSfr/50DMGpAW2Lx
	 PIBzdhhO9JLFg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a02c48a0420so59512066b.2
        for <linux-arch@vger.kernel.org>; Wed, 22 Nov 2023 22:13:54 -0800 (PST)
X-Gm-Message-State: AOJu0YxLuxOOIpOvHhadPrS/qYVAPRxpfaPKdwly70dLSWxqYvTPKfWp
	cdXjPtAWi5zT+nsqUqREHnytuUt4QIUd39ZSV7g=
X-Google-Smtp-Source: AGHT+IGJ0J2Q+NW1T2gIIux6FRTVCVJQRuVxi8rIJ2LhLy5JYl9uXiXl5i6fMgmXYsbEYqCxaCpKKh8ojvgAmLu12rc=
X-Received: by 2002:a17:906:7385:b0:a01:b8d5:e61e with SMTP id
 f5-20020a170906738500b00a01b8d5e61emr2680475ejl.16.1700720032613; Wed, 22 Nov
 2023 22:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121070209.210934-1-hengqi.chen@gmail.com>
 <CAAhV-H7SwSRDh8Ui2xVb1ncoaEQVd=dugphcBemkeaPNGQX2qw@mail.gmail.com>
 <CAEyhmHRYghT5iFiLByUmC=AjdygiBWU8TH3joSyyWibu0Ki2xw@mail.gmail.com>
 <CAAhV-H4Jr_a4j+Qnitd7ay9Vkcw5g0W_W3LNJwUzQ1BWXoGpoA@mail.gmail.com> <CAEyhmHRFZqH=4K8WUO6tPFd0NoWMHm_iLan+4EPiqovO03w1xw@mail.gmail.com>
In-Reply-To: <CAEyhmHRFZqH=4K8WUO6tPFd0NoWMHm_iLan+4EPiqovO03w1xw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 23 Nov 2023 14:13:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H53YNH_trJmgcp-=PjdTSXuyzvmxWVaeUg++yYiXd=1Kg@mail.gmail.com>
Message-ID: <CAAhV-H53YNH_trJmgcp-=PjdTSXuyzvmxWVaeUg++yYiXd=1Kg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, loongarch@lists.linux.dev, 
	kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Thu, Nov 23, 2023 at 1:49=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> On Wed, Nov 22, 2023 at 3:58=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Hengqi,
> >
> > On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.=
com> wrote:
> > >
> > > Hi, Huacai,
> > >
> > > On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <chenhuacai@kerne=
l.org> wrote:
> > > >
> > > > Hi, Hengqi,
> > > >
> > > > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <hengqi.chen@gm=
ail.com> wrote:
> > > > >
> > > > > Currently, we store syscall number in pt_regs::regs[11] and it ma=
y be
> > > > > changed during syscall execution. Take `execve` as an example:
> > > > >
> > > > >     sys_execve
> > > > >       -> do_execve
> > > > >         -> do_execveat_common
> > > > >           -> bprm_execve
> > > > >             -> exec_binprm
> > > > >               -> search_binary_handler
> > > > >                 -> load_elf_binary
> > > > >                   -> ELF_PLAT_INIT
> > > > >
> > > > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall_exit_to_user_=
mode
> > > > > we get a wrong syscall nr.
> > > > >
> > > > > Known affected syscalls includes execve/execveat/rt_sigreturn. To=
ols
> > > > > like execsnoop do not work properly because the sys_exit_* tracep=
oints
> > > > > does not trigger at all.
> > > > >
> > > > > Let's store syscall nr in thread_info instead.
> > > > Can we just modify ELF_PLAT_INIT and not clear regs[11]?
> > > >
> > >
> > > I am uncertain about the side effects of changing ELF_PLAT_INIT.
> > > From a completeness perspective, changing ELF_PLAT_INIT is suboptimal=
,
> > > rt_sigreturn is affected in another code path, and there may be other
> > > syscalls that I am unaware of.
> > Save syscall number in thread_info has more side effects, because
> > ptrace allows us to change the number during syscall, then we should
> > keep consistency between syscall and regs[11].
> >
>
> How about the change below:
>
> diff --git a/arch/loongarch/include/asm/syscall.h
> b/arch/loongarch/include/asm/syscall.h
> index e286dc58476e..954ba53bcc9a 100644
> --- a/arch/loongarch/include/asm/syscall.h
> +++ b/arch/loongarch/include/asm/syscall.h
> @@ -23,7 +23,9 @@ extern void *sys_call_table[];
>  static inline long syscall_get_nr(struct task_struct *task,
>                                   struct pt_regs *regs)
>  {
> -       return regs->regs[11];
> +       long nr =3D task_thread_info(task)->syscall;
> +
> +       return nr ? : regs->regs[11];
>  }
>
>  static inline void syscall_rollback(struct task_struct *task,
> diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/sysc=
all.c
> index b4c5acd7aa3b..553ab0d624cb 100644
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -53,6 +53,7 @@ void noinstr do_syscall(struct pt_regs *regs)
>         regs->regs[4] =3D -ENOSYS;
>
>         nr =3D syscall_enter_from_user_mode(regs, nr);
> +       current_thread_info()->syscall =3D nr;
>
>         if (nr < NR_syscalls) {
>                 syscall_fn =3D sys_call_table[nr];
> @@ -61,4 +62,5 @@ void noinstr do_syscall(struct pt_regs *regs)
>         }
>
>         syscall_exit_to_user_mode(regs);
> +       current_thread_info()->syscall =3D 0;
>  }
>
> * allow ptrace to change syscall nr
> * sys_exit_* will also see the right syscall nr
> * this works even if rt_sigreturn clobbers all pt_regs::regs
No, I still prefer to modify ELF_PLAT_INIT, we can wait Arnd's comments.

And, do you mean modifying ELF_PLAT_INIT cannot solve the
rt_sigreturn's problem?

Huacai

>
> > And about ELF_PLAT_INIT, maybe Arnd can give us some more information.
> >
> > Hi, Arnd,
> >
> > I found some new architectures, such as ARM64 and RISC-V, just do
> > nearly nothing in ELF_PLAT_INIT, while some old architectures, such as
> > x86 and MIPS, clear most of the registers, do you know why?
> >
> > Huacai
> >
> > >
> > > > Huacai
> > > >
> > > > >
> > > > > Fixes: be769645a2aef ("LoongArch: Add system call support")
> > > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > > ---
> > > > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > > > >  arch/loongarch/kernel/syscall.c      | 1 +
> > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarc=
h/include/asm/syscall.h
> > > > > index e286dc58476e..2317d674b92a 100644
> > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > > > >  static inline long syscall_get_nr(struct task_struct *task,
> > > > >                                   struct pt_regs *regs)
> > > > >  {
> > > > > -       return regs->regs[11];
> > > > > +       return task_thread_info(task)->syscall;
> > > > >  }
> > > > >
> > > > >  static inline void syscall_rollback(struct task_struct *task,
> > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/ker=
nel/syscall.c
> > > > > index b4c5acd7aa3b..2783e33cf276 100644
> > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt_regs *regs)
> > > > >         regs->orig_a0 =3D regs->regs[4];
> > > > >         regs->regs[4] =3D -ENOSYS;
> > > > >
> > > > > +       task_thread_info(current)->syscall =3D nr;
> > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > >
> > > > >         if (nr < NR_syscalls) {
> > > > > --
> > > > > 2.42.0
> > > > >
>

