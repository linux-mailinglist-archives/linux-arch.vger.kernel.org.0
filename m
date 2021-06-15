Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753A73A7317
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 02:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhFOA5k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 20:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFOA5k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 20:57:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD24C061767;
        Mon, 14 Jun 2021 17:55:21 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g4so10810820pjk.0;
        Mon, 14 Jun 2021 17:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=QzrGxTnPUC0jBXV0ew4TX56ApKartjN9afHhkE9XLEE=;
        b=FCfbIXXUJ9eD9iOp6G0KQqQGSKE4giS4Nt4l9IMPEFUcnjgYZddmFf6Wt8XKNl0KEw
         qttfH81lEIgK7PMN6clfFzEiTLG6+VhHnO51V8zMbZ/TS68/i2LDxgoc1F9XDMp0qclr
         SARt0s6cBrlzJ592WRTKguK2SES+kMtd/XF00k7Fhu28g3h4OiRh7hfoLqtXqQbLq7Mm
         jsbl6lBzZ5611JE9efl8EesI5rAUjPeySV90w5LOPlVwiDr7AYu3TcVeaAH8lgEb4CVb
         vvAkhABp51viWpluDNSyosBLo8v3IgE/7NoVvK8i10mt7pxPDuSRpgQbt3+Q869EmoJJ
         ysdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=QzrGxTnPUC0jBXV0ew4TX56ApKartjN9afHhkE9XLEE=;
        b=Sr7hEDz9WQnpIvCINcP5FXlKFpOPEd9GL3GHZKzezRsU7jdIaD41NXkggCbc9dXzMd
         pD/s5bakVUxITDYZPGSam3XMeOdkkz/uRZtpR0hDTiJfWEc3cvMXCdhmH6l8/5q7EdqE
         Ru1NDZMbROo0fiKkjZDdrTcmOG8ekhgXcMP+RaB+QSCQQ8CkU3dlwK2C8Fk8EGtxKcUK
         XfQeFVb/oKtvpKRMaOwKvTCgs+YeQTg6xkisTdndWI7J7WzKmRa5FP/TzoPE0Tl3CtCs
         wviIS3RLWfwKoYRYc8bxe4rluqwHlRyoQw2+7BN6Z9zdVvpVObdSdRr2YlD39rwWp5uX
         JoZA==
X-Gm-Message-State: AOAM531f4AlBJDYzwGDdkRYPP/VikKLOgjFC46kwF3JLpM+NzwK41Yjv
        KMCZidpJ1TnXrfI6jqT6OcY=
X-Google-Smtp-Source: ABdhPJx6GGY387qPBCOxNwRjZWcTOS6D6cRRTljNq3x31g0rJKHMy831BJ/WWcKDTMyTJ4anVdRfVQ==
X-Received: by 2002:a17:902:e550:b029:110:3074:e7cd with SMTP id n16-20020a170902e550b02901103074e7cdmr1706050plf.25.1623718520421;
        Mon, 14 Jun 2021 17:55:20 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id c62sm13768027pfa.12.2021.06.14.17.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:55:19 -0700 (PDT)
Date:   Tue, 15 Jun 2021 10:55:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 2/4] lazy tlb: allow lazy tlb mm refcounting to be
 configurable
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-3-npiggin@gmail.com>
        <8ac1d420-b861-f586-bacf-8c3949e9b5c4@kernel.org>
        <1623629185.fxzl5xdab6.astroid@bobo.none>
        <02e16a2f-2f58-b4f2-d335-065e007bcea2@kernel.org>
        <1623643443.b9twp3txmw.astroid@bobo.none>
        <1623645385.u2cqbcn3co.astroid@bobo.none>
        <1623647326.0np4yc0lo0.astroid@bobo.none>
        <aecf5bc8-9018-c021-287d-6a975b7a6235@kernel.org>
