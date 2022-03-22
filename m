Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145B84E490A
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 23:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiCVWSr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 18:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiCVWSq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 18:18:46 -0400
X-Greylist: delayed 1251 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 15:17:18 PDT
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com [192.185.61.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0355353731
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 15:17:17 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 0091A400D0A7C
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 16:56:26 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id WmSPnZTcK22u3WmSPnz4bq; Tue, 22 Mar 2022 16:54:25 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=85qDSXjuy3bqX48/V7qNAooeuLGvtvt332ffL0LuTg8=; b=WSLUVe52oGs/Ddtq6qQsCamGOs
        BMT1coTNJUYWPu167rm2U2dlsI6QLQehPvM9u4V/1wCnCJHSoLHHgj8NYbHP3oZO4gXj8xVL9c9zS
        vvD/zl0LNnzW/1HzjfgD25wzBtawy5bmlHT346hYaIsu+zPzLHQXnxZv9/GHee71iQnYGVrf6Llxf
        79yWtF5uQ6iini3C4yMLmO/gy5ruQL7shgzTfehlB4C2yLa66ka7nkeMfMoLQTE1KTqnOzbLFcSv+
        hAQGgxVECzthuOQLPiZ6TDCWR+k8GavdUHT0rUh8pP9ABeyGMoRWqb1PLayQ3iMyvBINUosOVKeof
        rywwIZ/A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54406)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nWmSO-0015dB-47; Tue, 22 Mar 2022 21:54:24 +0000
Message-ID: <0d20fb04-81b8-eeee-49ab-5b0a9e78c9f8@roeck-us.net>
Date:   Tue, 22 Mar 2022 14:54:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
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
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net> <YjoUU+8zrzB02pW7@sirena.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] random: block in /dev/urandom
In-Reply-To: <YjoUU+8zrzB02pW7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nWmSO-0015dB-47
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54406
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 46
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/22/22 11:24, Mark Brown wrote:
> On Tue, Mar 22, 2022 at 08:58:20AM -0700, Guenter Roeck wrote:
> 
>> This patch (or a later version of it) made it into mainline and causes a
>> large number of qemu boot test failures for various architectures (arm,
>> m68k, microblaze, sparc32, xtensa are the ones I observed). Common
>> denominator is that boot hangs at "Saving random seed:". A sample bisect
>> log is attached. Reverting this patch fixes the problem.
> 
> Just as a datapoint for debugging at least qemu/arm is getting coverage
> in CI systems (KernelCI is covering a bunch of different emulated
> machines and LKFT has at least one configuration as well, clang's tests
> have some wider architecture coverage as well I think) and they don't
> seem to be seeing any problems - there's some other variable in there.
> 
> For example current basic boot tests for KernelCI are at:
> 
>     https://linux.kernelci.org/test/job/mainline/branch/master/kernel/v5.17-1442-gb47d5a4f6b8d/plan/baseline/
> 
> for mainline and -next has:
> 
>     https://linux.kernelci.org/test/job/next/branch/master/kernel/next-20220322/plan/baseline/
> 
> These are with a buildroot based rootfs that has a "Saving random seed: "
> step in the boot process FWIW.

I use buildroot 2021.02.3. I have not changed the buildroot code, and it
still seems to be the same in 2022.02. I don't see the problem with all
boot tests, only with the architectures mentioned above, and not with all
qemu machines on the affected platforms. For arm, mostly older machines
are affected (versatile, realview, pxa configurations, collie, integratorcp,
sx1, mps2-an385, vexpress-a9, cubieboard). I didn't check, but maybe
kernelci doesn't test those machines ?

Guenter
