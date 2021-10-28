Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7B43E58E
	for <lists+linux-arch@lfdr.de>; Thu, 28 Oct 2021 17:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJ1P7E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Oct 2021 11:59:04 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:60400 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhJ1P7D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Oct 2021 11:59:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:54984)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mg7lb-00HVH7-MW; Thu, 28 Oct 2021 09:56:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42000 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mg7la-00BNln-Mc; Thu, 28 Oct 2021 09:56:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <7c99f791-4a87-ae52-bee7-cb794b0741d2@de.ibm.com> (Christian
        Borntraeger's message of "Tue, 26 Oct 2021 11:38:44 +0200")
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-11-ebiederm@xmission.com>
        <7c99f791-4a87-ae52-bee7-cb794b0741d2@de.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 28 Oct 2021 10:56:24 -0500
Message-ID: <87y26dp2hj.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mg7la-00BNln-Mc;;;mid=<87y26dp2hj.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18rKKOlSmtxyq2C51ggZJ/yg2hgTayDimU=
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
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Borntraeger <borntraeger@de.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 458 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 10 (2.1%), b_tie_ro: 8 (1.8%), parse: 1.05 (0.2%),
         extract_message_metadata: 14 (3.0%), get_uri_detail_list: 2.4 (0.5%),
        tests_pri_-1000: 15 (3.2%), tests_pri_-950: 1.44 (0.3%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 85 (18.5%), check_bayes:
        83 (18.0%), b_tokenize: 9 (1.9%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 3.0 (0.7%), b_tok_touch_all: 58 (12.7%), b_finish: 0.91
        (0.2%), tests_pri_0: 318 (69.4%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 3.2 (0.7%), poll_dns_idle: 1.23 (0.3%), tests_pri_10:
        2.6 (0.6%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 11/20] signal/s390: Use force_sigsegv in default_trap_handler
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christian Borntraeger <borntraeger@de.ibm.com> writes:

> Am 20.10.21 um 19:43 schrieb Eric W. Biederman:
>> Reading the history it is unclear why default_trap_handler calls
>> do_exit.  It is not even menthioned in the commit where the change
>> happened.  My best guess is that because it is unknown why the
>> exception happened it was desired to guarantee the process never
>> returned to userspace.
>>
>> Using do_exit(SIGSEGV) has the problem that it will only terminate one
>> thread of a process, leaving the process in an undefined state.
>>
>> Use force_sigsegv(SIGSEGV) instead which effectively has the same
>> behavior except that is uses the ordinary signal mechanism and
>> terminates all threads of a process and is generally well defined.
>
> Do I get that right, that programs can not block SIGSEGV from force_sigsegv
> with a signal handler? Thats how I read the code. If this is true
> then
>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

99% true, and it is what force_sigsegv(SIGSEGV) intends to do.

Andy Lutormorski pointed at a race where a thread can call sigaction
and change the signal handler after force_sigsegv has run but before
the process dequeues the SIGSEGV.

In principle it isn't too hard to close that race, and I was hoping to
be able to tell you that I had sorted by the time I replied.
Unfortunately it looks like it will take another week or two so will
probably not be ready by the merge window.

I am definitely going to close that race.

Eric


>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> Fixes: ca2ab03237ec ("[PATCH] s390: core changes")
>> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>   arch/s390/kernel/traps.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
>> index bcefc2173de4..51729ea2cf8e 100644
>> --- a/arch/s390/kernel/traps.c
>> +++ b/arch/s390/kernel/traps.c
>> @@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
>>   {
>>   	if (user_mode(regs)) {
>>   		report_user_fault(regs, SIGSEGV, 0);
>> -		do_exit(SIGSEGV);
>> +		force_sigsegv(SIGSEGV);
>>   	} else
>>   		die(regs, "Unknown program exception");
>>   }
>>
