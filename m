Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBE31E33EE
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 02:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgE0AJX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 20:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgE0AJX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 May 2020 20:09:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C75C061A0F;
        Tue, 26 May 2020 17:09:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z80so22778205qka.0;
        Tue, 26 May 2020 17:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z/e41keZ9hK13uzDSFVCQNKBrjo8Yy+WjtoAUUxsCoE=;
        b=YD8BMgqIdGIF2v2WL3/4ukqZRS7ej9Mhf1ac7XmFFnyE0zfUUkY508pKgy/27PRf5S
         4dY4OS+qiSn/2pMzhNrgFv3ZPjifgXHkPmrQqilUjhoRpOg7RuJxvRwVnbhA9AiG6bgy
         FhtRl9BlFmB8FzP0+KGxSoiX5l3AsySzOFrH6lZWmeVCW+bhzEf0+2Luw2fLP8u9IgQH
         bQb4/sK/g2j4fC9ZB068v+fIKn2sjyykvPKIQ9Dg9on3z1uAiBXmaH14Kpsy/JzmJo1j
         nvid2AUnMovKe0O0NWpDeRZ2faEOjCc9DoAAlGLV1Mx5jS6kKPUaoCX+OYdv9yQImP38
         3Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z/e41keZ9hK13uzDSFVCQNKBrjo8Yy+WjtoAUUxsCoE=;
        b=mcsWFT9Z28afQNYGN0yOLtEcq6ixB0gSxfx6TRQatE++EQtTDWjtJN6xQqVwytSKcL
         +sG74OCxT8ZR4kUSA3OQbpvUU4HhrBTjHoVtbo71j0pyQqIoYJ3B0+L12AtIZkLbOwtp
         TsyyjkoPCzTLCwwXZE63K5oOJpr0LjoDXBlC8Mcu13UB341sp60/liBs0p/dk3Z2oSkW
         ImnV9DSvgEQeEIpH+JLk5CCynMTXnhy2MDwUJIEkDaA+MSwEIk0hq/3m9v8yXMlSJPtf
         nIk3Lrsp2t2wrvq1KBNRgzlrxmyX5PTN57N3r+3jNsO1oAHx/Hrz9hzNlMO0H/79C9Nc
         7ncw==
X-Gm-Message-State: AOAM532AMMlplEHbVqUWZKcZ7XoUSeitJq57PDc1dGKJXp+MCtxn4q0E
        1pQIa1fIyU9Xwe/bw6TczlVKsfMzOIVEBccEXCe4wpYnn50=
X-Google-Smtp-Source: ABdhPJwYJIB+qn+QGUBRk+at9gO3DzYMMcM5GPo3SMrujDEITBo8BB/a1hQK0HuNmWVq1BLpoXascFYcNQuJvcR4i0M=
X-Received: by 2002:a05:620a:12d2:: with SMTP id e18mr1581333qkl.437.1590538162206;
 Tue, 26 May 2020 17:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200522003850.GA32698@paulmck-ThinkPad-P72> <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <ac799c98-45dd-d056-386f-cbebc7270c0c@gmail.com>
 <CAEf4BzYGbLfGA=NN=dP1RqDj7yp_Fnu0L-1bgQojPMt0-Y_X=g@mail.gmail.com>
 <69ed3604-4275-d73e-a5d6-2b70dd877104@gmail.com> <CAEf4BzajE6jCkbBQ+f0cG=Y+vAEPWGNhfOMFVVhoDZWjNV-oGA@mail.gmail.com>
 <d1113b47-a920-c0e4-9aa4-88781368a26f@gmail.com> <b92f9c0a-826c-d074-5389-8c340f7cccf2@gmail.com>
 <CAEf4BzZF6JO9Tpc2wRk1GDHKfDr0LeYz7LrHz93W1uNjSaq=bg@mail.gmail.com> <e994dbc1-4b8c-971f-5ec9-4e039b2658a2@gmail.com>
In-Reply-To: <e994dbc1-4b8c-971f-5ec9-4e039b2658a2@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 17:09:11 -0700
Message-ID: <CAEf4Bzbuk_=rQVe1x0GAQWvi-nissaZCUuG8GOh-YwCybe-ReQ@mail.gmail.com>
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

