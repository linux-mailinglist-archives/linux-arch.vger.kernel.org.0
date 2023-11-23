Return-Path: <linux-arch+bounces-416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB887F57DF
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 06:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6991C20C66
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 05:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83EBA5E;
	Thu, 23 Nov 2023 05:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV0Sz0Jw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E92111F
	for <linux-arch@vger.kernel.org>; Wed, 22 Nov 2023 21:49:48 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f0f94a08a0so364343fac.2
        for <linux-arch@vger.kernel.org>; Wed, 22 Nov 2023 21:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700718588; x=1701323388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPfksV5844JHYEUobFng9V4vWZpitSP8AHiUCoJcjbU=;
        b=EV0Sz0JwTDkS2J1d2pXx47L6L64iAXnj1dtu0zewBvEDKjH+DwQ0WRutOR5u3KW15t
         lO7zDHChLpRPrjcgDg8Pd27FxTkc6yYPeuBuCBXo/qyxFLyf/sKgWv2kzj7N2kxSQNj7
         PugmuBJ/ERkVCEyEB8SycoEv3AERXK6/xhkKrWqQatVls0yZ0svpSTDFNusKl5Mse6Hs
         +fk3vhH9eS7HRKUgvq/Y9O7VYfO3y09I/LafXjSZbgmTMpVw5vS9/6wQBDXYW2dXeegB
         2xZHfyHYEOmsLpADuMRXCvNhRoseRA9vVb4sLUQ23ScHnE9Hb8EIhwCKYlW3oXLB/FZe
         9Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700718588; x=1701323388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPfksV5844JHYEUobFng9V4vWZpitSP8AHiUCoJcjbU=;
        b=RcG7u2HPSUVw5klu6LXbN54Oq6qsofvfqRpkDZtY9FmCW/v5+nQuScSofqHmwyDBOp
         zYlihZAevi/o3SYNYml2HKVqKMeW8RRZvEWwqxElYNuCAbJFsYXF7ebsQsQe5ZGG4pqB
         Urnw2kOpo1zK/WGUDyzbBg305DPKacys6bfQNUwsUUG7ox9N1/IhRgge1dhrcm+sPQoC
         EOTW+4ZXMc1SFI2eW5Djd0dWn7p5wBZhwksWdr6c/rS4L81fbd/A3LnBoDWZKz7PVyKW
         AVHvr+Wutj66dPGycoAjxszUYAhOtiXpNSWHtVn1kHhukgSTFntSY+CzuU4iPLsSnjkb
         ke0Q==
X-Gm-Message-State: AOJu0YxJgQDmuGpjaUOIHYrJPay4B3c221cRcGKlXrFuKNC4WOuoRrJc
	IqtivEbTMV/245gJ83TGuQxwTdiIFBHN9MZHP/tSLVKCnic6BA==
X-Google-Smtp-Source: AGHT+IFBUgMf8BkN7yIm4mC7gjITFkIXu7lXnbcu5HUA1DhlXMvJUADTew6Dcv4oLC4YSr/cYCa/qrk72ZRBJGbucjI=
X-Received: by 2002:a05:6870:3c87:b0:1f5:ccc2:b21e with SMTP id
 gl7-20020a0568703c8700b001f5ccc2b21emr6712288oab.41.1700718587763; Wed, 22
 Nov 2023 21:49:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121070209.210934-1-hengqi.chen@gmail.com>
 <CAAhV-H7SwSRDh8Ui2xVb1ncoaEQVd=dugphcBemkeaPNGQX2qw@mail.gmail.com>
 <CAEyhmHRYghT5iFiLByUmC=AjdygiBWU8TH3joSyyWibu0Ki2xw@mail.gmail.com> <CAAhV-H4Jr_a4j+Qnitd7ay9Vkcw5g0W_W3LNJwUzQ1BWXoGpoA@mail.gmail.com>
In-Reply-To: <CAAhV-H4Jr_a4j+Qnitd7ay9Vkcw5g0W_W3LNJwUzQ1BWXoGpoA@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 23 Nov 2023 13:49:36 +0800
Message-ID: <CAEyhmHRFZqH=4K8WUO6tPFd0NoWMHm_iLan+4EPiqovO03w1xw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, loongarch@lists.linux.dev, 
	kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 3:58=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Hengqi,
