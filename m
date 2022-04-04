Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578394F1642
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358108AbiDDNoJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357763AbiDDNoA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 09:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBE63E0DC;
        Mon,  4 Apr 2022 06:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814E761305;
        Mon,  4 Apr 2022 13:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3653C34114;
        Mon,  4 Apr 2022 13:41:54 +0000 (UTC)
Message-ID: <6a38e8b8-7ccc-afba-6826-cb6e4f92af83@linux-m68k.org>
Date:   Mon, 4 Apr 2022 23:41:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On 4/4/22 23:07, Arnd Bergmann wrote:
> On Sun, Apr 3, 2022 at 2:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Tue, Mar 08, 2022 at 09:19:16AM +0100, Arnd Bergmann wrote:
>>> If there are no other objections, I'll just queue this up for 5.18 in
>>> the asm-generic
>>> tree along with the nds32 removal.
>>
>> So it is the last day of te merge window and arch/h8300 is till there.
>> And checking nw the removal has also not made it to linux-next.  Looks
>> like it is so stale that even the removal gets ignored :(
> 
> I was really hoping that someone else would at least comment.
> I've queued it up now for 5.19.
> 
> Should we garbage-collect some of the other nommu platforms where
> we're here? Some of them are just as stale:
> 
> 1. xtensa nommu has does not compile in mainline and as far as I can
> tell never did
>     (there was https://github.com/jcmvbkbc/linux-xtensa/tree/xtensa-5.6-esp32,
> which
>     worked at some point, but I don't think there was enough interest
> to get in merged)
> 
> 2. arch/sh Hitachi/Renesas sh2 (non-j2) support appears to be in a similar state
>      to h8300, I don't think anyone would miss it
> 
> 8<----- This may we where we want to draw the line ----
> 
> 3. arch/sh j2 support was added in 2016 and doesn't see a lot of
> changes, but I think
>      Rich still cares about it and wants to add J32 support (with MMU)
> in the future
> 
> 4. m68k Dragonball, Coldfire v2 and Coldfire v3 are just as obsolete as SH2 as
>     hardware is concerned, but Greg Ungerer keeps maintaining it, along with the
>     newer Coldfire v4 (with MMU)

I have no plans to stop maintaining ColdFire v2 and v3 (and v4), FWIW.

But we could consider the Dragonball support for removal. I keep it compiling,
but I don't use it and can't test that it actually works. Not sure that it
has been used for a very long time now. And I didn't even realize but its
serial driver (68328serial.c) was removed in 2015. No one seems too have
noticed and complained.

Regards
Greg
  


> 5. K210 was added in 2020. I assume you still want to keep it.
> 
> 7. Arm32 has several Cortex-M based platforms that are mainly kept for
>      legacy users (in particular stm32) or educational value.
> 
> 
>         Arnd