On Tue, May 26, 2020 at 4:00 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> On Tue, 26 May 2020 13:19:36 -0700, Andrii Nakryiko wrote:
> > On Tue, May 26, 2020 at 7:02 AM Akira Yokosawa <akiyks@gmail.com> wrote=
:
> >>
> >> On Tue, 26 May 2020 19:50:47 +0900, Akira Yokosawa wrote:
> >>> On Mon, 25 May 2020 16:31:05 -0700, Andrii Nakryiko wrote:
> >>>> On Mon, May 25, 2020 at 3:01 PM Akira Yokosawa <akiyks@gmail.com> wr=
ote:
> >>>>>
> >>> [...]
> >>>>> Yes, that should work.
> >>>>
> >>>> Ok, assigning to zero didn't work (it still complained about
> >>>> uninitialized read), but using a separate int *lenFail to assign to
> >>>> rLenPtr worked. Curiously, if I used rLenPtr =3D len1; in error case=
, it
> >>>> actually takes a bit more time to verify.
> >>>>
> >>>> So I've converted everything else as you suggested. I compiled lates=
t
> >>>> herd7 and it doesn't produce any warnings. But it's also extremely
> >>>> slow, compared to the herd7 that I get by default. Validating simple
> >>>> 1p1c cases takes about 2.5x times longer (0.03s vs 0.07),
> >>
> >> Wait a moment!
> >>
> >> This 0.03s was the run time of the original 1p1c litmus test, wasn't i=
t?
> >> Then you are comparing apples and oranges.
> >>
> >> How long does your default herd7 take to complete the updated 1p1c tes=
t?
> >>
> >>         Thanks, Akira
> >
> > It could be new test vs old test, so I re-ran again. Identical
> > 1p1c-unbound test:
> >
> > OLD version:
> >
> > $ herd7 -version && herd7 -unroll 0 -conf linux-kernel.cfg
> > ../../Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+unbound.litmus
> > 7.52, Rev: exported
> > Test bpf-rb+1p1c+unbound Allowed
> > States 2
> > 0:rFail=3D0; 1:rFail=3D0; cx=3D0; len1=3D1; px=3D1;
> > 0:rFail=3D0; 1:rFail=3D0; cx=3D1; len1=3D1; px=3D1;
> > Ok
> > Witnesses
> > Positive: 3 Negative: 0
> > Condition exists (0:rFail=3D0 /\ 1:rFail=3D0 /\ px=3D1 /\ len1=3D1 /\ (=
cx=3D0 \/ cx=3D1))
> > Observation bpf-rb+1p1c+unbound Always 3 0
> > Time bpf-rb+1p1c+unbound 0.03
> > Hash=3D20a68cc69b09fbb79f407f825c015623
> >
> > LATEST from sources version:
> >
> > $ herd7 -version && herd7 -unroll 0 -conf linux-kernel.cfg
> > ../../Documentation/litmus-tests/bpf-rb/bpf-rb+1p1c+unbound.litmus
> > 7.55+01(dev), Rev: 61e23aaee7bba87ccf4cdf1a620a3a9fa8f9a586
> > Test bpf-rb+1p1c+unbound Allowed
> > States 2
> > 0:rFail=3D0; 1:rFail=3D0; cx=3D0; len1=3D1; px=3D1;
> > 0:rFail=3D0; 1:rFail=3D0; cx=3D1; len1=3D1; px=3D1;
> > Ok
> > Witnesses
> > Positive: 3 Negative: 0
> > Condition exists (0:rFail=3D0 /\ 1:rFail=3D0 /\ px=3D1 /\ len1=3D1 /\ (=
cx=3D0 \/ cx=3D1))
> > Observation bpf-rb+1p1c+unbound Always 3 0
> > Time bpf-rb+1p1c+unbound 0.06
> > Hash=3D20a68cc69b09fbb79f407f825c015623
> >
> > Still 2x difference.
>
> I see opposite tendency on a different set of time consuming
> litmus tests comparing herd7 7.52 and HEAD.
>
>                                                 herd7 7.52     herd7 HEAD
> C-SB+l-o-o-u+l-o-o-u+l-o-o-u+l-o-o-u+l-o-o-u      8.44           6.12
> C-SB+l-o-o-u+l-o-o-u+l-o-o-u+l-o-o-u-C           77.19          69.92
> C-SB+l-o-o-u+l-o-o-u+l-o-o-u+l-o-o-u-CE         355.62         287.27
> C-SB+l-o-o-u+l-o-o-u+l-o-o-u+l-o-o-u-X          157.87         191.50
> C-SB+l-o-o-u+l-o-o-u+l-o-o-u+l-o-o-u              2.36           0.94
> C-SB+l-o-o-u+l-o-o-u-+l-o-o-u-C                   2.32           0.93
> C-SB+l-o-o-u+l-o-o-u-+l-o-o-u-CE                  5.64           3.52
> C-SB+l-o-o-u+l-o-o-u+l-o-o-u-X                    3.18           2.52
> C-SB+l-o-o-u+l-o-o-u+l-o-o-u-XE                  11.81          10.35
> C-SB+l-o-o-u+l-o-o-u+l-o-o-u                      0.25           0.19
> C-SB+l-o-o-u+l-o-o-u-C                            0.15           0.12
> C-SB+l-o-o-u+l-o-o-u-CE                           0.26           0.20
> C-SB+l-o-o-u+l-o-o-u-X                            0.17           0.14
> C-SB+l-o-o-u+l-o-o-u-XE                           0.38           0.30
> C-SB+l-o-o-u+l-o-o-u                              0.04           0.03
>
> NOTE: These were taken on a fairly old PC, with power-saving mode enabled=
.
>
> Did you used the original 1p1c unbound test?
> I'd like you to compare the updated 1p1c unbound test.

