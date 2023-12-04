Return-Path: <linux-arch+bounces-621-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32328029FC
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 02:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41334280C35
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 01:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449410F0;
	Mon,  4 Dec 2023 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbDc3Wfn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B90A8
	for <linux-arch@vger.kernel.org>; Sun,  3 Dec 2023 17:55:57 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1eb39505ba4so1778658fac.0
        for <linux-arch@vger.kernel.org>; Sun, 03 Dec 2023 17:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701654957; x=1702259757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTtphEMr2OlDETtXEitijMD12offq4ozAysRuJ934w8=;
        b=RbDc3WfnEE2p0+/gtdBE5EAjq9k28W9MEACgB0x7E5XNMLeXXqzrUEBTNcJSC4NSvS
         68MbLXHZ0TMfwFH7nfTmOltyhxUOo5rQIo1orfFR9Y4PKmZnBGVKPVR4T52ByF/6z5W6
         ZUnn0BCo43tS8vtgxDOTkjeIZjYEC1X0bCV8jKsFFYVE/I3XQjJJpKOjvs5cU9cGnknU
         jkF3hGPza/xQMoYVqYmRDScXoA7XMFJEmFGLorjYsrCIhLPxahJFSGtbaDRCf9hVkXdy
         TygOztCEw6SU/nPX5m9yX1Qt19KPYTkbIEfPEg0vioJ9YICLGfYwGDPTVhr/KFSBgdgL
         G6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701654957; x=1702259757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTtphEMr2OlDETtXEitijMD12offq4ozAysRuJ934w8=;
        b=aBMXVgoXY+n4JcwcSf511FflP9/XbiJpbSr5UlXiurYhg3BnOUgPug2xvO/x1em4x5
         +SWkymdTL/cxgkfdTdc4QGHKmxtBRQGSgmvIWOV3hIidVJ4QDh6dVE/idHUd2+/9UOJF
         iXRgP64uxmr0H8otIhCxP3nBJyHRks3lDCmDTGlqcFik1NNELdb92Kbmr99yGAVeYB4i
         t1LZpkUsa95wAIZVNa1HIakBdO2cBUpA4BLB67xnrUH5OC/N1A74rsadK/LfAzbxqd9s
         eNaEVOXhZ+UeDW7k7wZxtEzlgZII6NMRBIxqL8t+mYHcYbAkEvjISJJ1BUCU/Z4hudSK
         rM/A==
X-Gm-Message-State: AOJu0Yw84+SKzuGfeMOs5jryonHIO+acSEhQ1P88Ijoq8WdvOL4c2kJT
	qwEore0P1M/cGK84K7j06OvqiiPOQSxITT0vj7M=
X-Google-Smtp-Source: AGHT+IFGMuLHH5DR8CZghBk+bXC7qM7qdDP2YnwN5e9enHQ4rHJYysrwBd+DIXA7KSOOmp11L3JsWQJsjMDCTIOVNm8=
X-Received: by 2002:a05:6870:3854:b0:1e9:f0fe:6ba4 with SMTP id
 z20-20020a056870385400b001e9f0fe6ba4mr5281807oal.11.1701654957049; Sun, 03
 Dec 2023 17:55:57 -0800 (PST)
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
 <CAEyhmHQQ3NqN1cZ1AfhUEbaswy6BWHCTjmUyncxdNUwQuCVOAA@mail.gmail.com> <CAAhV-H7p4i+EJj9hd3mRdTePjJ07zSwuBKNuCp66828UnLMGkA@mail.gmail.com>
In-Reply-To: <CAAhV-H7p4i+EJj9hd3mRdTePjJ07zSwuBKNuCp66828UnLMGkA@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 4 Dec 2023 09:55:46 +0800
Message-ID: <CAEyhmHQaAi3vV7e51DY_6MyYoTVZNd8gC22+K9CT_s6m+3Sk-Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, loongarch@lists.linux.dev, 
	kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 3, 2023 at 11:17=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Hengqi,
