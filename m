Return-Path: <linux-arch+bounces-624-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5DB802B5E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 06:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92642B208FE
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 05:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1185395;
	Mon,  4 Dec 2023 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haJDQOiK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D14D7
	for <linux-arch@vger.kernel.org>; Sun,  3 Dec 2023 21:39:16 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1f5bd86ceb3so2276790fac.2
        for <linux-arch@vger.kernel.org>; Sun, 03 Dec 2023 21:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701668356; x=1702273156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzffWY0Qh0/s99exfuVeWazGuIACU930yeiyIGIc0mU=;
        b=haJDQOiKIxUQM3rdLZ1uS5ZPf/9GC7ESSuAG+CLyAuqdp5OJwZaGd+fDo1TlkAyGXC
         eRKs3+B76EGd7swh+10NJHHijth8q64ZmuswDmkFZtpt7RD7LYPNEHGD2dj3V/9P+kMI
         sBFNReHF4jS1u0Pr94MzW6KvznudlUZw8bBYemWT/KAfxRNXw32woUAq1ttGrDoNe2hx
         vyH9nJMkOVacbg0WJ39S6VrfutiZBmJxzMe6c4Xnq7sgzvjahnkb9pPB5XAc8KAEAl+E
         HMfXHs8uScOjoPQHXF2o74RIS6k71Ado4hSSIGRNHJ2adR/XC5K5mkXUXQd3G79bEz+i
         1/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701668356; x=1702273156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzffWY0Qh0/s99exfuVeWazGuIACU930yeiyIGIc0mU=;
        b=ggU2yzYhjZNzJlcZx+N3OsDTYD2wlkrWXIrBhRtDu6kMDw3r4gaChfY1Z9BKq9sXwi
         EC5MAX70q7ufIkbExWflFtbqwDkuCZoG+Z0jJBtGW1KMG3eCroU0lueF7UfkJt/IwbJQ
         8dpG8Jz0DkT+658+Rjx9vOQbcu7albZU9E7pYSJ8xnMcqkGMU8ig/cy4WzGQAapI74b1
         fEVmD0A7mFmhZTqnTIdJDVYAyHuzcv+yaFx1y/b9cFBwfh5AsVxnW9SLX3Xu/WDC8D5u
         ZWQXrq/YABz/fyWyi16ofLyWydTXBptmU2tI2eFFjE5jMec5atZbvdim0IRS2vrO+00R
         qNeg==
X-Gm-Message-State: AOJu0Ywy/geu7tEP0YjFxyPmStbYF01EHy9fyPi/qSih2qVXQGY6Ay21
	ecvGwj+dgyXb+XTZHu1bzZ8kRQagE/FJir0V3mJvao3DsaE=
X-Google-Smtp-Source: AGHT+IHZ1X6hGT1/uCYDlxZs/PZTVrVLH5t0w5O1xvjF2DjSZOln8rml84S4kjAEZhJAbWqDinCbYdrrHXoc7zujHwM=
X-Received: by 2002:a05:6871:5385:b0:1fb:51e:bc17 with SMTP id
 hy5-20020a056871538500b001fb051ebc17mr4219663oac.30.1701668355906; Sun, 03
 Dec 2023 21:39:15 -0800 (PST)
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
 <CAAhV-H7p4i+EJj9hd3mRdTePjJ07zSwuBKNuCp66828UnLMGkA@mail.gmail.com>
 <CAEyhmHQaAi3vV7e51DY_6MyYoTVZNd8gC22+K9CT_s6m+3Sk-Q@mail.gmail.com> <CAAhV-H5cTH+=1KGPXV3n3sSTdz1-ANQ0c9nHy7+RzWVq=b4TiA@mail.gmail.com>
In-Reply-To: <CAAhV-H5cTH+=1KGPXV3n3sSTdz1-ANQ0c9nHy7+RzWVq=b4TiA@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 4 Dec 2023 13:39:04 +0800
Message-ID: <CAEyhmHRBKHYsreFv987UHMm1geR3d3dOpjZ1uKJmeO9geWK5jw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, loongarch@lists.linux.dev, 
	kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Huacai,

Thanks for the suggestion, just send the fix.

Cheers,
---
Hengqi

