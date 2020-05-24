Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765BD1DFED8
	for <lists+linux-arch@lfdr.de>; Sun, 24 May 2020 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgEXMJU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 May 2020 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgEXMJU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 May 2020 08:09:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0EBC061A0E;
        Sun, 24 May 2020 05:09:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t8so5167284pju.3;
        Sun, 24 May 2020 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rb9RGmOmMMM2dD3TrKMy6fSbknGvk79DpYlGgni1l6k=;
        b=vYyTW1KK14kGJFVllzbYUO+xdYeN8H0K4QHbWiHtp6tjYrlHjxrqbb+UY1V8WUo4U2
         rHTNzXPX5IP0AXHXBtTipgufLXyTMyzFGEzXdZSfVQ5SchkTI88BUdrpUukxLgudjJ/R
         QJTldveomegj4/4iJpCThX34FXnRK8dhmYBSitoq3Wa4+DfzFNa7yZdLA2Q0R5Qgsc/C
         QvHlibRg0+vD1LmM8UAMU1VxH5xhzKu3EU8poLwn9XdFYZjR9EU3VURF/ovzXWyygQMG
         uFUaYqBf8CoFKueY1ObTRUuOfYaJvTK1Y2X5sWCEGkyDLskNh/2E4gi1WAuPHrUahAHD
         Y9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rb9RGmOmMMM2dD3TrKMy6fSbknGvk79DpYlGgni1l6k=;
        b=nnSNpX/BfH0iRf65zen3RlBezBzX6SiXGfkgE1LK+t3kAOQ1HcstnDv0TiJWfUmzCC
         juT8jCZerw+FskxBDVTHe8ajH4JbLdc0HHCVUeX0HKQMtB4HnoSvWxEPRS5U4xmj5t+G
         XiqX6SHySQQhTDFSCJhGu9GxOf5ocbsdXDaNDAebT29HRwZGQWCaUQ3TsQontOYJBELC
         DnFYIER1RGTw0zI8WHqAWHdY/RjXmw5nQkH2q6OrMcuaDOhZbBklJfcFgYVzUXAvJkKE
         6sUspFTZJtW9LoxmsfaQdxmGli7fP49QmxMqBdVHB77WhMLUNxnAj5iHpifV1381pO2B
         irGw==
X-Gm-Message-State: AOAM5309wTQFEjQU7K3HIIxRhf0QmBi16HiP5tPvEC0xlxtwodKJaol6
        hCVUrhvPfbvUMpEpYZiPHRM=
X-Google-Smtp-Source: ABdhPJzpj2UsvqpPU59Mv1QyThIf6RaZkRon2bGp4Y/Rm5lLcW6STN9oF3uQVffBebFMvN3+HiszXw==
X-Received: by 2002:a17:90a:17e6:: with SMTP id q93mr14011274pja.133.1590322159873;
        Sun, 24 May 2020 05:09:19 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a136sm10931645pfa.99.2020.05.24.05.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 05:09:19 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
To:     Andrii Nakryiko <andriin@fb.com>, paulmck@kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com,
        will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
Message-ID: <ac799c98-45dd-d056-386f-cbebc7270c0c@gmail.com>
Date:   Sun, 24 May 2020 21:09:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 22 May 2020 12:38:21 -0700, Andrii Nakryiko wrote:
> On 5/22/20 10:43 AM, Paul E. McKenney wrote:
>> On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
>>> On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
>>>> On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
>>>>> Hello!
>>>>>
>>>>> Just wanted to call your attention to some pretty cool and pretty s=
erious
>>>>> litmus tests that Andrii did as part of his BPF ring-buffer work:
>>>>>
>>>>> https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/=

>>>>>
>>>>> Thoughts?
>>>>
>>>> I find:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0smp_wmb()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0smp_store_release()
>>>>
>>>> a _very_ weird construct. What is that supposed to even do?
>>>
>>> Indeed, it looks like one or the other of those is redundant (dependi=
ng
>>> on the context).
>>
>> Probably.=C2=A0 Peter instead asked what it was supposed to even do.=C2=
=A0 ;-)
>=20
> I agree, I think smp_wmb() is redundant here. Can't remember why I thou=
ght that it's necessary, this algorithm went through a bunch of iteration=
s, starting as completely lockless, also using READ_ONCE/WRITE_ONCE at so=
me point, and settling on smp_read_acquire/smp_store_release, eventually.=
 Maybe there was some reason, but might be that I was just over-cautious.=
 See reply on patch thread as well ([0]).
