Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12A61E2FD3
	for <lists+linux-arch@lfdr.de>; Tue, 26 May 2020 22:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391001AbgEZUQC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 16:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390995AbgEZUQC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 May 2020 16:16:02 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15E3C03E96D;
        Tue, 26 May 2020 13:16:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n141so9641695qke.2;
        Tue, 26 May 2020 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OPSTz3+9sL2j3CNpWrd73Z+W3szJ+Rl89CpGrZfEGXY=;
        b=D7OGT7lwvBc9ui6tQG2wQjKXvF4bduIo/Gh4TwJYBME2EKlurLMFbr9vrt9hpc9RFI
         GWZNCavsf9YAg3OvTW+qXMOQtr9o/CzG8k8cEhSzF7XDHjoI3zsTr8DhfDLuD28GNdxy
         +RG5BQlpeQ+7ua+bb194hjapymfbrlv27YmsHDLT7G8dsuDmb+QiJglndoCNk4mHxmX5
         4EFAQczSFX3MRNZLtEp87sdxpg4KWoD/9xgcHLcUSRFKtj9QQcIsXeUH2aVuEL5kEkdm
         6uqq63WTVb7uPGOjb8Y6+Zj/S02Yw/yRwdCg1pwcUSHc1FC6tol2aZP7Cip/lyWCxwwi
         qJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OPSTz3+9sL2j3CNpWrd73Z+W3szJ+Rl89CpGrZfEGXY=;
        b=lBRYHmhK0lq/LwELzafmXT7xTDdEOjnDfrUW+dPXr8qkM/bKyEtX1GMcX2Ieqnlws5
         O9uJOmNuEstYC2jD03hWB6Jq6oy9/YqfMfVX3SX4CtEcxvguBwRZgGTKtTKmX2J3HZuE
         Urpcjv01jxfKmsgVjiI030e5PxIOdxisLFJ0/rUzK8vrZckDXTDK5t65c6VlBPDKNXMd
         +/p4jbtXnBIY0W7dnsmzmQPc2CtbgiX0QSsn2fY2Ob9U9QzFAHNFFWdfOFyTV0WjZiEn
         RU6bEIgODfiijcXLMJZG+A6MYpjBoyQGwL/KKRRmWOztNp2YFtN1CqOif5nGDDEP3TxG
         C8Cw==
X-Gm-Message-State: AOAM530qdSzJVISNrJT8sEb8Ijvl05UrMZkHu7SsS/3jRAJHNnD8l77C
        lHir1UDAW/aovPRht9oMxOSEZMyiQG0/G4rCKKM=
X-Google-Smtp-Source: ABdhPJy5uHT1787SR+PrHNYauXfRq8ltIDeLGSPFWzi22Fq05bz0Li/ElEv6zxIqs6ZD25P328y26fcrZ1KcatNwfYU=
X-Received: by 2002:a37:a89:: with SMTP id 131mr635420qkk.92.1590524161143;
 Tue, 26 May 2020 13:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200522003850.GA32698@paulmck-ThinkPad-P72> <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <ac799c98-45dd-d056-386f-cbebc7270c0c@gmail.com>
 <CAEf4BzYGbLfGA=NN=dP1RqDj7yp_Fnu0L-1bgQojPMt0-Y_X=g@mail.gmail.com>
 <69ed3604-4275-d73e-a5d6-2b70dd877104@gmail.com> <CAEf4BzajE6jCkbBQ+f0cG=Y+vAEPWGNhfOMFVVhoDZWjNV-oGA@mail.gmail.com>
 <d1113b47-a920-c0e4-9aa4-88781368a26f@gmail.com>
In-Reply-To: <d1113b47-a920-c0e4-9aa4-88781368a26f@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 13:15:49 -0700
Message-ID: <CAEf4BzZ0mCmUomn0poLk_ADJs9J-fZ0Um6QEqwg1TUL86TtgUg@mail.gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     luc.maranget@inria.fr, Andrii Nakryiko <andriin@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        dlustig@nvidia.com, Joel Fernandes <joel@joelfernandes.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 26, 2020 at 3:50 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> On Mon, 25 May 2020 16:31:05 -0700, Andrii Nakryiko wrote:
> > On Mon, May 25, 2020 at 3:01 PM Akira Yokosawa <akiyks@gmail.com> wrote=
:
> >>
> [...]
> >> Yes, that should work.
> >
> > Ok, assigning to zero didn't work (it still complained about
> > uninitialized read), but using a separate int *lenFail to assign to
> > rLenPtr worked. Curiously, if I used rLenPtr =3D len1; in error case, i=
t
> > actually takes a bit more time to verify.
> >
> > So I've converted everything else as you suggested. I compiled latest
> > herd7 and it doesn't produce any warnings. But it's also extremely
> > slow, compared to the herd7 that I get by default. Validating simple
> > 1p1c cases takes about 2.5x times longer (0.03s vs 0.07), but trying
> > to validate 2p1c case, which normally validates in 42s (unbounded) and
> > 110s (bounded), it took more than 20 minutes and hasn't finished,
> > before I gave up. So I don't know what's going on there...
>
> herdtools7 has recently been heavily restructured.
> On the performance regression, I must defer to Luc.
>
> Luc, do you have any idea?
>
> >
> > As for klitmus7, I managed to generate everything without warnings,
> > but couldn't make it build completely due to:
> >
> > $ make
> > make -C /lib/modules/5.6.13-01802-g938d64da97c6/build/
>
> So you are on Linux 5.6.x which requires cutting-edge klitmus7.
>

