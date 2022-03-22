Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901124E4426
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 17:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiCVQYR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbiCVQYQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 12:24:16 -0400
X-Greylist: delayed 1459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 09:22:48 PDT
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com [192.185.148.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588AD27FF1
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 09:22:47 -0700 (PDT)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 5AC561C1AA2
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 10:58:24 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id Wgtrn1GVUdx86WgtrnmbfR; Tue, 22 Mar 2022 10:58:24 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FmnYj8XY37ozsL1ncMDDe7VB7cs7ym+XNgIT3Nh/4mw=; b=Kw0GKrzk9B0sN5VlG6Annzh8cf
        rq7p+wcAyXObM/5XIdD+jQnafNsb9MldsbS2dJ220mIzfYucD5gyd2BTWJ1gpWkppysQ9fiAJi43d
        BZAxCn7tC4ErJB0O5csom3VWJFd6gGICvZlBbyT7zyxaxeTYWgYz6N7I3Na8EVNS7DSGHhDWLW1+S
        YB2J+I8uZOLSahLR36ZwEOvxctQs0PAKcfC13I9vB/n0xn9FiwrCUy9b+FVwwf2Z2uaiDssdV4bpm
        wvUSKJMPsLbrcH0E3CmeuJRS1Zb83L9dNx1usrPbQhd9JrJ8hhfcqWzzinJMvHfqr8kp1KItot6Fn
        u2oobCLw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57610 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nWgtq-000tfT-Ls; Tue, 22 Mar 2022 15:58:22 +0000
Date:   Tue, 22 Mar 2022 08:58:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arch@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v1] random: block in /dev/urandom
Message-ID: <20220322155820.GA1745955@roeck-us.net>
References: <20220217162848.303601-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217162848.303601-1-Jason@zx2c4.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nWgtq-000tfT-Ls
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57610
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 36
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022 at 05:28:48PM +0100, Jason A. Donenfeld wrote:
> This topic has come up countless times, and usually doesn't go anywhere.
> This time I thought I'd bring it up with a slightly narrower focus,
> updated for some developments over the last three years: we finally can
> make /dev/urandom always secure, in light of the fact that our RNG is
> now always seeded.
> 

[ ... ]

This patch (or a later version of it) made it into mainline and causes a
large number of qemu boot test failures for various architectures (arm,
m68k, microblaze, sparc32, xtensa are the ones I observed). Common
denominator is that boot hangs at "Saving random seed:". A sample bisect
log is attached. Reverting this patch fixes the problem.

Guenter

---
# bad: [8565d64430f8278bea38dab0a3ab60b4e11c71e4] Merge tag 'bounds-fixes-v5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
# good: [f443e374ae131c168a065ea1748feac6b2e76613] Linux 5.17
git bisect start 'HEAD' 'v5.17'
# bad: [5628b8de1228436d47491c662dc521bc138a3d43] Merge tag 'random-5.18-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random
git bisect bad 5628b8de1228436d47491c662dc521bc138a3d43
# good: [a04b1bf574e1f4875ea91f5c62ca051666443200] Merge tag 'for-5.18/parisc-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect good a04b1bf574e1f4875ea91f5c62ca051666443200
# good: [242ba6656d604aa8dc87451fc08143cb28d5a587] Merge tag 'acpi-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 242ba6656d604aa8dc87451fc08143cb28d5a587
# good: [02b82b02c34321dde10d003aafcd831a769b2a8a] Merge tag 'pm-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 02b82b02c34321dde10d003aafcd831a769b2a8a
# bad: [77553cf8f44863b31da242cf24671d76ddb61597] random: don't let 644 read-only sysctls be written to
git bisect bad 77553cf8f44863b31da242cf24671d76ddb61597
# good: [a07fdae346c35c6ba286af1c88e0effcfa330bf9] random: add proper SPDX header
git bisect good a07fdae346c35c6ba286af1c88e0effcfa330bf9
# good: [58340f8e952b613e0ead0bed58b97b05bf4743c5] random: defer fast pool mixing to worker
git bisect good 58340f8e952b613e0ead0bed58b97b05bf4743c5
# good: [da3951ebdcd1cb1d5c750e08cd05aee7b0c04d9a] random: round-robin registers as ulong, not u32
git bisect good da3951ebdcd1cb1d5c750e08cd05aee7b0c04d9a
# good: [abded93ec1e9692920fe309f07f40bd1035f2940] random: unify cycles_t and jiffies usage and types
git bisect good abded93ec1e9692920fe309f07f40bd1035f2940
# bad: [6f98a4bfee72c22f50aedb39fb761567969865fe] random: block in /dev/urandom
git bisect bad 6f98a4bfee72c22f50aedb39fb761567969865fe
# good: [c2a7de4feb6e09f23af7accc0f882a8fa92e7ae5] random: do crng pre-init loading in worker rather than irq
git bisect good c2a7de4feb6e09f23af7accc0f882a8fa92e7ae5
# first bad commit: [6f98a4bfee72c22f50aedb39fb761567969865fe] random: block in /dev/urandom