>
> On Thu, Nov 23, 2023 at 10:39=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.c=
om> wrote:
> >
> > On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >
> > > On Thu, Nov 23, 2023 at 4:09=E2=80=AFPM Hengqi Chen <hengqi.chen@gmai=
l.com> wrote:
> > > >
> > > > On Thu, Nov 23, 2023 at 2:13=E2=80=AFPM Huacai Chen <chenhuacai@ker=
nel.org> wrote:
> > > > >
> > > > > Hi, Hengqi,
> > > > >
> > > > > On Thu, Nov 23, 2023 at 1:49=E2=80=AFPM Hengqi Chen <hengqi.chen@=
gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 22, 2023 at 3:58=E2=80=AFPM Huacai Chen <chenhuacai=
@kernel.org> wrote:
> > > > > > >
> > > > > > > Hi, Hengqi,
> > > > > > >
> > > > > > > On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <hengqi.c=
hen@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi, Huacai,
> > > > > > > >
> > > > > > > > On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <chenhu=
acai@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi, Hengqi,
> > > > > > > > >
> > > > > > > > > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <heng=
qi.chen@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Currently, we store syscall number in pt_regs::regs[11]=
 and it may be
> > > > > > > > > > changed during syscall execution. Take `execve` as an e=
xample:
> > > > > > > > > >
> > > > > > > > > >     sys_execve
> > > > > > > > > >       -> do_execve
> > > > > > > > > >         -> do_execveat_common
> > > > > > > > > >           -> bprm_execve
> > > > > > > > > >             -> exec_binprm
> > > > > > > > > >               -> search_binary_handler
> > > > > > > > > >                 -> load_elf_binary
> > > > > > > > > >                   -> ELF_PLAT_INIT
> > > > > > > > > >
> > > > > > > > > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall_exi=
t_to_user_mode
> > > > > > > > > > we get a wrong syscall nr.
> > > > > > > > > >
> > > > > > > > > > Known affected syscalls includes execve/execveat/rt_sig=
return. Tools
> > > > > > > > > > like execsnoop do not work properly because the sys_exi=
t_* tracepoints
> > > > > > > > > > does not trigger at all.
> > > > > > > > > >
> > > > > > > > > > Let's store syscall nr in thread_info instead.
> > > > > > > > > Can we just modify ELF_PLAT_INIT and not clear regs[11]?
> > > > > > > > >
> > > > > > > >
> > > > > > > > I am uncertain about the side effects of changing ELF_PLAT_=
INIT.
> > > > > > > > From a completeness perspective, changing ELF_PLAT_INIT is =
suboptimal,
> > > > > > > > rt_sigreturn is affected in another code path, and there ma=
y be other
> > > > > > > > syscalls that I am unaware of.
> > > > > > > Save syscall number in thread_info has more side effects, bec=
ause
> > > > > > > ptrace allows us to change the number during syscall, then we=
 should
