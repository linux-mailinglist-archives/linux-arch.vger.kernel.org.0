Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADC8387D07
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbhERQDe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 12:03:34 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41974 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbhERQDe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 12:03:34 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lj2Ac-00AUYJ-9D; Tue, 18 May 2021 10:02:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lj2AZ-0004Ye-GI; Tue, 18 May 2021 10:02:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
References: <20210517203343.3941777-1-arnd@kernel.org>
        <20210517203343.3941777-2-arnd@kernel.org>
        <m1bl982m8c.fsf@fess.ebiederm.org>
        <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
        <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
Date:   Tue, 18 May 2021 11:01:57 -0500
In-Reply-To: <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com>
        (Arnd Bergmann's message of "Tue, 18 May 2021 16:17:53 +0200")
Message-ID: <m18s4c1156.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lj2AZ-0004Ye-GI;;;mid=<m18s4c1156.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3KUt9n9NsCywLTywTeK8LOKWYroFccQo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Arnd Bergmann <arnd@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2158 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (0.5%), b_tie_ro: 9 (0.4%), parse: 0.96 (0.0%),
         extract_message_metadata: 16 (0.7%), get_uri_detail_list: 2.1 (0.1%),
        tests_pri_-1000: 21 (1.0%), tests_pri_-950: 1.24 (0.1%),
        tests_pri_-900: 1.05 (0.0%), tests_pri_-90: 258 (11.9%), check_bayes:
        253 (11.7%), b_tokenize: 9 (0.4%), b_tok_get_all: 8 (0.4%),
        b_comp_prob: 2.5 (0.1%), b_tok_touch_all: 217 (10.1%), b_finish: 13
        (0.6%), tests_pri_0: 1766 (81.8%), check_dkim_signature: 0.95 (0.0%),
        check_dkim_adsp: 10 (0.4%), poll_dns_idle: 7 (0.3%), tests_pri_10: 28
        (1.3%), tests_pri_500: 53 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> On Tue, May 18, 2021 at 4:05 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> On Tue, May 18, 2021 at 3:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >
>> > Arnd Bergmann <arnd@kernel.org> writes:
>> >
>> > > From: Arnd Bergmann <arnd@arndb.de>KEXEC_ARCH_DEFAULT
>> > >
>> > > The compat version of sys_kexec_load() uses compat_alloc_user_space to
>> > > convert the user-provided arguments into the native format.
>> > >
>> > > Move the conversion into the regular implementation with
>> > > an in_compat_syscall() check to simplify it and avoid the
>> > > compat_alloc_user_space() call.
>> > >
>> > > compat_sys_kexec_load() now behaves the same as sys_kexec_load().
>> >
>> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> >KEXEC_ARCH_DEFAULT
>> > The patch is wrong.
>> >
>> > The logic between the compat entry point and the ordinary entry point
>> > are by necessity different.   This unifies the logic and breaks the compat
>> > entry point.
>> >
>> > The fundamentally necessity is that the code being loaded needs to know
>> > which mode the kernel is running in so it can safely transition to the
>> > new kernel.
>> >
>> > Given that the two entry points fundamentally need different logic,
>> > and that difference was not preserved and the goal of this patchset
>> > was to unify that which fundamentally needs to be different.  I don't
>> > think this patch series makes any sense for kexec.
>>
>> Sorry, I'm not following that explanation. Can you clarify what different
>> modes of the kernel you are referring to here, and how my patch
>> changes this?
>
> I think I figured it out now myself after comparing the two functions:
>
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -269,7 +269,8 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry,
> unsigned long, nr_segments,
>
>         /* Verify we are on the appropriate architecture */
>         if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
> -               ((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
> +               (in_compat_syscall() ||
> +               ((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT)))
>                 return -EINVAL;
>
>         /* Because we write directly to the reserved memory
>
> Not sure if that's the best way of doing it, but it looks like folding this
> in restores the current behavior.

Yes.  That is pretty much all there is.

I personally can't stand the sight of in_compat_syscall() doubly so when
you have to lie to the type system with casts.  The cognitive dissonance
I experience is extreme.

I will be happy to help you find another way to get rid of
compat_alloc_user, but not that way.


There is a whole mess in there that was introduced when someone added
do_kexec_load while I was napping in 2017 that makes the system calls an
absolute mess.  It all needs to be cleaned up.

Eric
