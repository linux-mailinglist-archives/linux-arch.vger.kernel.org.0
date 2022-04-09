Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10C4FA09D
	for <lists+linux-arch@lfdr.de>; Sat,  9 Apr 2022 02:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiDIAWU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Apr 2022 20:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiDIAWT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Apr 2022 20:22:19 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7736D1AF0F
        for <linux-arch@vger.kernel.org>; Fri,  8 Apr 2022 17:20:14 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r8so10447656oib.5
        for <linux-arch@vger.kernel.org>; Fri, 08 Apr 2022 17:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kku2i+uKWNnFd73jChiOeIEKCfjIgc7cEViNkZfQ8l0=;
        b=MvmX4LKI4DyQDgAaqj6D5BFwEshu/LnG+BxDPDDz7Qeqpx5yulnQb0cgGdCjkR9q36
         VpaPcgCUj3yaOiquaSfgEX4IdXJwB8lNNAtJixiKalOPG8IS2v7x1kbXjIxsFVr+IpDH
         2Mk4wxROIpeQzkoWtnHQzZd/qwCsaaE2lOuS+0lsC0gpWLI8Tv/e6/QWMrf74Q0KZ1jC
         3QlmXnTkrUpepdAe0RQZHwbtqfSsFVN6YNfuTxXtvuiHZ61SuiyOHGYBcG4eoXYJXOCQ
         sATmsP+kQl2mRatJE+nSXCnEagEoc6G6ci0p1uOhU3T5aOwSiYys6MaO7qWhJNngpGSk
         PtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kku2i+uKWNnFd73jChiOeIEKCfjIgc7cEViNkZfQ8l0=;
        b=xHcT9EEGilmkA+z2TTK/Et5TzRkpKAGr+/qBwmfFxfD8t4FHBJSsWcmft/nIgXH8vK
         r5S1eyVwPiDPodcBzZksz94dr0W0agv+xNCLK80tihVhFkTq3B02KJS+trCnKHtlV6g2
         cuNEUkJDBN08cGo4jDdxTNpMVoJJ9/ZP6ZiDG43kiK8jXdBqBWDSnNJiNFQ9n0fHpxrC
         Hv++vejjvon20rW6ocJFxQoRvQL/KJ02YE91GyMjuL88AC3X2dL8dk/1PKdsR6vJHcpb
         nc+DjQLN8Q51oZA0hRkPey7kPgICdjl/RA8BqRWGmYg1ZQkHPTlIDvyd1EzXCDBWxQr4
         Lzeg==
X-Gm-Message-State: AOAM533LSXND8L8GYC5Ob0RsI9BjsRQXFSw6ujLKp6DwbSj5f7ZeueRp
        ugmn9Td+2Jb2cCgyt9pgbBfmDcOV6TLG1Jfc
X-Google-Smtp-Source: ABdhPJzZe++rWaqfq9aV2dHyOIwxVl53YuTt+2x8aiaE6fJ5qXUhiElHKi0cEmeQsIJ8z1Fpr0L9uA==
X-Received: by 2002:a05:6808:616:b0:2ef:3773:44d5 with SMTP id y22-20020a056808061600b002ef377344d5mr989393oih.156.1649463613856;
        Fri, 08 Apr 2022 17:20:13 -0700 (PDT)
Received: from [192.168.86.187] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id b25-20020a0568301df900b005cf87029ee8sm9164623otj.67.2022.04.08.17.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 17:20:12 -0700 (PDT)
Message-ID: <8f9be869-7244-d92a-4683-f9c53da97755@landley.net>
Date:   Fri, 8 Apr 2022 19:24:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
To:     Greg Ungerer <gerg@linux-m68k.org>, Daniel Palmer <daniel@0x0f.com>
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
 <5b7687d4-8ba5-ad79-8a74-33fc2496a3db@linux-m68k.org>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <5b7687d4-8ba5-ad79-8a74-33fc2496a3db@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/5/22 08:07, Greg Ungerer wrote:
> Hi Daniel,
> 
> On 5/4/22 13:23, Daniel Palmer wrote:
>> On Mon, 4 Apr 2022 at 22:42, Greg Ungerer <gerg@linux-m68k.org> wrote:
>>> But we could consider the Dragonball support for removal. I keep it compiling,
>>> but I don't use it and can't test that it actually works. Not sure that it
>>> has been used for a very long time now. And I didn't even realize but its
>>> serial driver (68328serial.c) was removed in 2015. No one seems too have
>>> noticed and complained.
>> 
>> I noticed this and I am working on fixing it up for a new Dragonball
>> homebrew machine.
>> I'm trying to add a 68000 machine to QEMU to make the development
>> easier because I'm currently waiting an hour or more for a kernel to
>> load over serial.
>> It might be a few months.

I've been booting Linux on qemu-system-m68k -M q800 for a couple years now? (The
CROSS=m68k target of mkroot in toybox?)

# cat /proc/cpuinfo
CPU:		68040
MMU:		68040
FPU:		68040
Clocking:	1261.9MHz
BogoMips:	841.31
Calibration:	4206592 loops

It certainly THINKS it's got m68000...

$ qemu-system-m68k -cpu ?
cfv4e
m5206
m5208
m68000
m68010
m68020
m68030
m68040
m68060
any

(I'd love to get an m68k nommu system working but never sat down and worked out
a kernel .config qemu agreed to run, plus compiler and libc. Musl added m68k
support but I dunno if that includes coldfire?)

>> It looked like 68328serial.c was removed because someone tried to
>> clean it up and it was decided that no one was using it and it was
>> best to delete it.
>> My plan was to at some point send a series to fix up the issues with
>> the Dragonball support, revert removing the serial driver and adding
>> the patch that cleaned it up.
> 
> Nice. I will leave all the 68000/68328 code alone for now then.

The q800 config uses CONFIG_SERIAL_PMACZILOG. Seems to work fine?

> Regards
> Greg

Rob