On Mon, Dec 4, 2023 at 10:17=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Hengqi,
>
> On Mon, Dec 4, 2023 at 9:56=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
> >
> > On Sun, Dec 3, 2023 at 11:17=E2=80=AFAM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >
> > > Hi, Hengqi,
> > >
> > > On Thu, Nov 23, 2023 at 10:39=E2=80=AFPM Hengqi Chen <hengqi.chen@gma=
il.com> wrote:
> > > >
> > > > On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Huacai Chen <chenhuacai@ker=
nel.org> wrote:
> > > > >
> > > > > On Thu, Nov 23, 2023 at 4:09=E2=80=AFPM Hengqi Chen <hengqi.chen@=
gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 23, 2023 at 2:13=E2=80=AFPM Huacai Chen <chenhuacai=
@kernel.org> wrote:
> > > > > > >
> > > > > > > Hi, Hengqi,
> > > > > > >
> > > > > > > On Thu, Nov 23, 2023 at 1:49=E2=80=AFPM Hengqi Chen <hengqi.c=
hen@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Nov 22, 2023 at 3:58=E2=80=AFPM Huacai Chen <chenhu=
acai@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi, Hengqi,
> > > > > > > > >
> > > > > > > > > On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <heng=
qi.chen@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi, Huacai,
> > > > > > > > > >
> > > > > > > > > > On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <ch=
enhuacai@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi, Hengqi,
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <=
hengqi.chen@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Currently, we store syscall number in pt_regs::regs=
[11] and it may be
> > > > > > > > > > > > changed during syscall execution. Take `execve` as =
an example:
> > > > > > > > > > > >
> > > > > > > > > > > >     sys_execve
> > > > > > > > > > > >       -> do_execve
> > > > > > > > > > > >         -> do_execveat_common
> > > > > > > > > > > >           -> bprm_execve
> > > > > > > > > > > >             -> exec_binprm
> > > > > > > > > > > >               -> search_binary_handler
> > > > > > > > > > > >                 -> load_elf_binary
> > > > > > > > > > > >                   -> ELF_PLAT_INIT
> > > > > > > > > > > >
> > > > > > > > > > > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall=
_exit_to_user_mode
> > > > > > > > > > > > we get a wrong syscall nr.
> > > > > > > > > > > >
> > > > > > > > > > > > Known affected syscalls includes execve/execveat/rt=
_sigreturn. Tools
> > > > > > > > > > > > like execsnoop do not work properly because the sys=
_exit_* tracepoints
> > > > > > > > > > > > does not trigger at all.
> > > > > > > > > > > >
> > > > > > > > > > > > Let's store syscall nr in thread_info instead.
> > > > > > > > > > > Can we just modify ELF_PLAT_INIT and not clear regs[1=
1]?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I am uncertain about the side effects of changing ELF_P=
LAT_INIT.
> > > > > > > > > > From a completeness perspective, changing ELF_PLAT_INIT=
 is suboptimal,
> > > > > > > > > > rt_sigreturn is affected in another code path, and ther=
e may be other
> > > > > > > > > > syscalls that I am unaware of.
> > > > > > > > > Save syscall number in thread_info has more side effects,=
 because
