Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8557544C6A9
	for <lists+linux-arch@lfdr.de>; Wed, 10 Nov 2021 19:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhKJSR2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Nov 2021 13:17:28 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:50940 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhKJSR1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Nov 2021 13:17:27 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:52310)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mks7K-000pJ1-DU; Wed, 10 Nov 2021 11:14:38 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:44490 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mks7J-007tkI-Hf; Wed, 10 Nov 2021 11:14:38 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
References: <87tugkm3gc.fsf@disp2133>
Date:   Wed, 10 Nov 2021 12:14:02 -0600
In-Reply-To: <87tugkm3gc.fsf@disp2133> (Eric W. Biederman's message of "Wed,
        10 Nov 2021 09:32:19 -0600")
Message-ID: <874k8j3ml1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mks7J-007tkI-Hf;;;mid=<874k8j3ml1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/PDsEsELP7apBRzH/mY/wQRDe8KsIvi4k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 333 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (1.2%), b_tie_ro: 2.7 (0.8%), parse: 0.62
        (0.2%), extract_message_metadata: 12 (3.7%), get_uri_detail_list: 1.15
        (0.3%), tests_pri_-1000: 17 (5.2%), tests_pri_-950: 1.08 (0.3%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 78 (23.5%), check_bayes:
        77 (23.1%), b_tokenize: 4.6 (1.4%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 1.50 (0.5%), b_tok_touch_all: 62 (18.7%), b_finish: 0.73
        (0.2%), tests_pri_0: 208 (62.5%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 1.60 (0.5%), poll_dns_idle: 0.19 (0.1%),
        tests_pri_10: 1.71 (0.5%), tests_pri_500: 6 (1.8%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [GIT PULL] exit cleanups for v5.16
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Linus,
>
> Please pull the exit-cleanups-for-v5.16 branch from the git tree:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.16
>
>   HEAD: f91140e4553408cacd326624cd50fc367725e04a Arnd Bergmann <arnd@arndb.de>
>
>
> While looking at some issues related to the exit path in the kernel I
> found several instances where the code is not using the existing
> abstractions properly.
>
> This set of changes introduces force_fatal_sig a way of sending
> a signal and not allowing it to be caught, and corrects the
> misuse of the existing abstractions that I found.
>
> A lot of the misuse of the existing abstractions are silly things such
> as doing something after calling a no return function, rolling BUG by
> hand, doing more work than necessary to terminate a kernel thread, or
> calling do_exit(SIGKILL) instead of calling force_sig(SIGKILL).
>
> In the review a deficiency in force_fatal_sig and force_sig_seccomp
> where ptrace or sigaction could prevent the delivery of the signal was
> found.  I have added a change that adds SA_IMMUTABLE to change that
> makes it impossible to interrupt the delivery of those signals, and
> allows backporting to fix force_sig_seccomp.
>
> Arnd found an issue where a function passed to kthread_run had the wrong
> prototype, and after my cleanup was failing to build.

I forgot to mention there is a minor conflict with the staging tree.
One of the functions that I cleaned up was in a file that was completely
removed from staging.  The result is that when you encounter the
conflict that file can simply be removed.

Eric