> > > > > > > keep consistency between syscall and regs[11].
> > > > > > >
> > > > > >
> > > > > > How about the change below:
> > > > > >
> > > > > > diff --git a/arch/loongarch/include/asm/syscall.h
> > > > > > b/arch/loongarch/include/asm/syscall.h
> > > > > > index e286dc58476e..954ba53bcc9a 100644
> > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > @@ -23,7 +23,9 @@ extern void *sys_call_table[];
> > > > > >  static inline long syscall_get_nr(struct task_struct *task,
> > > > > >                                   struct pt_regs *regs)
> > > > > >  {
> > > > > > -       return regs->regs[11];
> > > > > > +       long nr =3D task_thread_info(task)->syscall;
> > > > > > +
> > > > > > +       return nr ? : regs->regs[11];
> > > > > >  }
> > > > > >
> > > > > >  static inline void syscall_rollback(struct task_struct *task,
> > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/k=
ernel/syscall.c
> > > > > > index b4c5acd7aa3b..553ab0d624cb 100644
> > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > @@ -53,6 +53,7 @@ void noinstr do_syscall(struct pt_regs *regs)
> > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > >
> > > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > > > +       current_thread_info()->syscall =3D nr;
> > > > > >
> > > > > >         if (nr < NR_syscalls) {
> > > > > >                 syscall_fn =3D sys_call_table[nr];
> > > > > > @@ -61,4 +62,5 @@ void noinstr do_syscall(struct pt_regs *regs)
> > > > > >         }
> > > > > >
> > > > > >         syscall_exit_to_user_mode(regs);
> > > > > > +       current_thread_info()->syscall =3D 0;
> > > > > >  }
> > > > > >
> > > > > > * allow ptrace to change syscall nr
> > > > > > * sys_exit_* will also see the right syscall nr
> > > > > > * this works even if rt_sigreturn clobbers all pt_regs::regs
> > > > > No, I still prefer to modify ELF_PLAT_INIT, we can wait Arnd's co=
mments.
> > > > >
> > > >
> > > > OK, I am not eager, anyway, we know the root cause. :)
> > > >
> > > > > And, do you mean modifying ELF_PLAT_INIT cannot solve the
> > > > > rt_sigreturn's problem?
> > > > >
> > > >
> > > > Right, see https://elixir.bootlin.com/linux/latest/source/arch/loon=
garch/kernel/signal.c#L807
> > > Is this the expected behavior for rt_sigreturn()? Otherwise I think
> > > RISC-V has the same problem. And if we really need the 'correct'
> > > syscall number, we can overwrite regs[11] in sys_rt_sigreturn().
> > >
> >
> > I check with x86 and arm64, both have the same issue, seems no one care=
.
> Does the rt_sigreturn issue affect execsnoop?
>

No, execsnoop only relies on sys_enter_execve/sys_exit_execve.

> Huacai
>
> >
> > > And another question: do you have any updates about the BPF system
> > > hang problem? :)
> > >
> >
> > Let's discuss this on a new thread.
> >
> > > Huacai
> > >
> > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > > > And about ELF_PLAT_INIT, maybe Arnd can give us some more inf=
ormation.
> > > > > > >
> > > > > > > Hi, Arnd,
> > > > > > >
> > > > > > > I found some new architectures, such as ARM64 and RISC-V, jus=
t do
> > > > > > > nearly nothing in ELF_PLAT_INIT, while some old architectures=
, such as
> > > > > > > x86 and MIPS, clear most of the registers, do you know why?
> > > > > > >
> > > > > > > Huacai
> > > > > > >
> > > > > > > >
> > > > > > > > > Huacai
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Fixes: be769645a2aef ("LoongArch: Add system call suppo=
rt")
> > > > > > > > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > > > > > > > > >  arch/loongarch/kernel/syscall.c      | 1 +
> > > > > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/arch/loongarch/include/asm/syscall.h b/arc=
h/loongarch/include/asm/syscall.h
> > > > > > > > > > index e286dc58476e..2317d674b92a 100644
> > > > > > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > > > > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > > > > > > > > >  static inline long syscall_get_nr(struct task_struct *=
task,
> > > > > > > > > >                                   struct pt_regs *regs)
> > > > > > > > > >  {
> > > > > > > > > > -       return regs->regs[11];
> > > > > > > > > > +       return task_thread_info(task)->syscall;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  static inline void syscall_rollback(struct task_struct=
 *task,
> > > > > > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loo=
ngarch/kernel/syscall.c
> > > > > > > > > > index b4c5acd7aa3b..2783e33cf276 100644
> > > > > > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > > > > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt_reg=
s *regs)
> > > > > > > > > >         regs->orig_a0 =3D regs->regs[4];
> > > > > > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > > > > > >
> > > > > > > > > > +       task_thread_info(current)->syscall =3D nr;
> > > > > > > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > > > > > > >
> > > > > > > > > >         if (nr < NR_syscalls) {
> > > > > > > > > > --
> > > > > > > > > > 2.42.0
> > > > > > > > > >
> > > > > >
> >

