Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641E228C00
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 22:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEWU7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 16:59:30 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41507 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfEWU7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 May 2019 16:59:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTuoD-0007Zz-12; Thu, 23 May 2019 14:59:29 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTuoC-0001Ok-66; Thu, 23 May 2019 14:59:28 -0600
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
        <875zq1gnh4.fsf_-_@xmission.com>
        <20190523161509.GE31896@fuggles.cambridge.arm.com>
Date:   Thu, 23 May 2019 15:59:20 -0500
In-Reply-To: <20190523161509.GE31896@fuggles.cambridge.arm.com> (Will Deacon's
        message of "Thu, 23 May 2019 17:15:09 +0100")
Message-ID: <8736l4evkn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hTuoC-0001Ok-66;;;mid=<8736l4evkn.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Z3RJpqVzsp/miFmNUMgwL6TRBDa41ahw=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3083]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Will Deacon <will.deacon@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 469 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (1.8%), parse: 0.85 (0.2%),
         extract_message_metadata: 11 (2.4%), get_uri_detail_list: 0.98 (0.2%),
         tests_pri_-1000: 5 (1.1%), tests_pri_-950: 1.38 (0.3%),
        tests_pri_-900: 1.24 (0.3%), tests_pri_-90: 21 (4.5%), check_bayes: 19
        (4.1%), b_tokenize: 4.3 (0.9%), b_tok_get_all: 6 (1.3%), b_comp_prob:
        1.68 (0.4%), b_tok_touch_all: 3.6 (0.8%), b_finish: 1.04 (0.2%),
        tests_pri_0: 142 (30.4%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 252 (53.9%), tests_pri_10:
        2.6 (0.6%), tests_pri_500: 268 (57.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCHv2 03/26] signal/arm64: Use force_sig not force_sig_fault for SIGKILL
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Will Deacon <will.deacon@arm.com> writes:

> On Thu, May 23, 2019 at 11:11:19AM -0500, Eric W. Biederman wrote:
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index ade32046f3fe..e45d5b440fb1 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -256,7 +256,10 @@ void arm64_force_sig_fault(int signo, int code, void __user *addr,
>>  			   const char *str)
>>  {
>>  	arm64_show_signal(signo, str);
>> -	force_sig_fault(signo, code, addr, current);
>> +	if (signo == SIGKILL)
>> +		force_sig(SIGKILL, current);
>> +	else
>> +		force_sig_fault(signo, code, addr, current);
>>  }
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> Are you planning to send this series on, or would you like me to pick this
> into the arm64 tree?

I am planning on taking this through siginfo tree, unless it causes
problems.

The rest of my patchset this is a part of is a clean up to remove
the task pointer which is always current from all of the force_sig
calls.

Eric