> > > > > > > > > ptrace allows us to change the number during syscall, the=
n we should
> > > > > > > > > keep consistency between syscall and regs[11].
> > > > > > > > >
> > > > > > > >
> > > > > > > > How about the change below:
> > > > > > > >
> > > > > > > > diff --git a/arch/loongarch/include/asm/syscall.h
> > > > > > > > b/arch/loongarch/include/asm/syscall.h
> > > > > > > > index e286dc58476e..954ba53bcc9a 100644
> > > > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > > > @@ -23,7 +23,9 @@ extern void *sys_call_table[];
> > > > > > > >  static inline long syscall_get_nr(struct task_struct *task=
,
> > > > > > > >                                   struct pt_regs *regs)
> > > > > > > >  {
> > > > > > > > -       return regs->regs[11];
> > > > > > > > +       long nr =3D task_thread_info(task)->syscall;
> > > > > > > > +
> > > > > > > > +       return nr ? : regs->regs[11];
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static inline void syscall_rollback(struct task_struct *ta=
sk,
> > > > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongar=
ch/kernel/syscall.c
> > > > > > > > index b4c5acd7aa3b..553ab0d624cb 100644
> > > > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > > > @@ -53,6 +53,7 @@ void noinstr do_syscall(struct pt_regs *r=
egs)
> > > > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > > > >
> > > > > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > > > > > +       current_thread_info()->syscall =3D nr;
> > > > > > > >
> > > > > > > >         if (nr < NR_syscalls) {
> > > > > > > >                 syscall_fn =3D sys_call_table[nr];
> > > > > > > > @@ -61,4 +62,5 @@ void noinstr do_syscall(struct pt_regs *r=
egs)
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         syscall_exit_to_user_mode(regs);
> > > > > > > > +       current_thread_info()->syscall =3D 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > * allow ptrace to change syscall nr
> > > > > > > > * sys_exit_* will also see the right syscall nr
> > > > > > > > * this works even if rt_sigreturn clobbers all pt_regs::reg=
s
> > > > > > > No, I still prefer to modify ELF_PLAT_INIT, we can wait Arnd'=
s comments.
> > > > > > >
> > > > > >
> > > > > > OK, I am not eager, anyway, we know the root cause. :)
> > > > > >
> > > > > > > And, do you mean modifying ELF_PLAT_INIT cannot solve the
> > > > > > > rt_sigreturn's problem?
> > > > > > >
> > > > > >
> > > > > > Right, see https://elixir.bootlin.com/linux/latest/source/arch/=
loongarch/kernel/signal.c#L807
> > > > > Is this the expected behavior for rt_sigreturn()? Otherwise I thi=
nk
> > > > > RISC-V has the same problem. And if we really need the 'correct'
> > > > > syscall number, we can overwrite regs[11] in sys_rt_sigreturn().
> > > > >
> > > >
> > > > I check with x86 and arm64, both have the same issue, seems no one =
care.
> > > Does the rt_sigreturn issue affect execsnoop?
> > >
> >
> > No, execsnoop only relies on sys_enter_execve/sys_exit_execve.
> Then I suggest the below one line patch, though Arnd still no
> response, I believe it has no side effect (because ARM64 and RISC-V
> clear nothing here):
>
> diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/as=
m/elf.h
> index b9a4ab54285c..45a2a2f7a27f 100644
> --- a/arch/loongarch/include/asm/elf.h
> +++ b/arch/loongarch/include/asm/elf.h
> @@ -293,7 +293,7 @@ extern const char *__elf_platform;
>  #define ELF_PLAT_INIT(_r, load_addr)   do { \
>         _r->regs[1] =3D _r->regs[2] =3D _r->regs[3] =3D _r->regs[4] =3D 0=
;      \
>         _r->regs[5] =3D _r->regs[6] =3D _r->regs[7] =3D _r->regs[8] =3D 0=
;      \
> -       _r->regs[9] =3D _r->regs[10] =3D _r->regs[11] =3D _r->regs[12] =
=3D 0;   \
> +       _r->regs[9] =3D _r->regs[10] =3D /* syscall */ =3D _r->regs[12] =
=3D 0;  \
>         _r->regs[13] =3D _r->regs[14] =3D _r->regs[15] =3D _r->regs[16] =
=3D 0;  \
>         _r->regs[17] =3D _r->regs[18] =3D _r->regs[19] =3D _r->regs[20] =
=3D 0;  \
>         _r->regs[21] =3D _r->regs[22] =3D _r->regs[23] =3D _r->regs[24] =
=3D 0;  \
>
> >
> > > Huacai
> > >
> > > >
> > > > > And another question: do you have any updates about the BPF syste=
m
> > > > > hang problem? :)
> > > > >
> > > >
> > > > Let's discuss this on a new thread.
> > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > > > Huacai
> > > > > > >
> > > > > > > >
> > > > > > > > > And about ELF_PLAT_INIT, maybe Arnd can give us some more=
 information.
> > > > > > > > >
> > > > > > > > > Hi, Arnd,
> > > > > > > > >
> > > > > > > > > I found some new architectures, such as ARM64 and RISC-V,=
 just do
> > > > > > > > > nearly nothing in ELF_PLAT_INIT, while some old architect=
ures, such as
> > > > > > > > > x86 and MIPS, clear most of the registers, do you know wh=
y?
> > > > > > > > >
> > > > > > > > > Huacai
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > Huacai
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Fixes: be769645a2aef ("LoongArch: Add system call s=
upport")
> > > > > > > > > > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > > > > > > > > > > >  arch/loongarch/kernel/syscall.c      | 1 +
> > > > > > > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/arch/loongarch/include/asm/syscall.h b=
/arch/loongarch/include/asm/syscall.h
> > > > > > > > > > > > index e286dc58476e..2317d674b92a 100644
> > > > > > > > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > > > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > > > > > > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > > > > > > > > > > >  static inline long syscall_get_nr(struct task_stru=
ct *task,
> > > > > > > > > > > >                                   struct pt_regs *r=
egs)
> > > > > > > > > > > >  {
> > > > > > > > > > > > -       return regs->regs[11];
> > > > > > > > > > > > +       return task_thread_info(task)->syscall;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > >  static inline void syscall_rollback(struct task_st=
ruct *task,
> > > > > > > > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch=
/loongarch/kernel/syscall.c
> > > > > > > > > > > > index b4c5acd7aa3b..2783e33cf276 100644
> > > > > > > > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > > > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > > > > > > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt=
_regs *regs)
> > > > > > > > > > > >         regs->orig_a0 =3D regs->regs[4];
> > > > > > > > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > > > > > > > >
> > > > > > > > > > > > +       task_thread_info(current)->syscall =3D nr;
> > > > > > > > > > > >         nr =3D syscall_enter_from_user_mode(regs, n=
r);
> > > > > > > > > > > >
> > > > > > > > > > > >         if (nr < NR_syscalls) {
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.42.0
> > > > > > > > > > > >
> > > > > > > >
> > > >

