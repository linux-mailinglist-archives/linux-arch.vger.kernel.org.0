Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4CF48B3AB
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 18:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbiAKRUu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 11 Jan 2022 12:20:50 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:35542 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiAKRUs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 12:20:48 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:33224)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7KpC-00651J-OM; Tue, 11 Jan 2022 10:20:47 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:59860 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7KpB-00EEcj-B3; Tue, 11 Jan 2022 10:20:46 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211213225350.27481-1-ebiederm@xmission.com>
        <9363765f-9883-75ee-70f1-a1a8e9841812@gmail.com>
        <87pmp67y4r.fsf@email.froward.int.ebiederm.org>
        <5bbb54c4-7504-cd28-5dde-4e5965496625@gmail.com>
        <87bl0m14ew.fsf@email.froward.int.ebiederm.org>
        <6692758a-0af2-67e0-26fd-365625b3ad0c@gmail.com>
Date:   Tue, 11 Jan 2022 11:20:16 -0600
In-Reply-To: <6692758a-0af2-67e0-26fd-365625b3ad0c@gmail.com> (Dmitry
        Osipenko's message of "Tue, 11 Jan 2022 11:59:39 +0300")
Message-ID: <87iluqtcj3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1n7KpB-00EEcj-B3;;;mid=<87iluqtcj3.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+9cMX4NoesSJ+elhthiVZ8FKRFkT0ojwM=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Dmitry Osipenko <digetx@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 549 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 8 (1.5%), parse: 1.18 (0.2%),
         extract_message_metadata: 4.3 (0.8%), get_uri_detail_list: 1.76
        (0.3%), tests_pri_-1000: 4.0 (0.7%), tests_pri_-950: 1.30 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 219 (39.9%), check_bayes:
        218 (39.6%), b_tokenize: 7 (1.3%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 195 (35.5%), b_finish: 1.06
        (0.2%), tests_pri_0: 285 (51.8%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.66 (0.1%), tests_pri_10:
        3.1 (0.6%), tests_pri_500: 12 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dmitry Osipenko <digetx@gmail.com> writes:

> 08.01.2022 21:13, Eric W. Biederman пишет:
>> Dmitry Osipenko <digetx@gmail.com> writes:
>> 
>>> 05.01.2022 22:58, Eric W. Biederman пишет:
>>>>
>>>> I have not yet been able to figure out how to run gst-pluggin-scanner in
>>>> a way that triggers this yet.  In truth I can't figure out how to
>>>> run gst-pluggin-scanner in a useful way.
>>>>
>>>> I am going to set up some unit tests and see if I can reproduce your
>>>> hang another way, but if you could give me some more information on what
>>>> you are doing to trigger this I would appreciate it.
>>>
>>> Thanks, Eric. The distro is Arch Linux, but it's a development
>>> environment where I'm running latest GStreamer from git master. I'll try
>>> to figure out the reproduction steps and get back to you.
>> 
>> Thank you.
>> 
>> Until I can figure out why this is causing problems I have dropped the
>> following two patches from my queue:
>>  signal: Make SIGKILL during coredumps an explicit special case
>>  signal: Drop signals received after a fatal signal has been processed
>> 
>> I have replaced them with the following two patches that just do what
>> is needed for the rest of the code in the series:
>>  signal: Have prepare_signal detect coredumps using
>>  signal: Make coredump handling explicit in complete_signal
>> 
>> Perversely my failure to change the SIGKILL handling when coredumps are
>> happening proves to me that I need to change the SIGKILL handling when
>> coredumps are happening to make the code more maintainable.
>
> Eric, thank you again. I started to look at the reproduction steps and
> haven't completed it yet. Turned out the problem affects only older
> NVIDIA Tegra2 Cortex-A9 CPU that lacks support of ARM NEON instructions
> set, hence the problem isn't visible on x86 and other CPUs out of the
> box. I'll need to check whether the problem could be simulated on all
> arches or maybe it's specific to VFP exception handling of ARM32.

It sounds like the gstreamer plugins only fail on certain hardware on
arm32, and things don't hang in coredumps unless the plugins fail.
That does make things tricky to minimize.

I have just verified that the known problematic code is not
in linux-next for Jan 11 2022.

If folks as they have time can double check linux-next and verify all is
well I would appreciate it.  I don't expect that there are problems but
sometimes one problem hides another.

Eric
