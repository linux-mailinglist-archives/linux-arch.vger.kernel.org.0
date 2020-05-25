Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F3E1E145D
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbgEYSbj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 14:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388753AbgEYSbj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 May 2020 14:31:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EA5C061A0E;
        Mon, 25 May 2020 11:31:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id er16so8403921qvb.0;
        Mon, 25 May 2020 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vZ+JDEUI1T3n+cUz6ycUNB54/raVRy9RoVxe2AtjSpA=;
        b=ooDnw9gy31Kaupt5etuBjXcSCtAvSl7n0QzNyVSOP7SNyi8NOz4267kjIiQbcp8nVA
         7Lk6Bum24Y6xP4RHoRJeYT7GIZO7NAKuNcEmYAJCRdqfArdp4LK+TqkljlUPPL0SWdso
         6jZ2N+kifADHadXP2H/I/dpM602xC9d3taA+PSqoMDXMsI4JUwEbQtZRq5s1979yHzg+
         5oqRFsFt907djeAPrRkmy7czaTcp9B9E3y15Ml4LbZdFPQI9vmpksKcu4WKgy4xsw53j
         ihQIXAj1utYuSqr9ylWz6BYCvrMXNgFNm+L0xBE/4BXo1EwGRQId2BqoIcAIwpF0J0Ea
         MMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vZ+JDEUI1T3n+cUz6ycUNB54/raVRy9RoVxe2AtjSpA=;
        b=oDQIBOVFGAdSDtA6UZP8Mhb/L463iGIKPxxj3qfzdTY93sVkzVDZwAuKDLP4K7TrY0
         hS2ZWgNALJV8EKS2eWHpdPBqPp8W35la9HJfJ3S+oTFn6hz0XWZNnBl2ISnROf6TwPWm
         JtCMI61kxRKtedlIzJlmUx6siIXOEzZFt2r/yIvedA6LeZlni3yalfVVj6mYZ9WFkhJQ
         R8AZrAhTSCyG8IMO8NTG+m/VGQiY0DGaH0yJ5vYxZQAaPeY5YdXmYImJ7+ChEg0OtakZ
         5xqOuNqD/gxLw739VSHMqWYtPaFw+mIw/BRG3fN0WRn8rc8gdvbl7+/en7xlkrGwBVgf
         IH9A==
X-Gm-Message-State: AOAM533gT5MMIJlDV2FTqf+Tap7fZwlKrODOuSaKnW/qZU0iHY73VAhL
        gqJqKyt/wKrnX+NiQqql1o528/WcRJli4VLtOCs=
X-Google-Smtp-Source: ABdhPJxTF0wxvIbCFxmGPxAeanUI5Be8qA2/wozmcOtp0OZDOBWOB0pJQ8o/4O3klRNgnkd0qhj9MbJbi76aLrUrc6o=
X-Received: by 2002:a0c:b92f:: with SMTP id u47mr3485492qvf.247.1590431498245;
 Mon, 25 May 2020 11:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200522003850.GA32698@paulmck-ThinkPad-P72> <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <ac799c98-45dd-d056-386f-cbebc7270c0c@gmail.com>
In-Reply-To: <ac799c98-45dd-d056-386f-cbebc7270c0c@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 May 2020 11:31:27 -0700
Message-ID: <CAEf4BzYGbLfGA=NN=dP1RqDj7yp_Fnu0L-1bgQojPMt0-Y_X=g@mail.gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        dlustig@nvidia.com, Joel Fernandes <joel@joelfernandes.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, May 24, 2020 at 5:09 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> On Fri, 22 May 2020 12:38:21 -0700, Andrii Nakryiko wrote:
> > On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> >> On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> >>> On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> >>>> On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> >>>>> Hello!
> >>>>>
> >>>>> Just wanted to call your attention to some pretty cool and pretty s=
erious
> >>>>> litmus tests that Andrii did as part of his BPF ring-buffer work:
> >>>>>
> >>>>> https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> >>>>>
> >>>>> Thoughts?
> >>>>
> >>>> I find:
> >>>>
> >>>>     smp_wmb()
> >>>>     smp_store_release()
> >>>>
> >>>> a _very_ weird construct. What is that supposed to even do?
> >>>
> >>> Indeed, it looks like one or the other of those is redundant (dependi=
ng
> >>> on the context).
> >>
> >> Probably.  Peter instead asked what it was supposed to even do.  ;-)
> >
> > I agree, I think smp_wmb() is redundant here. Can't remember why I thou=
ght that it's necessary, this algorithm went through a bunch of iterations,=
 starting as completely lockless, also using READ_ONCE/WRITE_ONCE at some p=
oint, and settling on smp_read_acquire/smp_store_release, eventually. Maybe=
 there was some reason, but might be that I was just over-cautious. See rep=
