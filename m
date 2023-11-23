Return-Path: <linux-arch+bounces-427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC57F61AA
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427951F20EF4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Nov 2023 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E1B2FC53;
	Thu, 23 Nov 2023 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcC0N4IO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3BB1BF
	for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 06:39:53 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b83c4c5aefso584371b6e.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Nov 2023 06:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700750393; x=1701355193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9X9uhF8OSYthUzmtslwmdEtCWgAjbVmdLteT4Uwcqw=;
        b=gcC0N4IOapVBuhY1vhizy4Em4MbB5dzNprILAbgeOwuyR8PrAUfsID1mfpphKzCCQh
         SUl+Ep9jTMKkJqbK3U6aXBr8L5tY9RUnaxATcCpll+ohk/7I44crtzxwV4TpyzP7ViAv
         rlKvgHc8GUpEbuQYa+ZBrFc1Oz28GC3I5QvRkabIMxq8E/1tfe36Re5+uNLK1WsplI1u
         9idnkBpWcVYvwLFEeOJ2Di4UAd2NTze8SmIHgHzpNOGpeNtFWlmsN6T9sVuUWiOHf0la
         5oORQ/LW8Mg8CSoCleXaAMjH7AOlOhZvI4eeibYkmN5Jkt5jNJSyZGtrdtgA6PGsNMdF
         fKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700750393; x=1701355193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9X9uhF8OSYthUzmtslwmdEtCWgAjbVmdLteT4Uwcqw=;
        b=RSITZRWU//UnuxiEPRa/pEuGPzYDk/0+EpDan6Cbm265QM63AHHqvAendcn6bgiHzD
         mpPJYut6Iam5Qr5Vnulc+s3fe7alFMmhndDMGVM62o+Wog23u6p6UyYHaBRoEj55aj+C
         e5Z9advAwvWf1jTXQGjcdTJkSI2OnjoJ65VUidokDZjohlohuclQcifRgGAXp9r/4OGl
         Ub6OuZDwfDTn1obJ4Re7LxCcSVIIMs8U8coSt6anfVdupZHTKXFhr9PhZPTBEyQyTy53
         GXXiq8z5ipcj2kqewySOwUeeqho0n0M0wpvGoHBFhgqEB+qzI8vPuOkogOFROAgHQ9pj
         Chhg==
X-Gm-Message-State: AOJu0Ywe+aCcFGfr0glPAgEMRoLNkh4dHJg2HSObjbGIExy6/96up2a7
	JLCIYqPZH/ifih+KxAeOO50/TzNB1NQH1oZWt7T+r/sR7MM=
X-Google-Smtp-Source: AGHT+IH8jQ4PDRhyeRzH9DiB0Z37O/a9ZpRgM1avWuvGR7ryKm8yIgJ/zLL8p7eNT59Vvn3rDOCukib9uQWFrJcqetA=
X-Received: by 2002:a05:6870:9b0c:b0:1e9:af81:54b6 with SMTP id
 hq12-20020a0568709b0c00b001e9af8154b6mr7149706oab.55.1700750393048; Thu, 23
 Nov 2023 06:39:53 -0800 (PST)
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
 <CAEyhmHSPwjWQ=KJKskQHTjNKfMV3WG6r8sHihqtbBsZeKUQzUg@mail.gmail.com> <CAAhV-H6xtawO3kMtJtzMAbGELTO=RieY3B2mM77Uk8rB73Ppqw@mail.gmail.com>
In-Reply-To: <CAAhV-H6xtawO3kMtJtzMAbGELTO=RieY3B2mM77Uk8rB73Ppqw@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 23 Nov 2023 22:39:41 +0800
Message-ID: <CAEyhmHQQ3NqN1cZ1AfhUEbaswy6BWHCTjmUyncxdNUwQuCVOAA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Store syscall nr in thread_info
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, loongarch@lists.linux.dev, 
	kernel@xen0n.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> On Thu, Nov 23, 2023 at 4:09=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > On Thu, Nov 23, 2023 at 2:13=E2=80=AFPM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >
