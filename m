Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03A348B3D7
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 18:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbiAKR20 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 11 Jan 2022 12:28:26 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50092 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiAKR2L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 12:28:11 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:48794)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7KwM-005tcc-0R; Tue, 11 Jan 2022 10:28:10 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:60092 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n7KwK-00EGFs-QD; Tue, 11 Jan 2022 10:28:09 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Olivier Langlois <olivier@trillion01.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211213225350.27481-1-ebiederm@xmission.com>
        <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
        <87sfu3b7wm.fsf@email.froward.int.ebiederm.org>
        <YdniQob7w5hTwB1v@osiris>
        <87ilurwjju.fsf@email.froward.int.ebiederm.org>
        <87o84juwhg.fsf@email.froward.int.ebiederm.org>
        <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
Date:   Tue, 11 Jan 2022 11:28:01 -0600
In-Reply-To: <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
        (Olivier Langlois's message of "Mon, 10 Jan 2022 18:00:07 -0500")
Message-ID: <87lezmrxlq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1n7KwK-00EGFs-QD;;;mid=<87lezmrxlq.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18MwSq61euGY5qBKV2lHfNFGNEA7dtXK2I=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
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
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Olivier Langlois <olivier@trillion01.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 547 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 9 (1.7%), parse: 1.53 (0.3%),
         extract_message_metadata: 17 (3.0%), get_uri_detail_list: 1.70 (0.3%),
         tests_pri_-1000: 10 (1.8%), tests_pri_-950: 1.50 (0.3%),
        tests_pri_-900: 1.40 (0.3%), tests_pri_-90: 126 (23.1%), check_bayes:
        117 (21.5%), b_tokenize: 6 (1.2%), b_tok_get_all: 7 (1.4%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 97 (17.7%), b_finish: 1.32
        (0.2%), tests_pri_0: 364 (66.6%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.67 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Olivier Langlois <olivier@trillion01.com> writes:

> On Mon, 2022-01-10 at 15:11 -0600, Eric W. Biederman wrote:
>> 
>> 
>> I have been able to confirm that changing wait_event_interruptible to
>> wait_event_killable was the culprit.  Something about the way
>> systemd-coredump handles coredumps is not compatible with
>> wait_event_killable.
>
> This is my experience too that systemd-coredump is doing something
> unexpected. When I tested the patch:
> https://lore.kernel.org/lkml/cover.1629655338.git.olivier@trillion01.com/
>
> to make sure that the patch worked, sending coredumps to systemd-
> coredump was making systemd-coredump, well, core dump... Not very
> useful...

Oh.  Wow....

> Sending the dumps through a pipe to anything else than systemd-coredump
> was working fine.

Interesting.

I need to read through the pipe code and see how all of that works.  For
writing directly to disk only ignoring killable interruptions are the
usual semantics.  Ordinary pipe code has different semantics, and I
suspect that is what is tripping things up.

As for systemd-coredump it does whatever it does and I suspect some
versions of systemd-coredump are simply not robust if a coredump stops
unexpectedly.

The good news is the pipe code is simple enough, it will be possible to
completely read through that code.

Eric