ly on patch thread as well ([0]).
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8zO+=
SoAJCDtp1jVhcQ@mail.gmail.com/
> >
> >
> >>
> >>> Also, what use is a spinlock that is accessed in only one thread?
> >>
> >> Multiple writers synchronize via the spinlock in this case.  I am
> >> guessing that his larger 16-hour test contended this spinlock.
> >
> > Yes, spinlock is for coordinating multiple producers. 2p1c cases (bound=
ed and unbounded) rely on this already. 1p1c cases are sort of subsets (but=
 very fast to verify) checking only consumer/producer interaction.
> >
> >>
> >>> Finally, I doubt that these tests belong under tools/memory-model.
> >>> Shouldn't they go under the new Documentation/ directory for litmus
> >>> tests?  And shouldn't the patch update a README file?
> >>
> >> Agreed, and I responded to that effect to his original patch:
> >>
> >> https://lore.kernel.org/bpf/20200522003433.GG2869@paulmck-ThinkPad-P72=
/
> >
> > Yep, makes sense, I'll will move.
>
> Hi Andrii,
>
> Andrea reported off-the-list that your litmus tests are incompatible
> with the to-be-released version 7.56 of herd7 and currently available
> versions of klitmus7.
>
> This is due to a couple of C-language level issues.
>
> herd7 used to be fairly generous in parsing C litmus tests.
> On the other hand, klitmus7 converts a litmus test into a
> kernel module.  The converted code is built by an actual C compiler
> with kernel headers included, and can fail to build due to syntax errors
> or serious warnings.
> herd7 HEAD is getting slightly stricter on uninitialized variable and
> it emits an error to mpsc-rb+1p1c+bounded.litmus:
>
> Warning: File "mpsc-rb+1p1c+bounded.litmus": read on location 0 does not =
match any write
>
> Converted code by klitmus7 fails to build with the following warning mess=
ages:
>
> $ make
> make -C /lib/modules/5.3.0-53-generic/build/ M=3D/home/akira/bpf-rb/klitm=
us modules
> make[1]: Entering directory '/usr/src/linux-headers-5.3.0-53-generic'
>   CC [M]  /home/akira/bpf-rb/klitmus/litmus000.o
> /home/akira/bpf-rb/klitmus/litmus000.c: In function =E2=80=98code1=E2=80=
=99:
> /home/akira/bpf-rb/klitmus/litmus000.c:426:14: error: passing argument 1 =
of =E2=80=98atomic_inc=E2=80=99
>   from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
>    atomic_inc(dropped);
>               ^~~~~~~
> In file included from ./arch/x86/include/asm/atomic.h:265:0,
>                  from ./arch/x86/include/asm/msr.h:67,
>                  from ./arch/x86/include/asm/processor.h:21,
>                  from ./arch/x86/include/asm/cpufeature.h:5,
>                  from ./arch/x86/include/asm/thread_info.h:53,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:10,
>                  from /home/akira/bpf-rb/klitmus/litmus000.c:11:
> ./include/asm-generic/atomic-instrumented.h:237:1: note: expected =E2=80=
=98atomic_t * {aka struct <anonymous> *}=E2=80=99 but argument is of type =
=E2=80=98int *=E2=80=99
>  atomic_inc(atomic_t *v)
>  ^~~~~~~~~~
> In file included from ./include/linux/export.h:45:0,
>                  from ./include/linux/linkage.h:7,
>                  from ./include/linux/kernel.h:8,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/module.h:9,
>                  from /home/akira/bpf-rb/klitmus/litmus000.c:11:
> /home/akira/bpf-rb/klitmus/litmus000.c: In function =E2=80=98thread0=E2=
=80=99:
> ./include/linux/compiler.h:187:26: warning: =E2=80=98rLenPtr=E2=80=99 may=
 be used uninitialized in this function [-Wmaybe-uninitialized]
>   case 4: *(__u32 *)res =3D *(volatile __u32 *)p; break;  \
>                           ^
> /home/akira/bpf-rb/klitmus/litmus000.c:365:7: note: =E2=80=98rLenPtr=E2=
=80=99 was declared here
>   int *rLenPtr;
>        ^~~~~~~
> In file included from ./include/linux/export.h:45:0,
>                  from ./include/linux/linkage.h:7,
>                  from ./include/linux/kernel.h:8,
>                  from ./include/linux/list.h:9,
>                  from ./include/linux/module.h:9,
>                  from /home/akira/bpf-rb/klitmus/litmus000.c:11:
> /home/akira/bpf-rb/klitmus/litmus000.c: In function =E2=80=98thread1=E2=
=80=99:
> ./include/linux/compiler.h:225:31: warning: =E2=80=98rLenPtr=E2=80=99 may=
 be used uninitialized in this function [-Wmaybe-uninitialized]