> > > Hi, Hengqi,
> > >
> > > On Thu, Nov 23, 2023 at 1:49=E2=80=AFPM Hengqi Chen <hengqi.chen@gmai=
l.com> wrote:
> > > >
> > > > On Wed, Nov 22, 2023 at 3:58=E2=80=AFPM Huacai Chen <chenhuacai@ker=
nel.org> wrote:
> > > > >
> > > > > Hi, Hengqi,
> > > > >
> > > > > On Wed, Nov 22, 2023 at 3:34=E2=80=AFPM Hengqi Chen <hengqi.chen@=
gmail.com> wrote:
> > > > > >
> > > > > > Hi, Huacai,
> > > > > >
> > > > > > On Wed, Nov 22, 2023 at 2:32=E2=80=AFPM Huacai Chen <chenhuacai=
@kernel.org> wrote:
> > > > > > >
> > > > > > > Hi, Hengqi,
> > > > > > >
> > > > > > > On Wed, Nov 22, 2023 at 1:14=E2=80=AFPM Hengqi Chen <hengqi.c=
hen@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Currently, we store syscall number in pt_regs::regs[11] and=
 it may be
> > > > > > > > changed during syscall execution. Take `execve` as an examp=
le:
> > > > > > > >
> > > > > > > >     sys_execve
> > > > > > > >       -> do_execve
> > > > > > > >         -> do_execveat_common
> > > > > > > >           -> bprm_execve
> > > > > > > >             -> exec_binprm
> > > > > > > >               -> search_binary_handler
> > > > > > > >                 -> load_elf_binary
> > > > > > > >                   -> ELF_PLAT_INIT
> > > > > > > >
> > > > > > > > ELF_PLAT_INIT reset regs[11] to 0, later in syscall_exit_to=
_user_mode
> > > > > > > > we get a wrong syscall nr.
> > > > > > > >
> > > > > > > > Known affected syscalls includes execve/execveat/rt_sigretu=
rn. Tools
> > > > > > > > like execsnoop do not work properly because the sys_exit_* =
tracepoints
> > > > > > > > does not trigger at all.
> > > > > > > >
> > > > > > > > Let's store syscall nr in thread_info instead.
> > > > > > > Can we just modify ELF_PLAT_INIT and not clear regs[11]?
> > > > > > >
> > > > > >
> > > > > > I am uncertain about the side effects of changing ELF_PLAT_INIT=
.
> > > > > > From a completeness perspective, changing ELF_PLAT_INIT is subo=
ptimal,
> > > > > > rt_sigreturn is affected in another code path, and there may be=
 other
> > > > > > syscalls that I am unaware of.
> > > > > Save syscall number in thread_info has more side effects, because
> > > > > ptrace allows us to change the number during syscall, then we sho=
uld
> > > > > keep consistency between syscall and regs[11].
> > > > >
> > > >
> > > > How about the change below:
> > > >
> > > > diff --git a/arch/loongarch/include/asm/syscall.h
> > > > b/arch/loongarch/include/asm/syscall.h
> > > > index e286dc58476e..954ba53bcc9a 100644
> > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > @@ -23,7 +23,9 @@ extern void *sys_call_table[];
> > > >  static inline long syscall_get_nr(struct task_struct *task,
> > > >                                   struct pt_regs *regs)
> > > >  {
> > > > -       return regs->regs[11];
> > > > +       long nr =3D task_thread_info(task)->syscall;
> > > > +
> > > > +       return nr ? : regs->regs[11];
> > > >  }
> > > >
> > > >  static inline void syscall_rollback(struct task_struct *task,
> > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kerne=
l/syscall.c
> > > > index b4c5acd7aa3b..553ab0d624cb 100644
> > > > --- a/arch/loongarch/kernel/syscall.c
> > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > @@ -53,6 +53,7 @@ void noinstr do_syscall(struct pt_regs *regs)
> > > >         regs->regs[4] =3D -ENOSYS;
> > > >
> > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > +       current_thread_info()->syscall =3D nr;
> > > >
> > > >         if (nr < NR_syscalls) {
> > > >                 syscall_fn =3D sys_call_table[nr];
> > > > @@ -61,4 +62,5 @@ void noinstr do_syscall(struct pt_regs *regs)
> > > >         }
> > > >
> > > >         syscall_exit_to_user_mode(regs);
> > > > +       current_thread_info()->syscall =3D 0;
> > > >  }
> > > >
> > > > * allow ptrace to change syscall nr
> > > > * sys_exit_* will also see the right syscall nr
> > > > * this works even if rt_sigreturn clobbers all pt_regs::regs
> > > No, I still prefer to modify ELF_PLAT_INIT, we can wait Arnd's commen=
ts.
> > >
> >
> > OK, I am not eager, anyway, we know the root cause. :)
> >
> > > And, do you mean modifying ELF_PLAT_INIT cannot solve the
> > > rt_sigreturn's problem?
> > >
> >
> > Right, see https://elixir.bootlin.com/linux/latest/source/arch/loongarc=
h/kernel/signal.c#L807
> Is this the expected behavior for rt_sigreturn()? Otherwise I think
> RISC-V has the same problem. And if we really need the 'correct'
> syscall number, we can overwrite regs[11] in sys_rt_sigreturn().
>

