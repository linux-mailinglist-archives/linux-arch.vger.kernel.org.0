Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07B93D6824
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 22:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhGZTsp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 15:48:45 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37256 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhGZTsp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 15:48:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m87Ds-001veA-FK; Mon, 26 Jul 2021 14:29:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43746 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m87Dr-003xRj-Fd; Mon, 26 Jul 2021 14:29:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Brad Boyer <flar@allandria.com>, geert@linux-m68k.org,
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
        <87a6m8kgtx.fsf_-_@disp2133> <875yww7s01.fsf@igel.home>
Date:   Mon, 26 Jul 2021 15:29:04 -0500
In-Reply-To: <875yww7s01.fsf@igel.home> (Andreas Schwab's message of "Mon, 26
        Jul 2021 22:13:50 +0200")
Message-ID: <87k0lcizu7.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m87Dr-003xRj-Fd;;;mid=<87k0lcizu7.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+z32KOejNI9Ouby2CSqkDgwF558HbGxx0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,TR_Symld_Words,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1832]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Andreas Schwab <schwab@linux-m68k.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 324 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (3.2%), b_tie_ro: 9 (2.8%), parse: 0.79 (0.2%),
         extract_message_metadata: 18 (5.5%), get_uri_detail_list: 0.71 (0.2%),
         tests_pri_-1000: 15 (4.7%), tests_pri_-950: 1.61 (0.5%),
        tests_pri_-900: 1.15 (0.4%), tests_pri_-90: 50 (15.5%), check_bayes:
        49 (15.0%), b_tokenize: 6 (1.8%), b_tok_get_all: 5.0 (1.5%),
        b_comp_prob: 1.83 (0.6%), b_tok_touch_all: 32 (9.9%), b_finish: 1.15
        (0.4%), tests_pri_0: 154 (47.5%), check_dkim_signature: 0.63 (0.2%),
        check_dkim_adsp: 2.8 (0.9%), poll_dns_idle: 1.00 (0.3%), tests_pri_10:
        2.3 (0.7%), tests_pri_500: 66 (20.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jul 26 2021, Eric W. Biederman wrote:
>
>> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
>> index a8f41615d94a..ec767523c012 100644
>> --- a/arch/m68k/fpsp040/skeleton.S
>> +++ b/arch/m68k/fpsp040/skeleton.S
>> @@ -502,7 +502,8 @@ in_ea:
>>  	.section .fixup,#alloc,#execinstr
>>  	.even
>>  1:
>> -	jbra	fpsp040_die
>> +	bsrl	fpsp040_die
>> +	jmp	.Lnotkern
>
> That should be jbra instead of jmp.

I will update my patch.  Mind if I ask what the difference is?

I could not find a reference mentioning jbra.  Do I need to look in the
gas source or do you know if there is a better source?

Eric

