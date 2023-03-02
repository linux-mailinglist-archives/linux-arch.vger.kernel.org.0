Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EBC6A802F
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCBKqM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 05:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCBKqL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 05:46:11 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B266236FD9;
        Thu,  2 Mar 2023 02:46:08 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 75C8960014;
        Thu,  2 Mar 2023 10:45:54 +0000 (UTC)
Message-ID: <5712b56e-e2a7-c1d2-081c-bcbecdbeffb5@ghiti.fr>
Date:   Thu, 2 Mar 2023 11:45:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 00/24] Remove COMMAND_LINE_SIZE from uapi
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
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
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
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
        linux-arch@vger.kernel.org
References: <20230302093539.372962-1-alexghiti@rivosinc.com>
 <CAMuHMdVC99kFpS9vL+HEqbXdDRMKVSW_t21X1p37d0oQufxKLw@mail.gmail.com>
 <c0dd1a6e-8e8e-5cdb-bc92-755462704edf@ghiti.fr>
 <CAMuHMdVSJADwTSkOD2mG2yU0XeFd0QAUjojQDz5phWhkRcLGOg@mail.gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAMuHMdVSJADwTSkOD2mG2yU0XeFd0QAUjojQDz5phWhkRcLGOg@mail.gmail.com>
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


On 3/2/23 11:44, Geert Uytterhoeven wrote:
> Hi Alex,
>
> On Thu, Mar 2, 2023 at 11:09 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> On 3/2/23 10:47, Geert Uytterhoeven wrote:
>>> On Thu, Mar 2, 2023 at 10:35 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>>> This all came up in the context of increasing COMMAND_LINE_SIZE in the
>>>> RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
>>>> maximum length of /proc/cmdline and userspace could staticly rely on
>>>> that to be correct.
>>>>
>>>> Usually I wouldn't mess around with changing this sort of thing, but
>>>> PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
>>>> to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
>>>> increasing, but they're from before the UAPI split so I'm not quite sure
>>>> what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
>>>> asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
>>>> boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
>>>> and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
>>>> asm-generic/setup.h.").
>>>>
>>>> It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
>>>> part of the uapi to begin with, and userspace should be able to handle
>>>> /proc/cmdline of whatever length it turns out to be.  I don't see any
>>>> references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
>>>> search, but that's not really enough to consider it unused on my end.
>>>>
>>>> This issue was already considered in s390 and they reached the same
>>>> conclusion in commit 622021cd6c56 ("s390: make command line
>>>> configurable").
>>>>
>>>> The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE really
>>>> shouldn't be part of uapi, so this now touches all the ports.  I've
>>>> tried to split this all out and leave it bisectable, but I haven't
>>>> tested it all that aggressively.
>>>>
>>>> Changes since v3 <https://lore.kernel.org/all/20230214074925.228106-1-alexghiti@rivosinc.com/>:
>>>> * Added RB/AB
>>>> * Added a mention to commit 622021cd6c56 ("s390: make command line
>>>>     configurable") in the cover letter
>>> Thanks for the update!
>>>
>>>    Apparently you forgot to add your own SoB?
>> I do not know, should I? Palmer did all the work, I only fixed 3 minor
>> things
> If you are picking up patches, and submitting them to someone else
> for upstream inclusion, you should add your own SoB.
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L419


Great, thanks for the pointer, I'll do that then!


Thanks again,


Alex


> Gr{oetje,eeting}s,
>
>                          Geert
>
