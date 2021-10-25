Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2549543A5D7
	for <lists+linux-arch@lfdr.de>; Mon, 25 Oct 2021 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhJYVa6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 17:30:58 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33878 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhJYVax (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 17:30:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:54352)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mf7W9-00AqF5-U6; Mon, 25 Oct 2021 15:28:29 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:41832 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mf7W8-003uop-UG; Mon, 25 Oct 2021 15:28:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        H Peter Anvin <hpa@zytor.com>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-10-ebiederm@xmission.com>
        <875ytkygfj.fsf_-_@disp2133>
        <CAHk-=whS0PL0NZrz2d8a3V+8=4szSZ6jqkg5fkjeaEjMN_NX8Q@mail.gmail.com>
Date:   Mon, 25 Oct 2021 16:28:22 -0500
In-Reply-To: <CAHk-=whS0PL0NZrz2d8a3V+8=4szSZ6jqkg5fkjeaEjMN_NX8Q@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 25 Oct 2021 14:12:03 -0700")
Message-ID: <87k0i0x095.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mf7W8-003uop-UG;;;mid=<87k0i0x095.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/DScZg9xLaFM+G28oBA4C2vv6AcTHqeoQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4960]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 445 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (2.7%), b_tie_ro: 11 (2.4%), parse: 1.45
        (0.3%), extract_message_metadata: 20 (4.6%), get_uri_detail_list: 1.84
        (0.4%), tests_pri_-1000: 27 (6.1%), tests_pri_-950: 1.81 (0.4%),
        tests_pri_-900: 1.49 (0.3%), tests_pri_-90: 97 (21.9%), check_bayes:
        95 (21.4%), b_tokenize: 7 (1.7%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 73 (16.5%), b_finish: 1.06
        (0.2%), tests_pri_0: 263 (59.1%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 3.0 (0.7%), poll_dns_idle: 1.17 (0.3%), tests_pri_10:
        3.0 (0.7%), tests_pri_500: 13 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 10/32] signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Oct 25, 2021 at 1:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Update save_v86_state to always complete all of it's work except
>> possibly some of the copies to userspace even if save_v86_state takes
>> a fault.  This ensures that the kernel is always in a sane state, even
>> if userspace has done something silly.
>
> Well, honestly, with this change, you might as well replace the
> force_sigsegv() with just a plain "force_sig()", and make it something
> the process can catch.

The trouble is I don't think there is enough information made available
for user space to do anything with the SIGSEGV.  My memory is that
applications like dosemu very much have a SIGSEGV handler.

So I think if it ever happened it could be quite confusing.  Not to
mention the pr_alert message.

But I guess if a test is written like you suggest we can include enough
information for someone to make sense of things.

> The only thing that "force_sigsgv()" does is to make SIGSEGV
> uncatchable. In contrast, a plain "force_sig()" just means that it
> can't be ignored - but it can be caught, and it is fatal only when not
> caught.
>
> And with the "always complete the non-vm86 state restore" part change,
> there's really no reason for it to not be caught.
>
> Of course, the other case (where we have no state information for the
> "enter vm86 mode" case) is still fatal, and is a "this should never
> happen". But the "cannot write to the vm86 save state" thing isn't
> technically fatal.
>
> It should even be possible to write a test for it: passing a read-only
> pointer to the vm86() system call. The vm86 entry will work (because
> it only reads the vm86 state from it), but then at vm86 exit, writing
> the state back will fail.
>
> Anybody?

I am enthusiastic about writing a test, but I will plod in that
direction just so I can get this sorted out.

Eric
