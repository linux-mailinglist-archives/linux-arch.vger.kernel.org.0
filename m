Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB6B1E183C
	for <lists+linux-arch@lfdr.de>; Tue, 26 May 2020 01:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbgEYXbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 19:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgEYXbR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 May 2020 19:31:17 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC326C061A0E;
        Mon, 25 May 2020 16:31:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 205so5747906qkg.3;
        Mon, 25 May 2020 16:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B05sP4Y1TR+BRkd0nFh6rwEnkm37VrvtAc9cPEzlqnM=;
        b=WXoh4IbDa153ZHovbj+K3NOedCEkkEpC4AMAiFkdoahkX3CzCagx1HyvlJiLr/LDqn
         abPyBGaCahHeV5OwgUHFUKBIROKJkxgDz9vwjFHVY7LzIzLHyuY1a37JyrCypTlDtvaK
         q1R4o0GxTVzKWw5N82oesXeHCHgOYkwJ8bguBGeCjtbJtw9LmhRgJG/10ZHtDoLu8R4p
         ynkplUCSEkF/kPAHmF0ybhFxwgD7jgLBO8oGsACLn97OiyQstsC8bjqHlhNy2HKeGWDA
         m4VuRMfaffJmGIatz2I+V7dmV2xdXlb62R/F0Qq5ig0SUtRrLrPuONx/4dVLbTtCm6cr
         /3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B05sP4Y1TR+BRkd0nFh6rwEnkm37VrvtAc9cPEzlqnM=;
        b=g3YBwrskwTo8PDhZXP7cvYRWIaWG1uCompDz0Nbydkiy/hDDLV4Mwy99QbxeqE+kpt
         IDzUJSvBc+35kI3v/qG/oNASp+ddh0NR7PXpkVXc+q4qSfpm9Qa7lIZMaJ+8ONRDEHOx
         nLM6NIknfFnmHofh5cKHWaZ4aiDuuLuZUf426tE5Kx3E8qOldErE2hnwtXuOLLn+dEPD
         DKPt+s6fY8fd70wCrnAHLeYzCeuJbnqnB0+0gSmyoZwfaSn8Y+5hEmBBrtcO5NDjn++V
         FvWdJ7L1WnqJkqXX3ukaYq5Ky3OdS1KeGoQz+4qo71MIVbgrPUs7/KLC7g+LiNB5c5at
         bY4Q==
X-Gm-Message-State: AOAM532Vp60jo+bahp6LRRlOC6qY3eeCXYYeVA2AX52F5AxdxHgcY9nC
        tTEd+axXdDRH++imGYqQYIbVp7+okybUEI9ju0I=
X-Google-Smtp-Source: ABdhPJyL3E29nY2D4Pm4KsYnZCW6qFjeOSeWFRshQMG2s1UG4byzRHuqNO25goIufuJMl3Lu1yzxL1xJlDEsrgALrdM=
X-Received: by 2002:a05:620a:247:: with SMTP id q7mr23539343qkn.36.1590449475979;
 Mon, 25 May 2020 16:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200522003850.GA32698@paulmck-ThinkPad-P72> <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu> <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com> <ac799c98-45dd-d056-386f-cbebc7270c0c@gmail.com>
 <CAEf4BzYGbLfGA=NN=dP1RqDj7yp_Fnu0L-1bgQojPMt0-Y_X=g@mail.gmail.com> <69ed3604-4275-d73e-a5d6-2b70dd877104@gmail.com>
In-Reply-To: <69ed3604-4275-d73e-a5d6-2b70dd877104@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 May 2020 16:31:05 -0700
Message-ID: <CAEf4BzajE6jCkbBQ+f0cG=Y+vAEPWGNhfOMFVVhoDZWjNV-oGA@mail.gmail.com>
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

