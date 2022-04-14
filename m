Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E67500335
	for <lists+linux-arch@lfdr.de>; Thu, 14 Apr 2022 02:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiDNAwM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 20:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiDNAwL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 20:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC0615A3F;
        Wed, 13 Apr 2022 17:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20914610FB;
        Thu, 14 Apr 2022 00:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E38C385A3;
        Thu, 14 Apr 2022 00:49:43 +0000 (UTC)
Message-ID: <7a26156e-1f06-b0b1-2859-432a75e9e0d4@linux-m68k.org>
Date:   Thu, 14 Apr 2022 10:49:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
To:     Rob Landley <rob@landley.net>, Finn Thain <fthain@linux-m68k.org>
Cc:     Daniel Palmer <daniel@0x0f.com>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
 <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <6a38e8b8-7ccc-afba-6826-cb6e4f92af83@linux-m68k.org>
 <CAFr9PXkk=8HOxPwVvFRzqHZteRREWxSOOcdjrcOPe0d=9AW2yQ@mail.gmail.com>
 <5b7687d4-8ba5-ad79-8a74-33fc2496a3db@linux-m68k.org>
 <8f9be869-7244-d92a-4683-f9c53da97755@landley.net>
 <3d5cf48c-94f1-2948-1683-4a2a87f4c697@linux-m68k.org>
 <147dc6cc-1fbb-558f-8e6d-29d4327d54b4@linux-m68k.org>
 <ae4125f5-e725-43ed-d05b-b1f88c0cd50c@landley.net>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <ae4125f5-e725-43ed-d05b-b1f88c0cd50c@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 10/4/22 17:26, Rob Landley wrote:
> 
> 
> On 4/8/22 23:18, Greg Ungerer wrote:
>>
>> On 9/4/22 11:59, Finn Thain wrote:
>>> On Fri, 8 Apr 2022, Rob Landley wrote:
>>>
>>>> On 4/5/22 08:07, Greg Ungerer wrote:
>>>>> On 5/4/22 13:23, Daniel Palmer wrote:
>>>>>> On Mon, 4 Apr 2022 at 22:42, Greg Ungerer <gerg@linux-m68k.org> wrote:
>>>>>>> But we could consider the Dragonball support for removal. I keep it
>>>>>>> compiling, but I don't use it and can't test that it actually works.
>>>>>>> Not sure that it has been used for a very long time now. And I
>>>>>>> didn't even realize but its serial driver (68328serial.c) was
>>>>>>> removed in 2015. No one seems too have noticed and complained.
>>>>>>
>>>>>> I noticed this and I am working on fixing it up for a new Dragonball
>>>>>> homebrew machine. I'm trying to add a 68000 machine to QEMU to make
>>>>>> the development easier because I'm currently waiting an hour or more
>>>>>> for a kernel to load over serial. It might be a few months.
>>>>
>>>> I've been booting Linux on qemu-system-m68k -M q800 for a couple years
>>>> now? (The CROSS=m68k target of mkroot in toybox?)
>>>>
>>>> # cat /proc/cpuinfo
>>>> CPU:		68040
>>>> MMU:		68040
>>>> FPU:		68040
>>>> Clocking:	1261.9MHz
>>>> BogoMips:	841.31
>>>> Calibration:	4206592 loops
>>>>
>>>> It certainly THINKS it's got m68000...
>>>>
>>>
>>> Most 68040 processor variants have a built-in MMU and the m68k "nommu"
>>> Linux port doesn't support them. The nommu port covers processors like
>>> 68000, Dragonball etc. whereas the m68k "mmu" port covers 680x0 where x is
>>> one of 2,3,4,6 with MMU.
> 
> In theory you can switch the MMU off. (Or at least give it a NOP page table that
> maps all the physical memory into one big contiguous block 1:1 with the physical
> address and leave it there.)
> 
> Doesn't mean anybody's bothered to implement and add a config option to stub
> that out in the kernel yet. But presumably you could have a bootloader shim do it...
> 
>>>> (I'd love to get an m68k nommu system working but never sat down and
>>>> worked out a kernel .config qemu agreed to run, plus compiler and libc.
>>>> Musl added m68k support but I dunno if that includes coldfire?)
>>>>
>>>
>>> I could never figure out how to boot a coldfire machine in qemu either.
>>> There was no documentation about that back when I attempted it but maybe
>>> things have improved since.
>>
>> FWIW this will do it:
>>
>>       qemu-system-m68k -nographic -machine mcf5208evb -kernel vmlinux
>>
>> That will boot an m5208evb_defconfig generated vmlinux.
>> But you will need a user space to get a full boot to login/shell.
> 
> No FDPIC support. :(
> 
> I had a binflt toolchain working with uClibc in 2015 or so, but I end of lifed
> https://landley.net/aboriginal in 2017 (five years ago now). Multiple reasons,
> but one was the old "last GPLv2 release" toolchain was getting painful to force
> the kernel to build with.
> 
> These days there's articles on lwn.net about yanking a.out support, which fdpic
> is a buggy variant of that didn't actually have a maintained elf2flt repository
> when I was assembling my toolchain. (I vaguely recall I poked enough people that
> somebody picked it up and stuck a repository on github, but Jeff Dionne
> explained some fundamental design flaw that had been introduced having to do
> with register offsets being calculated in the wrong framework or something?
> 
> I don't remember, I lost interest because it's _conceptually_ obsolete. FDPIC is
> ELF with a little extra header info, it's clean and potentially even useful on
> with-MMU systems as extra ASLR. BINFLT is a.out run through a postprocessing
> tool that nominally converts ELF files into the new format but actually needs .o
> files from earlier in the process and is kind of an alternate linker except it
> doesn't replace the linker... It's layers of ugly.

FLAT format has nothing to do with a.out.
Removing a.out support from the kernel will have no impact on binfmt_flat.

Regards
Greg

