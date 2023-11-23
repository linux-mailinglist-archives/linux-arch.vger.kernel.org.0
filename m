Return-Path: <linux-arch+bounces-418-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D47F59CC
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 09:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD33B20CBC
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65E318C0D;
	Thu, 23 Nov 2023 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It2OIhW4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBEAD42
	for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 00:09:08 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1f5da5df68eso393209fac.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 00:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700726948; x=1701331748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0szatL0xZvKs47aY/qd9ecf/D+vAjtd16GgCqHGEZA=;
        b=It2OIhW4X9WCBjZaEXV6nfQqY7OOL9Pv8LuMImvFbUGvkh0l9Ivu+8PrjsdQjiYzZE
         ZZ7ANwdoMr8dDZuXyG6K8vV48whn/hl+QWvkDhKDlZZY+1kSG9vE0SVYBnXgzjqWIVag
         DCQ+sq2dk8VNXgH+lVfXFDf3EJ+/D8xhrARMgo/nZxzFNZxrfE09hah8ZfZVC33oTNln
         HuzqatYQRmn9urgYxzrgDEbyXuthVGD+8nDE5JBBHAtVEJpmj4SyOPeZjcs7kQV6f/Zq
         rNugmcTPrh32l2lafNXYr2zR2+x9HSnaI+WPsnUyvwrvFJCMiO1n7mnneC0fWBUxyWov
         nf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700726948; x=1701331748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0szatL0xZvKs47aY/qd9ecf/D+vAjtd16GgCqHGEZA=;
        b=cqy2nhXtYrP1bOGXkt2Nty9o71amDlcbaMVYK1ruhRUjJufrp4om0GfH5AoYttB91F
         1SbxEPwnIa5XpDqAuUs1zb3ocLqHm+VpOEtLp1hlmoSMslp7TfiWS3/93LI5+XcOYfve
         JtiMxCcp7aoSr2MFpWUOtm1XPLEc/JLBlQKUjAWwdS+4neQXCCtRcoJu+UO61MI5GlS4
         5rNz7+CFzLEIi71jFvoTXVvM9DhPQar07K2SjCfpiRrQiTG3o/vEAG8eQ5cjat0cCdA2
         eJUbGZVRgRIVhrICntxe+XjACrmsqiRWVp96cPWLK0G9ZtCX+awqQXprQtsWapugXQE8
         rt6A==
X-Gm-Message-State: AOJu0YytpV/pWHZWDLyQ0VOd7l9uyJOA/aafHmIaLhgAvIanpFRn2qTe
	U3zDcJlO1SzuBKljPXTRLCJ6Qae0uKZnupkV0dYQdcjUnzfp7Q==
X-Google-Smtp-Source: AGHT+IEEuZcm3JAX9xQwWLvG+tcu3/Nk4NfFRTPLi7EhxCFUq+aXTyLy83VrmnESCMzUfwf2Dfd6MrMwyzGkUEWu3yc=
X-Received: by 2002:a05:6870:7a18:b0:1f9:77fe:7977 with SMTP id
 hf24-20020a0568707a1800b001f977fe7977mr6461844oab.13.1700726947876; Thu, 23
 Nov 2023 00:09:07 -0800 (PST)
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
 <CAEyhmHRFZqH=4K8WUO6tPFd0NoWMHm_iLan+4EPiqovO03w1xw@mail.gmail.com> <CAAhV-H53YNH_trJmgcp-=PjdTSXuyzvmxWVaeUg++yYiXd=1Kg@mail.gmail.com>
In-Reply-To: <CAAhV-H53YNH_trJmgcp-=PjdTSXuyzvmxWVaeUg++yYiXd=1Kg@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 23 Nov 2023 16:08:56 +0800
Message-ID: <CAEyhmHSPwjWQ=KJKskQHTjNKfMV3WG6r8sHihqtbBsZeKUQzUg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, loongarch@lists.linux.dev, 
	kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 2:13=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Hengqi,
