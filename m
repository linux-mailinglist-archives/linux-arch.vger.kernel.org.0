Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58543A51F
	for <lists+linux-arch@lfdr.de>; Mon, 25 Oct 2021 22:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhJYU6A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Oct 2021 16:58:00 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56310 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhJYU5q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Oct 2021 16:57:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:46434)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mf706-00AmGX-0a; Mon, 25 Oct 2021 14:55:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39982 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mf704-00CQtV-7C; Mon, 25 Oct 2021 14:55:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-5-ebiederm@xmission.com>
        <alpine.DEB.2.21.2110240622100.45807@angie.orcam.me.uk>
Date:   Mon, 25 Oct 2021 15:55:13 -0500
In-Reply-To: <alpine.DEB.2.21.2110240622100.45807@angie.orcam.me.uk> (Maciej
        W. Rozycki's message of "Sun, 24 Oct 2021 06:24:17 +0200 (CEST)")
Message-ID: <87y26gx1se.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mf704-00CQtV-7C;;;mid=<87y26gx1se.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+evW9omsIww1rKO9bifehdIM1qfwCNJao=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *****
X-Spam-Status: No, score=5.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TR_XM_SB_Phish,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,
        T_TooManySym_05,XMNoVowels,XMSubLong,XMSubPhish11 autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  1.5 XMSubPhish11 Phishy Language Subject
        *  0.0 TR_XM_SB_Phish Phishing flag in subject of message
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;"Maciej W. Rozycki" <macro@orcam.me.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 564 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.4 (0.8%), b_tie_ro: 3.0 (0.5%), parse: 0.92
        (0.2%), extract_message_metadata: 10 (1.8%), get_uri_detail_list: 0.94
        (0.2%), tests_pri_-1000: 4.5 (0.8%), tests_pri_-950: 1.18 (0.2%),
        tests_pri_-900: 0.80 (0.1%), tests_pri_-90: 99 (17.6%), check_bayes:
        97 (17.2%), b_tokenize: 3.8 (0.7%), b_tok_get_all: 6 (1.0%),
        b_comp_prob: 1.40 (0.2%), b_tok_touch_all: 83 (14.7%), b_finish: 0.87
        (0.2%), tests_pri_0: 163 (28.9%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 1.87 (0.3%), poll_dns_idle: 257 (45.5%),
        tests_pri_10: 2.1 (0.4%), tests_pri_500: 275 (48.7%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 05/20] signal/mips: Update (_save|_restore)_fp_context to fail with -EFAULT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Maciej W. Rozycki" <macro@orcam.me.uk> writes:

> On Wed, 20 Oct 2021, Eric W. Biederman wrote:
>
>> When an instruction to save or restore a register from the stack fails
>> in _save_fp_context or _restore_fp_context return with -EFAULT.  This
>> change was made to r2300_fpu.S[1] but it looks like it got lost with
>> the introduction of EX2[2].  This is also what the other implementation
>> of _save_fp_context and _restore_fp_context in r4k_fpu.S does, and
>> what is needed for the callers to be able to handle the error.
>
>  Umm, right, good catch, thanks!  I think this ought to be backported.
>
> Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>
>

I will add a CC stable.  So it can be backported after it is merged.

Eric
