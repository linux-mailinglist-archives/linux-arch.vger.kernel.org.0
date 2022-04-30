Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A9515D77
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiD3N0B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 09:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiD3NZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 09:25:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F16C6A42C
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 06:22:34 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a11so9066458pff.1
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mmn21HGnBMcyZvZiOKnwlQGRF5sgWcGXDhxVMtE/DjE=;
        b=lkC3ZF63lH4ZLVYVJCwyF338V8NZJWqaMWT5bUfvqYQ1tShxpqX1+etMfx2shdS1Dr
         cK/MOSotHI5vIY7OwU4N+KULBB3b5XH+sYHk1wIQwKzGXAxBv4y4fNbhY3vmRYc/XI5v
         AGbCkD+opcDUvX2QUJ0/a+CjRJMPSPMzjYVXpTDqBCYf3HIh4gjs7fD9ZmbRb5enZaIK
         66wocEZJOfKfnmCmlxiXaQxtC/FYWu4x/tSn60TerQtPqRXAMfdz+iLzR+eQWNyLF920
         BqYdkVe/aoDFcCnqN3pqDM2AnOB/qDcOuGY+0BV71env48fTds3gCzR+etKbHKRws+gZ
         r7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mmn21HGnBMcyZvZiOKnwlQGRF5sgWcGXDhxVMtE/DjE=;
        b=FSP+AwaAq2LkmMUzt5CvviwnX6iPYmWDVih9HUWK6WGwdxm4GAt19HUenCvTILV/F3
         kPJX/lF6rwcY/8UhduMP1Xosrh8QTFe7r816jB6F1gVYLYHI3/2PLkhlH1GSNhTW8beG
         Kazwhd7GjXcgzzHdUmkKbuDphUVLoQBgBFWyEO4wbqHWaY37BjRle0x115+Dkoq301ja
         AKoOP62h0TngQk3rQrzxZm+N0YphAY5HnEBZ34pf9gFGGqZrCLGiq3XDbT8I19MD4QE3
         h3mIMp+ZyeuRfZzMabBQeXfbH5U8yBF36c6moSWWit5bgqchYN+CfiKcCi8g8H9+XqvY
         WlIw==
X-Gm-Message-State: AOAM531YN71l7UBIzBnEFjZDazsqGBTh7GKUFnf/uCASxzIfslwYjpPO
        2XGD33L6USp5gtQluTERdBI8QsUZ5qJGMg==
X-Google-Smtp-Source: ABdhPJzVifXEst/jSLZeByETtT5Z2VCK1qICNh4p7J3VXLet4KXOrydzBQ2K22vBoXiQctUBhT277g==
X-Received: by 2002:a63:4d64:0:b0:39d:5e6e:242d with SMTP id n36-20020a634d64000000b0039d5e6e242dmr3174660pgl.32.1651324953376;
        Sat, 30 Apr 2022 06:22:33 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r4-20020a634404000000b003c18e0768e3sm6815904pga.78.2022.04.30.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:22:32 -0700 (PDT)
Date:   Sat, 30 Apr 2022 06:22:32 -0700 (PDT)
X-Google-Original-Date: Sat, 30 Apr 2022 06:22:30 PDT (-0700)
Subject:     Re: [PATCH V9 16/24] LoongArch: Add misc common routines
In-Reply-To: <CAK8P3a1Cnp-SNiXnSbnUdbw9jC+aT1TxEjckK2jFYgwT-CSpcw@mail.gmail.com>
CC:     chenhuacai@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        chenhuacai@loongson.cn, luto@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, akpm@linux-foundation.org, airlied@linux.ie,
        corbet@lwn.net, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lixuefeng@loongson.cn,
        siyanteng@loongson.cn, guoren@kernel.org, kernel@xen0n.name,
        jiaxun.yang@flygoat.com, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-aac79f77-a392-42cd-a885-247e7625046c@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 30 Apr 2022 03:41:59 PDT (-0700), Arnd Bergmann wrote:
> On Sat, Apr 30, 2022 at 12:00 PM Huacai Chen <chenhuacai@gmail.com> wrote:
>>
>> On Sat, Apr 30, 2022 at 5:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>> >
>> > > +unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
>> > > +{
>> > > +       u32 old32, mask, temp;
>> > > +       volatile u32 *ptr32;
>> > > +       unsigned int shift;
>> > > +
>> > > +       /* Check that ptr is naturally aligned */
>> >
>> > As discussed, please remove this function and all the references to it.
>>
>> It seems that "generic ticket spinlock" hasn't been merged in 5.18?
>
> No, but we can merge it together with the loongarch architecture for 5.19.
>
> I suggested you coordinate with Guo Ren and Palmer Dabbelt about how
> to best merge it. The latest version was pasted two weeks ago [1], and
> it sounds like there are only minor issues to work out and that I can merge
> v4 into the asm-generic tree before merging the loongarch code in the
> same place.
>
>      Arnd
>
> [1] https://lore.kernel.org/lkml/20220414220214.24556-1-palmer@rivosinc.com/

I can just send another version, IIRC it was just that discussion about 
the memory barrier and there's already prototype code so it shouldn't be 
too bad.  I was hoping to do it sooner, sorry.