Right, so I retried with the klitmus7 built from sources:

$ klitmus7 -version

                                    7.55+01(dev)

Still can't compile, though task_struct problem went away, proc_ops
error is still present:

$ make
grep: /lib/modules/5.7.0-rc5-02014-gb16540c748e9/build/include/linux/proc_f=
s.h:
No such file or directory
make -C /lib/modules/5.7.0-rc5-02014-gb16540c748e9/build/
M=3D/home/andriin/local/linux-trees/tools/memory-model/mymodules modules
make[1]: Entering directory `/data/users/andriin/linux-build/fb-config'
make[2]: Entering directory `/data/users/andriin/linux-build/default-x86_64=
'
grep: /lib/modules/5.7.0-rc5-02014-gb16540c748e9/build/include/linux/proc_f=
s.h:
No such file or directory
  CC [M]  /home/andriin/local/linux-trees/tools/memory-model/mymodules/litm=
us000.o
/home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.c:
In function =E2=80=98litmus_init=E2=80=99:
/home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.c:62=
1:67:
error: passing argument 4 of =E2=80=98proc_create=E2=80=99 from incompatibl=
e pointer
type [-Werror=3Dincompatible-pointer-types]
   struct proc_dir_entry *litmus_pde =3D
proc_create("litmus",0,NULL,&litmus_proc_ops);

^~~~~~~~~~~~~~~~
In file included from
/home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.c:15=
:
/data/users/andriin/linux/include/linux/proc_fs.h:79:24: note:
expected =E2=80=98const struct proc_ops *=E2=80=99 but argument is of type =
=E2=80=98const
struct file_operations *=E2=80=99
 struct proc_dir_entry *proc_create(const char *name, umode_t mode,
struct proc_dir_entry *parent, const struct proc_ops *proc_ops);
                        ^~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymodules/=
litmus000.o]
Error 1
make[2]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymodules]
Error 2
make[2]: Leaving directory `/data/users/andriin/linux-build/default-x86_64'
make[1]: *** [sub-make] Error 2
make[1]: Leaving directory `/data/users/andriin/linux-build/fb-config'
make: *** [all] Error 2

Don't know if I'm missing some headers or whatever.

> > M=3D/home/andriin/local/linux-trees/tools/memory-model/mymodules module=
s
> > make[1]: Entering directory `/data/users/andriin/linux-build/fb-config'
> > make[2]: Entering directory `/data/users/andriin/linux-build/default-x8=
6_64'
> >   CC [M]  /home/andriin/local/linux-trees/tools/memory-model/mymodules/=
litmus000.o
> > /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:
> > In function =E2=80=98zyva=E2=80=99:
> > /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:507:12:
> > warning: ISO C90 forbids variable length array =E2=80=98th=E2=80=99 [-W=
vla]
> >      struct task_struct *th[nth];
> >             ^~~~~~~~~~~
> > /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:
> > In function =E2=80=98litmus_init=E2=80=99:
> > /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:605:67:
> > error: passing argument 4 of =E2=80=98proc_create=E2=80=99 from incompa=
tible pointer
> > type [-Werror=3Dincompatible-pointer-types]
> >    struct proc_dir_entry *litmus_pde =3D
> > proc_create("litmus",0,NULL,&litmus_proc_fops);
> >
> > ^~~~~~~~~~~~~~~~~
> > In file included from
> > /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.=
c:15:
> > /data/users/andriin/linux-fb/include/linux/proc_fs.h:64:24: note:
> > expected =E2=80=98const struct proc_ops *=E2=80=99 but argument is of t=
ype =E2=80=98const
> > struct file_operations *=E2=80=99
> >  struct proc_dir_entry *proc_create(const char *name, umode_t mode,
> > struct proc_dir_entry *parent, const struct proc_ops *proc_ops);
> >                         ^~~~~~~~~~~
> > cc1: some warnings being treated as errors
> > make[3]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymodu=
les/litmus000.o]
> > Error 1
> > make[2]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymodu=
les]
> > Error 2
> > make[2]: Leaving directory `/data/users/andriin/linux-build/default-x86=
_64'
> > make[1]: *** [sub-make] Error 2
> > make[1]: Leaving directory `/data/users/andriin/linux-build/fb-config'
> > make: *** [all] Error 2
> >
>
> These errors suggest the klitmus7 you used is version 7.52 or some such.
> You said you have built herd7 from the source.  Have you also built klitm=
us7?

I did, but it wasn't in the PATH. I retried with latest klitmus7 and
still run into problems.

>
> The up-to-date klitmus7 should generate code compatible with Linux 5.6.x.
>
> Could you try with the latest one?
>
>         Thanks, Akira
>
> >
> > But at least it doesn't complain about atomic_t anymore. So anyways,
> > I'm going to post updated litmus tests separately from BPF ringbuf
> > patches, because Documentation/litmus-tests is not yet present in
> > bpf-next.
> >
> >>
> >> You can find a basic introduction of klitmus7 in tools/memory-model/RE=
ADME.
> >>
> >>         Thanks, Akira
> >>
> >>>
> >>>>
> >>>> Please note that if you are on Linux 5.6 (or later), you need an up-=
to-date
> >>>> klitmus7 due to a change in kernel API.
> >>>>
> >>>> Any question is welcome!
> >>>>
> >>>>         Thanks, Akira
> >>>>
> >
> > [...]
> >
>