No, that was updated one. I'll try another kernel a bit later (with
proper kernel-devel package), currently re-running 3p1c test to see
how long it takes.

>
>         Thanks, Akira
>
> >
> >>
> >>>>                                                           but trying
> >>>> to validate 2p1c case, which normally validates in 42s (unbounded) a=
nd
> >>>> 110s (bounded), it took more than 20 minutes and hasn't finished,
> >>>> before I gave up. So I don't know what's going on there...
> >>>
> >>> herdtools7 has recently been heavily restructured.
> >>> On the performance regression, I must defer to Luc.
> >>>
> >>> Luc, do you have any idea?
> >>>
> >>>>
> >>>> As for klitmus7, I managed to generate everything without warnings,
> >>>> but couldn't make it build completely due to:
> >>>>
> >>>> $ make
> >>>> make -C /lib/modules/5.6.13-01802-g938d64da97c6/build/
> >>>
> >>> So you are on Linux 5.6.x which requires cutting-edge klitmus7.
> >>>
> >>>> M=3D/home/andriin/local/linux-trees/tools/memory-model/mymodules mod=
ules
> >>>> make[1]: Entering directory `/data/users/andriin/linux-build/fb-conf=
ig'
> >>>> make[2]: Entering directory `/data/users/andriin/linux-build/default=
-x86_64'
> >>>>   CC [M]  /home/andriin/local/linux-trees/tools/memory-model/mymodul=
es/litmus000.o
> >>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus0=
00.c:
> >>>> In function =E2=80=98zyva=E2=80=99:
> >>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus0=
00.c:507:12:
> >>>> warning: ISO C90 forbids variable length array =E2=80=98th=E2=80=99 =
[-Wvla]
> >>>>      struct task_struct *th[nth];
> >>>>             ^~~~~~~~~~~
> >>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus0=
00.c:
> >>>> In function =E2=80=98litmus_init=E2=80=99:
> >>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus0=
00.c:605:67:
> >>>> error: passing argument 4 of =E2=80=98proc_create=E2=80=99 from inco=
mpatible pointer
> >>>> type [-Werror=3Dincompatible-pointer-types]
> >>>>    struct proc_dir_entry *litmus_pde =3D
> >>>> proc_create("litmus",0,NULL,&litmus_proc_fops);
> >>>>
> >>>> ^~~~~~~~~~~~~~~~~
> >>>> In file included from
> >>>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus0=
00.c:15:
> >>>> /data/users/andriin/linux-fb/include/linux/proc_fs.h:64:24: note:
> >>>> expected =E2=80=98const struct proc_ops *=E2=80=99 but argument is o=
f type =E2=80=98const
> >>>> struct file_operations *=E2=80=99
> >>>>  struct proc_dir_entry *proc_create(const char *name, umode_t mode,
> >>>> struct proc_dir_entry *parent, const struct proc_ops *proc_ops);
> >>>>                         ^~~~~~~~~~~
> >>>> cc1: some warnings being treated as errors
> >>>> make[3]: *** [/home/andriin/local/linux-trees/tools/memory-model/mym=
odules/litmus000.o]
> >>>> Error 1
> >>>> make[2]: *** [/home/andriin/local/linux-trees/tools/memory-model/mym=
odules]
> >>>> Error 2
> >>>> make[2]: Leaving directory `/data/users/andriin/linux-build/default-=
x86_64'
> >>>> make[1]: *** [sub-make] Error 2
> >>>> make[1]: Leaving directory `/data/users/andriin/linux-build/fb-confi=
g'
> >>>> make: *** [all] Error 2
> >>>>
> >>>
> >>> These errors suggest the klitmus7 you used is version 7.52 or some su=
ch.
> >>> You said you have built herd7 from the source.  Have you also built k=
litmus7?
> >>>
> >>> The up-to-date klitmus7 should generate code compatible with Linux 5.=
6.x.
> >>>
> >>> Could you try with the latest one?
> >>>
> >>>         Thanks, Akira
> >>>
> >>>>
> >>>> But at least it doesn't complain about atomic_t anymore. So anyways,
> >>>> I'm going to post updated litmus tests separately from BPF ringbuf
> >>>> patches, because Documentation/litmus-tests is not yet present in
> >>>> bpf-next.
> >>>>
> >>>>>
> >>>>> You can find a basic introduction of klitmus7 in tools/memory-model=
/README.
> >>>>>
> >>>>>         Thanks, Akira
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Please note that if you are on Linux 5.6 (or later), you need an =
up-to-date
> >>>>>>> klitmus7 due to a change in kernel API.
> >>>>>>>
> >>>>>>> Any question is welcome!
> >>>>>>>
> >>>>>>>         Thanks, Akira
> >>>>>>>
> >>>>
> >>>> [...]
> >>>>
> >>>
> >>
>
