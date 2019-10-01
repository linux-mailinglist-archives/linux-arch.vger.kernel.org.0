Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1BC440E
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2019 00:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfJAWyV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 18:54:21 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35958 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfJAWyV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 18:54:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFR24-00043h-FL; Tue, 01 Oct 2019 16:54:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFR1y-00061d-Ku; Tue, 01 Oct 2019 16:54:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Apelete Seketeli <apelete@seketeli.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Chee Nouk Phoon <cnphoon@altera.com>,
        Chris Zankel <chris@zankel.net>,
        Christian Ruppert <christian.ruppert@abilis.com>,
        Greg Ungerer <gerg@uclinux.org>, Helge Deller <deller@gmx.de>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Josh Boyer <jwboyer@gmail.com>, Jun Nie <jun.nie@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Paul Burton <paul.burton@mips.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Pierrick Hascoet <pierrick.hascoet@abilis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roland Stigge <stigge@antcom.de>,
        Vineet Gupta <vgupta@synopsys.com>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
        <201910011140.EA0181F13@keescook>
Date:   Tue, 01 Oct 2019 17:53:27 -0500
In-Reply-To: <201910011140.EA0181F13@keescook> (Kees Cook's message of "Tue, 1
        Oct 2019 11:46:45 -0700")
Message-ID: <87imp8hyc8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iFR1y-00061d-Ku;;;mid=<87imp8hyc8.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1890sJnTfB2radGtM5zpN9fbLEpYr3LK/s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4785]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 341 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 3.4 (1.0%), b_tie_ro: 2.8 (0.8%), parse: 0.72
        (0.2%), extract_message_metadata: 9 (2.5%), get_uri_detail_list: 0.91
        (0.3%), tests_pri_-1000: 11 (3.3%), tests_pri_-950: 1.02 (0.3%),
        tests_pri_-900: 0.96 (0.3%), tests_pri_-90: 23 (6.7%), check_bayes: 22
        (6.4%), b_tokenize: 7 (2.1%), b_tok_get_all: 7 (2.2%), b_comp_prob:
        1.78 (0.5%), b_tok_touch_all: 3.8 (1.1%), b_finish: 0.54 (0.2%),
        tests_pri_0: 283 (83.0%), check_dkim_signature: 0.52 (0.2%),
        check_dkim_adsp: 2.6 (0.8%), poll_dns_idle: 0.19 (0.1%), tests_pri_10:
        1.78 (0.5%), tests_pri_500: 4.8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Oct 01, 2019 at 01:36:32PM -0500, Eric W. Biederman wrote:
>> 
>> This system call has been deprecated almost since it was introduced, and
>> in a survey of the linux distributions I can no longer find any of them
>> that enable CONFIG_SYSCTL_SYSCALL.  The only indication that I can find
>> that anyone might care is that a few of the defconfigs in the kernel
>> enable CONFIG_SYSCTL_SYSCALL.  However this appears in only 31 of 414
>> defconfigs in the kernel, so I suspect this symbols presence is simply
>> because it is harmless to include rather than because it is necessary.
>> 
>> As there appear to be no users of the sysctl system call, remove the
>> code.  As this removes one of the few uses of the internal kernel mount
>> of proc I hope this allows for even more simplifications of the proc
>> filesystem.
>
> I'm for it. :) I tripped over this being deprecated over a decade ago. :P
>
> I think you can actually take this further and remove (or at least
> empty) the uapi/linux/sysctl.h file too.

I copied everyone who had put this into a defconfig and I will wait a
little more to see if anyone screams.  I think it is a safe guess that
several of the affected configurations are dead (or at least
unmaintained) as I received 17 bounces when copying everyone.

I would make it a followup that removes uapi/linux/sysctl.h.  I don't
see anything in it that isn't about the sysctl system call.  I will keep
it a separate patch as I can imagine something silly that needs the
header file to compile.  A separate patch would make a revert easier
if we find something like that.

Eric
