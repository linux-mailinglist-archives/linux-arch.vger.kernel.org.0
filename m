Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C803A488547
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 19:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiAHSOr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 8 Jan 2022 13:14:47 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:52814 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiAHSOr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 13:14:47 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:38462)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6GEo-0019tX-0e; Sat, 08 Jan 2022 11:14:46 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:33932 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n6GEl-000w1l-BS; Sat, 08 Jan 2022 11:14:44 -0700
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
Date:   Sat, 08 Jan 2022 12:13:59 -0600
In-Reply-To: <5bbb54c4-7504-cd28-5dde-4e5965496625@gmail.com> (Dmitry
        Osipenko's message of "Thu, 6 Jan 2022 00:39:10 +0300")
Message-ID: <87bl0m14ew.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1n6GEl-000w1l-BS;;;mid=<87bl0m14ew.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18S0I7LBCK7w4uyZFfzYkiEuP7fj3S3eVM=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Dmitry Osipenko <digetx@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1427 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 9 (0.7%), parse: 0.85 (0.1%),
         extract_message_metadata: 3.0 (0.2%), get_uri_detail_list: 1.01
        (0.1%), tests_pri_-1000: 3.6 (0.3%), tests_pri_-950: 1.22 (0.1%),
        tests_pri_-900: 0.96 (0.1%), tests_pri_-90: 92 (6.4%), check_bayes: 90
        (6.3%), b_tokenize: 6 (0.4%), b_tok_get_all: 7 (0.5%), b_comp_prob:
        2.1 (0.1%), b_tok_touch_all: 72 (5.0%), b_finish: 1.05 (0.1%),
        tests_pri_0: 1298 (91.0%), check_dkim_signature: 0.58 (0.0%),
        check_dkim_adsp: 3.1 (0.2%), poll_dns_idle: 1.15 (0.1%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dmitry Osipenko <digetx@gmail.com> writes:

> 05.01.2022 22:58, Eric W. Biederman пишет:
>> 
>> I have not yet been able to figure out how to run gst-pluggin-scanner in
>> a way that triggers this yet.  In truth I can't figure out how to
>> run gst-pluggin-scanner in a useful way.
>> 
>> I am going to set up some unit tests and see if I can reproduce your
>> hang another way, but if you could give me some more information on what
>> you are doing to trigger this I would appreciate it.
>
> Thanks, Eric. The distro is Arch Linux, but it's a development
> environment where I'm running latest GStreamer from git master. I'll try
> to figure out the reproduction steps and get back to you.

Thank you.

Until I can figure out why this is causing problems I have dropped the
following two patches from my queue:
 signal: Make SIGKILL during coredumps an explicit special case
 signal: Drop signals received after a fatal signal has been processed

I have replaced them with the following two patches that just do what
is needed for the rest of the code in the series:
 signal: Have prepare_signal detect coredumps using
 signal: Make coredump handling explicit in complete_signal

Perversely my failure to change the SIGKILL handling when coredumps are
happening proves to me that I need to change the SIGKILL handling when
coredumps are happening to make the code more maintainable.

Eric

