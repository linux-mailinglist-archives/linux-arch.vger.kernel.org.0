Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4436D3C2646
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jul 2021 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhGIOwn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jul 2021 10:52:43 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55144 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhGIOwn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jul 2021 10:52:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m1rpD-00A8qA-70; Fri, 09 Jul 2021 08:49:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:56964 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m1rpB-00F0wm-2v; Fri, 09 Jul 2021 08:49:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@gmail.com>, yili0568@gmail.com,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
        <20210706041820.1536502-11-chenhuacai@loongson.cn>
        <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
        <CAAhV-H4WtGqgYF_zDhaS9+Ja7k=Zs8O2qWo5GqHDDf5cKw-zow@mail.gmail.com>
        <CAK8P3a1GQ=P-kNB5+wUkyqV0uD11uHCJZSQ7gbkwjev0GhuJTQ@mail.gmail.com>
        <CAAhV-H4Yqo090vmy0Y7hGzguP9Q_C+EuZvsq7D43dA=J0f_1qA@mail.gmail.com>
        <CAK8P3a0QYcKaCSt9gfvDxDYOhBywihba+wWozspzytssmkx3tw@mail.gmail.com>
Date:   Fri, 09 Jul 2021 09:49:10 -0500
In-Reply-To: <CAK8P3a0QYcKaCSt9gfvDxDYOhBywihba+wWozspzytssmkx3tw@mail.gmail.com>
        (Arnd Bergmann's message of "Fri, 9 Jul 2021 12:22:42 +0200")
Message-ID: <875yxjee55.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m1rpB-00F0wm-2v;;;mid=<875yxjee55.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/1M7Km3cPABMWNGArCi61yOmDh3o+GL1w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1115 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.1 (0.4%), b_tie_ro: 2.9 (0.3%), parse: 0.74
        (0.1%), extract_message_metadata: 12 (1.1%), get_uri_detail_list: 2.5
        (0.2%), tests_pri_-1000: 5 (0.5%), tests_pri_-950: 1.08 (0.1%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 77 (6.9%), check_bayes: 76
        (6.8%), b_tokenize: 9 (0.8%), b_tok_get_all: 11 (1.0%), b_comp_prob:
        2.4 (0.2%), b_tok_touch_all: 50 (4.5%), b_finish: 0.63 (0.1%),
        tests_pri_0: 460 (41.3%), check_dkim_signature: 0.42 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 523 (46.9%), tests_pri_10:
        2.6 (0.2%), tests_pri_500: 549 (49.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Fri, Jul 9, 2021 at 11:24 AM Huacai Chen <chenhuacai@gmail.com> wrote:
>> On Thu, Jul 8, 2021 at 9:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thu, Jul 8, 2021 at 3:04 PM Huacai Chen <chenhuacai@gmail.com> wrote:
>> > > On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> > > > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>> > > > > +
>> > > > > +#ifndef _NSIG
>> > > > > +#define _NSIG          128
>> > > > > +#endif
>> > > >
>> > > > Everything else uses 64 here, except for MIPS.
>> > >
>> > > Once before we also wanted to use 64, but we also want to use LBT to
>> > > execute X86/MIPS/ARM binaries, so we chose the largest value (128).
>> > > Some applications, such as sighold02 in LTP, will fail if _NSIG is not
>> > > big enough.
>> >
>> > Have you tried separating the in-kernel _NSIG from the number used
>> > in the loongarch ABI? This may require a few changes to architecture
>> > independent signal handling code, but I think it would be a cleaner
>> > solution, and make it easier to port existing software without having
>> > to special-case loongarch along with mips.
>>
>> Jun Yi (yili0568@gmail.com) is my colleague who develops LBT software,
>> he has some questions about how to "separate the in-kernel _NSIG from
>> the number used in the LoongArch ABI".
>
> This ties in with how the foreign syscall implementation is done for LBT,
> and I don't know what you have today, on that side, since it is not part
> of the initial submission.
>
> I think what this means in the end is that any system call that takes
> a sigset_t argument will have to behave differently based on the
> architecture. At the moment, we have
>
> - compat_old_sigset_t (always 32-bit)
> - old_sigset_t (always word size: 32 or 64)
> - sigset_t (always 64, except on mips)
>
> The code dealing with old_sigset_t/compat_old_sigset_t shows how
> a kernel can deal with having different sigset sizes in user space, but
> now we need the same thing for sigset_t as well, if you have a kernel
> that needs to deal with both 128-bit and 64-bit masks in user space.
>
> Most such system calls currently go through set_user_sigmask or
> set_compat_user_sigmask, which only differ on big-endian.
> I would actually like to see these merged together and have a single
> helper checking for in_compat_syscall() to decide whether to do
> the word-swap for 32-bit bit-endian tasks or not, but that's a separate
> discussion (and I suspect that Eric won't like that version, based on
> other discussions we've had).

Reading through get_compat_sigset is the best argument I have ever seen
for getting rid of big endian architectures.  My gut reaction is we
should just sweep all of the big endian craziness into a corner and let
it disappear as the big endian architectures are retired.

Perhaps we generalize the non-compat version of the system calls and
only have a compat version of the system call for the big endian
architectures.

I really hope loongarch and any new architectures added to the tree all
are little endian.

> What I think you need for loongarch though is to change
> set_user_sigmask(), get_compat_sigset() and similar functions to
> behave differently depending on the user space execution context,
> converting the 64-bit masks for loongarch/x86/arm64 tasks into
> 128-bit in-kernel masks, while copying the 128-bit mips masks
> as-is. This also requires changing the sigset_t and _NSIG
> definitions so you get a 64-bit mask in user space, but a 128-bit
> mask in kernel space.
>
> There are multiple ways of achieving this, either by generalizing
> the common code, or by providing an architecture specific
> implementation to replace it for loongarch only. I think you need to
> try out which of those is the most maintainable.

I believe all of the modern versions of the system calls that
take a sigset_t in the kernel also take a sigsetsize.  So the most
straight forward thing to do is to carefully define what happens
to sigsets that are too big or too small when set.

Something like defining that if a sigset is larger than the kernel's
sigset size all of the additional bits must be zero, and if the sigset
is smaller than the kernel's sigset size all of the missing bits
will be set to zero in the kernel's sigset_t.  There may be cases
I am missing bug for SIG_SETMASK, SIG_BLOCK, and SIG_UNBLOCK those
look like the correct definitions.

Another option would be to simply have whatever translates the system
calls in userspace to perform the work of verifying the extra bits in
the bitmap are unused before calling system calls that take a sigset_t
and just ignoring the extra bits.

Eric
