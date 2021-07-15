Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F573C9F82
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhGONd1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 09:33:27 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55092 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhGONd0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 09:33:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m41Rg-00AcTY-Kv; Thu, 15 Jul 2021 07:30:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:49460 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m41Rf-009x1e-Cw; Thu, 15 Jul 2021 07:30:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
Date:   Thu, 15 Jul 2021 08:29:49 -0500
In-Reply-To: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com> (Michael
        Schmitz's message of "Wed, 23 Jun 2021 12:21:33 +1200")
Message-ID: <87zgunzovm.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m41Rf-009x1e-Cw;;;mid=<87zgunzovm.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19qDoQBF+W6wCsYMYjPYLIsWcESflkf144=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,
        XM_B_SpammyWords,XM_B_SpammyWords2 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4054]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Michael Schmitz <schmitzmic@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 666 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 10 (1.4%), parse: 0.98
        (0.1%), extract_message_metadata: 3.8 (0.6%), get_uri_detail_list:
        1.41 (0.2%), tests_pri_-1000: 3.8 (0.6%), tests_pri_-950: 1.55 (0.2%),
        tests_pri_-900: 1.47 (0.2%), tests_pri_-90: 110 (16.6%), check_bayes:
        107 (16.1%), b_tokenize: 6 (0.9%), b_tok_get_all: 10 (1.5%),
        b_comp_prob: 2.3 (0.3%), b_tok_touch_all: 84 (12.6%), b_finish: 1.49
        (0.2%), tests_pri_0: 514 (77.2%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 2.9 (0.4%), poll_dns_idle: 0.77 (0.1%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/3] m68k: Improved switch stack handling
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> m68k version of Eric's patch series 'alpha/ptrace: Improved
> switch_stack handling'.
>
> Registers d6, d7, a3-a6 are not saved on the stack by default
> on every syscall entry by the m68k kernel. A separate switch
> stack frame is pushed to save those registers as needed.
> This leaves the majority of syscalls with only a subset of
> registers on the stack, and access to unsaved registers in
> those would expose or modify random stack addresses.  
>
> Patch 1 and 2 add a switch stack for all syscalls that were
> found to need one to allow ptrace access to all registers
> outside of syscall entry/exit tracing, as well as kernel
> worker threads. This ought to protect against accidents.
>
> Patch 3 adds safety checks and debug output to m68k get_reg()
> and put_reg() functions. Any unsafe register access during
> process tracing will be prevented and reported. 
>
> Suggestions for optimizations or improvements welcome!
>
> Cheers,
>
>    Michael
>    
> Link: https://lore.kernel.org/r/<87pmwlek8d.fsf_-_@disp2133>

I have been digging into this some more and I have found one place
that I am having a challenge dealing with.

In arch/m68k/fpsp040/skeleton.S there is an assembly version of
copy_from_user that calls fpsp040_die when the bytes can not be read.

Now fpsp040_die is just:

/*
 * This function is called if an error occur while accessing
 * user-space from the fpsp040 code.
 */
asmlinkage void fpsp040_die(void)
{
	do_exit(SIGSEGV);
}


The problem here is the instruction emulation performed in the fpsp040
code performs a very minimal saving of registers.  I don't think even
the normal system call entry point registers that are saved are present
at that point.

Is there any chance you can help me figure out how to get a stack frame
with all of the registers present before fpsp040_die is called?

Eric
