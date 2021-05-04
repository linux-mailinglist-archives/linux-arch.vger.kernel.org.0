Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC864372DD9
	for <lists+linux-arch@lfdr.de>; Tue,  4 May 2021 18:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhEDQRt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 May 2021 12:17:49 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58016 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhEDQRs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2021 12:17:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldxj7-0016mO-3L; Tue, 04 May 2021 10:16:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldxj5-00GMeL-GN; Tue, 04 May 2021 10:16:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <m14kfjh8et.fsf_-_@fess.ebiederm.org>
        <20210503203814.25487-1-ebiederm@xmission.com>
        <20210503203814.25487-10-ebiederm@xmission.com>
        <m1o8drfs1m.fsf@fess.ebiederm.org>
        <CANpmjNNOK6Mkxkjx5nD-t-yPQ-oYtaW5Xui=hi3kpY_-Y0=2JA@mail.gmail.com>
        <m1lf8vb1w8.fsf@fess.ebiederm.org>
        <CAMn1gO7+wMzHoGtp2t3=jJxRmPAGEbhnUDFLQQ0vFXZ2NP8stg@mail.gmail.com>
        <YJEZdhe6JGFNYlum@elver.google.com>
Date:   Tue, 04 May 2021 11:16:43 -0500
In-Reply-To: <YJEZdhe6JGFNYlum@elver.google.com> (Marco Elver's message of
        "Tue, 4 May 2021 11:52:54 +0200")
