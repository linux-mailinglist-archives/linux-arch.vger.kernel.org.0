Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA411D575
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 19:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfLLS1h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 13:27:37 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:41028 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbfLLS1h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 13:27:37 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1ifTBW-0006da-Da; Thu, 12 Dec 2019 11:27:34 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ifTBV-0007Vb-8k; Thu, 12 Dec 2019 11:27:34 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
        <20191211184027.20130-13-catalin.marinas@arm.com>
        <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
Date:   Thu, 12 Dec 2019 12:26:41 -0600
In-Reply-To: <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 11 Dec 2019 20:31:28 +0100")
Message-ID: <87zhfxqu1q.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ifTBV-0007Vb-8k;;;mid=<87zhfxqu1q.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Nj1okHY+lVK9nVgaeSq2QimrMTWlLlGo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1506]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 522 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.5%), b_tie_ro: 1.69 (0.3%), parse: 0.84
        (0.2%), extract_message_metadata: 16 (3.0%), get_uri_detail_list: 2.6
        (0.5%), tests_pri_-1000: 10 (1.9%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 34 (6.6%), check_bayes: 33
        (6.3%), b_tokenize: 10 (1.8%), b_tok_get_all: 13 (2.6%), b_comp_prob:
        3.5 (0.7%), b_tok_touch_all: 4.3 (0.8%), b_finish: 0.59 (0.1%),
        tests_pri_0: 441 (84.4%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.39 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 10 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 12/22] arm64: mte: Add specific SIGSEGV codes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>> Add MTE-specific SIGSEGV codes to siginfo.h.
>>
>> Note that the for MTE we are reusing the same SPARC ADI codes because
>> the two functionalities are similar and they cannot coexist on the same
>> system.

Please Please Please don't do that.

It is actively harmful to have architecture specific si_code values.
As it makes maintenance much more difficult.

Especially as the si_codes are part of union descrimanator.

If your functionality is identical reuse the numbers otherwise please
just select the next numbers not yet used.

We have at least 256 si_codes per signal 2**32 if we really need them so
there is no need to be reuse numbers.

The practical problem is that architecture specific si_codes start
turning kernel/signal.c into #ifdef soup, and we loose a lot of
basic compile coverage because of that.  In turn not compiling the code
leads to bit-rot in all kinds of weird places.



Now as far as the observation that this is almost the same as other
functionality why can't this fit the existing interface exposed to
userspace?   Sometimes there are good reasons, but technology gets
a lot more uptake and testing when the same interfaces are more widely
available.

Eric

p.s. As for coexistence there is always the possibility that one chip
in a cpu family does supports one thing and another chip in a cpu
family supports another.  So userspace may have to cope with the
situation even if an individual chip doesn't.

I remember a similar case where sparc had several distinct page table
formats and we had a single kernel that had to cope with them all.


>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> [catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  include/uapi/asm-generic/siginfo.h | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
>> index cb3d6c267181..a5184a5438c6 100644
>> --- a/include/uapi/asm-generic/siginfo.h
>> +++ b/include/uapi/asm-generic/siginfo.h
>> @@ -227,8 +227,13 @@ typedef struct siginfo {
>>  # define SEGV_PKUERR   4       /* failed protection key checks */
>>  #endif
>>  #define SEGV_ACCADI    5       /* ADI not enabled for mapped object */
>> -#define SEGV_ADIDERR   6       /* Disrupting MCD error */
>> -#define SEGV_ADIPERR   7       /* Precise MCD exception */
>> +#ifdef __aarch64__
>> +# define SEGV_MTEAERR  6       /* Asynchronous MTE error */
>> +# define SEGV_MTESERR  7       /* Synchronous MTE exception */
>> +#else
>> +# define SEGV_ADIDERR  6       /* Disrupting MCD error */
>> +# define SEGV_ADIPERR  7       /* Precise MCD exception */
>> +#endif
>
> SEGV_ADIPERR/SEGV_ADIDERR were added together with SEGV_ACCADI,
> it seems a bit odd to make only two of them conditional but not the others.
>
> I think we are generally working towards having the same constants
> across architectures even for features that only exist on one of them.
>
> Adding Al and Eric to Cc, maybe they have another suggestion on what
> constants should be used.
>
>      Arnd
