Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351BE741C8E
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 01:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF1Xnu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 19:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF1Xnt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2023 19:43:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7577610EC;
        Wed, 28 Jun 2023 16:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mkpKticynoUGDZ1Tdpq3P9FZu5kxXQf0JefJvMLgJuA=; b=eVGM60hxW/1oCROBhJRKbbF9pd
        /WHGc+o+pb+fkeVze6GKs3Hcu2mjtmWM/4oUGYCU0t+UbFMtrvvcjHSl/cglLWbeBdgmG30OqcMNt
        S2Pr1+dHNTd4T3qFeiVwQeps/R+LjlmcLTRsuZ8NdhZsmraeYrB2Kel7p0VxJ6+7q7EgMQ6Wx6ank
        P+yHcdGkzLdLPcfc5husZ1HslNubmokchQy4wGscGAVnBMae971Q/C5VLDp5JrfEWC1X5YToHzDHK
        +ikxlG8dV0EOrjRrjMKr08rEq8iFClaMjdpXxuLncvJrq9YBnHim1BxRohfVxP5cT8JFsbmDDx9YM
        9l9IY3yQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEeow-00H298-0w;
        Wed, 28 Jun 2023 23:43:34 +0000
Message-ID: <08e273fc-49c5-dd09-1c9e-d85a080767f9@infradead.org>
Date:   Wed, 28 Jun 2023 16:43:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] syscalls: Cleanup references to sys_lookup_dcookie()
Content-Language: en-US
To:     Sohil Mehta <sohil.mehta@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sergei Trofimovich <slyich@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230628230935.1196180-1-sohil.mehta@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230628230935.1196180-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 6/28/23 16:09, Sohil Mehta wrote:
> commit 'be65de6b03aa ("fs: Remove dcookies support")' removed the
> syscall definition for lookup_dcookie.  However, syscall tables still
> point to the old sys_lookup_dcookie() definition. Update syscall tables
> of all architectures to directly point to sys_ni_syscall() instead.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> This patch has a dependency on another patch that has been applied to the
> asm-generic tree:
> https://lore.kernel.org/lkml/20230621223600.1348693-1-sohil.mehta@intel.com/
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl              | 2 +-
>  arch/arm/tools/syscall.tbl                          | 2 +-
>  arch/arm64/include/asm/unistd32.h                   | 4 ++--
>  arch/ia64/kernel/syscalls/syscall.tbl               | 2 +-
>  arch/m68k/kernel/syscalls/syscall.tbl               | 2 +-
>  arch/microblaze/kernel/syscalls/syscall.tbl         | 2 +-
>  arch/mips/kernel/syscalls/syscall_n32.tbl           | 2 +-
>  arch/mips/kernel/syscalls/syscall_n64.tbl           | 2 +-
>  arch/mips/kernel/syscalls/syscall_o32.tbl           | 2 +-
>  arch/parisc/kernel/syscalls/syscall.tbl             | 2 +-
>  arch/powerpc/kernel/syscalls/syscall.tbl            | 2 +-
>  arch/s390/kernel/syscalls/syscall.tbl               | 2 +-
>  arch/sh/kernel/syscalls/syscall.tbl                 | 2 +-
>  arch/sparc/kernel/syscalls/syscall.tbl              | 2 +-
>  arch/x86/entry/syscalls/syscall_32.tbl              | 2 +-
>  arch/x86/entry/syscalls/syscall_64.tbl              | 2 +-
>  arch/xtensa/kernel/syscalls/syscall.tbl             | 2 +-
>  include/linux/compat.h                              | 1 -
>  include/linux/syscalls.h                            | 1 -
>  include/uapi/asm-generic/unistd.h                   | 2 +-
>  kernel/sys_ni.c                                     | 2 --
>  tools/include/uapi/asm-generic/unistd.h             | 2 +-
>  tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 2 +-
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 2 +-
>  tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 2 +-
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 +-
>  26 files changed, 24 insertions(+), 28 deletions(-)
> 


-- 
~Randy
