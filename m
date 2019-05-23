Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E04128042
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 16:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfEWOxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 10:53:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56239 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbfEWOxQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 May 2019 10:53:16 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTp5m-0005Tv-Qv; Thu, 23 May 2019 08:53:14 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTp5l-0004Kl-Ui; Thu, 23 May 2019 08:53:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>,
        James Morse <James.Morse@arm.com>,
        Will Deacon <Will.Deacon@arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
        <20190523003916.20726-4-ebiederm@xmission.com>
        <20190523102101.GW28398@e103592.cambridge.arm.com>
Date:   Thu, 23 May 2019 09:53:06 -0500
In-Reply-To: <20190523102101.GW28398@e103592.cambridge.arm.com> (Dave Martin's
        message of "Thu, 23 May 2019 11:21:04 +0100")
Message-ID: <87r28pgr3h.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hTp5l-0004Kl-Ui;;;mid=<87r28pgr3h.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+THGiZIT6lV3EfwGpihTf9JNTesyMd/TY=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Dave Martin <Dave.Martin@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 529 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.1 (0.6%), b_tie_ro: 2.2 (0.4%), parse: 0.88
        (0.2%), extract_message_metadata: 16 (3.0%), get_uri_detail_list: 3.2
        (0.6%), tests_pri_-1000: 18 (3.5%), tests_pri_-950: 1.37 (0.3%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 34 (6.4%), check_bayes: 32
        (6.1%), b_tokenize: 10 (2.0%), b_tok_get_all: 12 (2.3%), b_comp_prob:
        3.4 (0.6%), b_tok_touch_all: 3.8 (0.7%), b_finish: 0.60 (0.1%),
        tests_pri_0: 442 (83.6%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.0 (0.4%), poll_dns_idle: 0.46 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 03/26] signal/arm64: Use force_sig not force_sig_fault for SIGKILL
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dave Martin <Dave.Martin@arm.com> writes:

> On Thu, May 23, 2019 at 01:38:53AM +0100, Eric W. Biederman wrote:
>> It really only matters to debuggers but the SIGKILL does not have any
>> si_codes that use the fault member of the siginfo union.  Correct this
>> the simple way and call force_sig instead of force_sig_fault when the
>> signal is SIGKILL.
>
> I haven't fully understood the context for this, but why does it matter
> what's in siginfo for SIGKILL?  My understanding is that userspace
> (including ptrace) never gets to see it anyway for the SIGKILL case.

Yes.  In practice I think it would take tracing or something very
exotic to notice anything going wrong because the task will be killed.

> Here it feels like SIGKILL is logically a synchronous, thread-targeted
> fault: we must ensure that no subsequent insn in current executes (just
> like other fault signal).  In this case, I thought we fall back to
> SIGKILL not because there is no fault, but because we failed to
> properly diagnose or report the type of fault that occurred.
>
> So maybe handling it consistently with other faults signals makes
> sense.  The fact that delivery of this signal destroys the process
> before anyone can look at the resulting siginfo feels like a
> side-effect rather than something obviously wrong.
>
> The siginfo is potentially useful diagnostic information, that we could
> subsequently provide a means to access post-mortem.
>
> I just dived in on this single patch, so I may be missing something more
> fundamental, or just being pedantic...

Not really.  I was working on another cleanup and this usage of SIGKILL
came up.

A synchronous thread synchronous fault gets us as far as the forc_sig
family of functions.  That only leaves the question of which union
member in struct siginfo we are using.  The union members are _kill,
_fault, _timer, _rt, _sigchld, _sigfault, _sigpoll, and _sigsys.

As it has prove quite error prone for people to fill out struct siginfo
in the past by hand, I have provided a couple of helper functions for
the common cases that come up such as: force_sig_fault,
force_sig_mceerr, force_sig_bnderr, force_sig_pkuerr.  Each of those
helper functions takes the information needed to fill out the union
member of struct siginfo that kind of fault corresponds to.

For the SIGKILL case the only si_code I see being passed SI_KERNEL.
The SI_KERNEL si_code corresponds to the _kill union member while
force_sig_fault fills in fields for the _fault union member.

Because of the mismatch of which union member SIGKILL should be using
and the union member force_sig_fault applies alarm bells ring in my head
when I read the current arm64 kernel code.  Somewhat doubly so because
the other fields in passed to force_sig_fault appear to be somewhat
random when SIGKILL is the signal.

So I figured let's preserve the usage of SIGKILL as a synchronous
exception.  That seems legitimate and other folks do that as well but
let's use force_sig instead of force_sig_fault instead.  I don't know if
userspace will notice but at the very least we won't be providing a bad
example for other kernel code to follow and we won't wind up be making
assumptions that are true today and false tomorrow when some
implementation detail changes.

For imformation on what signals and si_codes correspond to which
union members you can look at siginfo_layout.  That function
is the keeper of the magic decoder key.  Currently the only two
si_codes defined for SIGKILL are SI_KERNEL and SI_USER both of which
correspond to a _kill union member.

Eric


> Cheers
> ---Dave
>
>> Cc: stable@vger.kernel.org
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Fixes: af40ff687bc9 ("arm64: signal: Ensure si_code is valid for all fault signals")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  arch/arm64/kernel/traps.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index ade32046f3fe..0feb17bdcaa0 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -282,6 +282,11 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>>  		current->thread.fault_address = 0;
>>  		current->thread.fault_code = err;
>>  
>> +		if (signo == SIGKILL) {
>> +			arm64_show_signal(signo, str);
>> +			force_sig(signo, current);
>> +			return;
>> +		}
>>  		arm64_force_sig_fault(signo, sicode, addr, str);
>>  	} else {
>>  		die(str, regs, err);
>> -- 
>> 2.21.0
>> 