I check with x86 and arm64, both have the same issue, seems no one care.

> And another question: do you have any updates about the BPF system
> hang problem? :)
>

Let's discuss this on a new thread.

> Huacai
>
> >
> > > Huacai
> > >
> > > >
> > > > > And about ELF_PLAT_INIT, maybe Arnd can give us some more informa=
tion.
> > > > >
> > > > > Hi, Arnd,
> > > > >
> > > > > I found some new architectures, such as ARM64 and RISC-V, just do
> > > > > nearly nothing in ELF_PLAT_INIT, while some old architectures, su=
ch as
> > > > > x86 and MIPS, clear most of the registers, do you know why?
> > > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > > > Huacai
> > > > > > >
> > > > > > > >
> > > > > > > > Fixes: be769645a2aef ("LoongArch: Add system call support")
> > > > > > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > > > > > ---
> > > > > > > >  arch/loongarch/include/asm/syscall.h | 2 +-
> > > > > > > >  arch/loongarch/kernel/syscall.c      | 1 +
> > > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/arch/loongarch/include/asm/syscall.h b/arch/lo=
ongarch/include/asm/syscall.h
> > > > > > > > index e286dc58476e..2317d674b92a 100644
> > > > > > > > --- a/arch/loongarch/include/asm/syscall.h
> > > > > > > > +++ b/arch/loongarch/include/asm/syscall.h
> > > > > > > > @@ -23,7 +23,7 @@ extern void *sys_call_table[];
> > > > > > > >  static inline long syscall_get_nr(struct task_struct *task=
,
> > > > > > > >                                   struct pt_regs *regs)
> > > > > > > >  {
> > > > > > > > -       return regs->regs[11];
> > > > > > > > +       return task_thread_info(task)->syscall;
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static inline void syscall_rollback(struct task_struct *ta=
sk,
> > > > > > > > diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongar=
ch/kernel/syscall.c
> > > > > > > > index b4c5acd7aa3b..2783e33cf276 100644
> > > > > > > > --- a/arch/loongarch/kernel/syscall.c
> > > > > > > > +++ b/arch/loongarch/kernel/syscall.c
> > > > > > > > @@ -52,6 +52,7 @@ void noinstr do_syscall(struct pt_regs *r=
egs)
> > > > > > > >         regs->orig_a0 =3D regs->regs[4];
> > > > > > > >         regs->regs[4] =3D -ENOSYS;
> > > > > > > >
> > > > > > > > +       task_thread_info(current)->syscall =3D nr;
> > > > > > > >         nr =3D syscall_enter_from_user_mode(regs, nr);
> > > > > > > >
> > > > > > > >         if (nr < NR_syscalls) {
> > > > > > > > --
> > > > > > > > 2.42.0
> > > > > > > >
> > > >

