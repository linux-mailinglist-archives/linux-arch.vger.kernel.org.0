Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CF33813CF
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 00:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhENWjs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 18:39:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42680 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhENWjs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2021 18:39:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lhgS0-004tzQ-9N; Fri, 14 May 2021 16:38:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lhgRz-004D3L-AH; Fri, 14 May 2021 16:38:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
        <m1r1irpc5v.fsf@fess.ebiederm.org>
        <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
        <m1czuapjpx.fsf@fess.ebiederm.org>
        <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
        <m14kfjh8et.fsf_-_@fess.ebiederm.org>
        <m1tuni8ano.fsf_-_@fess.ebiederm.org>
        <m1a6oxewym.fsf_-_@fess.ebiederm.org>
        <CAHk-=wikDD+gCUECg9NZAVSV6W_FUdyZFHzK4isfrwES_+sH-w@mail.gmail.com>
        <m14kf5aufb.fsf@fess.ebiederm.org>
Date:   Fri, 14 May 2021 17:38:25 -0500
In-Reply-To: <m14kf5aufb.fsf@fess.ebiederm.org> (Eric W. Biederman's message
        of "Fri, 14 May 2021 16:15:36 -0500")
Message-ID: <m1tun57xge.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lhgRz-004D3L-AH;;;mid=<m1tun57xge.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19odSp5HEfI42QhPUSRdilH+u4toHAL8FY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1368]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 412 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 10 (2.4%), parse: 1.06
        (0.3%), extract_message_metadata: 15 (3.7%), get_uri_detail_list: 1.72
        (0.4%), tests_pri_-1000: 22 (5.4%), tests_pri_-950: 1.19 (0.3%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 63 (15.3%), check_bayes:
        61 (14.9%), b_tokenize: 11 (2.7%), b_tok_get_all: 9 (2.3%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 34 (8.3%), b_finish: 0.99
        (0.2%), tests_pri_0: 285 (69.1%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 1.02 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] siginfo: ABI fixes for v5.13-rc2
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Thu, May 13, 2021 at 9:55 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>
>>> Please pull the for-v5.13-rc2 branch from the git tree:
>>
>> I really don't like this tree.
>>
>> The immediate cause for "no" is the silly
>>
>>  #if IS_ENABLED(CONFIG_SPARC)
>>
>> and
>>
>>  #if IS_ENABLED(CONFIG_ALPHA)
>>
>> code in kernel/signal.c. It has absolutely zero business being there,
>> when those architectures have a perfectly fine arch/*/kernel/signal.c
>> file where that code would make much more sense *WITHOUT* any odd
>> preprocessor games.
>
> The code is generic it just happens those functions are only used on
> sparc and alpha.  Further I really want to make filling out siginfo_t
> happen in dedicated functions as much as possible in kernel/signal.c.
> The probably of getting it wrong without a helper functions is very
> strong.  As the code I am fixing demonstrates.
>
> The IS_ENABLED(arch) is mostly there so we can delete the code if/when
> the architectures are retired in another decade or so.

There is also the question of why alpha allows userspace to block
SIGFPE.

If it turns out that alpha is just silly by allowing synchronous
exceptions to be blocked, then the code really becomes generic and
shared shared between sparc and alpha.

Which is really why the code does not make sense in some architecture
specific version of signal.c.  That and the fact the two functions
are almost identical.

If you want I can remove the #ifdefs and we can take up slightly more
space until someone implements -ffunction-sections.

Do you know if alpha will be stuck triggering the same floating point
error if the SIGFPE is blocked or can alpha somehow continue past it?

If alpha using send_sig instead of force_sig is historical and does not
reflect the reality of the hardware alpha can be converted and several
of the send_sig variants can be removed.  Otherwise alpha remains the
odd man out, and the code can remain until all of the alpha hardware
dies.  (I don't think anyone is manufacturing alpha hardware anymore).

I would look it up but I have lost access to whatever alpha
documentation I had.

Eric