On Mon, May 25, 2020 at 3:01 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> On Mon, 25 May 2020 11:31:27 -0700, Andrii Nakryiko wrote:
> > On Sun, May 24, 2020 at 5:09 AM Akira Yokosawa <akiyks@gmail.com> wrote=
:
> >>
> >> On Fri, 22 May 2020 12:38:21 -0700, Andrii Nakryiko wrote:
> >>> On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> >>>> On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> >>>>> On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> >>>>>> On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> >>>>>>> Hello!
> >>>>>>>
> >>>>>>> Just wanted to call your attention to some pretty cool and pretty=
 serious
> >>>>>>> litmus tests that Andrii did as part of his BPF ring-buffer work:
> >>>>>>>
> >>>>>>> https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.co=
m/
> >>>>>>>
> >>>>>>> Thoughts?
> >>>>>>
> >>>>>> I find:
> >>>>>>
> >>>>>>     smp_wmb()
> >>>>>>     smp_store_release()
> >>>>>>
> >>>>>> a _very_ weird construct. What is that supposed to even do?
> >>>>>
> >>>>> Indeed, it looks like one or the other of those is redundant (depen=
ding
> >>>>> on the context).
> >>>>
> >>>> Probably.  Peter instead asked what it was supposed to even do.  ;-)
> >>>
> >>> I agree, I think smp_wmb() is redundant here. Can't remember why I th=
ought that it's necessary, this algorithm went through a bunch of iteration=
s, starting as completely lockless, also using READ_ONCE/WRITE_ONCE at some=
 point, and settling on smp_read_acquire/smp_store_release, eventually. May=
be there was some reason, but might be that I was just over-cautious. See r=
eply on patch thread as well ([0]).
> >>>
> >>>   [0] https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8z=
O+SoAJCDtp1jVhcQ@mail.gmail.com/
> >>>
> >>>
> >>>>
> >>>>> Also, what use is a spinlock that is accessed in only one thread?
> >>>>
> >>>> Multiple writers synchronize via the spinlock in this case.  I am
> >>>> guessing that his larger 16-hour test contended this spinlock.
> >>>
> >>> Yes, spinlock is for coordinating multiple producers. 2p1c cases (bou=
nded and unbounded) rely on this already. 1p1c cases are sort of subsets (b=
ut very fast to verify) checking only consumer/producer interaction.
> >>>
> >>>>
> >>>>> Finally, I doubt that these tests belong under tools/memory-model.
> >>>>> Shouldn't they go under the new Documentation/ directory for litmus
> >>>>> tests?  And shouldn't the patch update a README file?
> >>>>
> >>>> Agreed, and I responded to that effect to his original patch:
> >>>>
> >>>> https://lore.kernel.org/bpf/20200522003433.GG2869@paulmck-ThinkPad-P=
72/
> >>>
> >>> Yep, makes sense, I'll will move.
> >>
> >> Hi Andrii,
> >>
> >> Andrea reported off-the-list that your litmus tests are incompatible
> >> with the to-be-released version 7.56 of herd7 and currently available
> >> versions of klitmus7.
> >>
> >> This is due to a couple of C-language level issues.
> >>
> >> herd7 used to be fairly generous in parsing C litmus tests.
> >> On the other hand, klitmus7 converts a litmus test into a
> >> kernel module.  The converted code is built by an actual C compiler
> >> with kernel headers included, and can fail to build due to syntax erro=
rs
> >> or serious warnings.
> >> herd7 HEAD is getting slightly stricter on uninitialized variable and
> >> it emits an error to mpsc-rb+1p1c+bounded.litmus:
> >>
> >> Warning: File "mpsc-rb+1p1c+bounded.litmus": read on location 0 does n=
ot match any write
> >>
> >> Converted code by klitmus7 fails to build with the following warning m=
essages:
> >>
> >> $ make
> >> make -C /lib/modules/5.3.0-53-generic/build/ M=3D/home/akira/bpf-rb/kl=
itmus modules
> >> make[1]: Entering directory '/usr/src/linux-headers-5.3.0-53-generic'
> >>   CC [M]  /home/akira/bpf-rb/klitmus/litmus000.o
> >> /home/akira/bpf-rb/klitmus/litmus000.c: In function =E2=80=98code1=E2=
=80=99:
> >> /home/akira/bpf-rb/klitmus/litmus000.c:426:14: error: passing argument=
 1 of =E2=80=98atomic_inc=E2=80=99
