Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF724FA17A
	for <lists+linux-arch@lfdr.de>; Sat,  9 Apr 2022 04:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiDICCT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Apr 2022 22:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiDICCS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Apr 2022 22:02:18 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DECB0A4C;
        Fri,  8 Apr 2022 19:00:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AC6DA5C0191;
        Fri,  8 Apr 2022 22:00:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 08 Apr 2022 22:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9lxjt1eCK1sCUN2U3
        ZA/uMQai3qIWY0P3RCwD0Y1H10=; b=ImVsVJDYieuJviuvTYfjN3zmcVnC0yBVc
        gAf3Vp0QRJeXVTBir2b9FRv1iFfcePyIo+zqL6qc87macmxsggOkaXpmTxRaLQzD
        ZBZD7Gwe+y1JpIbJ2s+dW21UbYcL8DcgJHpNcCkh6wSzpnBrnqOhr4vwh9PuoU4A
        nAik+VpMvmKlwCSK7KJzkah40P7uFkMqCI8CCJZpwSCbqpoBgaVAcA+n4azJcn9X
        LKiX2+Kh1Ps+phv0VLnmp8JS4ZO5iLDr+pKOzV+WthoX8YcJsRkiRa5vx3qDV0pD
        lr6kcjvM6tvT99BAQM4vIc6WvNcgaaYPyY1SLyqwNr1t46Rx52B5A==
X-ME-Sender: <xms:p-hQYiG0t5MMQuqFFuIM0gTCkQEMXoG4nK18sba6qAazuPSirVuSGg>
    <xme:p-hQYjV0b-VrW2ZIGmh875pw2FXjFqNXBD6tyRS3T8wfBSGq0YGisvtK2pLlMvQby
    Bhul1OcsKpibnkgAqM>
X-ME-Received: <xmr:p-hQYsJwGOGdp5G3I2104Y6nkLPUbyCQfJLRwksBCU5EBpl6CBuX7bhG97cTtryRpjQDiYFrBMpbDoD9wkIpjsGa_79gOHTFBZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekuddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:p-hQYsG6cUAt5KTOfe5-bCBMufJOrEvNjMTUpENIenYZlqFicYVrdw>
    <xmx:p-hQYoWuZWJDDmKZBL6Z2CLLZ5WBhjyxE6aRp2QWbWafzm0PpgDZTQ>
    <xmx:p-hQYvNomfkBfWSrR0dejtPiEVcEMFgSW1Oeg1lpXBFSdnyk0eSFBQ>
    <xmx:qOhQYpVbcUk1bKzlGr7DDE33LTHY0V_uv4o3O-V9hs6Guvo_C5VEow>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Apr 2022 22:00:04 -0400 (EDT)
Date:   Sat, 9 Apr 2022 11:59:57 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Rob Landley <rob@landley.net>
cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Daniel Palmer <daniel@0x0f.com>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [RFC PULL] remove arch/h8300
In-Reply-To: <8f9be869-7244-d92a-4683-f9c53da97755@landley.net>
Message-ID: <3d5cf48c-94f1-2948-1683-4a2a87f4c697@linux-m68k.org>
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com> <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com> <6a38e8b8-7ccc-afba-6826-cb6e4f92af83@linux-m68k.org>
 <CAFr9PXkk=8HOxPwVvFRzqHZteRREWxSOOcdjrcOPe0d=9AW2yQ@mail.gmail.com> <5b7687d4-8ba5-ad79-8a74-33fc2496a3db@linux-m68k.org> <8f9be869-7244-d92a-4683-f9c53da97755@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 8 Apr 2022, Rob Landley wrote:

> On 4/5/22 08:07, Greg Ungerer wrote:
> > On 5/4/22 13:23, Daniel Palmer wrote:
> >> On Mon, 4 Apr 2022 at 22:42, Greg Ungerer <gerg@linux-m68k.org> wrote:
> >>> But we could consider the Dragonball support for removal. I keep it 
> >>> compiling, but I don't use it and can't test that it actually works. 
> >>> Not sure that it has been used for a very long time now. And I 
> >>> didn't even realize but its serial driver (68328serial.c) was 
> >>> removed in 2015. No one seems too have noticed and complained.
> >> 
> >> I noticed this and I am working on fixing it up for a new Dragonball 
> >> homebrew machine. I'm trying to add a 68000 machine to QEMU to make 
> >> the development easier because I'm currently waiting an hour or more 
> >> for a kernel to load over serial. It might be a few months.
> 
> I've been booting Linux on qemu-system-m68k -M q800 for a couple years 
> now? (The CROSS=m68k target of mkroot in toybox?)
> 
> # cat /proc/cpuinfo
> CPU:		68040
> MMU:		68040
> FPU:		68040
> Clocking:	1261.9MHz
> BogoMips:	841.31
> Calibration:	4206592 loops
> 
> It certainly THINKS it's got m68000...
> 

Most 68040 processor variants have a built-in MMU and the m68k "nommu" 
Linux port doesn't support them. The nommu port covers processors like 
68000, Dragonball etc. whereas the m68k "mmu" port covers 680x0 where x is 
one of 2,3,4,6 with MMU.

> $ qemu-system-m68k -cpu ?
> cfv4e
> m5206
> m5208
> m68000
> m68010
> m68020
> m68030
> m68040
> m68060
> any
> 
> (I'd love to get an m68k nommu system working but never sat down and 
> worked out a kernel .config qemu agreed to run, plus compiler and libc. 
> Musl added m68k support but I dunno if that includes coldfire?)
> 

I could never figure out how to boot a coldfire machine in qemu either. 
There was no documentation about that back when I attempted it but maybe 
things have improved since.

> >> It looked like 68328serial.c was removed because someone tried to 
> >> clean it up and it was decided that no one was using it and it was 
> >> best to delete it. My plan was to at some point send a series to fix 
> >> up the issues with the Dragonball support, revert removing the serial 
> >> driver and adding the patch that cleaned it up.
> > 
> > Nice. I will leave all the 68000/68328 code alone for now then.
> 
> The q800 config uses CONFIG_SERIAL_PMACZILOG. Seems to work fine?
> 

That driver would work on certain 68000 systems e.g. early Macs. (And IIRC 
someone did once boot a customized Linux kernel on a Mac SE...)
