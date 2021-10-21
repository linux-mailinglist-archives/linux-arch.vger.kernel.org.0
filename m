Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815B1436315
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhJUNgo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 09:36:44 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54244 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUNgo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 09:36:44 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:40512)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdYD5-005DQ9-NZ; Thu, 21 Oct 2021 07:34:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:46380 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdYD4-003epC-7e; Thu, 21 Oct 2021 07:34:19 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        "open list\:TENSILICA XTENSA PORT \(xtensa\)" 
        <linux-xtensa@linux-xtensa.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "open list\:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        H Peter Anvin <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Kees Cook <keescook@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Openrisc <openrisc@lists.librecores.org>,
        Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greentime Hu <green.hu@gmail.com>
References: <87y26nmwkb.fsf@disp2133> <877de7jrev.fsf@disp2133>
        <CAMuHMdURxrdjsXq7+q-AWTwxVUdmddOj2vvNHv6M=WtsU5nRvg@mail.gmail.com>
Date:   Thu, 21 Oct 2021 08:33:51 -0500
In-Reply-To: <CAMuHMdURxrdjsXq7+q-AWTwxVUdmddOj2vvNHv6M=WtsU5nRvg@mail.gmail.com>
        (Geert Uytterhoeven's message of "Thu, 21 Oct 2021 10:09:46 +0200")
Message-ID: <87tuhaijsw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdYD4-003epC-7e;;;mid=<87tuhaijsw.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Mpe2HbWR2YDGhZ3vVJNTbKaHiNpeOXoM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 897 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.4%), b_tie_ro: 10 (1.2%), parse: 1.14
        (0.1%), extract_message_metadata: 14 (1.6%), get_uri_detail_list: 1.00
        (0.1%), tests_pri_-1000: 27 (3.0%), tests_pri_-950: 1.31 (0.1%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 286 (31.9%), check_bayes:
        285 (31.7%), b_tokenize: 12 (1.3%), b_tok_get_all: 8 (0.9%),
        b_comp_prob: 2.2 (0.3%), b_tok_touch_all: 260 (28.9%), b_finish: 0.94
        (0.1%), tests_pri_0: 537 (59.9%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 3.0 (0.3%), poll_dns_idle: 1.00 (0.1%), tests_pri_10:
        3.2 (0.4%), tests_pri_500: 10 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 21/20] signal: Replace force_sigsegv(SIGSEGV) with force_fatal_sig(SIGSEGV)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Eric,
>
> Patch 21/20?

In reviewing another part of the patchset Linus asked if force_sigsegv
could go away.  It can't completely but I can get this far.

Given that it is just a cleanup it makes most sense to me as an
additional patch on top of what is already here.


> On Wed, Oct 20, 2021 at 11:52 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Now that force_fatal_sig exists it is unnecessary and a bit confusing
>> to use force_sigsegv in cases where the simpler force_fatal_sig is
>> wanted.  So change every instance we can to make the code clearer.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
>>  arch/m68k/kernel/traps.c        | 2 +-
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thank you.

Eric