> >>   from incompatible pointer type [-Werror=3Dincompatible-pointer-types=
]
> >>    atomic_inc(dropped);
> >>               ^~~~~~~
> >> In file included from ./arch/x86/include/asm/atomic.h:265:0,
> >>                  from ./arch/x86/include/asm/msr.h:67,
> >>                  from ./arch/x86/include/asm/processor.h:21,
> >>                  from ./arch/x86/include/asm/cpufeature.h:5,
> >>                  from ./arch/x86/include/asm/thread_info.h:53,
> >>                  from ./include/linux/thread_info.h:38,
> >>                  from ./arch/x86/include/asm/preempt.h:7,
> >>                  from ./include/linux/preempt.h:78,
> >>                  from ./include/linux/spinlock.h:51,
> >>                  from ./include/linux/seqlock.h:36,
> >>                  from ./include/linux/time.h:6,
> >>                  from ./include/linux/stat.h:19,
> >>                  from ./include/linux/module.h:10,
> >>                  from /home/akira/bpf-rb/klitmus/litmus000.c:11:
> >> ./include/asm-generic/atomic-instrumented.h:237:1: note: expected =E2=
=80=98atomic_t * {aka struct <anonymous> *}=E2=80=99 but argument is of typ=
e =E2=80=98int *=E2=80=99
> >>  atomic_inc(atomic_t *v)
> >>  ^~~~~~~~~~
> >> In file included from ./include/linux/export.h:45:0,
> >>                  from ./include/linux/linkage.h:7,
> >>                  from ./include/linux/kernel.h:8,
> >>                  from ./include/linux/list.h:9,
> >>                  from ./include/linux/module.h:9,
> >>                  from /home/akira/bpf-rb/klitmus/litmus000.c:11:
> >> /home/akira/bpf-rb/klitmus/litmus000.c: In function =E2=80=98thread0=
=E2=80=99:
> >> ./include/linux/compiler.h:187:26: warning: =E2=80=98rLenPtr=E2=80=99 =
may be used uninitialized in this function [-Wmaybe-uninitialized]
> >>   case 4: *(__u32 *)res =3D *(volatile __u32 *)p; break;  \
> >>                           ^
> >> /home/akira/bpf-rb/klitmus/litmus000.c:365:7: note: =E2=80=98rLenPtr=
=E2=80=99 was declared here
> >>   int *rLenPtr;
> >>        ^~~~~~~
> >> In file included from ./include/linux/export.h:45:0,
> >>                  from ./include/linux/linkage.h:7,
> >>                  from ./include/linux/kernel.h:8,
> >>                  from ./include/linux/list.h:9,
> >>                  from ./include/linux/module.h:9,
> >>                  from /home/akira/bpf-rb/klitmus/litmus000.c:11:
> >> /home/akira/bpf-rb/klitmus/litmus000.c: In function =E2=80=98thread1=
=E2=80=99:
> >> ./include/linux/compiler.h:225:31: warning: =E2=80=98rLenPtr=E2=80=99 =
may be used uninitialized in this function [-Wmaybe-uninitialized]
> >>   case 4: *(volatile __u32 *)p =3D *(__u32 *)res; break;
> >>           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> >> /home/akira/bpf-rb/klitmus/litmus000.c:417:7: note: =E2=80=98rLenPtr=
=E2=80=99 was declared here
> >>   int *rLenPtr;
> >>        ^~~~~~~
> >> cc1: some warnings being treated as errors
> >> scripts/Makefile.build:288: recipe for target '/home/akira/bpf-rb/klit=
mus/litmus000.o' failed
> >> make[2]: *** [/home/akira/bpf-rb/klitmus/litmus000.o] Error 1
> >> Makefile:1656: recipe for target '_module_/home/akira/bpf-rb/klitmus' =
failed
> >> make[1]: *** [_module_/home/akira/bpf-rb/klitmus] Error 2
> >> make[1]: Leaving directory '/usr/src/linux-headers-5.3.0-53-generic'
> >> Makefile:8: recipe for target 'all' failed
> >> make: *** [all] Error 2
> >>
> >> Appended below is a patch I applied to mpsc-rb+1p1c+bounded.litmus to =
make
> >> herd7 HEAD and klitmus7 happy. (Give or take the redundant memory barr=
ier.)
> >>
> >> The other variants need similar changes.
> >
> > Ok, cool, thanks for letting me know. I'll see if I can upgrade
> > everything and test on my side (if you have a pointer to instructions
> > how to use klitmus7, that would be greatly appreaciated!)
> >
> >>
> >> What I did here are:
> >>
> >>     - Remove unnecessary initialization (shared variables are 0 by def=
ault)
> >>     - Declare "dropped" as atomic_t
> >
> > These two look good.
> >
> >>     - Promote rLenPtr to a shared variable LenPtr
> >
> > This one might work for single producer litmus tests, but it's wrong
> > for 2- and 3-producer cases, because it has to be local to producer.
>
> Ah, I knew I had missed something...
>
> > But I think I can work around unitialized read warning by assigning it
> > to 0 in failure case.
>
> Yes, that should work.

