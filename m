Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D5B370401
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 01:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhD3XYp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 19:24:45 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37844 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhD3XYp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Apr 2021 19:24:45 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lccUF-00CsoG-Qp; Fri, 30 Apr 2021 17:23:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lccUE-007HaN-Pp; Fri, 30 Apr 2021 17:23:55 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
Date:   Fri, 30 Apr 2021 18:23:51 -0500
In-Reply-To: <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 30 Apr 2021 17:49:45 -0500")
Message-ID: <m1im43qrug.fsf_-_@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lccUE-007HaN-Pp;;;mid=<m1im43qrug.fsf_-_@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xW7yT9MZRBfGY7mc5Y3fx4buEUPwx95M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0621]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 286 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (1.6%), b_tie_ro: 3.0 (1.1%), parse: 1.04
        (0.4%), extract_message_metadata: 2.8 (1.0%), get_uri_detail_list:
        0.72 (0.3%), tests_pri_-1000: 3.9 (1.4%), tests_pri_-950: 1.24 (0.4%),
        tests_pri_-900: 1.01 (0.4%), tests_pri_-90: 83 (28.9%), check_bayes:
        81 (28.3%), b_tokenize: 4.2 (1.5%), b_tok_get_all: 5 (1.8%),
        b_comp_prob: 1.29 (0.5%), b_tok_touch_all: 67 (23.6%), b_finish: 0.71
        (0.2%), tests_pri_0: 173 (60.5%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 2.6 (0.9%), poll_dns_idle: 1.24 (0.4%), tests_pri_10:
        2.2 (0.8%), tests_pri_500: 7 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Is perf_sigtrap synchronous?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


I am looking at perf_sigtrap and I am confused by the code.


	/*
	 * We'd expect this to only occur if the irq_work is delayed and either
	 * ctx->task or current has changed in the meantime. This can be the
	 * case on architectures that do not implement arch_irq_work_raise().
	 */
	if (WARN_ON_ONCE(event->ctx->task != current))
		return;

	/*
	 * perf_pending_event() can race with the task exiting.
	 */
	if (current->flags & PF_EXITING)
		return;


It performs tests that absolutely can never fail if we are talking about
a synchronous exception.  The code force_sig family of functions only
make sense to use with and are only safe to use with synchronous
exceptions.

Are the tests in perf_sigtrap necessary or is perf_sigtrap not reporting
a synchronous event?

Eric
