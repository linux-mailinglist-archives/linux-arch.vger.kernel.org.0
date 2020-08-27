Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C31254ECD
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 21:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgH0TjQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 15:39:16 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44211 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0TjP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 15:39:15 -0400
Received: by mail-il1-f193.google.com with SMTP id j9so5878685ilc.11;
        Thu, 27 Aug 2020 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOB1L9Z2LmUKGGeFyj84nON/LDrM3AY4psgNY87vymw=;
        b=OdHs4L9Ujfp3PQmb2CnawHfr6pib3Mou2W4IqK9gK/q74g/vSmAY5IibNlwwPXjL0b
         5NGlUNmZ6k0DF03WOSrOLhFPmdu4PzcoquTboVrApL8RmYXVgXNZKgzeq+f4YEDLMDof
         Su+ub46724WODtxB8KZL/mIuhurVshHcwRUK9T2XIgcbvO4O/tfNIgdbT1vkbDS4fdgw
         ekxI471ss7zqC1dsg9I9qcROP5g5MM+Zd9qCmotFs4sceCnUzxkMZnQbkZ8sM8X1hUmH
         oiHWjpk4l9W6NoyVS8q3C5saAs2d36saw/zDSuhCQVB8b95clOQwGeHMRd2NyEVAtBp/
         4BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOB1L9Z2LmUKGGeFyj84nON/LDrM3AY4psgNY87vymw=;
        b=QOoPcCABVccNguFA4Eo5W9IrN/Ej3/nhNQJcj48hd8yfO/hEAe282RkrdFRQJYDnBu
         Y5vyuRbCYwJRit1Z+IglW4NiWzcDd9j3LRXYUA65tRIXn58JIhUahAloGy+R2nFMi8Wz
         wa7P5WH6+5Uf4f1VlEOBtiAoruHSJjUuhJ4/hDbV34jpmcH/L46N1Xan5fhWMa9eKhJT
         qNkGbUP8BDtjOu4zxjcQZMc+yxUfuNRtdeN4ambChcMZiq3sw38fc9A/NDTfLvp2bmQF
         wBlKDpzqL0grFjJxTT9zzw/50UdbM9ezXf7Sd7dz03u5Bhyc4yEkp3GO4XX6pzouzbZf
         VkNQ==
X-Gm-Message-State: AOAM532U/shoH0cTGRHR6lzIXGmyigPmVIRFfYOmjS1uljA1/9/OPdqN
        qe5yefnRXKV+Lh3p6ZNzlF2bC70iSq/dvIlaFOk=
X-Google-Smtp-Source: ABdhPJz3AFlP3Kd2dCES2TE657Fj/aB8MwwtB77fXJN6/mzwzKCWE10R5tOLPhiUJGyp0tLFgg6gBnnGIoHe5BhRZaY=
X-Received: by 2002:a92:5e4c:: with SMTP id s73mr18025364ilb.151.1598557093725;
 Thu, 27 Aug 2020 12:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <a770d45d-b147-a8c5-b7f8-30d668cbed84@intel.com> <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net>
In-Reply-To: <4BDFD364-798C-4537-A88E-F94F101F524B@amacapital.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 27 Aug 2020 12:37:37 -0700
Message-ID: <CAMe9rOoTjSwRSPuqP6RKkDzPA_VPh5gVYRVFJ-ezAD4Et-FUng@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 11:56 AM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>
>
>
> > On Aug 27, 2020, at 11:13 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrot=
e:
> >
> > =EF=BB=BFOn 8/27/2020 6:36 AM, Florian Weimer wrote:
> >> * H. J. Lu:
> >>>> On Thu, Aug 27, 2020 at 6:19 AM Florian Weimer <fweimer@redhat.com> =
wrote:
> >>>>>
> >>>>> * Dave Martin:
> >>>>>
> >>>>>> You're right that this has implications: for i386, libc probably p=
ulls
> >>>>>> more arguments off the stack than are really there in some situati=
ons.
> >>>>>> This isn't a new problem though.  There are already generic prctls=
 with
> >>>>>> fewer than 4 args that are used on x86.
> >>>>>
> >>>>> As originally posted, glibc prctl would have to know that it has to=
 pull
> >>>>> an u64 argument off the argument list for ARCH_X86_CET_DISABLE.  Bu=
t
> >>>>> then the u64 argument is a problem for arch_prctl as well.
> >>>>>
> >>>
> >>> Argument of ARCH_X86_CET_DISABLE is int and passed in register.
> >> The commit message and the C source say otherwise, I think (not sure
> >> about the C source, not a kernel hacker).
> >
> > H.J. Lu suggested that we fix x86 arch_prctl() to take four arguments, =
and then keep MMAP_SHSTK as an arch_prctl().  Because now the map flags and=
 size are all in registers, this also solves problems being pointed out ear=
lier.  Without a wrapper, the shadow stack mmap call (from user space) will=
 be:
> >
> > syscall(_NR_arch_prctl, ARCH_X86_CET_MMAP_SHSTK, size, MAP_32BIT).
>
> I admit I don=E2=80=99t see a show stopping technical reason we can=E2=80=
=99t add arguments to an existing syscall, but I=E2=80=99m pretty sure it=
=E2=80=99s unprecedented, and it doesn=E2=80=99t seem like a good idea.

prctl prototype is:

extern int prctl (int __option, ...)

and implemented in kernel as:

      int prctl(int option, unsigned long arg2, unsigned long arg3,
                 unsigned long arg4, unsigned long arg5);

Not all prctl operations take all 5 arguments.   It also applies
to arch_prctl.  It is quite normal for different operations of
arch_prctl to take different numbers of arguments.

--=20
H.J.
