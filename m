Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA264170878
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 20:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBZTIA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 14:08:00 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:48534 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZTH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 14:07:59 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j722H-0004xQ-Mj; Wed, 26 Feb 2020 12:07:57 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j722G-0003UI-Hj; Wed, 26 Feb 2020 12:07:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
        <20200226180526.3272848-10-catalin.marinas@arm.com>
Date:   Wed, 26 Feb 2020 13:05:52 -0600
In-Reply-To: <20200226180526.3272848-10-catalin.marinas@arm.com> (Catalin
        Marinas's message of "Wed, 26 Feb 2020 18:05:16 +0000")
Message-ID: <874kvdxj73.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j722G-0003UI-Hj;;;mid=<874kvdxj73.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/0F2i/+wSq/VqwOdFbGsprftz56H+SliE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3193]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Catalin Marinas <catalin.marinas@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 534 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.0 (0.6%), b_tie_ro: 1.98 (0.4%), parse: 1.11
        (0.2%), extract_message_metadata: 20 (3.8%), get_uri_detail_list: 2.3
        (0.4%), tests_pri_-1000: 25 (4.7%), tests_pri_-950: 1.36 (0.3%),
        tests_pri_-900: 0.98 (0.2%), tests_pri_-90: 24 (4.5%), check_bayes: 22
        (4.2%), b_tokenize: 7 (1.4%), b_tok_get_all: 7 (1.3%), b_comp_prob:
        2.1 (0.4%), b_tok_touch_all: 3.9 (0.7%), b_finish: 0.61 (0.1%),
        tests_pri_0: 246 (46.1%), check_dkim_signature: 1.02 (0.2%),
        check_dkim_adsp: 6 (1.1%), poll_dns_idle: 195 (36.5%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 206 (38.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 09/19] arm64: mte: Add specific SIGSEGV codes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> Add MTE-specific SIGSEGV codes to siginfo.h.
>
> Note that the for MTE we are reusing the same SPARC ADI codes because
> the two functionalities are similar and they cannot coexist on the same
> system.

Any chance you can move the v2 notes up into the description or
otherwise fix it.  The description talks about reusing the ADI codes
which is no longer happening.

Otherwise the patch looks good.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> [catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
> [catalin.marinas@arm.com: dropped #ifdef __aarch64__, renumbered]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>
> Notes:
>     v2:
>     - Dropped the #ifdef __aarch64__.
>     - Renumbered the SEGV_MTE* values to avoid clash with ADI.
>
>  include/uapi/asm-generic/siginfo.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index cb3d6c267181..7aacf9389010 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -229,7 +229,9 @@ typedef struct siginfo {
>  #define SEGV_ACCADI	5	/* ADI not enabled for mapped object */
>  #define SEGV_ADIDERR	6	/* Disrupting MCD error */
>  #define SEGV_ADIPERR	7	/* Precise MCD exception */
> -#define NSIGSEGV	7
> +#define SEGV_MTEAERR	8	/* Asynchronous ARM MTE error */
> +#define SEGV_MTESERR	9	/* Synchronous ARM MTE exception */
> +#define NSIGSEGV	9
>  
>  /*
>   * SIGBUS si_codes
