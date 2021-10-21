Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC843687F
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhJUQ7Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:59:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57460 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhJUQ7Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:59:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:37828)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdbNL-0007uh-Jx; Thu, 21 Oct 2021 10:57:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:56884 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdbNI-00Cp0n-Sb; Thu, 21 Oct 2021 10:57:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-15-ebiederm@xmission.com>
        <202110210927.D0B4B0342@keescook>
Date:   Thu, 21 Oct 2021 11:56:57 -0500
In-Reply-To: <202110210927.D0B4B0342@keescook> (Kees Cook's message of "Thu,
        21 Oct 2021 09:34:31 -0700")
Message-ID: <87k0i69uzq.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdbNI-00Cp0n-Sb;;;mid=<87k0i69uzq.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/YItO3jyT9mchv5aB02C3xGFTztmDK/Gc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMGappySubj_02,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4969]
        *  0.7 XMSubLong Long Subject
        *  1.0 XMGappySubj_02 Gappier still
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1549 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 10 (0.6%), parse: 0.93
        (0.1%), extract_message_metadata: 17 (1.1%), get_uri_detail_list: 1.67
        (0.1%), tests_pri_-1000: 22 (1.4%), tests_pri_-950: 2.0 (0.1%),
        tests_pri_-900: 1.64 (0.1%), tests_pri_-90: 204 (13.2%), check_bayes:
        200 (12.9%), b_tokenize: 11 (0.7%), b_tok_get_all: 6 (0.4%),
        b_comp_prob: 2.3 (0.1%), b_tok_touch_all: 176 (11.4%), b_finish: 1.08
        (0.1%), tests_pri_0: 1275 (82.3%), check_dkim_signature: 0.86 (0.1%),
        check_dkim_adsp: 3.6 (0.2%), poll_dns_idle: 0.47 (0.0%), tests_pri_10:
        3.1 (0.2%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 15/20] signal/sparc32: Exit with a fatal signal when try_to_clear_window_buffer fails
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Oct 20, 2021 at 12:44:01PM -0500, Eric W. Biederman wrote:
>> The function try_to_clear_window_buffer is only called from
>> rtrap_32.c.  After it is called the signal pending state is retested,
>
> nit: rtrap_32.S
>
>> and signals are handled if TIF_SIGPENDING is set.  This allows
>> try_to_clear_window_buffer to call force_fatal_signal and then rely on
>> the signal being delivered to kill the process, without any danger of
>> returning to userspace, or otherwise using possible corrupt state on
>> failure.
>
> The TIF_SIGPENDING test happens in do_notify_resume(), though I see
> other code before that:
>
> ...
>         call    try_to_clear_window_buffer
>         add    %sp, STACKFRAME_SZ, %o0
>
>         b       signal_p
> ...
> signal_p:
>         andcc   %g2, _TIF_DO_NOTIFY_RESUME_MASK, %g0
>         bz,a    ret_trap_continue
>         ld     [%sp + STACKFRAME_SZ + PT_PSR], %t_psr
>
>         mov     %g2, %o2
>         mov     %l6, %o1
>         call    do_notify_resume
>
> Will the ret_trap_continue always be skipped?

The ret_trap_continue is the break out of the loop.  So unless the code
is not properly setting the signal to be pending the code should be good.

> Also I see the "tp->w_saved = 0" never happens due to the "return" in
> try_to_clear_window_buffer. Is that okay?

It should be.  As you point out the w_saved value is only used in
generating signal frames.  The code in get_signal should never
return and should call do_group_exit which calls do_exit, so building
signal frames that happens after get_signal returns should never be
reached.

Further this is the same way the code makes it to do_exit today.

Also looking at it I think the logic is that w_saved == 0
says that the register windows have been saved on the user mode stack,
and that clearly has not happened so I think it would in general
be a bug to clear w_saved on failure.

> Only synchronize_user_stack()
> uses it, and that could be called in do_sigreturn(). Should the "return"
> be removed?

Of course I could be wrong, if David or someone else who knows sparc32
better than me wants to set me straight I would really appreciate it.

Eric

