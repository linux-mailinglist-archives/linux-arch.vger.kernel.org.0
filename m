Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD2172229
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgB0PWb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 10:22:31 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:40872 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgB0PWb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 10:22:31 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7Kzd-0002oK-5G; Thu, 27 Feb 2020 08:22:29 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7Kzc-0004Rt-Be; Thu, 27 Feb 2020 08:22:28 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20200226180526.3272848-10-catalin.marinas@arm.com>
        <202002270627.YYGOStB9%lkp@intel.com>
        <20200227110558.GB3281767@arrakis.emea.arm.com>
Date:   Thu, 27 Feb 2020 09:20:23 -0600
In-Reply-To: <20200227110558.GB3281767@arrakis.emea.arm.com> (Catalin
        Marinas's message of "Thu, 27 Feb 2020 11:05:58 +0000")
Message-ID: <87tv3cvyyw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7Kzc-0004Rt-Be;;;mid=<87tv3cvyyw.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/nALEEfqW3mERTujRdYVsPc5xKTukFjx4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1223]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Catalin Marinas <catalin.marinas@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 284 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (1.0%), b_tie_ro: 1.98 (0.7%), parse: 0.75
        (0.3%), extract_message_metadata: 15 (5.1%), get_uri_detail_list: 1.59
        (0.6%), tests_pri_-1000: 25 (8.8%), tests_pri_-950: 1.01 (0.4%),
        tests_pri_-900: 0.81 (0.3%), tests_pri_-90: 28 (10.0%), check_bayes:
        27 (9.5%), b_tokenize: 7 (2.5%), b_tok_get_all: 11 (3.7%),
        b_comp_prob: 3.1 (1.1%), b_tok_touch_all: 3.9 (1.4%), b_finish: 0.61
        (0.2%), tests_pri_0: 200 (70.4%), check_dkim_signature: 0.63 (0.2%),
        check_dkim_adsp: 2.5 (0.9%), poll_dns_idle: 0.60 (0.2%), tests_pri_10:
        1.83 (0.6%), tests_pri_500: 6 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 09/19] arm64: mte: Add specific SIGSEGV codes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Feb 27, 2020 at 06:33:14AM +0800, kbuild test robot wrote:
>> url:    https://github.com/0day-ci/linux/commits/Catalin-Marinas/arm64-Memory-Tagging-Extension-user-space-support/20200227-041230
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
>> config: x86_64-defconfig (attached as .config)
>> compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=x86_64 
>> 
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>> 
>> All error/warnings (new ones prefixed by >>):
>> 
>>    In file included from include/linux/export.h:43:0,
>>                     from include/linux/linkage.h:7,
>>                     from arch/x86/include/asm/cache.h:5,
>>                     from include/linux/cache.h:6,
>>                     from include/linux/time.h:5,
>>                     from include/linux/compat.h:10,
>>                     from arch/x86/kernel/signal_compat.c:2:
>>    In function 'signal_compat_build_tests',
>>        inlined from 'sigaction_compat_abi' at arch/x86/kernel/signal_compat.c:166:2:
>> >> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_30' declared with attribute error: BUILD_BUG_ON failed: NSIGSEGV != 7
>
> I haven't realised that x86 has a build check for NSIGSEGV. I'll fold in
> the diff below (there are no new fields added to siginfo, so no other
> changes necessary):

Yes.  That looks good.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index 9ccbf0576cd0..a7f3e12cfbdb 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -27,7 +27,7 @@ static inline void signal_compat_build_tests(void)
>  	 */
>  	BUILD_BUG_ON(NSIGILL  != 11);
>  	BUILD_BUG_ON(NSIGFPE  != 15);
> -	BUILD_BUG_ON(NSIGSEGV != 7);
> +	BUILD_BUG_ON(NSIGSEGV != 9);
>  	BUILD_BUG_ON(NSIGBUS  != 5);
>  	BUILD_BUG_ON(NSIGTRAP != 5);
>  	BUILD_BUG_ON(NSIGCHLD != 6);
