Return-Path: <linux-arch+bounces-622-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376AF802A33
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 03:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3713280C8E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 02:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8951109;
	Mon,  4 Dec 2023 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9Z88ekH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA410F0
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 02:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866C1C433C8
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 02:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701656219;
	bh=kqjRhgTaWFyWNU0iDPibNUZDm+BI9k9CgyR6qAyUgIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p9Z88ekH2+TXdp7gx8oSV9sh5/k+1dONUihJfFqkT1wBlwXij8XbXJF04j9DvDVDY
	 3cu+hG0Ijisn2wbl/BhWMqHqUAKikXx9v+js6vMsUQt6+xE/+NRmijmResii03Inu8
	 8uhEymXn98MlNAW3l/ssAd5NvYgji4+I52eEho9fuLY410XvbiUoW3tJBYR8xVXn9N
	 bnwdUUXk9Po6NKyLtOkW3Mv1/3snYGVR80f7fjDfmSEmDjRY5BFgarcIWtSaLmRPMg
	 YhDJlCaj73POOoZSaT6FPUkfKY+B9wvpzizH+613Zs/jmggCcSO5bcKKXqPZ8uXR+J
	 Gim6tzBBbZXwQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54a945861c6so4906323a12.3
        for <linux-arch@vger.kernel.org>; Sun, 03 Dec 2023 18:16:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yyrd9lxuERMAUceH0OVCk36OmlFNuLMw7/QxNN4jaJtYADwLEjw
	J42oQ9LiX9nRzRgfAcnXCKesrs2Bfxp/ZoKIsog=
X-Google-Smtp-Source: AGHT+IE+fEccqGwFMBhK661nmD8tez5/mcWWY4NJEpbIlX9MEZryLkLbRc/xqM9QGL6UD0nTeWCbF7gr/Dv4WQJ8kc0=
X-Received: by 2002:a50:a6c4:0:b0:54c:a3f0:598c with SMTP id
 f4-20020a50a6c4000000b0054ca3f0598cmr864610edc.24.1701656217877; Sun, 03 Dec
 2023 18:16:57 -0800 (PST)
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
 <CAAhV-H6xtawO3kMtJtzMAbGELTO=RieY3B2mM77Uk8rB73Ppqw@mail.gmail.com>
 <CAEyhmHQQ3NqN1cZ1AfhUEbaswy6BWHCTjmUyncxdNUwQuCVOAA@mail.gmail.com>
 <CAAhV-H7p4i+EJj9hd3mRdTePjJ07zSwuBKNuCp66828UnLMGkA@mail.gmail.com> <CAEyhmHQaAi3vV7e51DY_6MyYoTVZNd8gC22+K9CT_s6m+3Sk-Q@mail.gmail.com>
In-Reply-To: <CAEyhmHQaAi3vV7e51DY_6MyYoTVZNd8gC22+K9CT_s6m+3Sk-Q@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 4 Dec 2023 10:16:44 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5cTH+=1KGPXV3n3sSTdz1-ANQ0c9nHy7+RzWVq=b4TiA@mail.gmail.com>
Message-ID: <CAAhV-H5cTH+=1KGPXV3n3sSTdz1-ANQ0c9nHy7+RzWVq=b4TiA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, loongarch@lists.linux.dev, 
	kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hengqi,

On Mon, Dec 4, 2023 at 9:56=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> On Sun, Dec 3, 2023 at 11:17=E2=80=AFAM Huacai Chen <chenhuacai@kernel.or=
g> wrote:
> >
> > Hi, Hengqi,
> >
> > On Thu, Nov 23, 2023 at 10:39=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail=
.com> wrote:
> > >
> > > On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Huacai Chen <chenhuacai@kerne=
l.org> wrote:
> > > >
> > > > On Thu, Nov 23, 2023 at 4:09=E2=80=AFPM Hengqi Chen <hengqi.chen@gm=
ail.com> wrote:
> > > > >
> > > > > On Thu, Nov 23, 2023 at 2:13=E2=80=AFPM Huacai Chen <chenhuacai@k=
ernel.org> wrote:
> > > > > >
> > > > > > Hi, Hengqi,
> > > > > >
> > > > > > On Thu, Nov 23, 2023 at 1:49=E2=80=AFPM Hengqi Chen <hengqi.che=
n@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Nov 22, 2023 at 3:58=E2=80=AFPM Huacai Chen <chenhuac=
ai@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Hi, Hengqi,
> > > > > > > >
> > > > > > > > On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <hengqi=
.chen@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi, Huacai,
> > > > > > > > >
> > > > > > > > > On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <chen=
huacai@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi, Hengqi,
> > > > > > > > > >
> > > > > > > > > > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <he=
ngqi.chen@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Currently, we store syscall number in pt_regs::regs[1=
1] and it may be
> > > > > > > > > > > changed during syscall execution. Take `execve` as an=
 example:
