Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F147A472FCA
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 15:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhLMOv2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 09:51:28 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:52936 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhLMOv1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 09:51:27 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:45796)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwmfk-007Cyd-Mm; Mon, 13 Dec 2021 07:51:24 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:40216 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwmfj-00BB7w-LH; Mon, 13 Dec 2021 07:51:24 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-1-ebiederm@xmission.com>
        <YbY2CDkZbOFRBN0i@osiris>
Date:   Mon, 13 Dec 2021 08:50:44 -0600
In-Reply-To: <YbY2CDkZbOFRBN0i@osiris> (Heiko Carstens's message of "Sun, 12
        Dec 2021 18:48:56 +0100")
Message-ID: <87czm036ez.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mwmfj-00BB7w-LH;;;mid=<87czm036ez.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18KAzcwgpDXJi2izmCoG3YxLtoPlPFwE2s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Heiko Carstens <hca@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 431 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 12 (2.8%), b_tie_ro: 10 (2.4%), parse: 0.95
        (0.2%), extract_message_metadata: 14 (3.3%), get_uri_detail_list: 1.69
        (0.4%), tests_pri_-1000: 14 (3.3%), tests_pri_-950: 1.37 (0.3%),
        tests_pri_-900: 1.08 (0.3%), tests_pri_-90: 57 (13.3%), check_bayes:
        56 (13.0%), b_tokenize: 7 (1.6%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 36 (8.4%), b_finish: 0.87
        (0.2%), tests_pri_0: 317 (73.7%), check_dkim_signature: 0.64 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 0.86 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 01/10] exit/s390: Remove dead reference to do_exit from copy_thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Heiko Carstens <hca@linux.ibm.com> writes:

> On Wed, Dec 08, 2021 at 02:25:23PM -0600, Eric W. Biederman wrote:
>> My s390 assembly is not particularly good so I have read the history
>> of the reference to do_exit copy_thread and have been able to
>> verify that do_exit is not used.
>> 
>> The general argument is that s390 has been changed to use the generic
>> kernel_thread and kernel_execve and the generic versions do not call
>> do_exit.  So it is strange to see a do_exit reference sitting there.
>> 
>> The history of the do_exit reference in s390's version of copy_thread
>> seems conclusive that the do_exit reference is something that lingers
>> and should have been removed several years ago.
> ...
>> Remove this dead reference to do_exit to make it clear that s390 is
>> not doing anything with do_exit in copy_thread.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  arch/s390/kernel/process.c | 1 -
>>  1 file changed, 1 deletion(-)
>
> Applied to s390 tree. Just in case you want to apply this to your tree too:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Thank you for looking at this and confirming I had read that the code
properly and that the do_exit reference was no longer used.

I will probably take this through my tree as well just so I don't have
that trailing do_exit reference.

At this point I will give things a bit more for people to review or say
something about the other changes and if there is no negative feedback
I think I will just apply the lot.

Eric

