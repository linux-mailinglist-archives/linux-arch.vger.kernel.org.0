Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80FF2A1A7
	for <lists+linux-arch@lfdr.de>; Sat, 25 May 2019 01:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfEXXfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 19:35:43 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49389 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfEXXfn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 May 2019 19:35:43 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hUJiw-0002yc-DP; Fri, 24 May 2019 17:35:42 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hUJiv-0006Bx-Uh; Fri, 24 May 2019 17:35:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     linux-kernel@vger.kernel.org
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
References: <20190523003916.20726-1-ebiederm@xmission.com>
Date:   Fri, 24 May 2019 18:35:31 -0500
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Wed, 22 May 2019 19:38:50 -0500")
Message-ID: <87imtzctoc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hUJiv-0006Bx-Uh;;;mid=<87imtzctoc.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+B20jF1ziR89m3eWO13gGZa3HRiSPsR2M=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4534]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 140 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.8 (2.0%), b_tie_ro: 1.86 (1.3%), parse: 0.93
        (0.7%), extract_message_metadata: 2.3 (1.6%), get_uri_detail_list:
        0.22 (0.2%), tests_pri_-1000: 3.1 (2.2%), tests_pri_-950: 1.06 (0.8%),
        tests_pri_-900: 0.87 (0.6%), tests_pri_-90: 11 (7.9%), check_bayes: 10
        (7.1%), b_tokenize: 2.7 (1.9%), b_tok_get_all: 3.0 (2.1%),
        b_comp_prob: 0.85 (0.6%), b_tok_touch_all: 2.0 (1.4%), b_finish: 0.61
        (0.4%), tests_pri_0: 101 (72.0%), check_dkim_signature: 0.34 (0.2%),
        check_dkim_adsp: 3.0 (2.1%), poll_dns_idle: 1.24 (0.9%), tests_pri_10:
        1.85 (1.3%), tests_pri_500: 6 (3.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REVIEW][PATCH 00/26] signal: Remove task argument from force_sig_info
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Oleg,

Any comments on this patchset?

Eric
