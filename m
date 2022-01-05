Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA76A485BC1
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 23:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbiAEWgV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 17:36:21 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:51080 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245111AbiAEWgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 17:36:17 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:39210)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5EtB-00DgC5-GK; Wed, 05 Jan 2022 15:36:13 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:50620 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5EtA-00ExSX-Hd; Wed, 05 Jan 2022 15:36:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-5-ebiederm@xmission.com>
        <YdU0bzBuHCokPgCM@zeniv-ca.linux.org.uk>
Date:   Wed, 05 Jan 2022 16:36:04 -0600
In-Reply-To: <YdU0bzBuHCokPgCM@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Wed, 5 Jan 2022 06:02:23 +0000")
Message-ID: <87zgo94xpn.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5EtA-00ExSX-Hd;;;mid=<87zgo94xpn.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ZYm4a4a0sQT3RXN8pv1gnZRFbvkQ/ui0=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 410 ms - load_scoreonly_sql: 0.15 (0.0%),
        signal_user_changed: 12 (2.9%), b_tie_ro: 10 (2.4%), parse: 0.88
        (0.2%), extract_message_metadata: 20 (4.9%), get_uri_detail_list: 1.13
        (0.3%), tests_pri_-1000: 30 (7.3%), tests_pri_-950: 1.33 (0.3%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 123 (30.1%), check_bayes:
        120 (29.3%), b_tokenize: 7 (1.6%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 1.99 (0.5%), b_tok_touch_all: 101 (24.7%), b_finish: 1.06
        (0.3%), tests_pri_0: 207 (50.4%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.33 (0.1%), tests_pri_10:
        2.9 (0.7%), tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 05/10] exit: Stop exporting do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Dec 08, 2021 at 02:25:27PM -0600, Eric W. Biederman wrote:
>> Now that there are no more modular uses of do_exit remove the EXPORT_SYMBOL.
>> 
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  kernel/exit.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index f975cd8a2ed8..57afac845a0a 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -843,7 +843,6 @@ void __noreturn do_exit(long code)
>>  	lockdep_free_task(tsk);
>>  	do_task_dead();
>>  }
>> -EXPORT_SYMBOL_GPL(do_exit);
>
> "Now" in the commit message is misleading, AFAICS - there's no such users
> in the mainline right now (and yes, that one could be moved all the way
> up).

Yes.  I should have said.  Now there are few enough users of do_exit
that I can inspect the code and see there are no more modular users.

Or words to that effect.

Because honestly my make_task_dead change got rid of most of the callers
of do_exit.

Eric

