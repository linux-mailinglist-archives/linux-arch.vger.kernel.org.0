Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC8447DE19
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 04:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbhLWDeu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 22:34:50 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:51616 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346218AbhLWDet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Dec 2021 22:34:49 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:41304)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0EsS-008mUJ-A0; Wed, 22 Dec 2021 20:34:48 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:43790 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n0EsR-00AR5u-8e; Wed, 22 Dec 2021 20:34:47 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mike Christie <michael.christie@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-9-ebiederm@xmission.com>
        <YcNsG0Lp94V13whH@archlinux-ax161>
        <87zgoswkym.fsf@email.froward.int.ebiederm.org>
        <YcNyjxac3wlKPywk@archlinux-ax161>
        <87pmpow7ga.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
Date:   Wed, 22 Dec 2021 21:34:39 -0600
In-Reply-To: <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 22 Dec 2021 17:44:19 -0800")
Message-ID: <87o858uh80.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n0EsR-00AR5u-8e;;;mid=<87o858uh80.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/fF160QdsqN4oM1IDCMSjxQAhzKoPXXSg=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 461 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 13 (2.8%), b_tie_ro: 11 (2.4%), parse: 1.47
        (0.3%), extract_message_metadata: 17 (3.7%), get_uri_detail_list: 1.23
        (0.3%), tests_pri_-1000: 18 (3.9%), tests_pri_-950: 1.37 (0.3%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 61 (13.3%), check_bayes:
        60 (13.0%), b_tokenize: 7 (1.6%), b_tok_get_all: 9 (1.9%),
        b_comp_prob: 2.2 (0.5%), b_tok_touch_all: 38 (8.3%), b_finish: 0.87
        (0.2%), tests_pri_0: 328 (71.0%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.91 (0.2%), tests_pri_10:
        3.1 (0.7%), tests_pri_500: 13 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 09/10] kthread: Ensure struct kthread is present for all kthreads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Added a couple of people from the vhost thread.

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Dec 22, 2021 at 3:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Solve this by skipping the put_user for all kthreads.
>
> Ugh.
>
> While this fixes the problem, could we please just not mis-use that
> 'set_child_tid' as that kthread pointer any more?
>
> It was always kind of hacky. I think a new pointer with the proper
> 'struct kthread *' type would be an improvement.
>
> One of the "arguments" in the comment for re-using that set_child_tid
> pointer was that 'fork()' used to not wrongly copy it, but your patch
> literally now does that "allocate new kthread struct" at fork-time, so
> that argument is actually bogus now.

I agree.  I think I saw in the recent vhost patches that were
generalizing create_io_thread that the pf_io_worker field of
struct task_struct was being generalized as well.

If so I think it makes sense just to take that approach.

Just build some basic infrastructure that can be used for io_workers,
vhost_workers, and kthreads.

Eric


