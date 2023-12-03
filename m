Return-Path: <linux-arch+bounces-616-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE21802084
	for <lists+linux-arch@lfdr.de>; Sun,  3 Dec 2023 04:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2FDEB20A82
	for <lists+linux-arch@lfdr.de>; Sun,  3 Dec 2023 03:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A10801;
	Sun,  3 Dec 2023 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX2hGNwd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC667F5
	for <linux-arch@vger.kernel.org>; Sun,  3 Dec 2023 03:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A87C433C8
	for <linux-arch@vger.kernel.org>; Sun,  3 Dec 2023 03:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701573476;
	bh=0l2hPIrHhxLiHRISKdgR4z6SoUec/uQacpxNnqQZz2w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UX2hGNwdCmQtlm06tpFtj2Zv6qsFS+mPxNdQNZXCfgatJK1gd9hJvXtdaQnrPFIYK
	 FlKucFbQIpRcSaeQS84/E3oZkbDVyn68Dk8vqANRoGjGznWw59hbVlQhNOM3i0tw5k
	 GbbhOBPGlTWqmntbjn22DMmE+Bf2WvQLrDMWBNGNIe3rfUo9joG4Ncok2G0OC5jbTi
	 2ND9it5N1arckoYShdl8cvsjieIpAgIUbBDuSa4AQlq8ta5yBrlnw8y1kS+kINA8rY
	 IrHgJy5WWm4kEjdYxowCq2o2KVsde4stvfmkI7E5eoaR/cxl+UA7eWKn8f0E+gB3Hh
	 YIUGuY/yMB4sg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-54ca43031d1so264643a12.0
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2023 19:17:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yyml+YnDqXu+HrtG+y/zCIY4wmGBohhb45OArX6z8+CSRFrffRD
	FiwwTL8KNrQxFvvRis508upk45gc/HJ7E28fpDg=
X-Google-Smtp-Source: AGHT+IHJ7YxvYy8V8Ho7KoTA8zirjrFcFfA2Wp69fczW2nWKpnm0XZCJFwVI9IBt0L5xdyQ1UMKwAu6uBfZNAKqKu7g=
X-Received: by 2002:a50:d68d:0:b0:54b:53f0:2696 with SMTP id
 r13-20020a50d68d000000b0054b53f02696mr1959421edi.30.1701573474836; Sat, 02
 Dec 2023 19:17:54 -0800 (PST)
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
 <CAAhV-H53YNH_trJmgcp-=PjdTSXuyzvmxWVaeUg++yYiXd=1Kg@mail.gmail.com>
 <CAEyhmHSPwjWQ=KJKskQHTjNKfMV3WG6r8sHihqtbBsZeKUQzUg@mail.gmail.com>
 <CAAhV-H6xtawO3kMtJtzMAbGELTO=RieY3B2mM77Uk8rB73Ppqw@mail.gmail.com> <CAEyhmHQQ3NqN1cZ1AfhUEbaswy6BWHCTjmUyncxdNUwQuCVOAA@mail.gmail.com>
In-Reply-To: <CAEyhmHQQ3NqN1cZ1AfhUEbaswy6BWHCTjmUyncxdNUwQuCVOAA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 3 Dec 2023 11:17:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7p4i+EJj9hd3mRdTePjJ07zSwuBKNuCp66828UnLMGkA@mail.gmail.com>
Message-ID: <CAAhV-H7p4i+EJj9hd3mRdTePjJ07zSwuBKNuCp66828UnLMGkA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, loongarch@lists.linux.dev, 
	kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Thu, Nov 23, 2023 at 10:39=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > On Thu, Nov 23, 2023 at 4:09=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.=
