Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87774D3AC8
	for <lists+linux-arch@lfdr.de>; Wed,  9 Mar 2022 21:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiCIUFc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Mar 2022 15:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbiCIUFb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2022 15:05:31 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB0D24BC3;
        Wed,  9 Mar 2022 12:04:31 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:38326)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nS2Xh-00CxEg-Pi; Wed, 09 Mar 2022 13:04:17 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34642 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nS2Xe-0012kW-1P; Wed, 09 Mar 2022 13:04:17 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Borislav Petkov <bp@alien8.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Theodore Ts'o <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        =?utf-8?Q?M=C3=A5ns_Rullg=C3=A5rd?= <mans@mansr.com>,
        Michael Cree <mcree@orcon.net.nz>,
        <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
        <YeCuNapJLK4M5sat@zn.tnic>
        <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
        <YeHLIDsjGB944GSP@zn.tnic>
        <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
        <YeHQmbMYyy92AbBp@zn.tnic> <YeKyBP5rac8sVvWw@zn.tnic>
        <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de>
Date:   Wed, 09 Mar 2022 14:03:42 -0600
In-Reply-To: <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de> (John
        Paul Adrian Glaubitz's message of "Sat, 15 Jan 2022 20:42:59 +0100")
Message-ID: <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nS2Xe-0012kW-1P;;;mid=<87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+e4yH+BUF7W62HMdvNWWMejYj/t+Qtgp8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3142 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.3%), b_tie_ro: 9 (0.3%), parse: 0.97 (0.0%),
         extract_message_metadata: 22 (0.7%), get_uri_detail_list: 2.4 (0.1%),
        tests_pri_-1000: 25 (0.8%), tests_pri_-950: 1.24 (0.0%),
        tests_pri_-900: 1.02 (0.0%), tests_pri_-90: 91 (2.9%), check_bayes: 89
        (2.8%), b_tokenize: 10 (0.3%), b_tok_get_all: 9 (0.3%), b_comp_prob:
        2.4 (0.1%), b_tok_touch_all: 64 (2.0%), b_finish: 0.95 (0.0%),
        tests_pri_0: 1994 (63.4%), check_dkim_signature: 0.52 (0.0%),
        check_dkim_adsp: 3.8 (0.1%), poll_dns_idle: 977 (31.1%), tests_pri_10:
        3.1 (0.1%), tests_pri_500: 991 (31.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] a.out: Stop building a.out/osf1 support on alpha and m68k
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


There has been repeated discussion on removing a.out support, the most
recent was[1].  Having read through a bunch of the discussion it looks
like no one has see any reason why we need to keep a.out support.

The m68k maintainer has even come out in favor of removing a.out
support[2].

At a practical level with only two rarely used architectures building
a.out support, it gets increasingly hard to test and to care about.
Which means the code will almost certainly bit-rot.

Let's see if anyone cares about a.out support on the last two
architectures that build it, by disabling the build of the support in
Kconfig.  If anyone cares, this can be easily reverted, and we can then
have a discussion about what it is going to take to support a.out
binaries in the long term.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
[1] https://lkml.kernel.org/r/20220113160115.5375-1-bp@alien8.de
[2] https://lkml.kernel.org/r/CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Kees do you think you could add this to your execve branch?

I think this should be a complimentary patch to Borislav Petkov's patch
at the top of this tread to remove a.out support on x86.

 arch/alpha/Kconfig | 1 -
 arch/m68k/Kconfig  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 4e87783c90ad..14c97acea351 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -12,7 +12,6 @@ config ALPHA
 	select FORCE_PCI if !ALPHA_JENSEN
 	select PCI_DOMAINS if PCI
 	select PCI_SYSCALL if PCI
-	select HAVE_AOUT
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 936e1803c7c7..268b3860d40d 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -17,7 +17,6 @@ config M68K
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_SHOW
-	select HAVE_AOUT if MMU
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED
-- 
2.29.2

