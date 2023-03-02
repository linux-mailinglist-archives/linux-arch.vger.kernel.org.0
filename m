Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48996A8262
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 13:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBMjB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 07:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCBMjB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 07:39:01 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5510A89;
        Thu,  2 Mar 2023 04:38:57 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id B7D6960008;
        Thu,  2 Mar 2023 12:38:45 +0000 (UTC)
Message-ID: <6b206e38-2e2e-0236-1b7d-96a537d0038e@ghiti.fr>
Date:   Thu, 2 Mar 2023 13:38:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 00/24] Remove COMMAND_LINE_SIZE from uapi
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
 <040104fc-81b7-fd45-b268-111e39f2927f@ghiti.fr>
In-Reply-To: <040104fc-81b7-fd45-b268-111e39f2927f@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 3/2/23 11:06, Alexandre Ghiti wrote:
> Hi Arnd,
>
> On 3/2/23 10:35, Alexandre Ghiti wrote:
>> This all came up in the context of increasing COMMAND_LINE_SIZE in the
>> RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
>> maximum length of /proc/cmdline and userspace could staticly rely on
>> that to be correct.
>>
>> Usually I wouldn't mess around with changing this sort of thing, but
>> PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
>> to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
>> increasing, but they're from before the UAPI split so I'm not quite sure
>> what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
>> asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
>> boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
>> and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
>> asm-generic/setup.h.").
>>
>> It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
>> part of the uapi to begin with, and userspace should be able to handle
>> /proc/cmdline of whatever length it turns out to be.  I don't see any
>> references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
>> search, but that's not really enough to consider it unused on my end.
>>
>> This issue was already considered in s390 and they reached the same
>> conclusion in commit 622021cd6c56 ("s390: make command line
>> configurable").
>>
>> The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE really
>> shouldn't be part of uapi, so this now touches all the ports. I've
>> tried to split this all out and leave it bisectable, but I haven't
>> tested it all that aggressively.
>>
>> Changes since v3 
>> <https://lore.kernel.org/all/20230214074925.228106-1-alexghiti@rivosinc.com/>:
>> * Added RB/AB
>> * Added a mention to commit 622021cd6c56 ("s390: make command line
>>    configurable") in the cover letter
>>
>> Changes since v2 
>> <https://lore.kernel.org/all/20221211061358.28035-1-palmer@rivosinc.com/>:
>> * Fix sh, csky and ia64 builds, as reported by kernel test robot
>>
>> Changes since v1 
>> <https://lore.kernel.org/all/20210423025545.313965-1-palmer@dabbelt.com/>:
>> * Touches every arch.
>>
>> base-commit-tag: next-20230207
>>
>> Palmer Dabbelt (24):
>>    alpha: Remove COMMAND_LINE_SIZE from uapi
>>    arm64: Remove COMMAND_LINE_SIZE from uapi
>>    arm: Remove COMMAND_LINE_SIZE from uapi
>>    ia64: Remove COMMAND_LINE_SIZE from uapi
>>    m68k: Remove COMMAND_LINE_SIZE from uapi
>>    microblaze: Remove COMMAND_LINE_SIZE from uapi
>>    mips: Remove COMMAND_LINE_SIZE from uapi
>>    parisc: Remove COMMAND_LINE_SIZE from uapi
>>    powerpc: Remove COMMAND_LINE_SIZE from uapi
>>    sparc: Remove COMMAND_LINE_SIZE from uapi
>>    xtensa: Remove COMMAND_LINE_SIZE from uapi
>>    asm-generic: Remove COMMAND_LINE_SIZE from uapi
>>    alpha: Remove empty <uapi/asm/setup.h>
>>    arc: Remove empty <uapi/asm/setup.h>
>>    m68k: Remove empty <uapi/asm/setup.h>
>>    arm64: Remove empty <uapi/asm/setup.h>
>>    microblaze: Remove empty <uapi/asm/setup.h>
>>    sparc: Remove empty <uapi/asm/setup.h>
>>    parisc: Remove empty <uapi/asm/setup.h>
>>    x86: Remove empty <uapi/asm/setup.h>
>>    xtensa: Remove empty <uapi/asm/setup.h>
>>    powerpc: Remove empty <uapi/asm/setup.h>
>>    mips: Remove empty <uapi/asm/setup.h>
>>    s390: Remove empty <uapi/asm/setup.h>
>>
>>   .../admin-guide/kernel-parameters.rst         |  2 +-
>>   arch/alpha/include/asm/setup.h                |  4 +--
>>   arch/alpha/include/uapi/asm/setup.h           |  7 -----
>>   arch/arc/include/asm/setup.h                  |  1 -
>>   arch/arc/include/uapi/asm/setup.h             |  6 -----
>>   arch/arm/include/asm/setup.h                  |  1 +
>>   arch/arm/include/uapi/asm/setup.h             |  2 --
>>   arch/arm64/include/asm/setup.h                |  3 ++-
>>   arch/arm64/include/uapi/asm/setup.h           | 27 -------------------
>>   arch/ia64/include/asm/setup.h                 | 10 +++++++
>>   arch/ia64/include/uapi/asm/setup.h            |  6 ++---
>>   arch/loongarch/include/asm/setup.h            |  2 +-
>>   arch/m68k/include/asm/setup.h                 |  3 +--
>>   arch/m68k/include/uapi/asm/setup.h            | 17 ------------
>>   arch/microblaze/include/asm/setup.h           |  2 +-
>>   arch/microblaze/include/uapi/asm/setup.h      | 20 --------------
>>   arch/mips/include/asm/setup.h                 |  3 ++-
>>   arch/mips/include/uapi/asm/setup.h            |  8 ------
>>   arch/parisc/include/{uapi => }/asm/setup.h    |  0
>>   arch/powerpc/include/asm/setup.h              |  2 +-
>>   arch/powerpc/include/uapi/asm/setup.h         |  7 -----
>>   arch/s390/include/asm/setup.h                 |  1 -
>>   arch/s390/include/uapi/asm/setup.h            |  1 -
>>   arch/sh/include/asm/setup.h                   |  2 +-
>>   arch/sparc/include/asm/setup.h                |  6 ++++-
>>   arch/sparc/include/uapi/asm/setup.h           | 16 -----------
>>   arch/x86/include/asm/setup.h                  |  2 --
>>   arch/x86/include/uapi/asm/setup.h             |  1 -
>>   arch/xtensa/include/{uapi => }/asm/setup.h    |  0
>>   include/asm-generic/Kbuild                    |  1 +
>>   include/{uapi => }/asm-generic/setup.h        |  0
>>   include/uapi/asm-generic/Kbuild               |  1 -
>>   32 files changed, 31 insertions(+), 133 deletions(-)
>>   delete mode 100644 arch/alpha/include/uapi/asm/setup.h
>>   delete mode 100644 arch/arc/include/uapi/asm/setup.h
>>   delete mode 100644 arch/arm64/include/uapi/asm/setup.h
>>   create mode 100644 arch/ia64/include/asm/setup.h
>>   delete mode 100644 arch/m68k/include/uapi/asm/setup.h
>>   delete mode 100644 arch/microblaze/include/uapi/asm/setup.h
>>   delete mode 100644 arch/mips/include/uapi/asm/setup.h
>>   rename arch/parisc/include/{uapi => }/asm/setup.h (100%)
>>   delete mode 100644 arch/powerpc/include/uapi/asm/setup.h
>>   delete mode 100644 arch/s390/include/uapi/asm/setup.h
>>   delete mode 100644 arch/sparc/include/uapi/asm/setup.h
>>   delete mode 100644 arch/x86/include/uapi/asm/setup.h
>>   rename arch/xtensa/include/{uapi => }/asm/setup.h (100%)
>>   rename include/{uapi => }/asm-generic/setup.h (100%)
>>
> Björn noticed that I should also remove the command line size for 
> riscv since it was picked up in 6.3 by Palmer...I send a v6 right now, 
> sorry about that.
>
> Alex
>

Hmmm when implementing the riscv patch, I noticed that the patches that 
introduce a new include/asm/setup.h file add the following SPDX header:

/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

To me we should not add "WITH Linux-syscall-note" as this header is not 
part of the user visible headers: any opinion before I send the v5?

Thanks,

Alex

