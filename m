Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3556370E74
	for <lists+linux-arch@lfdr.de>; Sun,  2 May 2021 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhEBS2T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 May 2021 14:28:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39128 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhEBS2T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 May 2021 14:28:19 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldGoQ-00FXga-HS; Sun, 02 May 2021 12:27:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldGoP-00BO9w-MT; Sun, 02 May 2021 12:27:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
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
        kasan-dev <kasan-dev@googlegroups.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
        <m1tunns7yf.fsf_-_@fess.ebiederm.org>
        <CANpmjNOZj-jRfFH365znJGqDAwdXL4Z2QBuHOtdvN_uNJ8WBSA@mail.gmail.com>
Date:   Sun, 02 May 2021 13:27:21 -0500
In-Reply-To: <CANpmjNOZj-jRfFH365znJGqDAwdXL4Z2QBuHOtdvN_uNJ8WBSA@mail.gmail.com>
        (Marco Elver's message of "Sat, 1 May 2021 12:31:10 +0200")
Message-ID: <m1czu9ng8m.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ldGoP-00BO9w-MT;;;mid=<m1czu9ng8m.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+I6HZ0cD4XvYQ+uzlALtJgYoOqGyYDPxk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4920]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 325 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.4 (1.3%), b_tie_ro: 3.0 (0.9%), parse: 1.06
        (0.3%), extract_message_metadata: 11 (3.3%), get_uri_detail_list: 1.98
        (0.6%), tests_pri_-1000: 11 (3.4%), tests_pri_-950: 1.02 (0.3%),
        tests_pri_-900: 0.83 (0.3%), tests_pri_-90: 52 (16.0%), check_bayes:
        51 (15.6%), b_tokenize: 6 (1.8%), b_tok_get_all: 7 (2.2%),
        b_comp_prob: 1.90 (0.6%), b_tok_touch_all: 33 (10.1%), b_finish: 0.72
        (0.2%), tests_pri_0: 232 (71.3%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.3 (0.7%), poll_dns_idle: 0.94 (0.3%), tests_pri_10:
        2.7 (0.8%), tests_pri_500: 7 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] siginfo: Move si_trapno inside the union inside _si_fault
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Sat, 1 May 2021 at 00:50, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> It turns out that linux uses si_trapno very sparingly, and as such it
>> can be considered extra information for a very narrow selection of
>> signals, rather than information that is present with every fault
>> reported in siginfo.
>>
>> As such move si_trapno inside the union inside of _si_fault.  This
>> results in no change in placement, and makes it eaiser to extend
>> _si_fault in the future as this reduces the number of special cases.
>> In particular with si_trapno included in the union it is no longer a
>> concern that the union must be pointer alligned on most architectures
>> because the union followes immediately after si_addr which is a
>> pointer.
>>
>
> Maybe add "Link:
> https://lkml.kernel.org/r/CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com"
>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Acked-by: Marco Elver <elver@google.com>
>
> By no longer guarding it with __ARCH_SI_TRAPNO we run the risk that it
> will be used by something else at some point. Is that intentional?

The motivation was letting the code be tested on other architectures.

But once si_trapno falls inside the union instead of being present for
every signal reporting a fault it doesn't really matter.

I think it would be poor taste but harmless to use si_trapno, mostly
because defining a new entry in the union could be more specific and
well defined.

Eric
