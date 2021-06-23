Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5541A3B1CAA
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFWOjU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 10:39:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51340 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhFWOjR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Jun 2021 10:39:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lw3zq-00DaGO-Vs; Wed, 23 Jun 2021 08:36:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lw3zp-00FFdy-0H; Wed, 23 Jun 2021 08:36:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk>
        <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
        <YNEfXhi80e/VXgc9@zeniv-ca.linux.org.uk>
        <CAHk-=wjtagi3g5thA-T8ooM8AXcy3brdHzugCPU0itdbpDYH_A@mail.gmail.com>
        <87h7hpbojt.fsf@disp2133>
        <20c787ec-4a3c-061c-c649-5bc3e7ef0464@gmail.com>
        <55bdad37-187b-e1f5-a359-c5206b20ff4d@gmail.com>
Date:   Wed, 23 Jun 2021 09:36:45 -0500
In-Reply-To: <55bdad37-187b-e1f5-a359-c5206b20ff4d@gmail.com> (Michael
        Schmitz's message of "Wed, 23 Jun 2021 17:26:22 +1200")
Message-ID: <87sg18abr6.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lw3zp-00FFdy-0H;;;mid=<87sg18abr6.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+NbP08c6rBMLpVRuWsiul7P0EciH0CoAk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michael Schmitz <schmitzmic@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1070 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.0%), b_tie_ro: 9 (0.9%), parse: 0.96 (0.1%),
         extract_message_metadata: 2.8 (0.3%), get_uri_detail_list: 0.84
        (0.1%), tests_pri_-1000: 4.4 (0.4%), tests_pri_-950: 1.19 (0.1%),
        tests_pri_-900: 1.05 (0.1%), tests_pri_-90: 567 (53.0%), check_bayes:
        565 (52.8%), b_tokenize: 7 (0.7%), b_tok_get_all: 8 (0.7%),
        b_comp_prob: 2.0 (0.2%), b_tok_touch_all: 544 (50.9%), b_finish: 1.00
        (0.1%), tests_pri_0: 458 (42.8%), check_dkim_signature: 0.79 (0.1%),
        check_dkim_adsp: 3.4 (0.3%), poll_dns_idle: 0.74 (0.1%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 14 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> Hi Eric,
>
> Am 23.06.2021 um 09:48 schrieb Michael Schmitz:
>>>
>>> The challenging ones are /proc/pid/syscall and seccomp which want to see
>>> all of the system call arguments.  I think every architecture always
>>> saves the system call arguments unconditionally, so those cases are
>>> probably not as interesting.  But they certain look like they could be
>>> trouble.
>>
>> Seccomp hasn't yet been implemented on m68k, though I'm working on that
>> with Adrian. The sole secure_computing() call will happen in
>> syscall_trace_enter(), so all system call arguments have been saved on
>> the stack.
>>
>> Haven't looked at /proc/pid/syscall yet ...
>
> Not supported at present (no HAVE_ARCH_TRACEHOOK for m68k). And the
> syscall_get_arguments I wrote for seccomp support only copies the first five
> data registers, which are always saved.

Yes.  It is looking like I can fix everything generically except for
faking user space registers for io_uring threads.

Eric