>   case 4: *(volatile __u32 *)p =3D *(__u32 *)res; break;
>           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> /home/akira/bpf-rb/klitmus/litmus000.c:417:7: note: =E2=80=98rLenPtr=E2=
=80=99 was declared here
>   int *rLenPtr;
>        ^~~~~~~
> cc1: some warnings being treated as errors
> scripts/Makefile.build:288: recipe for target '/home/akira/bpf-rb/klitmus=
/litmus000.o' failed
> make[2]: *** [/home/akira/bpf-rb/klitmus/litmus000.o] Error 1
> Makefile:1656: recipe for target '_module_/home/akira/bpf-rb/klitmus' fai=
led
> make[1]: *** [_module_/home/akira/bpf-rb/klitmus] Error 2
> make[1]: Leaving directory '/usr/src/linux-headers-5.3.0-53-generic'
> Makefile:8: recipe for target 'all' failed
> make: *** [all] Error 2
>
> Appended below is a patch I applied to mpsc-rb+1p1c+bounded.litmus to mak=
e
> herd7 HEAD and klitmus7 happy. (Give or take the redundant memory barrier=
.)
>
> The other variants need similar changes.

Ok, cool, thanks for letting me know. I'll see if I can upgrade
everything and test on my side (if you have a pointer to instructions
how to use klitmus7, that would be greatly appreaciated!)

>
> What I did here are:
>
>     - Remove unnecessary initialization (shared variables are 0 by defaul=
t)
>     - Declare "dropped" as atomic_t

These two look good.

>     - Promote rLenPtr to a shared variable LenPtr

This one might work for single producer litmus tests, but it's wrong
for 2- and 3-producer cases, because it has to be local to producer.
But I think I can work around unitialized read warning by assigning it
to 0 in failure case.

>
> Please note that if you are on Linux 5.6 (or later), you need an up-to-da=
te
> klitmus7 due to a change in kernel API.
>
> Any question is welcome!
>
>         Thanks, Akira
>
> -----------------------
> diff --git a/mpsc-rb+1p1c+bounded.litmus b/mpsc-rb+1p1c+bounded.litmus
> index cafd17a..5af43c1 100644
> --- a/mpsc-rb+1p1c+bounded.litmus
> +++ b/mpsc-rb+1p1c+bounded.litmus
> @@ -17,15 +17,11 @@ C mpsc-rb+1p1c+bounded
>
>  {
>         max_len =3D 1;
> -       len1 =3D 0;
> -       px =3D 0;
> -       cx =3D 0;
> -       dropped =3D 0;
> +       atomic_t dropped;
>  }
>
> -P0(int *len1, int *cx, int *px)
> +P0(int *len1, int *cx, int *px, int *LenPtr)
>  {
> -       int *rLenPtr;
>         int rLen;
>         int rPx;
>         int rCx;
> @@ -37,11 +33,11 @@ P0(int *len1, int *cx, int *px)
>         rPx =3D smp_load_acquire(px);
>         if (rCx < rPx) {
>                 if (rCx =3D=3D 0)
> -                       rLenPtr =3D len1;
> +                       LenPtr =3D len1;
>                 else
>                         rFail =3D 1;
>
> -               rLen =3D smp_load_acquire(rLenPtr);
> +               rLen =3D smp_load_acquire(LenPtr);
>                 if (rLen =3D=3D 0) {
>                         rFail =3D 1;
>                 } else if (rLen =3D=3D 1) {
> @@ -51,12 +47,11 @@ P0(int *len1, int *cx, int *px)
>         }
>  }
>
> -P1(int *len1, spinlock_t *rb_lock, int *px, int *cx, int *dropped, int *=
max_len)
> +P1(int *len1, spinlock_t *rb_lock, int *px, int *cx, atomic_t *dropped, =
int *max_len, int *LenPtr)
>  {
>         int rPx;
>         int rCx;
>         int rFail;
> -       int *rLenPtr;
>
>         rFail =3D 0;
>         rCx =3D smp_load_acquire(cx);
> @@ -69,17 +64,17 @@ P1(int *len1, spinlock_t *rb_lock, int *px, int *cx, =
int *dropped, int *max_len)
>                 spin_unlock(rb_lock);
>         } else {
>                 if (rPx =3D=3D 0)
> -                       rLenPtr =3D len1;
> +                       LenPtr =3D len1;
>                 else
>                         rFail =3D 1;
>
> -               *rLenPtr =3D -1;
> +               *LenPtr =3D -1;
>                 smp_wmb();
>                 smp_store_release(px, rPx + 1);
>
>                 spin_unlock(rb_lock);
>
> -               smp_store_release(rLenPtr, 1);
> +               smp_store_release(LenPtr, 1);
>         }
>  }
>
> ----------------
>
