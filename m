Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52737209F
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhECTjp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 15:39:45 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42650 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECTjo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 15:39:44 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldeP2-00HDI3-Qv; Mon, 03 May 2021 13:38:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldeOx-00DxKW-Li; Mon, 03 May 2021 13:38:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
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
        <m11rarqqx2.fsf_-_@fess.ebiederm.org>
        <CANpmjNNJ_MnNyD4R2+9i24E=9xPHKnwTh6zwWtBYkuAq1Xo6-w@mail.gmail.com>
        <m1wnshm14b.fsf@fess.ebiederm.org>
        <YI/wJSwQitisM8Xf@hirez.programming.kicks-ass.net>
Date:   Mon, 03 May 2021 14:38:39 -0500
In-Reply-To: <YI/wJSwQitisM8Xf@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 3 May 2021 14:44:21 +0200")
Message-ID: <m1sg33ip4w.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ldeOx-00DxKW-Li;;;mid=<m1sg33ip4w.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX193P6Zs47y9HH8Pk31Hd8htHGyDNhcJWFA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_08,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1431]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4529 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (0.3%), b_tie_ro: 10 (0.2%), parse: 1.07
        (0.0%), extract_message_metadata: 23 (0.5%), get_uri_detail_list: 1.11
        (0.0%), tests_pri_-1000: 9 (0.2%), tests_pri_-950: 1.95 (0.0%),
        tests_pri_-900: 1.46 (0.0%), tests_pri_-90: 78 (1.7%), check_bayes: 76
        (1.7%), b_tokenize: 9 (0.2%), b_tok_get_all: 8 (0.2%), b_comp_prob:
        2.9 (0.1%), b_tok_touch_all: 52 (1.1%), b_finish: 1.48 (0.0%),
        tests_pri_0: 319 (7.1%), check_dkim_signature: 0.92 (0.0%),
        check_dkim_adsp: 2.4 (0.1%), poll_dns_idle: 4052 (89.5%),
        tests_pri_10: 3.0 (0.1%), tests_pri_500: 4074 (90.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 7/3] signal: Deliver all of the perf_data in si_perf
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Sun, May 02, 2021 at 01:39:16PM -0500, Eric W. Biederman wrote:
>
>> The one thing that this doesn't do is give you a 64bit field
>> on 32bit architectures.
>> 
>> On 32bit builds the layout is:
>> 
>> 	int si_signo;
>> 	int si_errno;
>> 	int si_code;
>> 	void __user *_addr;
>>         
>> So I believe if the first 3 fields were moved into the _sifields union
>> si_perf could define a 64bit field as it's first member and it would not
>> break anything else.
>> 
>> Given that the data field is 64bit that seems desirable.
>
> The data field is fundamentally an address, it is internally a u64
> because the perf ring buffer has u64 alignment and it saves on compat
> crap etc.
>
> So for the 32bit/compat case the high bits will always be 0 and
> truncating into an unsigned long is fine.

I see why it is fine to truncate the data field into an unsigned long.

Other than technical difficulties in extending siginfo_t is there any
reason not to define data as a __u64?

Eric