>=20
> =C2=A0 [0] https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5Y=
J8zO+SoAJCDtp1jVhcQ@mail.gmail.com/
>=20
>=20
>>
>>> Also, what use is a spinlock that is accessed in only one thread?
>>
>> Multiple writers synchronize via the spinlock in this case.=C2=A0 I am=

>> guessing that his larger 16-hour test contended this spinlock.
>=20
> Yes, spinlock is for coordinating multiple producers. 2p1c cases (bound=
ed and unbounded) rely on this already. 1p1c cases are sort of subsets (b=
ut very fast to verify) checking only consumer/producer interaction.
>=20
>>
>>> Finally, I doubt that these tests belong under tools/memory-model.
>>> Shouldn't they go under the new Documentation/ directory for litmus
>>> tests?=C2=A0 And shouldn't the patch update a README file?
>>
>> Agreed, and I responded to that effect to his original patch:
>>
>> https://lore.kernel.org/bpf/20200522003433.GG2869@paulmck-ThinkPad-P72=
/
>=20
> Yep, makes sense, I'll will move.

Hi Andrii,

Andrea reported off-the-list that your litmus tests are incompatible
with the to-be-released version 7.56 of herd7 and currently available
versions of klitmus7.

This is due to a couple of C-language level issues.

herd7 used to be fairly generous in parsing C litmus tests.
On the other hand, klitmus7 converts a litmus test into a
kernel module.  The converted code is built by an actual C compiler
with kernel headers included, and can fail to build due to syntax errors
or serious warnings.
herd7 HEAD is getting slightly stricter on uninitialized variable and
it emits an error to mpsc-rb+1p1c+bounded.litmus:

Warning: File "mpsc-rb+1p1c+bounded.litmus": read on location 0 does not =
match any write

Converted code by klitmus7 fails to build with the following warning mess=
ages:

$ make
make -C /lib/modules/5.3.0-53-generic/build/ M=3D/home/akira/bpf-rb/klitm=
us modules
make[1]: Entering directory '/usr/src/linux-headers-5.3.0-53-generic'
  CC [M]  /home/akira/bpf-rb/klitmus/litmus000.o
/home/akira/bpf-rb/klitmus/litmus000.c: In function =E2=80=98code1=E2=80=99=
:
/home/akira/bpf-rb/klitmus/litmus000.c:426:14: error: passing argument 1 =
of =E2=80=98atomic_inc=E2=80=99
  from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   atomic_inc(dropped);
              ^~~~~~~
In file included from ./arch/x86/include/asm/atomic.h:265:0,
                 from ./arch/x86/include/asm/msr.h:67,
                 from ./arch/x86/include/asm/processor.h:21,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:10,
                 from /home/akira/bpf-rb/klitmus/litmus000.c:11:
=2E/include/asm-generic/atomic-instrumented.h:237:1: note: expected =E2=80=
=98atomic_t * {aka struct <anonymous> *}=E2=80=99 but argument is of type=
 =E2=80=98int *=E2=80=99
 atomic_inc(atomic_t *v)
 ^~~~~~~~~~
In file included from ./include/linux/export.h:45:0,
                 from ./include/linux/linkage.h:7,
                 from ./include/linux/kernel.h:8,
                 from ./include/linux/list.h:9,
                 from ./include/linux/module.h:9,
                 from /home/akira/bpf-rb/klitmus/litmus000.c:11:
/home/akira/bpf-rb/klitmus/litmus000.c: In function =E2=80=98thread0=E2=80=
=99:
=2E/include/linux/compiler.h:187:26: warning: =E2=80=98rLenPtr=E2=80=99 m=
ay be used uninitialized in this function [-Wmaybe-uninitialized]
  case 4: *(__u32 *)res =3D *(volatile __u32 *)p; break;  \
                          ^
/home/akira/bpf-rb/klitmus/litmus000.c:365:7: note: =E2=80=98rLenPtr=E2=80=
=99 was declared here
  int *rLenPtr;
       ^~~~~~~
In file included from ./include/linux/export.h:45:0,
                 from ./include/linux/linkage.h:7,
                 from ./include/linux/kernel.h:8,
                 from ./include/linux/list.h:9,
                 from ./include/linux/module.h:9,
                 from /home/akira/bpf-rb/klitmus/litmus000.c:11:
/home/akira/bpf-rb/klitmus/litmus000.c: In function =E2=80=98thread1=E2=80=
=99:
=2E/include/linux/compiler.h:225:31: warning: =E2=80=98rLenPtr=E2=80=99 m=
ay be used uninitialized in this function [-Wmaybe-uninitialized]
  case 4: *(volatile __u32 *)p =3D *(__u32 *)res; break;
          ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
/home/akira/bpf-rb/klitmus/litmus000.c:417:7: note: =E2=80=98rLenPtr=E2=80=
=99 was declared here
  int *rLenPtr;
       ^~~~~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:288: recipe for target '/home/akira/bpf-rb/klitmus=
/litmus000.o' failed
make[2]: *** [/home/akira/bpf-rb/klitmus/litmus000.o] Error 1
Makefile:1656: recipe for target '_module_/home/akira/bpf-rb/klitmus' fai=
led
make[1]: *** [_module_/home/akira/bpf-rb/klitmus] Error 2
make[1]: Leaving directory '/usr/src/linux-headers-5.3.0-53-generic'
Makefile:8: recipe for target 'all' failed
make: *** [all] Error 2

Appended below is a patch I applied to mpsc-rb+1p1c+bounded.litmus to mak=
e
herd7 HEAD and klitmus7 happy. (Give or take the redundant memory barrier=
=2E)

The other variants need similar changes.

What I did here are:

    - Remove unnecessary initialization (shared variables are 0 by defaul=
t)
    - Declare "dropped" as atomic_t
    - Promote rLenPtr to a shared variable LenPtr

Please note that if you are on Linux 5.6 (or later), you need an up-to-da=
te
klitmus7 due to a change in kernel API.

Any question is welcome!

        Thanks, Akira

-----------------------
diff --git a/mpsc-rb+1p1c+bounded.litmus b/mpsc-rb+1p1c+bounded.litmus
index cafd17a..5af43c1 100644
--- a/mpsc-rb+1p1c+bounded.litmus
+++ b/mpsc-rb+1p1c+bounded.litmus
@@ -17,15 +17,11 @@ C mpsc-rb+1p1c+bounded
=20
 {
 	max_len =3D 1;
-	len1 =3D 0;
-	px =3D 0;
-	cx =3D 0;
-	dropped =3D 0;
+	atomic_t dropped;
 }
=20
-P0(int *len1, int *cx, int *px)
+P0(int *len1, int *cx, int *px, int *LenPtr)
 {
-	int *rLenPtr;
 	int rLen;
 	int rPx;
 	int rCx;
@@ -37,11 +33,11 @@ P0(int *len1, int *cx, int *px)
 	rPx =3D smp_load_acquire(px);
 	if (rCx < rPx) {
 		if (rCx =3D=3D 0)
-			rLenPtr =3D len1;
+			LenPtr =3D len1;
 		else
 			rFail =3D 1;
=20
-		rLen =3D smp_load_acquire(rLenPtr);
+		rLen =3D smp_load_acquire(LenPtr);
 		if (rLen =3D=3D 0) {
 			rFail =3D 1;
 		} else if (rLen =3D=3D 1) {
@@ -51,12 +47,11 @@ P0(int *len1, int *cx, int *px)
 	}
 }
=20
-P1(int *len1, spinlock_t *rb_lock, int *px, int *cx, int *dropped, int *=
max_len)
+P1(int *len1, spinlock_t *rb_lock, int *px, int *cx, atomic_t *dropped, =
int *max_len, int *LenPtr)
 {
 	int rPx;
 	int rCx;
 	int rFail;
-	int *rLenPtr;
=20
 	rFail =3D 0;
 	rCx =3D smp_load_acquire(cx);
@@ -69,17 +64,17 @@ P1(int *len1, spinlock_t *rb_lock, int *px, int *cx, =
int *dropped, int *max_len)
 		spin_unlock(rb_lock);
 	} else {
 		if (rPx =3D=3D 0)
-			rLenPtr =3D len1;
+			LenPtr =3D len1;
 		else
 			rFail =3D 1;
=20
-		*rLenPtr =3D -1;
+		*LenPtr =3D -1;
 		smp_wmb();
 		smp_store_release(px, rPx + 1);
=20
 		spin_unlock(rb_lock);
=20
-		smp_store_release(rLenPtr, 1);
+		smp_store_release(LenPtr, 1);
 	}
 }
=20
----------------