In-Reply-To: <aecf5bc8-9018-c021-287d-6a975b7a6235@kernel.org>
MIME-Version: 1.0
Message-Id: <1623715482.4lskm3cx10.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 15, 2021 2:20 am:
> Replying to several emails at once...
>=20
>=20
> On 6/13/21 10:21 PM, Nicholas Piggin wrote:
>> Excerpts from Nicholas Piggin's message of June 14, 2021 2:47 pm:
>>> Excerpts from Nicholas Piggin's message of June 14, 2021 2:14 pm:
>>>> Excerpts from Andy Lutomirski's message of June 14, 2021 1:52 pm:
>>>>> On 6/13/21 5:45 PM, Nicholas Piggin wrote:
>>>>>> Excerpts from Andy Lutomirski's message of June 9, 2021 2:20 am:
>>>>>>> On 6/4/21 6:42 PM, Nicholas Piggin wrote:
>>>>>>>> Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy =
tlb mm
>>>>>>>> when it is context switched. This can be disabled by architectures=
 that
>>>>>>>> don't require this refcounting if they clean up lazy tlb mms when =
the
>>>>>>>> last refcount is dropped. Currently this is always enabled, which =
is
>>>>>>>> what existing code does, so the patch is effectively a no-op.
>>>>>>>>
>>>>>>>> Rename rq->prev_mm to rq->prev_lazy_mm, because that's what it is.
>>>>>>>
>>>>>>> I am in favor of this approach, but I would be a lot more comfortab=
le
>>>>>>> with the resulting code if task->active_mm were at least better
>>>>>>> documented and possibly even guarded by ifdefs.
>>>>>>
>>>>>> active_mm is fairly well documented in Documentation/active_mm.rst I=
MO.
>>>>>> I don't think anything has changed in 20 years, I don't know what mo=
re
>>>>>> is needed, but if you can add to documentation that would be nice. M=
aybe
>>>>>> moving a bit of that into .c and .h files?
>>>>>>
>>>>>
>>>>> Quoting from that file:
>>>>>
>>>>>   - however, we obviously need to keep track of which address space w=
e
>>>>>     "stole" for such an anonymous user. For that, we have "tsk->activ=
e_mm",
>>>>>     which shows what the currently active address space is.
>>>>>
>>>>> This isn't even true right now on x86.
>>>>
>>>> From the perspective of core code, it is. x86 might do something crazy=
=20
>>>> with it, but it has to make it appear this way to non-arch code that
>>>> uses active_mm.
>>>>
>>>> Is x86's scheme documented?
>=20
> arch/x86/include/asm/tlbflush.h documents it a bit:
>=20
>         /*
>          * cpu_tlbstate.loaded_mm should match CR3 whenever interrupts
>          * are on.  This means that it may not match current->active_mm,
>          * which will contain the previous user mm when we're in lazy TLB
>          * mode even if we've already switched back to swapper_pg_dir.
>          *
>          * During switch_mm_irqs_off(), loaded_mm will be set to
>          * LOADED_MM_SWITCHING during the brief interrupts-off window
>          * when CR3 and loaded_mm would otherwise be inconsistent.  This
>          * is for nmi_uaccess_okay()'s benefit.
>          */

So the only documentation relating to the current active_mm value or=20
refcounting is that it may not match what the x86 specific code is=20
doing?

All this complexity you accuse me of adding is entirely in x86 code.
On other architectures, it's very simple and understandable, and=20
documented. I don't know how else to explain this.

>>>>
>>>>> With your patch applied:
>>>>>
>>>>>  To support all that, the "struct mm_struct" now has two counters: a
>>>>>  "mm_users" counter that is how many "real address space users" there=
 are,
>>>>>  and a "mm_count" counter that is the number of "lazy" users (ie anon=
ymous
>>>>>  users) plus one if there are any real users.
>>>>>
>>>>> isn't even true any more.
>>>>
>>>> Well yeah but the active_mm concept hasn't changed. The refcounting=20
>>>> change is hopefully reasonably documented?
>=20
> active_mm is *only* refcounting in the core code.  See below.

It's just not. It's passed in to switch_mm. Most architectures except=20
for x86 require this.

