Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1843E62C
	for <lists+linux-arch@lfdr.de>; Thu, 28 Oct 2021 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhJ1Qgh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Oct 2021 12:36:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54138 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1Qgg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Oct 2021 12:36:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:35186)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mg8Lv-005DnD-MN; Thu, 28 Oct 2021 10:34:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43544 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mg8Lu-002HAx-PA; Thu, 28 Oct 2021 10:34:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-13-ebiederm@xmission.com>
        <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
        <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org>
        <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
        <87v91kqt6b.fsf@disp2133>
        <CAHk-=wiph8wmVDJZiUETH3r_+fWhDvaEz64aA0XNimkSOHf+dw@mail.gmail.com>
Date:   Thu, 28 Oct 2021 11:33:59 -0500
In-Reply-To: <CAHk-=wiph8wmVDJZiUETH3r_+fWhDvaEz64aA0XNimkSOHf+dw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 26 Oct 2021 09:15:52 -0700")
Message-ID: <87tuh1m7m0.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mg8Lu-002HAx-PA;;;mid=<87tuh1m7m0.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Tt77o5kiz8xKuTpFNy8fo11D0wrkux48=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4976]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 348 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (3.0%), b_tie_ro: 9 (2.5%), parse: 0.90 (0.3%),
         extract_message_metadata: 14 (3.9%), get_uri_detail_list: 1.42 (0.4%),
         tests_pri_-1000: 15 (4.3%), tests_pri_-950: 1.28 (0.4%),
        tests_pri_-900: 0.97 (0.3%), tests_pri_-90: 112 (32.0%), check_bayes:
        102 (29.4%), b_tokenize: 6 (1.8%), b_tok_get_all: 7 (2.1%),
        b_comp_prob: 2.4 (0.7%), b_tok_touch_all: 83 (23.8%), b_finish: 0.86
        (0.2%), tests_pri_0: 184 (52.8%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 2.5 (0.7%), poll_dns_idle: 0.75 (0.2%), tests_pri_10:
        1.82 (0.5%), tests_pri_500: 6 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Oct 25, 2021 at 9:58 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Rereading this I think you might be misreading something.
>
> Gaah. Yes, indeed.
>
>> force_siginfo_to_task takes a sigdfl parameter which I am setting in
>> force_fatal_signal.
>
> .. and I realized that the first time I read through it, but then when
> I read through it due to Andy saying it worries him, I missed it and
> thought the handler didn't get reset.
>
> So the patch is fine.

Thank you.

Andy is right that there is a race with sigaction changing the signal
handler.

To make complete_signal reliably recognize fatal signals is going to
take a bit of work.  None of it particularly hard but there are a lot of
pieces that need to be changed carefully.  Part of the problem is that
recognizing fatal signals early started out as an optimization, and
there remain places in complete_signal and prepare_signal that assume it
is always possible to not recognize fatal signals early and let
get_signal handle things.

The coredump handling of it is the biggest challenge.  Computing a
destination thread with wants_signal in complete_signal before dealing
with fatal signals (which don't care) means that wants_signal can
cause the early recognition of fatal signals to fail.

The entire blocked vs real_blocked set of signal masks are interesting.
The current way those signal masks work does not appear to allow knowing
when blocked is being overridden and blocked is stored in real_blocked.
Something I think needs to be known if fatal signal are always going to
be recognized early.

Given that race it looks like it is important to make the guarantee that
fatal signals are always recognized early.  So the rest of the kernel
can count on that property.

But I aim to get this set of changes into linux-next first.  As I don't
anything will melt down if we leave that race for a bit longer.

Eric
