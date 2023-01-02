Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43765AD92
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jan 2023 08:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjABHIa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Jan 2023 02:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABHI3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2023 02:08:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1349E23;
        Sun,  1 Jan 2023 23:08:26 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pCEvi-0003ql-G6; Mon, 02 Jan 2023 08:08:18 +0100
Message-ID: <bb976dd2-490c-a2a0-6c46-65ab79a413b2@leemhuis.info>
Date:   Mon, 2 Jan 2023 08:08:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] arch: fix broken BuildID for arm64 and riscv
Content-Language: en-US, de-DE
To:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Dennis Gilmore <dennis@ausil.us>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, llvm@lists.linux.dev
References: <20221226184537.744960-1-masahiroy@kernel.org>
 <Y7Jal56f6UBh1abE@dev-arch.thelio-3990X>
From:   "Linux kernel regression tracking (#info)" 
        <regressions@leemhuis.info>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y7Jal56f6UBh1abE@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672643306;3df46b7c;
X-HE-SMSGID: 1pCEvi-0003ql-G6
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; all text you find below is based on a few templates
paragraphs you might have encountered already already in similar form.
See link in footer if these mails annoy you.]

On 02.01.23 05:16, Nathan Chancellor wrote:
> On Tue, Dec 27, 2022 at 03:45:37AM +0900, Masahiro Yamada wrote:
>> Dennis Gilmore reports that the BuildID is missing in the arm64 vmlinux
>> since commit 994b7ac1697b ("arm64: remove special treatment for the
>> link order of head.o").
> [...]
> I just bisected this change as the cause of a few link failures that we
> now see in CI with Debian's binutils (2.35.2):
> 
> https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2Jjl88DXc3YRi2RtvXAzlS8NQ4p/build.log
> 
> This does not appear to be related to clang/LLVM because I can easily
> reproduce it with Debian's s390x GCC and binutils building defconfig:
> 
> [...]
> 
> I ended up bisecting binutils for the fix, as I could not reproduce it
> with 2.36+. My bisect landed on commit 21401fc7bf6 ("Duplicate output
> sections in scripts"):
> 
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=21401fc7bf67dbf73f4a3eda4bcfc58fa4211584
> 
> Unfortunately, I cannot immediately grok why this commit cause the above
> issue nor why the binutils commit resolves it so I figured I would
> immediately report it for public investigation's sake and quicker
> resolution.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 99cb0d917ffa1ab628bb67364ca9b162c07699b1
#regzbot title arch: link failures in CI with Debian's binutils
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (see page linked in footer for details).

Ciao, Thorsten
-- 
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr

Annoyed by mails like this? Feel free to send them to /dev/null:
https://linux-regtracking.leemhuis.info/about/#infomails