Message-ID: <m1im3ya2z8.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ldxj5-00GMeL-GN;;;mid=<m1im3ya2z8.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+LzdVYRglNd0Xkn7k8K8l9BDDFZViEpes=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=8.0 tests=ALL_TRUSTED,BAYES_05,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_SpammyWords,XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0158]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 980 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (0.9%), b_tie_ro: 8 (0.8%), parse: 1.00 (0.1%),
        extract_message_metadata: 14 (1.4%), get_uri_detail_list: 4.0 (0.4%),
        tests_pri_-1000: 13 (1.3%), tests_pri_-950: 1.24 (0.1%),
        tests_pri_-900: 1.02 (0.1%), tests_pri_-90: 250 (25.5%), check_bayes:
        248 (25.3%), b_tokenize: 14 (1.5%), b_tok_get_all: 12 (1.3%),
        b_comp_prob: 4.8 (0.5%), b_tok_touch_all: 208 (21.2%), b_finish: 4.9
        (0.5%), tests_pri_0: 672 (68.6%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 0.54 (0.1%), tests_pri_10:
        2.6 (0.3%), tests_pri_500: 13 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 10/12] signal: Redefine signinfo so 64bit fields are possible
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Mon, May 03, 2021 at 09:03PM -0700, Peter Collingbourne wrote:
>> On Mon, May 3, 2021 at 8:42 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> > Marco Elver <elver@google.com> writes:
>> > > On Mon, 3 May 2021 at 23:04, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> > >> "Eric W. Beiderman" <ebiederm@xmission.com> writes:
>> > >> > From: "Eric W. Biederman" <ebiederm@xmission.com>
>> > >> >
>> > >> > The si_perf code really wants to add a u64 field.  This change enables
>> > >> > that by reorganizing the definition of siginfo_t, so that a 64bit
>> > >> > field can be added without increasing the alignment of other fields.
>> > >
>> > > If you can, it'd be good to have an explanation for this, because it's
>> > > not at all obvious -- some future archeologist will wonder how we ever
>> > > came up with this definition of siginfo...
>> > >
>> > > (I see the trick here is that before the union would have changed
>> > > alignment, introducing padding after the 3 ints -- but now because the
>> > > 3 ints are inside the union the union's padding no longer adds padding
>> > > for these ints.  Perhaps you can explain it better than I can. Also
>> > > see below.)
>> >
>> > Yes.  The big idea is adding a 64bit field into the second union
>> > in the _sigfault case will increase the alignment of that second
>> > union to 64bit.
>> >
>> > In the 64bit case the alignment is already 64bit so it is not an
>> > issue.
>> >
>> > In the 32bit case there are 3 ints followed by a pointer.  When the
>> > 64bit member is added the alignment of _segfault becomes 64bit.  That
>> > 64bit alignment after 3 ints changes the location of the 32bit pointer.
>> >
>> > By moving the 3 preceding ints into _segfault that does not happen.
>> >
>> >
>> >
>> > There remains one very subtle issue that I think isn't a problem
>> > but I would appreciate someone else double checking me.
>> >
>> >
>> > The old definition of siginfo_t on 32bit almost certainly had 32bit
>> > alignment.  With the addition of a 64bit member siginfo_t gains 64bit
>> > alignment.  This difference only matters if the 64bit field is accessed.
>> > Accessing a 64bit field with 32bit alignment will cause unaligned access
>> > exceptions on some (most?) architectures.
>> >
>> > For the 64bit field to be accessed the code needs to be recompiled with
>> > the new headers.  Which implies that when everything is recompiled
>> > siginfo_t will become 64bit aligned.
>> >
>> >
>> > So the change should be safe unless someone is casting something with
>> > 32bit alignment into siginfo_t.
>> 
>> How about if someone has a field of type siginfo_t as an element of a
>> struct? For example:
>> 
>> struct foo {
>>   int x;
>>   siginfo_t y;
>> };
>> 
>> With this change wouldn't the y field move from offset 4 to offset 8?
>
> This is a problem if such a struct is part of the ABI -- in the kernel I
> found these that might be problematic:
>
> | arch/csky/kernel/signal.c:struct rt_sigframe {
> | arch/csky/kernel/signal.c-	/*
> | arch/csky/kernel/signal.c-	 * pad[3] is compatible with the same struct defined in
> | arch/csky/kernel/signal.c-	 * gcc/libgcc/config/csky/linux-unwind.h
> | arch/csky/kernel/signal.c-	 */
> | arch/csky/kernel/signal.c-	int pad[3];
> | arch/csky/kernel/signal.c-	struct siginfo info;
> | arch/csky/kernel/signal.c-	struct ucontext uc;
> | arch/csky/kernel/signal.c-};
> | [...]
> | arch/parisc/include/asm/rt_sigframe.h-#define SIGRETURN_TRAMP 4
> | arch/parisc/include/asm/rt_sigframe.h-#define SIGRESTARTBLOCK_TRAMP 5 
> | arch/parisc/include/asm/rt_sigframe.h-#define TRAMP_SIZE (SIGRETURN_TRAMP + SIGRESTARTBLOCK_TRAMP)
> | arch/parisc/include/asm/rt_sigframe.h-
> | arch/parisc/include/asm/rt_sigframe.h:struct rt_sigframe {
> | arch/parisc/include/asm/rt_sigframe.h-	/* XXX: Must match trampoline size in arch/parisc/kernel/signal.c 
> | arch/parisc/include/asm/rt_sigframe.h-	        Secondary to that it must protect the ERESTART_RESTARTBLOCK
> | arch/parisc/include/asm/rt_sigframe.h-		trampoline we left on the stack (we were bad and didn't 
> | arch/parisc/include/asm/rt_sigframe.h-		change sp so we could run really fast.) */
> | arch/parisc/include/asm/rt_sigframe.h-	unsigned int tramp[TRAMP_SIZE];
> | arch/parisc/include/asm/rt_sigframe.h-	struct siginfo info;
> | [..]
> | arch/parisc/kernel/signal32.h-#define COMPAT_SIGRETURN_TRAMP 4
> | arch/parisc/kernel/signal32.h-#define COMPAT_SIGRESTARTBLOCK_TRAMP 5
> | arch/parisc/kernel/signal32.h-#define COMPAT_TRAMP_SIZE (COMPAT_SIGRETURN_TRAMP + \
> | arch/parisc/kernel/signal32.h-				COMPAT_SIGRESTARTBLOCK_TRAMP)
> | arch/parisc/kernel/signal32.h-
> | arch/parisc/kernel/signal32.h:struct compat_rt_sigframe {
> | arch/parisc/kernel/signal32.h-        /* XXX: Must match trampoline size in arch/parisc/kernel/signal.c
> | arch/parisc/kernel/signal32.h-                Secondary to that it must protect the ERESTART_RESTARTBLOCK
> | arch/parisc/kernel/signal32.h-                trampoline we left on the stack (we were bad and didn't
> | arch/parisc/kernel/signal32.h-                change sp so we could run really fast.) */
> | arch/parisc/kernel/signal32.h-        compat_uint_t tramp[COMPAT_TRAMP_SIZE];
> | arch/parisc/kernel/signal32.h-        compat_siginfo_t info;
>
> Adding these static asserts to parisc shows the problem:
>
> | diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
> | index fb1e94a3982b..0be582fb81be 100644
> | --- a/arch/parisc/kernel/signal.c
> | +++ b/arch/parisc/kernel/signal.c
> | @@ -610,3 +610,6 @@ void do_notify_resume(struct pt_regs *regs, long in_syscall)
> |  	if (test_thread_flag(TIF_NOTIFY_RESUME))
> |  		tracehook_notify_resume(regs);
> |  }
> | +
> | +static_assert(sizeof(unsigned long) == 4); // 32 bit build
> | +static_assert(offsetof(struct rt_sigframe, info) == 9 * 4);
>
> This passes without the siginfo rework in this patch. With it:
>
> | ./include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct rt_sigframe, info) == 9 * 4"
>
> As sad as it is, I don't think we can have our cake and eat it, too. :-(
>
> Unless you see why this is fine, I think we need to drop this patch and
> go back to the simpler version you had.

No.  I really can't.  I think we are stuck with 32bit alignment on 32bit
architectures at this point.  Which precludes 32bit architectures from
including a 64bit field.

The variant of this that concerns me the most is siginfo_t embedded in a
structure in a library combined with code that is compiled with new
headers.  The offset of the embedded siginfo_t could very easily change
and break things.

That makes the alignment an ABI property we can't mess with.  Shame.

I will figure out some static asserts to verify this property remains
on 32bit and respin this series.

Eric
