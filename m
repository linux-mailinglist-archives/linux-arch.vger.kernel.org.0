Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B2C10A509
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 21:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfKZUG1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 15:06:27 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36776 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZUG0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 15:06:26 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1iZh6P-0006gr-Fl; Tue, 26 Nov 2019 13:06:25 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iZh6O-0005EV-SR; Tue, 26 Nov 2019 13:06:25 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        "open list\:TENSILICA XTENSA PORT \(xtensa\)" 
        <linux-xtensa@linux-xtensa.org>
References: <8736eaxxdg.fsf@x220.int.ebiederm.org>
        <CAMo8BfK-Ua70sZe8JBHz3KK7+WjP1MvBa=jTK=-HrOHuAuDnHg@mail.gmail.com>
Date:   Tue, 26 Nov 2019 14:05:50 -0600
In-Reply-To: <CAMo8BfK-Ua70sZe8JBHz3KK7+WjP1MvBa=jTK=-HrOHuAuDnHg@mail.gmail.com>
        (Max Filippov's message of "Tue, 26 Nov 2019 11:27:29 -0800")
Message-ID: <87v9r6wggx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iZh6O-0005EV-SR;;;mid=<87v9r6wggx.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/74OOhpR6FUZedstdsHvxDU2YHFq/Tzh0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2625]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 248 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (1.1%), b_tie_ro: 1.96 (0.8%), parse: 0.81
        (0.3%), extract_message_metadata: 11 (4.4%), get_uri_detail_list: 1.24
        (0.5%), tests_pri_-1000: 13 (5.4%), tests_pri_-950: 1.36 (0.5%),
        tests_pri_-900: 1.09 (0.4%), tests_pri_-90: 25 (10.0%), check_bayes:
        23 (9.2%), b_tokenize: 5 (2.0%), b_tok_get_all: 11 (4.6%),
        b_comp_prob: 2.1 (0.8%), b_tok_touch_all: 2.3 (0.9%), b_finish: 0.72
        (0.3%), tests_pri_0: 181 (73.0%), check_dkim_signature: 0.52 (0.2%),
        check_dkim_adsp: 2.3 (0.9%), poll_dns_idle: 0.65 (0.3%), tests_pri_10:
        2.3 (0.9%), tests_pri_500: 7 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: new uses of SYSCTL_SYSCALL
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Max Filippov <jcmvbkbc@gmail.com> writes:

> Hi Eric,
>
> On Tue, Nov 26, 2019 at 11:15 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Doing a test merge against linux-next I see that in the
>> tree git://github.com/jcmvbkbc/linux-xtensa.git#xtensa-for-next
>> a new defconfig is added:
>>
>> arch/xtensa/configs/xip_kc705_defconfig
>>
>> That defconfig adds CONFIG_SYSCTL_SYSCALL.
>>
>> Is xtensa actually using this system call?  So far I have not seen any
>> other users and I am serously proposing to remove it.
>
> I'm sure that this config symbol was inherited from some other config
> that I used as a base for the xip_kc705_defconfig. I didn't enable it
> intentionally. I'll drop it from the config and fix up the patch that
> introduced it.

Thank you for confirming that.

I would recommend an incremental commit/patch on top to change just this
one thing so you don't rebase just before you send a pull request and
cause Linus's to wonder if you have tested the code at all.

Eric