> > > > > > > > > > >
> > > > > > > > > > >     sys_execve
> > > > > > > > > > >       -> do_execve
> > > > > > > > > > >         -> do_execveat_common
> > > > > > > > > > >           -> bprm_execve
> > > > > > > > > > >             -> exec_binprm
> > > > > > > > > > >               -> search_binary_handler
> > > > > > > > > > >                 -> load_elf_binary
> > > > > > > > > > >                   -> ELF_PLAT_INIT
> > > > > > > > > > >
> > > > > > > > > > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall_e=
xit_to_user_mode
> > > > > > > > > > > we get a wrong syscall nr.
> > > > > > > > > > >
> > > > > > > > > > > Known affected syscalls includes execve/execveat/rt_s=
igreturn. Tools
> > > > > > > > > > > like execsnoop do not work properly because the sys_e=
xit_* tracepoints
> > > > > > > > > > > does not trigger at all.
> > > > > > > > > > >
> > > > > > > > > > > Let's store syscall nr in thread_info instead.
> > > > > > > > > > Can we just modify ELF_PLAT_INIT and not clear regs[11]=
?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I am uncertain about the side effects of changing ELF_PLA=
T_INIT.
> > > > > > > > > From a completeness perspective, changing ELF_PLAT_INIT i=
s suboptimal,
> > > > > > > > > rt_sigreturn is affected in another code path, and there =
may be other
> > > > > > > > > syscalls that I am unaware of.
> > > > > > > > Save syscall number in thread_info has more side effects, b=
ecause
> > > > > > > > ptrace allows us to change the number during syscall, then =
we should
> > > > > > > > keep consistency between syscall and regs[11].
> > > > > > > >
> > > > > > >
> > > > > > > How about the change below:
> > > > > > >
> > > > > > > diff --git a/arch/loongarch/include/asm/syscall.h
> > > > > > > b/arch/loongarch/include/asm/syscall.h
> > > > > > > index e286dc58476e..954ba53bcc9a 100644
> > > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > > @@ -23,7 +23,9 @@ extern void *sys_call_table[];
> > > > > > >  static inline long syscall_get_nr(struct task_struct *task,
> > > > > > >                                   struct pt_regs *regs)
> > > > > > >  {
> > > > > > > -       return regs->regs[11];
> > > > > > > +       long nr =3D task_thread_info(task)->syscall;
> > > > > > > +
> > > > > > > +       return nr ? : regs->regs[11];
> > > > > > >  }
> > > > > > >
> > > > > > >  static inline void syscall_rollback(struct task_struct *task=
,
> > > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch=
/kernel/syscall.c
> > > > > > > index b4c5acd7aa3b..553ab0d624cb 100644
> > > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > > @@ -53,6 +53,7 @@ void noinstr do_syscall(struct pt_regs *reg=
s)
> > > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > > >
> > > > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > > > > +       current_thread_info()->syscall =3D nr;
> > > > > > >
> > > > > > >         if (nr < NR_syscalls) {
> > > > > > >                 syscall_fn =3D sys_call_table[nr];
> > > > > > > @@ -61,4 +62,5 @@ void noinstr do_syscall(struct pt_regs *reg=
s)
> > > > > > >         }
> > > > > > >
> > > > > > >         syscall_exit_to_user_mode(regs);
> > > > > > > +       current_thread_info()->syscall =3D 0;
> > > > > > >  }
> > > > > > >
> > > > > > > * allow ptrace to change syscall nr
> > > > > > > * sys_exit_* will also see the right syscall nr
> > > > > > > * this works even if rt_sigreturn clobbers all pt_regs::regs
> > > > > > No, I still prefer to modify ELF_PLAT_INIT, we can wait Arnd's =
comments.
> > > > > >
> > > > >
> > > > > OK, I am not eager, anyway, we know the root cause. :)
> > > > >
> > > > > > And, do you mean modifying ELF_PLAT_INIT cannot solve the
> > > > > > rt_sigreturn's problem?
> > > > > >
> > > > >
> > > > > Right, see https://elixir.bootlin.com/linux/latest/source/arch/lo=
ongarch/kernel/signal.c#L807
> > > > Is this the expected behavior for rt_sigreturn()? Otherwise I think
> > > > RISC-V has the same problem. And if we really need the 'correct'
> > > > syscall number, we can overwrite regs[11] in sys_rt_sigreturn().
> > > >
> > >
> > > I check with x86 and arm64, both have the same issue, seems no one ca=
re.
> > Does the rt_sigreturn issue affect execsnoop?
> >
>
> No, execsnoop only relies on sys_enter_execve/sys_exit_execve.
Then I suggest the below one line patch, though Arnd still no
response, I believe it has no side effect (because ARM64 and RISC-V
clear nothing here):

diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/=
elf.h
index b9a4ab54285c..45a2a2f7a27f 100644
--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -293,7 +293,7 @@ extern const char *__elf_platform;
 #define ELF_PLAT_INIT(_r, load_addr)   do { \
        _r->regs[1] =3D _r->regs[2] =3D _r->regs[3] =3D _r->regs[4] =3D 0; =
     \
        _r->regs[5] =3D _r->regs[6] =3D _r->regs[7] =3D _r->regs[8] =3D 0; =
     \
-       _r->regs[9] =3D _r->regs[10] =3D _r->regs[11] =3D _r->regs[12] =3D =
0;   \
+       _r->regs[9] =3D _r->regs[10] =3D /* syscall */ =3D _r->regs[12] =3D=
 0;  \
        _r->regs[13] =3D _r->regs[14] =3D _r->regs[15] =3D _r->regs[16] =3D=
 0;  \
        _r->regs[17] =3D _r->regs[18] =3D _r->regs[19] =3D _r->regs[20] =3D=
 0;  \
        _r->regs[21] =3D _r->regs[22] =3D _r->regs[23] =3D _r->regs[24] =3D=
 0;  \

>
> > Huacai
> >
> > >
> > > > And another question: do you have any updates about the BPF system
> > > > hang problem? :)
> > > >
> > >
> > > Let's discuss this on a new thread.
> > >
> > > > Huacai
> > > >
> > > > >
> > > > > > Huacai
> > > > > >
> > > > > > >
> > > > > > > > And about ELF_PLAT_INIT, maybe Arnd can give us some more i=
nformation.
> > > > > > > >
> > > > > > > > Hi, Arnd,
> > > > > > > >
> > > > > > > > I found some new architectures, such as ARM64 and RISC-V, j=
ust do
> > > > > > > > nearly nothing in ELF_PLAT_INIT, while some old architectur=
es, such as
> > > > > > > > x86 and MIPS, clear most of the registers, do you know why?
> > > > > > > >
> > > > > > > > Huacai
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > Huacai
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Fixes: be769645a2aef ("LoongArch: Add system call sup=
port")
> > > > > > > > > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > > > > > > > > > >  arch/loongarch/kernel/syscall.c      | 1 +
> > > > > > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/arch/loongarch/include/asm/syscall.h b/a=
rch/loongarch/include/asm/syscall.h
> > > > > > > > > > > index e286dc58476e..2317d674b92a 100644
> > > > > > > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > > > > > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > > > > > > > > > >  static inline long syscall_get_nr(struct task_struct=
 *task,
> > > > > > > > > > >                                   struct pt_regs *reg=
s)
> > > > > > > > > > >  {
> > > > > > > > > > > -       return regs->regs[11];
> > > > > > > > > > > +       return task_thread_info(task)->syscall;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  static inline void syscall_rollback(struct task_stru=
ct *task,
> > > > > > > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/l=
oongarch/kernel/syscall.c
> > > > > > > > > > > index b4c5acd7aa3b..2783e33cf276 100644
> > > > > > > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > > > > > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt_r=
egs *regs)
> > > > > > > > > > >         regs->orig_a0 =3D regs->regs[4];
> > > > > > > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > > > > > > >
> > > > > > > > > > > +       task_thread_info(current)->syscall =3D nr;
> > > > > > > > > > >         nr =3D syscall_enter_from_user_mode(regs, nr)=
;
> > > > > > > > > > >
> > > > > > > > > > >         if (nr < NR_syscalls) {
> > > > > > > > > > > --
> > > > > > > > > > > 2.42.0
> > > > > > > > > > >
> > > > > > >
> > >