>>>>>
>>>>> I looked through all active_mm references in core code.  We have:
>>>>>
>>>>> kernel/sched/core.c: it's all refcounting, although it's a bit tangle=
d
>>>>> with membarrier.
>>>>>
>>>>> kernel/kthread.c: same.  refcounting and membarrier stuff.
>>>>>
>>>>> kernel/exit.c: exit_mm() a BUG_ON().
>>>>>
>>>>> kernel/fork.c: initialization code and a warning.
>>>>>
>>>>> kernel/cpu.c: cpu offline stuff.  wouldn't be needed if active_mm wen=
t away.
>>>>>
>>>>> fs/exec.c: nothing of interest
>>>>
>>>> I might not have been clear. Core code doesn't need active_mm if=20
>>>> active_mm somehow goes away. I'm saying active_mm can't go away becaus=
e
>>>> it's needed to support (most) archs that do lazy tlb mm switching.
>>>>
>>>> The part I don't understand is when you say it can just go away. How?=20
>=20
> #ifdef CONFIG_MMU_TLB_REFCOUNT
> 	struct mm_struct *active_mm;
> #endif

Thanks for returning the snark.

>>>>
>>>>> I didn't go through drivers, but I maintain my point.  active_mm is
>>>>> there for refcounting.  So please don't just make it even more confus=
ing
>>>>> -- do your performance improvement, but improve the code at the same
>>>>> time: get rid of active_mm, at least on architectures that opt out of
>>>>> the refcounting.
>>>>
>>>> powerpc opts out of the refcounting and can not "get rid of active_mm"=
.
>>>> Not even in theory.
>>>
>>> That is to say, it does do a type of reference management that requires=
=20
>>> active_mm so you can argue it has not entirely opted out of refcounting=
.
>>> But we're not just doing refcounting for the sake of refcounting! That
>>> would make no sense.
>>>
>>> active_mm is required because that's the mm that we have switched to=20
>>> (from core code's perspective), and it is integral to know when to=20
>>> switch to a different mm. See how active_mm is a fundamental concept
>>> in core code? It's part of the contract between core code and the
>>> arch mm context management calls. reference counting follows from there
>>> but it's not the _reason_ for this code.
>=20
> I don't understand what contract you're talking about.  The core code
> maintains an active_mm counter and keeps that mm_struct from
> disappearing.  That's *it*.  The core code does not care that active_mm
> is active, and x86 provides evidence of that -- on x86,
> current->active_mm may well be completely unused.

I already acknowledged archs can do their own thing under the covers if=20
they want.

>=20
>>>
>>> Pretend the reference problem does not exit (whether by refcounting or=20
>>> shootdown or garbage collection or whatever). We still can't remove=20
>>> active_mm! We need it to know how to call into arch functions like=20
>>> switch_mm.
>=20
> static inline void do_switch_mm(struct task_struct *prev_task, ...)
> {
> #ifdef CONFIG_MMU_TLB_REFCOUNT
> 	switch_mm(...);
> #else
> 	switch_mm(fewer parameters);
> 	/* or pass NULL or whatever. */
> #endif
> }

And prev_task comes from active_mm, ergo core code requires the concept=20
of active_mm.

I already said I'm quite happy for wrappers to be added so those can=20
compile out of an arch like x86. That's not doing anything for=20
complexity of core code, because it still needs to maintain the active=20
mm wrappers.

>>> I don't know if you just forgot that critical requirement in your above=
=20
>>> list, or you actually are entirely using x86's mental model for this=20
>>> code which is doing something entirely different that does not need it=20
>>> at all. If that is the case I really don't mind some cleanup or wrapper=
=20
>>> functions for x86 do entirely do its own thing, but if that's the case
>>> you can't criticize core code's use of active_mm due to the current
>>> state of x86. It's x86 that needs documentation and cleaning up.
>>=20
>> Ah, that must be where your confusion is coming from: x86's switch_mm=20
>> doesn't use prev anywhere, and the reference scheme it is using appears=20
>> to be under-documented, although vague references in changelogs suggest=20
>> it has not actually "opted out" of active_mm refcounting.
>=20
> All of this is true, except I don't believe I'm confused.

Well someone is. My patches don't change any of the fundamental=20
complexity of core code's maintaining of active_mm, nor alleviate the
requirement to keep active_mm around under the new config introduced,
and yet you are saying:

  I am in favor of this approach, but I would be a lot more comfortable
  with the resulting code if task->active_mm were at least better
  documented and possibly even guarded by ifdefs.

It doesn't make sense. It can't be guarded by ifdefs even if we took
away the shootdown IPI's use of it as part of reference / lifetime
management.

And that you don't like the state of the code but I'm trying to wrangle=20
specifics out of you on that and it's difficult.

>>=20
>> That's understandable, but please redirect your objections to the proper=
=20
>> place. git blame suggests 3d28ebceaffab.
>=20
> Thanks for the snark.

Is it not true? I don't mean that one patch causing all the x86=20
complexity or even making the situation worse itself. But you seem to be=20
asking my series to do things that really apply to the x86 changes over
the past few years that got us here.

>=20
> Here's the situation.
>=20
> Before that patch, x86 more or less fully used the core scheme.  With
> that patch, x86 has the property that loaded_mm (which is used) either
> points to init_mm (which is permanently live) or to active_mm (which the
> core code keeps alive, which is the whole point).  x86 still uses the
> core active_mm refcounting scheme.  The result is a bit overcomplicated,
> but it works, and it enabled massive improvements to the x86 arch code.
>=20
> You are proposing a whole new simplification in which an arch can opt in
> to telling the core code that it doesn't need to keep active_mm alive.
> Great!  But now it's possible to get quite confused -- either an
> elaborate dance is needed or current->active_mm could point to freed
> memory.  This is poor design.

powerpc still needs active_mm, there's zero point to configuring it away=20
and maintaining exactly the same thing in a per-cpu variable in the arch
code because the code has to be there in the core for all other archs
anyway so that would be stupid.

I would be more than happy to try help review a patch that helps the
x86 situation, but my patch is not intended to do what x86 code wants.

> I'm entirely in favor of allowing arches to opt out of active_mm
> refcounting.  As you've noticed, it's quite expensive on large systems.
> x86 would opt out, too, if given the opportunity [1].  But I think you
> should do it right.  If an arch opts out of active_mm refcounting, then
> keeping a lazy mm (if any!) alive becomes entirely the arch code's
> responsibility.
>
> Once that happens, task->active_mm is not just a waste
> of 4-8 bytes of memory per task, it's actively harmful -- some code,
> somewhere in the kernel, might dereference it and access freed memory!

That's not an accurate description of my patches. powerpc still requires=20
active_mm exactly the same, and the "elaborate dance" amounts to having
CPUs stop using the mm as a lazy tlb when the last user goes away.

>=20
> So please do your patches right.  By all means add a new config option,
> but make that config option make active_mm go away entirely.  Then it
> can't be misused.

I already have a patch that's halfway there I pulled out of the series
for the last submission. As I said, feel free to build on it.

>=20
> NAK to the current set.

I propose instead we do take the series, and write some patches on top=20
of that which helps x86. Here's 1/n

2/n is to make wrappers for active_mm maintenance in core code.

3/n is adjust context_switch_nolazy() to just use init_mm (or NULL) directl=
y
and put ifdefs around active_mm.

Is that what x86 wants?

Thanks,
Nick

commit 99f90520821b9717d4447872354c2933894a1100
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Thu Jul 9 15:01:25 2020 +1000

    lazy tlb: allow lazy tlb mm switching to be configurable
   =20
    Add CONFIG_MMU_LAZY_TLB which can be configured out to disable the lazy
    tlb mechanism entirely, and switches to init_mm when switching to a
    kernel thread.
   =20
    NOMMU systems could easily go without this and save a bit of code and
    the refcount atomics, because their mm switch is a no-op. They have not
    been switched over by default because the arch code needs to be audited
    and tested for lazy tlb mm refcounting and converted to _lazy_tlb
    refcounting if necessary.
   =20
    CONFIG_MMU_LAZY_TLB_REFCOUNT is also added, but it must always be
    enabled if CONFIG_MMU_LAZY_TLB is enabled until the next patch which
    provides an alternate scheme.
   =20
    Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

diff --git a/arch/Kconfig b/arch/Kconfig
index cf468c9777d8..3b80042bd0c2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -418,6 +418,26 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	  irqs disabled over activate_mm. Architectures that do IPI based TLB
 	  shootdowns should enable this.
=20
+# Enable "lazy TLB", which means a user->kernel thread context switch does=
 not
+# switch the mm to init_mm and the kernel thread takes a reference to the =
user
+# mm to provide its kernel mapping. This is how Linux has traditionally wo=
rked
+# (see Documentation/vm/active_mm.rst), for performance. Switching to and =
from
+# idle thread is a performance-critical case.
+#
+# If mm context switches are inexpensive or free (in the case of NOMMU) th=
en
+# this could be disabled.
+#
+# It would make sense to have this depend on MMU, but need to audit and te=
st
+# the NOMMU architectures for lazy mm refcounting first.
+config MMU_LAZY_TLB
+	def_bool y
+	depends on !NO_MMU_LAZY_TLB
+
+# This allows archs to disable MMU_LAZY_TLB. mmgrab/mmdrop in arch/ code h=
as
+# to be audited and switched to _lazy_tlb postfix as necessary.
+config NO_MMU_LAZY_TLB
+	def_bool n
+
 # Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
 # MMU_LAZY_TLB_REFCOUNT=3Dn can improve the scalability of context switchi=
ng
 # to/from kernel threads when the same mm is running on a lot of CPUs (a l=
arge
@@ -431,6 +451,7 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 # to a kthread ->active_mm (non-arch code has been converted already).
 config MMU_LAZY_TLB_REFCOUNT
 	def_bool y
+	depends on MMU_LAZY_TLB
 	depends on !MMU_LAZY_TLB_SHOOTDOWN
=20
 # This option allows MMU_LAZY_TLB_REFCOUNT=3Dn. It ensures no CPUs are usi=
ng an
@@ -445,6 +466,7 @@ config MMU_LAZY_TLB_REFCOUNT
 # MMU_LAZY_TLB_REFCOUNT=3Dn (see above).
 config MMU_LAZY_TLB_SHOOTDOWN
 	bool
+	depends on MMU_LAZY_TLB
=20
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10cb712be3..5cb039c686a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4285,22 +4285,10 @@ asmlinkage __visible void schedule_tail(struct task=
_struct *prev)
 	calculate_sigpending();
 }
