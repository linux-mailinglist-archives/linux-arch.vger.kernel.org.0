Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501814F4493
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 00:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiDEPEJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385694AbiDEOSr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 10:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2A3135A;
        Tue,  5 Apr 2022 06:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF37A61868;
        Tue,  5 Apr 2022 13:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA18DC385A1;
        Tue,  5 Apr 2022 13:07:11 +0000 (UTC)
Message-ID: <5b7687d4-8ba5-ad79-8a74-33fc2496a3db@linux-m68k.org>
Date:   Tue, 5 Apr 2022 23:07:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAFr9PXkk=8HOxPwVvFRzqHZteRREWxSOOcdjrcOPe0d=9AW2yQ@mail.gmail.com>
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

Hi Daniel,

On 5/4/22 13:23, Daniel Palmer wrote:
> On Mon, 4 Apr 2022 at 22:42, Greg Ungerer <gerg@linux-m68k.org> wrote:
>> But we could consider the Dragonball support for removal. I keep it compiling,
>> but I don't use it and can't test that it actually works. Not sure that it
>> has been used for a very long time now. And I didn't even realize but its
>> serial driver (68328serial.c) was removed in 2015. No one seems too have
>> noticed and complained.
> 
> I noticed this and I am working on fixing it up for a new Dragonball
> homebrew machine.
> I'm trying to add a 68000 machine to QEMU to make the development
> easier because I'm currently waiting an hour or more for a kernel to
> load over serial.
> It might be a few months.
> 
> It looked like 68328serial.c was removed because someone tried to
> clean it up and it was decided that no one was using it and it was
> best to delete it.
> My plan was to at some point send a series to fix up the issues with
> the Dragonball support, revert removing the serial driver and adding
> the patch that cleaned it up.

Nice. I will leave all the 68000/68328 code alone for now then.

Regards
Greg