Ok, assigning to zero didn't work (it still complained about
uninitialized read), but using a separate int *lenFail to assign to
rLenPtr worked. Curiously, if I used rLenPtr =3D len1; in error case, it
actually takes a bit more time to verify.

So I've converted everything else as you suggested. I compiled latest
herd7 and it doesn't produce any warnings. But it's also extremely
slow, compared to the herd7 that I get by default. Validating simple
1p1c cases takes about 2.5x times longer (0.03s vs 0.07), but trying
to validate 2p1c case, which normally validates in 42s (unbounded) and
110s (bounded), it took more than 20 minutes and hasn't finished,
before I gave up. So I don't know what's going on there...

As for klitmus7, I managed to generate everything without warnings,
but couldn't make it build completely due to:

$ make
make -C /lib/modules/5.6.13-01802-g938d64da97c6/build/
M=3D/home/andriin/local/linux-trees/tools/memory-model/mymodules modules
make[1]: Entering directory `/data/users/andriin/linux-build/fb-config'
make[2]: Entering directory `/data/users/andriin/linux-build/default-x86_64=
'
  CC [M]  /home/andriin/local/linux-trees/tools/memory-model/mymodules/litm=
us000.o
/home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.c:
In function =E2=80=98zyva=E2=80=99:
/home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.c:50=
7:12:
warning: ISO C90 forbids variable length array =E2=80=98th=E2=80=99 [-Wvla]
     struct task_struct *th[nth];
            ^~~~~~~~~~~
/home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.c:
In function =E2=80=98litmus_init=E2=80=99:
/home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.c:60=
5:67:
error: passing argument 4 of =E2=80=98proc_create=E2=80=99 from incompatibl=
e pointer
type [-Werror=3Dincompatible-pointer-types]
   struct proc_dir_entry *litmus_pde =3D
proc_create("litmus",0,NULL,&litmus_proc_fops);

^~~~~~~~~~~~~~~~~
In file included from
/home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000.c:15=
:
/data/users/andriin/linux-fb/include/linux/proc_fs.h:64:24: note:
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


But at least it doesn't complain about atomic_t anymore. So anyways,
I'm going to post updated litmus tests separately from BPF ringbuf
patches, because Documentation/litmus-tests is not yet present in
bpf-next.

>
> You can find a basic introduction of klitmus7 in tools/memory-model/READM=
E.
>
>         Thanks, Akira
>
> >
> >>
> >> Please note that if you are on Linux 5.6 (or later), you need an up-to=
-date
> >> klitmus7 due to a change in kernel API.
> >>
> >> Any question is welcome!
> >>
> >>         Thanks, Akira
> >>

[...]
