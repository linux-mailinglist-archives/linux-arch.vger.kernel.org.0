Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACD3A353D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 22:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFJVAK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 17:00:10 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46278 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJVAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 17:00:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrRkd-00G7Q2-LO; Thu, 10 Jun 2021 14:58:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrRkb-003V64-TI; Thu, 10 Jun 2021 14:58:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-arch@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Daniel Jacobowitz <drow@nevyn.them.org>,
        Kees Cook <keescook@chromium.org>
Date:   Thu, 10 Jun 2021 15:57:58 -0500
Message-ID: <87sg1p30a1.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lrRkb-003V64-TI;;;mid=<87sg1p30a1.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//8WQu+x+uCru6/HE74WQnaxGdKbF4cdU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMSubLong,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-arch@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 593 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (2.4%), b_tie_ro: 12 (2.1%), parse: 0.94
        (0.2%), extract_message_metadata: 3.5 (0.6%), get_uri_detail_list:
        1.06 (0.2%), tests_pri_-1000: 4.9 (0.8%), tests_pri_-950: 1.75 (0.3%),
        tests_pri_-900: 1.18 (0.2%), tests_pri_-90: 79 (13.3%), check_bayes:
        77 (13.0%), b_tokenize: 5 (0.9%), b_tok_get_all: 8 (1.3%),
        b_comp_prob: 2.3 (0.4%), b_tok_touch_all: 57 (9.6%), b_finish: 1.35
        (0.2%), tests_pri_0: 467 (78.7%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 3.8 (0.6%), poll_dns_idle: 1.85 (0.3%), tests_pri_10:
        2.7 (0.5%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Folks,

Digging through the guts of exit I found something I am not quite
certain what to do with.  On some architectures such as alpha, m68k, and
nios2 the kernel calls into system calls with a subset of the registers
saved on the kernel stack, and the kernel calls into signal handling and
a few other contexts with all of the registers saved on the kernel
stack.  The problem is sometimes we read all of the registers from
a context where they are not all saved.

When this was initially observed it looked just like a coredump problem
and it could be solved by tweaking the coredump code.  That change was
77f6ab8b7768 ("don't dump the threads that had been already exiting when
zapped.")

However I have looked farther and we have the location where get_signal
is called from io_uring, and we have the ptrace_stop in
PTRACE_EVENT_EXIT.  In PTRACE_EVENT_EXIT we could be called from exit(2)
which is a syscall and we definitely won't have everything saved on the
kernel stack.  I have not doubled checked create_io_thread but I don't
think create_io_threads saves all of the registers on the kernel stack.

I think at this point we need to say that the architectures that have a
do this need to be fixed to at least call do_exit and the kernel
function in create_io_thread with the deeper stack.

Is that reasonable of me to ask?  Is there some other way to deal with
this issue that I am not seeing?  Am I missing some critical detail that
makes PTRACE_EVENT_EXIT in do_exit not a problem if someone reads the
register with ptrace?

Eric

