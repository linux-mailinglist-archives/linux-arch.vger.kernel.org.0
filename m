Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5D33B6902
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 21:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhF1TYF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 15:24:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37532 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhF1TYE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 15:24:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:38726)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxwp4-00Fc6j-MQ; Mon, 28 Jun 2021 13:21:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39076 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxwp2-00GijM-LY; Mon, 28 Jun 2021 13:21:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
        <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
        <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
        <87a6njf0ia.fsf@disp2133>
        <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
        <87tulpbp19.fsf@disp2133>
        <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
        <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133>
        <87r1gr6qc4.fsf_-_@disp2133> <202106252014.5AE600929@keescook>
Date:   Mon, 28 Jun 2021 14:21:24 -0500
In-Reply-To: <202106252014.5AE600929@keescook> (Kees Cook's message of "Fri,
        25 Jun 2021 20:17:51 -0700")
Message-ID: <87im1xx0az.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lxwp2-00GijM-LY;;;mid=<87im1xx0az.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+AUA4C0dC+FUTNNB1hCOCUPdqu7Mk4gYY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4971]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1416 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 9 (0.7%), parse: 0.92 (0.1%),
         extract_message_metadata: 12 (0.8%), get_uri_detail_list: 1.17 (0.1%),
         tests_pri_-1000: 13 (0.9%), tests_pri_-950: 1.39 (0.1%),
        tests_pri_-900: 1.08 (0.1%), tests_pri_-90: 984 (69.5%), check_bayes:
        980 (69.2%), b_tokenize: 8 (0.5%), b_tok_get_all: 7 (0.5%),
        b_comp_prob: 2.4 (0.2%), b_tok_touch_all: 957 (67.6%), b_finish: 3.1
        (0.2%), tests_pri_0: 379 (26.8%), check_dkim_signature: 0.98 (0.1%),
        check_dkim_adsp: 3.5 (0.2%), poll_dns_idle: 0.26 (0.0%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/9] signal/seccomp: Refactor seccomp signal and coredump generation
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Jun 24, 2021 at 01:59:55PM -0500, Eric W. Biederman wrote:
>> 
>> Factor out force_sig_seccomp from the seccomp signal generation and
>> place it in kernel/signal.c.  The function force_sig_seccomp takes a
>> paramter force_coredump to indicate that the sigaction field should be
>> reset to SIGDFL so that a coredump will be generated when the signal
>> is delivered.
>
> Ah! This is the part I missed when I was originally trying to figure
> out the coredump stuff. It's the need for setting a default handler
> (i.e. doing a coredump)?

Yes.  If we don't force the handler to SIG_DFL someone might catch
SIGSYS.

>> force_sig_seccomp is then used to replace both seccomp_send_sigsys
>> and seccomp_init_siginfo.
>> 
>> force_sig_info_to_task gains an extra parameter to force using
>> the default signal action.
>> 
>> With this change seccomp is no longer a special case and there
>> becomes exactly one place do_coredump is called from.
>
> Looks good to me. This may benefit from force_sig_seccomp() to be wrapped
> in an #ifdef CONFIG_SECCOMP.

At which point Linus will probably be grumpy with me for introducing
#ifdefs.

I suspect seccomp at this point is sufficiently common that is probably
more productive to figure out how to remove #ifdef  CONFIG_SECCOMP.

> (This patch reminds me that the seccomp self tests don't check for core
> dumps...)

This patch is slightly wrong in that it kept the call to do_group_exit
when it can never be reached.

Eric


