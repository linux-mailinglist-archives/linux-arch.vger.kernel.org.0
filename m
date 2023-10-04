Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52DE7B78A1
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 09:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbjJDHXO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 03:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjJDHXO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 03:23:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E2AB;
        Wed,  4 Oct 2023 00:23:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AA2C433C7;
        Wed,  4 Oct 2023 07:22:59 +0000 (UTC)
Date:   Wed, 4 Oct 2023 08:22:57 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
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
        Arnd Bergmann <arnd@arndb.de>,
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
        Brian Gerst <brgerst@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
Message-ID: <ZR0S0QUoAbqTS/O+@arm.com>
References: <20230914185804.2000497-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914185804.2000497-1-sohil.mehta@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 06:58:03PM +0000, Sohil Mehta wrote:
> commit c35559f94ebc ("x86/shstk: Introduce map_shadow_stack syscall")
> recently added support for map_shadow_stack() but it is limited to x86
> only for now. There is a possibility that other architectures (namely,
> arm64 and RISC-V), that are implementing equivalent support for shadow
> stacks, might need to add support for it.
> 
> Independent of that, reserving arch-specific syscall numbers in the
> syscall tables of all architectures is good practice and would help
> avoid future conflicts. map_shadow_stack() is marked as a conditional
> syscall in sys_ni.c. Adding it to the syscall tables of other
> architectures is harmless and would return ENOSYS when exercised.
> 
> Note, map_shadow_stack() was assigned #453 during the merge process
> since #452 was taken by fchmodat2().
> 
> For Powerpc, map it to sys_ni_syscall() as is the norm for Powerpc
> syscall tables.
> 
> For Alpha, map_shadow_stack() takes up #563 as Alpha still diverges from
> the common syscall numbering system in the other architectures.
> 
> Link: https://lore.kernel.org/lkml/20230515212255.GA562920@debug.ba.rivosinc.com/
> Link: https://lore.kernel.org/lkml/b402b80b-a7c6-4ef0-b977-c0f5f582b78a@sirena.org.uk/
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v2:
> - Skip syscall table changes to tools/. They will be handled separetely by the
>   perf folks.
> - Map Powerpc to sys_ni_syscall (Rick Edgecombe)
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
>  arch/arm/tools/syscall.tbl                  | 1 +
>  arch/arm64/include/asm/unistd.h             | 2 +-
>  arch/arm64/include/asm/unistd32.h           | 2 ++

For arm64 (compat):

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
