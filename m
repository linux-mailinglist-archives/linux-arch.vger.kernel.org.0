Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088153F7989
	for <lists+linux-arch@lfdr.de>; Wed, 25 Aug 2021 17:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhHYP5V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Aug 2021 11:57:21 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59200 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbhHYP5V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Aug 2021 11:57:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:34002)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mIvGU-00BJtr-36; Wed, 25 Aug 2021 09:56:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55852 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mIvGS-00DL13-SD; Wed, 25 Aug 2021 09:56:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Brad Boyer <flar@allandria.com>,
        Andreas Schwab <schwab@linux-m68k.org>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
References: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
        <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
        <87h7gopvz2.fsf@disp2133>
        <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
        <877dhio13t.fsf@disp2133>
        <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com>
        <87tukkk6h3.fsf@disp2133>
        <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com>
        <87eebn7w7y.fsf@igel.home>
        <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
        <20210725101253.GA6096@allandria.com>
        <be3ddf9a-745e-4798-17a7-a9d0ddd7eef7@gmail.com>
        <87a6m8kgtx.fsf_-_@disp2133>
        <33327fd4-47fc-2eab-04e4-242697a23d5f@gmail.com>
        <87tukghjfs.fsf_-_@disp2133>
Date:   Wed, 25 Aug 2021 10:56:26 -0500
In-Reply-To: <87tukghjfs.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Mon, 26 Jul 2021 16:08:39 -0500")
Message-ID: <87v93tmsb9.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mIvGS-00DL13-SD;;;mid=<87v93tmsb9.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19jEnItnpOVDV2Rm9Ei+HQwl2CuUif63q4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,TR_Symld_Words,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michael Schmitz <schmitzmic@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 489 ms - load_scoreonly_sql: 0.40 (0.1%),
        signal_user_changed: 13 (2.7%), b_tie_ro: 11 (2.2%), parse: 1.32
        (0.3%), extract_message_metadata: 14 (2.9%), get_uri_detail_list: 2.1
        (0.4%), tests_pri_-1000: 14 (2.9%), tests_pri_-950: 1.32 (0.3%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 71 (14.6%), check_bayes:
        70 (14.2%), b_tokenize: 7 (1.5%), b_tok_get_all: 6 (1.3%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 50 (10.3%), b_finish: 0.88
        (0.2%), tests_pri_0: 356 (72.7%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 3.4 (0.7%), poll_dns_idle: 1.54 (0.3%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 11 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> In the fpsp040 code when copyin or copyout fails call
> force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).
>
> This solves a couple of problems.  Because do_exit embeds the ptrace
> stop PTRACE_EVENT_EXIT a complete stack frame needs to be present for
> that to work correctly.  There is always the information needed for a
> ptrace stop where get_signal is called.  So exiting with a signal
> solves the ptrace issue.
>
> Further exiting with a signal ensures that all of the threads in a
> process are killed not just the thread that malfunctioned.  Which
> avoids confusing userspace.
>
> To make force_sigsegv(SIGSEGV) work in fpsp040_die modify the code to
> save all of the registers and jump to ret_from_exception (which
> ultimately calls get_signal) after fpsp040_die returns.
>
> v2: Updated the branches to use gas's pseudo ops that automatically
>     calculate the best branch instruction to use for the purpose.
>
> v1: Link: https://lkml.kernel.org/r/87a6m8kgtx.fsf_-_@disp2133
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Any chance I can get an ack on this patch?

Eric

> ---
>  arch/m68k/fpsp040/skeleton.S | 3 ++-
>  arch/m68k/kernel/traps.c     | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
> index a8f41615d94a..439395aa6fb4 100644
> --- a/arch/m68k/fpsp040/skeleton.S
> +++ b/arch/m68k/fpsp040/skeleton.S
> @@ -502,7 +502,8 @@ in_ea:
>  	.section .fixup,#alloc,#execinstr
>  	.even
>  1:
> -	jbra	fpsp040_die
> +	jbsr	fpsp040_die
> +	jbra	.Lnotkern
>  
>  	.section __ex_table,#alloc
>  	.align	4
> diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
> index 9e1261462bcc..5b19fcdcd69e 100644
> --- a/arch/m68k/kernel/traps.c
> +++ b/arch/m68k/kernel/traps.c
> @@ -1150,7 +1150,7 @@ asmlinkage void set_esp0(unsigned long ssp)
>   */
>  asmlinkage void fpsp040_die(void)
>  {
> -	do_exit(SIGSEGV);
> +	force_sigsegv(SIGSEGV);
>  }
>  
>  #ifdef CONFIG_M68KFPU_EMU
