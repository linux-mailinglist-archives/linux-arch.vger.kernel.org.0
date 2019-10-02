Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9AC2C8B7D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2019 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfJBOlu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 10:41:50 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53200 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfJBOlt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2019 10:41:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFfoy-0000co-LJ; Wed, 02 Oct 2019 08:41:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFfox-0000M4-PV; Wed, 02 Oct 2019 08:41:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Apelete Seketeli <apelete@seketeli.net>,
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
        <87imp8hyc8.fsf@x220.int.ebiederm.org>
        <CAK8P3a1zLATC7rzYxSpAK-z=NJ1rw7-3ZgHqCOJUUf6b9HwK1A@mail.gmail.com>
Date:   Wed, 02 Oct 2019 09:41:00 -0500
In-Reply-To: <CAK8P3a1zLATC7rzYxSpAK-z=NJ1rw7-3ZgHqCOJUUf6b9HwK1A@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 2 Oct 2019 09:31:01 +0200")
Message-ID: <87a7aji51f.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iFfox-0000M4-PV;;;mid=<87a7aji51f.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19IHDVGlAbdPU8dF8uFaTBUUrSZFrNIEnY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4966]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 422 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.6%), b_tie_ro: 1.79 (0.4%), parse: 0.65
        (0.2%), extract_message_metadata: 16 (3.8%), get_uri_detail_list: 1.31
        (0.3%), tests_pri_-1000: 15 (3.6%), tests_pri_-950: 1.03 (0.2%),
        tests_pri_-900: 0.96 (0.2%), tests_pri_-90: 30 (7.2%), check_bayes: 29
        (6.9%), b_tokenize: 8 (2.0%), b_tok_get_all: 11 (2.7%), b_comp_prob:
        2.1 (0.5%), b_tok_touch_all: 4.3 (1.0%), b_finish: 0.61 (0.1%),
        tests_pri_0: 240 (56.7%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 10 (2.3%), poll_dns_idle: 100 (23.6%), tests_pri_10:
        1.63 (0.4%), tests_pri_500: 112 (26.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Oct 2, 2019 at 12:54 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> > On Tue, Oct 01, 2019 at 01:36:32PM -0500, Eric W. Biederman wrote:
>> >
>> > I think you can actually take this further and remove (or at least
>> > empty) the uapi/linux/sysctl.h file too.
>>
>> I copied everyone who had put this into a defconfig and I will wait a
>> little more to see if anyone screams.  I think it is a safe guess that
>> several of the affected configurations are dead (or at least
>> unmaintained) as I received 17 bounces when copying everyone.
>
> Looking at the arm defconfigs:
>
>> arch/arm/configs/axm55xx_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> No notable work on this platform since it got sold to Intel in 2014.
> I think they still use it but not with mainline kernels that lack support
> for most drivers and the later chips.
>
>> arch/arm/configs/keystone_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> Not that old either, but this hardware is mostly obsoleted by newer variants
> that we support with the arm64 defconfig.
>
>> arch/arm/configs/lpc32xx_defconfig:CONFIG_SYSCTL_SYSCALL=y
>> arch/arm/configs/moxart_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> Ancient hardware, but still in active use. These tend to have very little
> RAM, but they both enable CONFIG_PROC_FS.
>
>> arch/arm/configs/qcom_defconfig:CONFIG_SYSCTL_SYSCALL=y
>> arch/arm/configs/zx_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> These are for older Qualcomm and LG chips that tend to be used
> with Android rather than the defconfig here. Maybe double-check
> if the official android-common tree enables SYSCTL_SYSCALL.

I just looked quickly at:
https://android.googlesource.com/kernel/configs/

I don't see the string SYSCTL mentioned anywhere.  Much less
SYSCTL_SYSCALL.

Eric