>
> On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > Hi, Huacai,
> >
> > On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >
> > > Hi, Hengqi,
> > >
> > > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <hengqi.chen@gmai=
l.com> wrote:
> > > >
> > > > Currently, we store syscall number in pt_regs::regs[11] and it may =
be
> > > > changed during syscall execution. Take `execve` as an example:
> > > >
> > > >     sys_execve
> > > >       -> do_execve
> > > >         -> do_execveat_common
> > > >           -> bprm_execve
> > > >             -> exec_binprm
> > > >               -> search_binary_handler
> > > >                 -> load_elf_binary
> > > >                   -> ELF_PLAT_INIT
> > > >
> > > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall_exit_to_user_mo=
de
> > > > we get a wrong syscall nr.
> > > >
> > > > Known affected syscalls includes execve/execveat/rt_sigreturn. Tool=
s
> > > > like execsnoop do not work properly because the sys_exit_* tracepoi=
nts
> > > > does not trigger at all.
> > > >
> > > > Let's store syscall nr in thread_info instead.
> > > Can we just modify ELF_PLAT_INIT and not clear regs[11]?
> > >
> >
> > I am uncertain about the side effects of changing ELF_PLAT_INIT.
> > From a completeness perspective, changing ELF_PLAT_INIT is suboptimal,
> > rt_sigreturn is affected in another code path, and there may be other
> > syscalls that I am unaware of.
> Save syscall number in thread_info has more side effects, because
> ptrace allows us to change the number during syscall, then we should
> keep consistency between syscall and regs[11].
>

How about the change below:

diff --git a/arch/loongarch/include/asm/syscall.h
b/arch/loongarch/include/asm/syscall.h
index e286dc58476e..954ba53bcc9a 100644
--- a/arch/loongarch/include/asm/syscall.h
+++ b/arch/loongarch/include/asm/syscall.h
@@ -23,7 +23,9 @@ extern void *sys_call_table[];
 static inline long syscall_get_nr(struct task_struct *task,
                                  struct pt_regs *regs)
 {
-       return regs->regs[11];
+       long nr =3D task_thread_info(task)->syscall;
+
+       return nr ? : regs->regs[11];
 }

 static inline void syscall_rollback(struct task_struct *task,
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscal=
l.c
index b4c5acd7aa3b..553ab0d624cb 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -53,6 +53,7 @@ void noinstr do_syscall(struct pt_regs *regs)
        regs->regs[4] =3D -ENOSYS;

        nr =3D syscall_enter_from_user_mode(regs, nr);
+       current_thread_info()->syscall =3D nr;

        if (nr < NR_syscalls) {
                syscall_fn =3D sys_call_table[nr];
@@ -61,4 +62,5 @@ void noinstr do_syscall(struct pt_regs *regs)
        }

        syscall_exit_to_user_mode(regs);
+       current_thread_info()->syscall =3D 0;
 }

* allow ptrace to change syscall nr
* sys_exit_* will also see the right syscall nr
* this works even if rt_sigreturn clobbers all pt_regs::regs

> And about ELF_PLAT_INIT, maybe Arnd can give us some more information.
>
> Hi, Arnd,
>
> I found some new architectures, such as ARM64 and RISC-V, just do
> nearly nothing in ELF_PLAT_INIT, while some old architectures, such as
> x86 and MIPS, clear most of the registers, do you know why?
>
> Huacai
>
> >
> > > Huacai
> > >
> > > >
> > > > Fixes: be769645a2aef ("LoongArch: Add system call support")
> > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > ---
> > > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > > >  arch/loongarch/kernel/syscall.c      | 1 +
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/=
include/asm/syscall.h
> > > > index e286dc58476e..2317d674b92a 100644
> > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > > >  static inline long syscall_get_nr(struct task_struct *task,
> > > >                                   struct pt_regs *regs)
> > > >  {
> > > > -       return regs->regs[11];
> > > > +       return task_thread_info(task)->syscall;
> > > >  }
> > > >
> > > >  static inline void syscall_rollback(struct task_struct *task,
> > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kerne=
l/syscall.c
> > > > index b4c5acd7aa3b..2783e33cf276 100644
> > > > --- a/arch/loongarch/kernel/syscall.c
> > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt_regs *regs)
> > > >         regs->orig_a0 =3D regs->regs[4];
> > > >         regs->regs[4] =3D -ENOSYS;
> > > >
> > > > +       task_thread_info(current)->syscall =3D nr;
> > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > >
> > > >         if (nr < NR_syscalls) {
> > > > --
> > > > 2.42.0
> > > >