=20
-/*
- * context_switch - switch to the new MM and the new thread's register sta=
te.
- */
-static __always_inline struct rq *
-context_switch(struct rq *rq, struct task_struct *prev,
-	       struct task_struct *next, struct rq_flags *rf)
+static __always_inline void
+context_switch_mm(struct rq *rq, struct task_struct *prev,
+	       struct task_struct *next)
 {
-	prepare_task_switch(rq, prev, next);
-
-	/*
-	 * For paravirt, this is coupled with an exit in switch_to to
-	 * combine the page table reload and the switch backend into
-	 * one hypercall.
-	 */
-	arch_start_context_switch(prev);
-
 	/*
 	 * kernel -> kernel   lazy + transfer active
 	 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
@@ -4345,6 +4333,40 @@ context_switch(struct rq *rq, struct task_struct *pr=
ev,
 #endif
 		}
 	}
+}
+
+static __always_inline void
+context_switch_mm_nolazy(struct rq *rq, struct task_struct *prev,
+	       struct task_struct *next)
+{
+	if (!next->mm)
+		next->active_mm =3D &init_mm;
+	membarrier_switch_mm(rq, prev->active_mm, next->active_mm);
+	switch_mm_irqs_off(prev->active_mm, next->active_mm, next);
+	if (!prev->mm)
+		prev->active_mm =3D NULL;
+}
+
+/*
+ * context_switch - switch to the new MM and the new thread's register sta=
te.
+ */
+static __always_inline struct rq *
+context_switch(struct rq *rq, struct task_struct *prev,
+	       struct task_struct *next, struct rq_flags *rf)
+{
+	prepare_task_switch(rq, prev, next);
+
+	/*
+	 * For paravirt, this is coupled with an exit in switch_to to
+	 * combine the page table reload and the switch backend into
+	 * one hypercall.
+	 */
+	arch_start_context_switch(prev);
+
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+		context_switch_mm(rq, prev, next);
+	else
+		context_switch_mm_nolazy(rq, prev, next);
=20
 	rq->clock_update_flags &=3D ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
=20
