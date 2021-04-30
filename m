Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5073703F9
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 01:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhD3XU6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 19:20:58 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33508 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhD3XU6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Apr 2021 19:20:58 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lccQV-004DLh-Rr; Fri, 30 Apr 2021 17:20:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lccQU-007HCH-J2; Fri, 30 Apr 2021 17:20:03 -0600
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
        <m1o8dvs7s7.fsf_-_@fess.ebiederm.org>
Date:   Fri, 30 Apr 2021 18:19:58 -0500
In-Reply-To: <m1o8dvs7s7.fsf_-_@fess.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 30 Apr 2021 17:54:16 -0500")
Message-ID: <m1y2czqs0x.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lccQU-007HCH-J2;;;mid=<m1y2czqs0x.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18OuzsZtpaVFuh5x4vTdt9uc78OYUZkyKE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,TR_XM_PhishingBody,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,XM_B_Phish66
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 518 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.0%), b_tie_ro: 9 (1.7%), parse: 1.05 (0.2%),
         extract_message_metadata: 12 (2.2%), get_uri_detail_list: 2.5 (0.5%),
        tests_pri_-1000: 13 (2.5%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.45 (0.3%), tests_pri_-90: 106 (20.4%), check_bayes:
        104 (20.0%), b_tokenize: 12 (2.2%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.0 (0.4%), b_tok_touch_all: 79 (15.2%), b_finish: 1.01
        (0.2%), tests_pri_0: 361 (69.7%), check_dkim_signature: 0.75 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.80 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] signal: Implement SIL_FAULT_TRAPNO
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Now that si_trapno is part of the union in _si_fault and available on
> all architectures, add SIL_FAULT_TRAPNO and update siginfo_layout to
> return SIL_FAULT_TRAPNO when si_trapno is actually used.
>
> Update the code that uses siginfo_layout to deal with SIL_FAULT_TRAPNO
> and have the same code ignore si_trapno in in all other cases.

This change is missing a break in signalfd.

Eric

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/signalfd.c          |  7 ++-----
>  include/linux/signal.h |  1 +
>  kernel/signal.c        | 36 ++++++++++++++----------------------
>  3 files changed, 17 insertions(+), 27 deletions(-)
>
> diff --git a/fs/signalfd.c b/fs/signalfd.c
> index 040a1142915f..126c681a30e7 100644
> --- a/fs/signalfd.c
> +++ b/fs/signalfd.c
> @@ -123,15 +123,12 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>  		 */
>  	case SIL_FAULT:
>  		new.ssi_addr = (long) kinfo->si_addr;
+ 		break;
> -#ifdef __ARCH_SI_TRAPNO
> +	case SIL_FAULT_TRAPNO:
> +		new.ssi_addr = (long) kinfo->si_addr;
>  		new.ssi_trapno = kinfo->si_trapno;
> -#endif
>  		break;
>  	case SIL_FAULT_MCEERR:
>  		new.ssi_addr = (long) kinfo->si_addr;
> -#ifdef __ARCH_SI_TRAPNO
> -		new.ssi_trapno = kinfo->si_trapno;
> -#endif
>  		new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
>  		break;
>  	case SIL_PERF_EVENT:
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 1e98548d7cf6..5160fd45e5ca 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -40,6 +40,7 @@ enum siginfo_layout {
>  	SIL_TIMER,
>  	SIL_POLL,
>  	SIL_FAULT,
> +	SIL_FAULT_TRAPNO,
>  	SIL_FAULT_MCEERR,
>  	SIL_FAULT_BNDERR,
>  	SIL_FAULT_PKUERR,
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c3017aa8024a..7b2d61cb7411 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1194,6 +1194,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>  	case SIL_TIMER:
>  	case SIL_POLL:
>  	case SIL_FAULT:
> +	case SIL_FAULT_TRAPNO:
>  	case SIL_FAULT_MCEERR:
>  	case SIL_FAULT_BNDERR:
>  	case SIL_FAULT_PKUERR:
> @@ -2527,6 +2528,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
>  {
>  	switch (siginfo_layout(ksig->sig, ksig->info.si_code)) {
>  	case SIL_FAULT:
> +	case SIL_FAULT_TRAPNO:
>  	case SIL_FAULT_MCEERR:
>  	case SIL_FAULT_BNDERR:
>  	case SIL_FAULT_PKUERR:
> @@ -3206,6 +3208,12 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>  			if ((sig == SIGBUS) &&
>  			    (si_code >= BUS_MCEERR_AR) && (si_code <= BUS_MCEERR_AO))
>  				layout = SIL_FAULT_MCEERR;
> +			else if (IS_ENABLED(ALPHA) &&
> +				 ((sig == SIGFPE) ||
> +				  ((sig == SIGTRAP) && (si_code == TRAP_UNK))))
> +				layout = SIL_FAULT_TRAPNO;
> +			else if (IS_ENABLED(SPARC) && (sig == SIGILL) && (si_code == ILL_ILLTRP))
> +				layout = SIL_FAULT_TRAPNO;
>  			else if ((sig == SIGSEGV) && (si_code == SEGV_BNDERR))
>  				layout = SIL_FAULT_BNDERR;
>  #ifdef SEGV_PKUERR
> @@ -3317,30 +3325,22 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>  		break;
>  	case SIL_FAULT:
>  		to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> +		break;
> +	case SIL_FAULT_TRAPNO:
> +		to->si_addr = ptr_to_compat(from->si_addr);
>  		to->si_trapno = from->si_trapno;
> -#endif
>  		break;
>  	case SIL_FAULT_MCEERR:
>  		to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -		to->si_trapno = from->si_trapno;
> -#endif
>  		to->si_addr_lsb = from->si_addr_lsb;
>  		break;
>  	case SIL_FAULT_BNDERR:
>  		to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -		to->si_trapno = from->si_trapno;
> -#endif
>  		to->si_lower = ptr_to_compat(from->si_lower);
>  		to->si_upper = ptr_to_compat(from->si_upper);
>  		break;
>  	case SIL_FAULT_PKUERR:
>  		to->si_addr = ptr_to_compat(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -		to->si_trapno = from->si_trapno;
> -#endif
>  		to->si_pkey = from->si_pkey;
>  		break;
>  	case SIL_PERF_EVENT:
> @@ -3401,30 +3401,22 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>  		break;
>  	case SIL_FAULT:
>  		to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> +		break;
> +	case SIL_FAULT_TRAPNO:
> +		to->si_addr = compat_ptr(from->si_addr);
>  		to->si_trapno = from->si_trapno;
> -#endif
>  		break;
>  	case SIL_FAULT_MCEERR:
>  		to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -		to->si_trapno = from->si_trapno;
> -#endif
>  		to->si_addr_lsb = from->si_addr_lsb;
>  		break;
>  	case SIL_FAULT_BNDERR:
>  		to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -		to->si_trapno = from->si_trapno;
> -#endif
>  		to->si_lower = compat_ptr(from->si_lower);
>  		to->si_upper = compat_ptr(from->si_upper);
>  		break;
>  	case SIL_FAULT_PKUERR:
>  		to->si_addr = compat_ptr(from->si_addr);
> -#ifdef __ARCH_SI_TRAPNO
> -		to->si_trapno = from->si_trapno;
> -#endif
>  		to->si_pkey = from->si_pkey;
>  		break;
>  	case SIL_PERF_EVENT:
