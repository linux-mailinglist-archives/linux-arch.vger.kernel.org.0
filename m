Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40807383682
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbhEQPdR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 11:33:17 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38832 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244432AbhEQPbO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 May 2021 11:31:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lifBk-0003MZ-KS; Mon, 17 May 2021 09:29:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lifBj-00BZOl-IR; Mon, 17 May 2021 09:29:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
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
References: <m15z031z0a.fsf@fess.ebiederm.org>
        <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
        <m1r1irpc5v.fsf@fess.ebiederm.org>
        <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
        <m1czuapjpx.fsf@fess.ebiederm.org>
        <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
        <m14kfjh8et.fsf_-_@fess.ebiederm.org>
        <m1tuni8ano.fsf_-_@fess.ebiederm.org>
        <m1a6oxewym.fsf_-_@fess.ebiederm.org> <YKDMWXj2YDkDy1DG@gmail.com>
Date:   Mon, 17 May 2021 10:29:39 -0500
In-Reply-To: <YKDMWXj2YDkDy1DG@gmail.com> (Ingo Molnar's message of "Sun, 16
        May 2021 09:40:09 +0200")
Message-ID: <m1wnrx750c.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lifBj-00BZOl-IR;;;mid=<m1wnrx750c.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX199lR/IyLLJ1RHiRf25MlrgYHNCCIjDaII=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4536]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Ingo Molnar <mingo@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 436 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (3.1%), b_tie_ro: 11 (2.6%), parse: 0.96
        (0.2%), extract_message_metadata: 15 (3.5%), get_uri_detail_list: 1.38
        (0.3%), tests_pri_-1000: 14 (3.2%), tests_pri_-950: 1.66 (0.4%),
        tests_pri_-900: 1.18 (0.3%), tests_pri_-90: 64 (14.6%), check_bayes:
        62 (14.1%), b_tokenize: 7 (1.6%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.9 (0.7%), b_tok_touch_all: 38 (8.8%), b_finish: 1.21
        (0.3%), tests_pri_0: 313 (71.8%), check_dkim_signature: 0.71 (0.2%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 1.10 (0.3%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] siginfo: ABI fixes for v5.13-rc2
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> Looking deeper it was discovered that si_trapno is used for only
>> a few select signals on alpha and sparc, and that none of the
>> other _sigfault fields past si_addr are used at all.  Which means
>> technically no regression on alpha and sparc.
>
> If there's no functional regression on any platform, could much of this 
> wait until v5.14, or do we want some of these cleanups right now?
>
> The fixes seem to be for long-existing bugs, not fresh regressions, AFAICS. 
> The asserts & cleanups are useful, but not regression fixes.
>
> I.e. this is a bit scary:

The new ABI for SIGTRAP TRAP perf that came in the merge window is
broken and wrong.  We need to revert/disable the new SIGTRAP TRAP_PERF
or have a fix before v5.13.

The issue is old crap getting in the way of a new addition.  I think I
might see a smaller code change on how to get to something compatible
with this.

>>  32 files changed, 377 insertions(+), 163 deletions(-)
>
> at -rc2 time.

The additions are all tests to make certain everything is fine.
The actual code change without the assertions (tests) is essentially
a wash.

Eric

