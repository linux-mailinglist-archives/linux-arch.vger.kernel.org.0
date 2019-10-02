Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6386FC8BD5
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2019 16:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfJBOua (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 10:50:30 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54494 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJBOua (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2019 10:50:30 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFfxU-0001ee-Bs; Wed, 02 Oct 2019 08:50:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iFfxT-0001fT-MJ; Wed, 02 Oct 2019 08:50:28 -0600
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
Date:   Wed, 02 Oct 2019 09:49:48 -0500
In-Reply-To: <CAK8P3a1zLATC7rzYxSpAK-z=NJ1rw7-3ZgHqCOJUUf6b9HwK1A@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 2 Oct 2019 09:31:01 +0200")
Message-ID: <87v9t7gq2b.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iFfxT-0001fT-MJ;;;mid=<87v9t7gq2b.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UEBXD5WP39qJHI4Xhd6CvSgTp9fMBYRU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_XMDrugObfuBody_08 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Arnd Bergmann <arnd@arndb.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 269 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.1 (1.1%), b_tie_ro: 2.1 (0.8%), parse: 1.13
        (0.4%), extract_message_metadata: 16 (6.0%), get_uri_detail_list: 1.01
        (0.4%), tests_pri_-1000: 24 (9.0%), tests_pri_-950: 1.27 (0.5%),
        tests_pri_-900: 1.10 (0.4%), tests_pri_-90: 35 (13.0%), check_bayes:
        33 (12.3%), b_tokenize: 11 (4.1%), b_tok_get_all: 8 (3.1%),
        b_comp_prob: 2.5 (0.9%), b_tok_touch_all: 7 (2.6%), b_finish: 0.73
        (0.3%), tests_pri_0: 173 (64.3%), check_dkim_signature: 0.55 (0.2%),
        check_dkim_adsp: 2.3 (0.9%), poll_dns_idle: 0.64 (0.2%), tests_pri_10:
        3.2 (1.2%), tests_pri_500: 8 (3.0%), rewrite_mail: 0.00 (0.0%)
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

>> arch/arm/configs/lpc32xx_defconfig:CONFIG_SYSCTL_SYSCALL=y
>> arch/arm/configs/moxart_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> Ancient hardware, but still in active use. These tend to have very little
> RAM, but they both enable CONFIG_PROC_FS.

You actually have to enable CONFIG_PROC_FS to enable
CONFIG_SYSCTL_SYSCALL at this point.  CONFIG_SYSCTL_SYSCALL is just an
emulation of the old interface built on top of /proc.

Thank you for the feedback.

Eric