>
> On Thu, Nov 23, 2023 at 1:49=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > On Wed, Nov 22, 2023 at 3:58=E2=80=AFPM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >
> > > Hi, Hengqi,
> > >
> > > On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <hengqi.chen@gmai=
l.com> wrote:
> > > >
> > > > Hi, Huacai,
> > > >
> > > > On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <chenhuacai@ker=
nel.org> wrote:
> > > > >
> > > > > Hi, Hengqi,
> > > > >
> > > > > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <hengqi.chen@=
gmail.com> wrote:
> > > > > >
> > > > > > Currently, we store syscall number in pt_regs::regs[11] and it =
may be
> > > > > > changed during syscall execution. Take `execve` as an example:
> > > > > >
> > > > > >     sys_execve
> > > > > >       -> do_execve
> > > > > >         -> do_execveat_common
> > > > > >           -> bprm_execve
> > > > > >             -> exec_binprm
> > > > > >               -> search_binary_handler
> > > > > >                 -> load_elf_binary
> > > > > >                   -> ELF_PLAT_INIT
> > > > > >
> > > > > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall_exit_to_use=
r_mode
> > > > > > we get a wrong syscall nr.
> > > > > >
> > > > > > Known affected syscalls includes execve/execveat/rt_sigreturn. =
Tools
> > > > > > like execsnoop do not work properly because the sys_exit_* trac=
epoints
> > > > > > does not trigger at all.
> > > > > >
> > > > > > Let's store syscall nr in thread_info instead.
> > > > > Can we just modify ELF_PLAT_INIT and not clear regs[11]?
> > > > >
> > > >
> > > > I am uncertain about the side effects of changing ELF_PLAT_INIT.
> > > > From a completeness perspective, changing ELF_PLAT_INIT is suboptim=
al,
> > > > rt_sigreturn is affected in another code path, and there may be oth=
er
> > > > syscalls that I am unaware of.
> > > Save syscall number in thread_info has more side effects, because
> > > ptrace allows us to change the number during syscall, then we should
> > > keep consistency between syscall and regs[11].
> > >
> >
> > How about the change below:
> >
> > diff --git a/arch/loongarch/include/asm/syscall.h
> > b/arch/loongarch/include/asm/syscall.h
> > index e286dc58476e..954ba53bcc9a 100644
> > --- a/arch/loongarch/include/asm/syscall.h
> > +++ b/arch/loongarch/include/asm/syscall.h
> > @@ -23,7 +23,9 @@ extern void *sys_call_table[];
> >  static inline long syscall_get_nr(struct task_struct *task,
> >                                   struct pt_regs *regs)
> >  {
> > -       return regs->regs[11];
> > +       long nr =3D task_thread_info(task)->syscall;
> > +
> > +       return nr ? : regs->regs[11];
> >  }
> >
> >  static inline void syscall_rollback(struct task_struct *task,
> > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/sy=
scall.c
> > index b4c5acd7aa3b..553ab0d624cb 100644
> > --- a/arch/loongarch/kernel/syscall.c
> > +++ b/arch/loongarch/kernel/syscall.c
> > @@ -53,6 +53,7 @@ void noinstr do_syscall(struct pt_regs *regs)
> >         regs->regs[4] =3D -ENOSYS;
> >
> >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > +       current_thread_info()->syscall =3D nr;
> >
> >         if (nr < NR_syscalls) {
> >                 syscall_fn =3D sys_call_table[nr];
> > @@ -61,4 +62,5 @@ void noinstr do_syscall(struct pt_regs *regs)
> >         }
> >
> >         syscall_exit_to_user_mode(regs);
> > +       current_thread_info()->syscall =3D 0;
> >  }
> >
> > * allow ptrace to change syscall nr
> > * sys_exit_* will also see the right syscall nr
> > * this works even if rt_sigreturn clobbers all pt_regs::regs
> No, I still prefer to modify ELF_PLAT_INIT, we can wait Arnd's comments.
>

OK, I am not eager, anyway, we know the root cause. :)

> And, do you mean modifying ELF_PLAT_INIT cannot solve the
> rt_sigreturn's problem?
>

Right, see https://elixir.bootlin.com/linux/latest/source/arch/loongarch/ke=
rnel/signal.c#L807

> Huacai
>
> >
> > > And about ELF_PLAT_INIT, maybe Arnd can give us some more information=
.
> > >
> > > Hi, Arnd,
> > >
> > > I found some new architectures, such as ARM64 and RISC-V, just do
> > > nearly nothing in ELF_PLAT_INIT, while some old architectures, such a=
s
> > > x86 and MIPS, clear most of the registers, do you know why?
> > >
> > > Huacai
> > >
> > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > > Fixes: be769645a2aef ("LoongArch: Add system call support")
> > > > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > > > ---
> > > > > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > > > > >  arch/loongarch/kernel/syscall.c      | 1 +
> > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loonga=
rch/include/asm/syscall.h
> > > > > > index e286dc58476e..2317d674b92a 100644
> > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > > > > >  static inline long syscall_get_nr(struct task_struct *task,
> > > > > >                                   struct pt_regs *regs)
> > > > > >  {
> > > > > > -       return regs->regs[11];
> > > > > > +       return task_thread_info(task)->syscall;
> > > > > >  }
> > > > > >
> > > > > >  static inline void syscall_rollback(struct task_struct *task,
> > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/k=
ernel/syscall.c
> > > > > > index b4c5acd7aa3b..2783e33cf276 100644
> > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt_regs *regs)
> > > > > >         regs->orig_a0 =3D regs->regs[4];
> > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > >
> > > > > > +       task_thread_info(current)->syscall =3D nr;
> > > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > > >
> > > > > >         if (nr < NR_syscalls) {
> > > > > > --
> > > > > > 2.42.0
> > > > > >
> >