com> wrote:
> > >
> > > On Thu, Nov 23, 2023 at 2:13=E2=80=AFPM Huacai Chen <chenhuacai@kerne=
l.org> wrote:
> > > >
> > > > Hi, Hengqi,
> > > >
> > > > On Thu, Nov 23, 2023 at 1:49=E2=80=AFPM Hengqi Chen <hengqi.chen@gm=
ail.com> wrote:
> > > > >
> > > > > On Wed, Nov 22, 2023 at 3:58=E2=80=AFPM Huacai Chen <chenhuacai@k=
ernel.org> wrote:
> > > > > >
> > > > > > Hi, Hengqi,
> > > > > >
> > > > > > On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <hengqi.che=
n@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi, Huacai,
> > > > > > >
> > > > > > > On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <chenhuac=
ai@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Hi, Hengqi,
> > > > > > > >
> > > > > > > > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <hengqi=
.chen@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Currently, we store syscall number in pt_regs::regs[11] a=
nd it may be
> > > > > > > > > changed during syscall execution. Take `execve` as an exa=
mple:
> > > > > > > > >
> > > > > > > > >     sys_execve
> > > > > > > > >       -> do_execve
> > > > > > > > >         -> do_execveat_common
> > > > > > > > >           -> bprm_execve
> > > > > > > > >             -> exec_binprm
> > > > > > > > >               -> search_binary_handler
> > > > > > > > >                 -> load_elf_binary
> > > > > > > > >                   -> ELF_PLAT_INIT
> > > > > > > > >
> > > > > > > > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall_exit_=
to_user_mode
> > > > > > > > > we get a wrong syscall nr.
> > > > > > > > >
> > > > > > > > > Known affected syscalls includes execve/execveat/rt_sigre=
turn. Tools
> > > > > > > > > like execsnoop do not work properly because the sys_exit_=
* tracepoints
> > > > > > > > > does not trigger at all.
> > > > > > > > >
> > > > > > > > > Let's store syscall nr in thread_info instead.
> > > > > > > > Can we just modify ELF_PLAT_INIT and not clear regs[11]?
> > > > > > > >
> > > > > > >
> > > > > > > I am uncertain about the side effects of changing ELF_PLAT_IN=
IT.
> > > > > > > From a completeness perspective, changing ELF_PLAT_INIT is su=
boptimal,
> > > > > > > rt_sigreturn is affected in another code path, and there may =
be other
> > > > > > > syscalls that I am unaware of.
> > > > > > Save syscall number in thread_info has more side effects, becau=
se
> > > > > > ptrace allows us to change the number during syscall, then we s=
hould
> > > > > > keep consistency between syscall and regs[11].
> > > > > >
> > > > >
> > > > > How about the change below:
> > > > >
> > > > > diff --git a/arch/loongarch/include/asm/syscall.h
> > > > > b/arch/loongarch/include/asm/syscall.h
> > > > > index e286dc58476e..954ba53bcc9a 100644
> > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > @@ -23,7 +23,9 @@ extern void *sys_call_table[];
> > > > >  static inline long syscall_get_nr(struct task_struct *task,
> > > > >                                   struct pt_regs *regs)
> > > > >  {
> > > > > -       return regs->regs[11];
> > > > > +       long nr =3D task_thread_info(task)->syscall;
> > > > > +
> > > > > +       return nr ? : regs->regs[11];
> > > > >  }
> > > > >
> > > > >  static inline void syscall_rollback(struct task_struct *task,
> > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/ker=
nel/syscall.c
> > > > > index b4c5acd7aa3b..553ab0d624cb 100644
> > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > @@ -53,6 +53,7 @@ void noinstr do_syscall(struct pt_regs *regs)
> > > > >         regs->regs[4] =3D -ENOSYS;
> > > > >
> > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > > +       current_thread_info()->syscall =3D nr;
> > > > >
> > > > >         if (nr < NR_syscalls) {
> > > > >                 syscall_fn =3D sys_call_table[nr];
> > > > > @@ -61,4 +62,5 @@ void noinstr do_syscall(struct pt_regs *regs)
> > > > >         }
> > > > >
> > > > >         syscall_exit_to_user_mode(regs);
> > > > > +       current_thread_info()->syscall =3D 0;
> > > > >  }
> > > > >
> > > > > * allow ptrace to change syscall nr
> > > > > * sys_exit_* will also see the right syscall nr
> > > > > * this works even if rt_sigreturn clobbers all pt_regs::regs
> > > > No, I still prefer to modify ELF_PLAT_INIT, we can wait Arnd's comm=
ents.
> > > >
> > >
> > > OK, I am not eager, anyway, we know the root cause. :)
> > >
> > > > And, do you mean modifying ELF_PLAT_INIT cannot solve the
> > > > rt_sigreturn's problem?
> > > >
> > >
> > > Right, see https://elixir.bootlin.com/linux/latest/source/arch/loonga=
rch/kernel/signal.c#L807
> > Is this the expected behavior for rt_sigreturn()? Otherwise I think
> > RISC-V has the same problem. And if we really need the 'correct'
> > syscall number, we can overwrite regs[11] in sys_rt_sigreturn().
> >
>
> I check with x86 and arm64, both have the same issue, seems no one care.
Does the rt_sigreturn issue affect execsnoop?

Huacai

>
> > And another question: do you have any updates about the BPF system
> > hang problem? :)
> >
>
> Let's discuss this on a new thread.
>
> > Huacai
> >
> > >
> > > > Huacai
> > > >
> > > > >
> > > > > > And about ELF_PLAT_INIT, maybe Arnd can give us some more infor=
mation.
> > > > > >
> > > > > > Hi, Arnd,
> > > > > >
> > > > > > I found some new architectures, such as ARM64 and RISC-V, just =
do
> > > > > > nearly nothing in ELF_PLAT_INIT, while some old architectures, =
such as
> > > > > > x86 and MIPS, clear most of the registers, do you know why?
> > > > > >
> > > > > > Huacai
> > > > > >
> > > > > > >
> > > > > > > > Huacai
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Fixes: be769645a2aef ("LoongArch: Add system call support=
")
> > > > > > > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > > > > > > > >  arch/loongarch/kernel/syscall.c      | 1 +
> > > > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/loongarch/include/asm/syscall.h b/arch/=
loongarch/include/asm/syscall.h
> > > > > > > > > index e286dc58476e..2317d674b92a 100644
> > > > > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > > > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > > > > > > > >  static inline long syscall_get_nr(struct task_struct *ta=
sk,
> > > > > > > > >                                   struct pt_regs *regs)
> > > > > > > > >  {
> > > > > > > > > -       return regs->regs[11];
> > > > > > > > > +       return task_thread_info(task)->syscall;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static inline void syscall_rollback(struct task_struct *=
task,
> > > > > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loong=
arch/kernel/syscall.c
> > > > > > > > > index b4c5acd7aa3b..2783e33cf276 100644
> > > > > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > > > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt_regs =
*regs)
> > > > > > > > >         regs->orig_a0 =3D regs->regs[4];
> > > > > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > > > > >
> > > > > > > > > +       task_thread_info(current)->syscall =3D nr;
> > > > > > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > > > > > >
> > > > > > > > >         if (nr < NR_syscalls) {
> > > > > > > > > --
> > > > > > > > > 2.42.0
> > > > > > > > >
> > > > >
>

