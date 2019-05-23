Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55AD2805C
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfEWO7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 10:59:30 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52242 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbfEWO7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 May 2019 10:59:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTpBo-00030K-MM; Thu, 23 May 2019 08:59:28 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTpBn-0005AC-PE; Thu, 23 May 2019 08:59:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
        <20190523003916.20726-4-ebiederm@xmission.com>
        <20190523101702.GG26646@fuggles.cambridge.arm.com>
Date:   Thu, 23 May 2019 09:59:20 -0500
In-Reply-To: <20190523101702.GG26646@fuggles.cambridge.arm.com> (Will Deacon's
        message of "Thu, 23 May 2019 11:17:02 +0100")
Message-ID: <87d0k9gqt3.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hTpBn-0005AC-PE;;;mid=<87d0k9gqt3.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+nHg2SfTEM+VVuC4vmrmmS7rYHAMpU7QI=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Will Deacon <will.deacon@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 384 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 3.4 (0.9%), b_tie_ro: 2.2 (0.6%), parse: 1.21
        (0.3%), extract_message_metadata: 15 (4.0%), get_uri_detail_list: 1.86
        (0.5%), tests_pri_-1000: 18 (4.8%), tests_pri_-950: 1.35 (0.4%),
        tests_pri_-900: 1.10 (0.3%), tests_pri_-90: 24 (6.3%), check_bayes: 23
        (5.9%), b_tokenize: 7 (1.9%), b_tok_get_all: 8 (2.0%), b_comp_prob:
        2.5 (0.7%), b_tok_touch_all: 3.3 (0.9%), b_finish: 0.61 (0.2%),
        tests_pri_0: 305 (79.5%), check_dkim_signature: 0.68 (0.2%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.41 (0.1%), tests_pri_10:
        1.82 (0.5%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 03/26] signal/arm64: Use force_sig not force_sig_fault for SIGKILL
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Will Deacon <will.deacon@arm.com> writes:

> On Wed, May 22, 2019 at 07:38:53PM -0500, Eric W. Biederman wrote:
>> It really only matters to debuggers but the SIGKILL does not have any
>> si_codes that use the fault member of the siginfo union.  Correct this
>> the simple way and call force_sig instead of force_sig_fault when the
>> signal is SIGKILL.
>> 
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
>
> I know it's a bit of a misnomer, but I'd rather do this check inside
> arm64_force_sig_fault, since I think we have other callers (e.g.
> do_bad_area()) which also blindly pass in SIGKILL here.

Sigh.  You are right.

I thought I had checked for that when I made my change there.  But
do_bad_area will definitely do that, and that was one of the cases that
jumped out at me as needing to be fixed, when I skimmed the arm code.

I will respin this patch to move that lower.

> We could rename the thing if necessary.

I would not mind but as long as we aren't misusing the generic bits
I won't have alarm bells going of in my head when I look at their
users.

Eric

