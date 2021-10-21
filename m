Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB8436899
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhJURFP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 13:05:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40282 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhJURFP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 13:05:15 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:59376)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdbT0-005fTo-ML; Thu, 21 Oct 2021 11:02:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57008 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdbSy-00CpzD-L6; Thu, 21 Oct 2021 11:02:58 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, H Peter Anvin <hpa@zytor.com>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-10-ebiederm@xmission.com>
        <202110210915.BF17C14980@keescook>
Date:   Thu, 21 Oct 2021 12:02:49 -0500
In-Reply-To: <202110210915.BF17C14980@keescook> (Kees Cook's message of "Thu,
        21 Oct 2021 09:16:02 -0700")
Message-ID: <87r1ce8g5i.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdbSy-00CpzD-L6;;;mid=<87r1ce8g5i.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+4tFpR82thOj+XqsfADzJzogO4+LK+nWA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1360 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (0.6%), b_tie_ro: 7 (0.5%), parse: 0.80 (0.1%),
        extract_message_metadata: 11 (0.8%), get_uri_detail_list: 0.96 (0.1%),
        tests_pri_-1000: 13 (0.9%), tests_pri_-950: 1.35 (0.1%),
        tests_pri_-900: 1.21 (0.1%), tests_pri_-90: 79 (5.8%), check_bayes: 77
        (5.7%), b_tokenize: 6 (0.4%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        2.2 (0.2%), b_tok_touch_all: 60 (4.4%), b_finish: 0.89 (0.1%),
        tests_pri_0: 1227 (90.2%), check_dkim_signature: 0.58 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 0.41 (0.0%), tests_pri_10:
        3.3 (0.2%), tests_pri_500: 12 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 10/20] signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Oct 20, 2021 at 12:43:56PM -0500, Eric W. Biederman wrote:
>> Instead of pretending to send SIGSEGV by calling do_exit(SIGSEGV)
>> call force_sigsegv(SIGSEGV) to force the process to take a SIGSEGV
>> and terminate.
>> 
>> Update handle_signal to return immediately when save_v86_state fails
>> and kills the process.  Returning immediately without doing anything
>> except killing the process with SIGSEGV is also what signal_setup_done
>> does when setup_rt_frame fails.  Plus it is always ok to return
>> immediately without delivering a signal to a userspace handler when a
>> fatal signal has killed the current process.
>
> Do the tools/testing/selftests/x86 tests all pass after these changes? I
> know Andy has a bunch of weird corner cases in there.

That would require a 32bit userspace wouldn't it?

It is a good idea so I will see if I can dig such a box up, but I
unfortunately don't have an up-to-date 32bit box handy, or even
an up-to-date box with a 32bit userspace.

It has been about 20 years since I have done much with 32bit x86.

How hard is it to run the tests under tools/testing/selftests/...
Last time I tried it was a royal pain.  I am hoping it is better this
round.

Eric
