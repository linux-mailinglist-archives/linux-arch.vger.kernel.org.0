Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9437B44034A
	for <lists+linux-arch@lfdr.de>; Fri, 29 Oct 2021 21:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJ2Tg4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Oct 2021 15:36:56 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37482 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ2Tg4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Oct 2021 15:36:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:57118)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mgXdx-007QLV-Jn; Fri, 29 Oct 2021 13:34:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:32942 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mgXdw-00EJtM-9Y; Fri, 29 Oct 2021 13:34:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-11-ebiederm@xmission.com>
        <7c99f791-4a87-ae52-bee7-cb794b0741d2@de.ibm.com>
        <87y26dp2hj.fsf@disp2133>
Date:   Fri, 29 Oct 2021 14:32:36 -0500
In-Reply-To: <87y26dp2hj.fsf@disp2133> (Eric W. Biederman's message of "Thu,
        28 Oct 2021 10:56:24 -0500")
Message-ID: <87v91fhbjf.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mgXdw-00EJtM-9Y;;;mid=<87v91fhbjf.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+IQGABJNds1K89FHzqTI6D9ZKRfirmdT4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Borntraeger <borntraeger@de.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 488 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 10 (2.0%), parse: 0.94
        (0.2%), extract_message_metadata: 13 (2.7%), get_uri_detail_list: 2.3
        (0.5%), tests_pri_-1000: 14 (2.9%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 154 (31.6%), check_bayes:
        153 (31.3%), b_tokenize: 8 (1.7%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 129 (26.5%), b_finish: 0.92
        (0.2%), tests_pri_0: 281 (57.5%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 1.04 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 11/20] signal/s390: Use force_sigsegv in default_trap_handler
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Christian Borntraeger <borntraeger@de.ibm.com> writes:
>
>> Am 20.10.21 um 19:43 schrieb Eric W. Biederman:
>>> Reading the history it is unclear why default_trap_handler calls
>>> do_exit.  It is not even menthioned in the commit where the change
>>> happened.  My best guess is that because it is unknown why the
>>> exception happened it was desired to guarantee the process never
>>> returned to userspace.
>>>
>>> Using do_exit(SIGSEGV) has the problem that it will only terminate one
>>> thread of a process, leaving the process in an undefined state.
>>>
>>> Use force_sigsegv(SIGSEGV) instead which effectively has the same
>>> behavior except that is uses the ordinary signal mechanism and
>>> terminates all threads of a process and is generally well defined.
>>
>> Do I get that right, that programs can not block SIGSEGV from force_sigsegv
>> with a signal handler? Thats how I read the code. If this is true
>> then
>>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>
> 99% true, and it is what force_sigsegv(SIGSEGV) intends to do.
>
> Andy Lutormorski pointed at a race where a thread can call sigaction
> and change the signal handler after force_sigsegv has run but before
> the process dequeues the SIGSEGV.

I now have a simple patch that closes the sigaction vs force_sig race,
that I am adding to this set of changes.  So now I can say programs can
not block force_sigsegv(SIGSEGV) with a signal handler or any other
method.

Eric

>>> Cc: Heiko Carstens <hca@linux.ibm.com>
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Cc: linux-s390@vger.kernel.org
>>> Fixes: ca2ab03237ec ("[PATCH] s390: core changes")
>>> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>> ---
>>>   arch/s390/kernel/traps.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
>>> index bcefc2173de4..51729ea2cf8e 100644
>>> --- a/arch/s390/kernel/traps.c
>>> +++ b/arch/s390/kernel/traps.c
>>> @@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
>>>   {
>>>   	if (user_mode(regs)) {
>>>   		report_user_fault(regs, SIGSEGV, 0);
>>> -		do_exit(SIGSEGV);
>>> +		force_sigsegv(SIGSEGV);
>>>   	} else
>>>   		die(regs, "Unknown program exception");
>>>   }
>>>
