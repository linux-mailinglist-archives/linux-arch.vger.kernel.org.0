Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA734485A34
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 21:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbiAEUqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 15:46:24 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:54592 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbiAEUqX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 15:46:23 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:38802)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5DAr-001UfZ-0r; Wed, 05 Jan 2022 13:46:21 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:47550 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5DAn-00BQ0p-Mf; Wed, 05 Jan 2022 13:46:20 -0700
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
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-2-ebiederm@xmission.com>
        <YdUmN7n4W5YETUhW@zeniv-ca.linux.org.uk>
Date:   Wed, 05 Jan 2022 14:46:10 -0600
In-Reply-To: <YdUmN7n4W5YETUhW@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Wed, 5 Jan 2022 05:01:43 +0000")
Message-ID: <871r1l9ai5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5DAn-00BQ0p-Mf;;;mid=<871r1l9ai5.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cxTE75XzmaE/dsLVkJGQ6nZA+2vo0yWw=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_12,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 575 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.7%), b_tie_ro: 9 (1.5%), parse: 1.15 (0.2%),
         extract_message_metadata: 14 (2.4%), get_uri_detail_list: 1.51 (0.3%),
         tests_pri_-1000: 9 (1.6%), tests_pri_-950: 1.52 (0.3%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 67 (11.7%), check_bayes:
        66 (11.4%), b_tokenize: 7 (1.2%), b_tok_get_all: 8 (1.3%),
        b_comp_prob: 2.3 (0.4%), b_tok_touch_all: 45 (7.9%), b_finish: 0.81
        (0.1%), tests_pri_0: 455 (79.2%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 1.00 (0.2%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 02/10] exit: Add and use make_task_dead.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Dec 08, 2021 at 02:25:24PM -0600, Eric W. Biederman wrote:
>> There are two big uses of do_exit.  The first is it's design use to be
>> the guts of the exit(2) system call.  The second use is to terminate
>> a task after something catastrophic has happened like a NULL pointer
>> in kernel code.
>> 
>> Add a function make_task_dead that is initialy exactly the same as
>> do_exit to cover the cases where do_exit is called to handle
>> catastrophic failure.  In time this can probably be reduced to just a
>> light wrapper around do_task_dead. For now keep it exactly the same so
>> that there will be no behavioral differences introducing this new
>> concept.
>> 
>> Replace all of the uses of do_exit that use it for catastraphic
>> task cleanup with make_task_dead to make it clear what the code
>> is doing.
>> 
>> As part of this rename rewind_stack_do_exit
>> rewind_stack_and_make_dead.
>
> Umm...   What about .Linvalid_mask: in arch/xtensa/kernel/entry.S?
> That's an obvious case for your make_task_dead().

Good catch.

Being in assembly it did not have anything after the name do_exit so it
hid from my regex "[^A-Za-z0-9_]do_exit[^A-Za-z0-9]".  Thank you for
finding that.

Skimming the surrounding code it looks like Linvalid_mask can only be
reached by buggy hardware or buggy kernel code.    If userspace could
trigger the condition it would be a candidate for force_exit_sig.

I am a bit puzzled why die is not called, instead of die being
handrolled there.

xtensa folks any thoughts?

If not I will queue up a minimal patch to replace do_exit with
make_task_dead.

Eric

