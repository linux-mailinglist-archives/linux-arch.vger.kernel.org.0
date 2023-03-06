Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1886AB9F4
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 10:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCFJfi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 04:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCFJfh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 04:35:37 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D56CA275;
        Mon,  6 Mar 2023 01:35:33 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id D7AAE60017;
        Mon,  6 Mar 2023 09:35:17 +0000 (UTC)
Message-ID: <caaed678-4a5a-70e5-2ee7-cb2c8042afc0@ghiti.fr>
Date:   Mon, 6 Mar 2023 10:35:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 00/24] Remove COMMAND_LINE_SIZE from uapi
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
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
        Albert Ou <aou@eecs.berkeley.edu>, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        borntraeger@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>,
        ysato@users.osdn.me, Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        chris@zankel.net, Max Filippov <jcmvbkbc@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux-Arch <linux-arch@vger.kernel.org>
References: <mhng-e8b09772-24e5-4729-a0bf-01a9e4c76636@palmer-ri-x1c9a>
 <21F95EC4-71EA-4154-A7DC-8A5BA54F174B@zytor.com>
 <674bc31e-e4ed-988f-820d-54213d83f9c7@ghiti.fr>
 <c500840b-b57d-47f2-a3d9-41465b10ffae@app.fastmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <c500840b-b57d-47f2-a3d9-41465b10ffae@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 3/3/23 17:40, Arnd Bergmann wrote:
> On Fri, Mar 3, 2023, at 12:59, Alexandre Ghiti wrote:
>> On 3/2/23 20:50, H. Peter Anvin wrote:
>>> On March 1, 2023 7:17:18 PM PST, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>>>>> Commit 622021cd6c560ce7 ("s390: make command line configurable"),
>>>>>> I assume?
>>>>> Yes, sorry for that. I got distracted while writing and used the wrong
>>>>> branch to look this up.
>>>> Alex: Probably worth adding that to the list in the cover letter as it looks like you were planning on a v4 anyway (which I guess you now have to do, given that I just added the issue to RISC-V).
>>> The only use that is uapi is the *default* length of the command line if the kernel header doesn't include it (in the case of x86, it is in the bzImage header, but that is atchitecture- or even boot format-specific.)
>> Is COMMAND_LINE_SIZE what you call the default length? Does that mean
>> that to you the patchset is wrong?
> On x86, the COMMAND_LINE_SIZE value is already not part of a uapi header,
> but instead (since bzImage format version 2.06) is communicated from
> the kernel to the boot loader, which then knows how much data the
> kernel will read (at most) from the command line.
>
> Most x86 kernels these days are booted using UEFI, which I think has
> no such interface, the firmware just passes the command line and a
> length, but has no way of knowing if the kernel will truncate this.
> I think that is the same as with any other architecture that passes
> the command line through UEFI, DT or ATAGS, all of which use
> length/value pairs.
>
> Russell argued on IRC that this can be considered an ABI since a
> boot loader may use its knowledge of the kernel's command line size
> limit to reject long command lines. On the other hand, I don't
> think that any boot loader actually does, they just trust that it
> fits and don't have a good way of rejecting invalid configuration
> other than truncating and/or warning.
>
> One notable exception I found while looking through is the old
> (pre-ATAGS) parameter structure on Arm, which uses COMMAND_LINE_SIZE
> as part of the structure definition. Apparently this was deprecated
> 22 years ago, so hopefully the remaining riscpc and footbridge
> users have all upgraded their bootloaders.
>
> The only other case I could find that might go wrong is
> m68knommu with a few files copying a COMMAND_LINE_SIZE sized
> buffer from flash into a kernel buffer:
>
> arch/m68k/coldfire/m5206.c:void __init config_BSP(char *commandp, int size)
> arch/m68k/coldfire/m5206.c-{
> arch/m68k/coldfire/m5206.c-#if defined(CONFIG_NETtel)
> arch/m68k/coldfire/m5206.c-     /* Copy command line from FLASH to local buffer... */
> arch/m68k/coldfire/m5206.c-     memcpy(commandp, (char *) 0xf0004000, size);
> arch/m68k/coldfire/m5206.c-     commandp[size-1] = 0;
> arch/m68k/coldfire/m5206.c-#endif /* CONFIG_NETtel */


I see, thanks your thorough explanation: I don't see this m64k issue as 
a blocker (unless Geert disagrees but he already reviewed the m64k 
patches),  so I'll send the v5 now.

Thanks again,

Alex


>
>       Arnd
