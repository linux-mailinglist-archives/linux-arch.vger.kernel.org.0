Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D73AA330
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 20:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhFPScy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 14:32:54 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33884 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhFPScy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 14:32:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltaJF-00A84z-5r; Wed, 16 Jun 2021 12:30:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltaJE-000z9Q-7B; Wed, 16 Jun 2021 12:30:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <87sg1p30a1.fsf@disp2133>
        <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
        <87pmwsytb3.fsf@disp2133>
        <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133>
        <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
        <87mtrpg47k.fsf@disp2133>
Date:   Wed, 16 Jun 2021 13:29:38 -0500
In-Reply-To: <87mtrpg47k.fsf@disp2133> (Eric W. Biederman's message of "Wed,
        16 Jun 2021 11:32:47 -0500")
Message-ID: <87pmwlek8d.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltaJE-000z9Q-7B;;;mid=<87pmwlek8d.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/QcGeYYkSKc73XnoZZIXFLvqc9Us7t81k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_XMDrugObfuBody_08,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 351 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (3.2%), b_tie_ro: 10 (2.7%), parse: 1.21
        (0.3%), extract_message_metadata: 3.2 (0.9%), get_uri_detail_list:
        0.56 (0.2%), tests_pri_-1000: 4.9 (1.4%), tests_pri_-950: 1.37 (0.4%),
        tests_pri_-900: 1.14 (0.3%), tests_pri_-90: 110 (31.3%), check_bayes:
        108 (30.8%), b_tokenize: 7 (1.9%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 2.0 (0.6%), b_tok_touch_all: 89 (25.5%), b_finish: 0.93
        (0.3%), tests_pri_0: 199 (56.7%), check_dkim_signature: 0.58 (0.2%),
        check_dkim_adsp: 3.7 (1.1%), poll_dns_idle: 1.43 (0.4%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/2] alpha/ptrace: Improved switch_stack handling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


This pair of changes has not received anything beyond build and boot
testing.  I am posting these changes as they do a much better job of
warning of problems and shutting down the security hole.  Making them
a much better pattern than the my last patch.

I hope to get the test cases soon.

 arch/alpha/include/asm/thread_info.h   |  2 ++
 arch/alpha/kernel/entry.S              | 62 ++++++++++++++++++++++++++--------
 arch/alpha/kernel/process.c            |  3 ++
 arch/alpha/kernel/ptrace.c             | 13 +++++--
 arch/alpha/kernel/syscalls/syscall.tbl |  8 ++---
 5 files changed, 67 insertions(+), 21 deletions(-)

Eric W. Biederman (2):
      alpha/ptrace: Record and handle the absence of switch_stack
      alpha/ptrace: Add missing switch_stack frames

