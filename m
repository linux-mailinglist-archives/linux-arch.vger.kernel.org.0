Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022F24367A5
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUQ1j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:27:39 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33066 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhJUQ1j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:27:39 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:49386)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdasZ-005agR-VI; Thu, 21 Oct 2021 10:25:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55044 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdasW-004580-Ld; Thu, 21 Oct 2021 10:25:19 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-2-ebiederm@xmission.com>
        <202110210858.41719190D2@keescook>
Date:   Thu, 21 Oct 2021 11:25:08 -0500
In-Reply-To: <202110210858.41719190D2@keescook> (Kees Cook's message of "Thu,
        21 Oct 2021 09:02:04 -0700")
Message-ID: <87cznycpln.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdasW-004580-Ld;;;mid=<87cznycpln.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+8ac5GaciGlAstn3lEEUZ+dUI+mMUpD0U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4918]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2655 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (0.4%), b_tie_ro: 10 (0.4%), parse: 1.30
        (0.0%), extract_message_metadata: 11 (0.4%), get_uri_detail_list: 1.09
        (0.0%), tests_pri_-1000: 15 (0.6%), tests_pri_-950: 1.30 (0.0%),
        tests_pri_-900: 1.09 (0.0%), tests_pri_-90: 1221 (46.0%), check_bayes:
        1219 (45.9%), b_tokenize: 7 (0.3%), b_tok_get_all: 8 (0.3%),
        b_comp_prob: 2.4 (0.1%), b_tok_touch_all: 1197 (45.1%), b_finish: 1.20
        (0.0%), tests_pri_0: 1376 (51.8%), check_dkim_signature: 1.12 (0.0%),
        check_dkim_adsp: 7 (0.2%), poll_dns_idle: 2.7 (0.1%), tests_pri_10:
        3.2 (0.1%), tests_pri_500: 10 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 02/20] exit: Remove calls of do_exit after noreturn versions of die
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Oct 20, 2021 at 12:43:48PM -0500, Eric W. Biederman wrote:
>> On nds32, openrisc, s390, sh, and xtensa the function die never
>> returns.  Mark die __noreturn so that no one expects die to return.
>> Remove the do_exit calls after die as they will never be reached.
>
> Maybe note that the "bust_spinlocks" calls are also redundant, since
> they're in die(). I note that is a "mismatch" between the do_kill()
> in die() (SIGSEGV) and after die() (SIGKILL). This patch makes no
> behavioral change (the first caller would "win"), but I thought I'd note
> it in case some architecture would prefer a different signal.

If someone has some strong preferences in the matter of which signal a
wait on a processes that has oopsed should return please let me know.

My next step in cleaning up the uses of do_exit looks like it is going
to be getting all of the architectures to use the same signal for oopses
(aka die), and then introducing a helper (called something like
"make_task_dead" or "oops_task_exit" ) that will replace do_exit on the
oops path and not take a signal number at all.

That helper I can then remove the ptrace break point from and possibly
some of the coredump logic as well.  Ultimately it will be something
we can optimize for the case when we know there is a kernel bug and we
just want the task to exit so the rest of the system can limp along
as best as it can.

Eric
