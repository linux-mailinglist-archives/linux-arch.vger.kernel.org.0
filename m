Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E155F225
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 02:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiF2ABm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 20:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF2ABl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 20:01:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE94531225;
        Tue, 28 Jun 2022 17:01:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 68so13659604pgb.10;
        Tue, 28 Jun 2022 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0kpjfuIly1nOW0q2ELB2CmN7oIQ7HX+3B2PaKKHsB78=;
        b=D7i2NgedY/bHyI8emNN+y0jr/G9IOYRWkIjlIhVn6DbWgwRG2UARyfZk3UwO7T2V+D
         ESqmy18MQo7RMsisYmEMOTQj203NqQOZVs7qiFGDUYY81Hru7Iv0ADFCQgagZlaKMdVq
         xung15+Nlj1soULvCk9mS+bfRYyJ9ltpn9UcH1mz1cQDWfJ2ax2IcuBr2SQ3tsjHpoK1
         NeL3oeSuqVVYbcSBohKZ73kauU8T3VpyxipPF6h/oJ8e2qxtdKJwYj9HlUbwfye7QPMt
         PuFn7aX0KOb+qDfsVshvX0sC/38kqLR1JFdKMTuOuvGx8cb2fuTFMwQneoiKRpnAUU2m
         4Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0kpjfuIly1nOW0q2ELB2CmN7oIQ7HX+3B2PaKKHsB78=;
        b=4C5l0TQMlwumCsDZ4LSdd3QzskDu8GBG+vdBVd/2ZJ797l0ryCzqWCwKmYAcdUy7s4
         oFki4t6oA6GTyDdLCN0gUoyroFuNDtXf9mGNhCENLg9c6xkFEwN6CKz8l4wStnCXtTC1
         ylb+2z8ej7U8w0qjURaZt4Mt1wURzjPcfOPJ5IXGjwsNHtt8Nj4GDfkYUZeWMwH3wSaL
         nq5Ep/kzBqE3lvG/ITc1uA0zWooFGvuqUGcIyf0mhSOQ6O4xCdK94Wtnca0V68ZFPyjs
         kIonjPR/8V4gR6uYTi7FLLJbTCIsU+YzdOmLSdmAADNMTt2j7+dhmRwNQc8JiKIgFFHk
         hx+A==
X-Gm-Message-State: AJIora/DSerp7bCeD5uvhPIBa482Wnauw1HIJ/+abqXL7QX7ej1U4L2e
        FMpFRnnAB4Ms46Sa3qauyu4=
X-Google-Smtp-Source: AGRyM1uB9qD4Z15I0Lke4zy2AkjVbLhbeqqf5QXYDPBQAVzl/v0z9XhcHbOncWmuxVZyAGIQBi5g6Q==
X-Received: by 2002:a63:2b16:0:b0:3fa:faf9:e6d7 with SMTP id r22-20020a632b16000000b003fafaf9e6d7mr446010pgr.325.1656460900460;
        Tue, 28 Jun 2022 17:01:40 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033? ([2001:df0:0:200c:75aa:d6ca:4354:6033])
        by smtp.gmail.com with ESMTPSA id cd21-20020a056a00421500b0051b32c2a5a7sm9863096pfb.138.2022.06.28.17.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 17:01:39 -0700 (PDT)
Message-ID: <859c2adc-d3cb-64e8-faba-06e1ac5eddaf@gmail.com>
Date:   Wed, 29 Jun 2022 12:01:24 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
 <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
 <fc47e8da-81d3-e563-0a17-4eb23db015cc@acm.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <fc47e8da-81d3-e563-0a17-4eb23db015cc@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Bart,

On 29/06/22 11:50, Bart Van Assche wrote:
> On 6/28/22 16:09, Michael Schmitz wrote:
>> On 29/06/22 09:50, Arnd Bergmann wrote:
>>> On Tue, Jun 28, 2022 at 11:03 PM Michael Schmitz 
>>> <schmitzmic@gmail.com> wrote:
>>>> On 28/06/22 19:03, Geert Uytterhoeven wrote:
>>>>>> The driver allocates bounce buffers using kmalloc if it hits an
>>>>>> unaligned data buffer - can such buffers still even happen these 
>>>>>> days?
>>>>> No idea.
>>>> Hmmm - I think I'll stick a WARN_ONCE() in there so we know whether 
>>>> this
>>>> code path is still being used.
>>> kmalloc() guarantees alignment to the next power-of-two size or
>>> KMALLOC_MIN_ALIGN, whichever is bigger. On m68k this means it
>>> is cacheline aligned.
>>
>> And all SCSI buffers are allocated using kmalloc? No way at all for 
>> user space to pass unaligned data?
>>
>> (SCSI is a weird beast - I have used a SCSI DAT tape driver many many 
>> years ago, which broke all sorts of assumptions about transfer block 
>> sizes ... but that might actually have been in the v0.99 days, many 
>> rewrites of SCSI midlevel ago).
>>
>> Just being cautious, as getting any of this tested will be a stretch.
>
> An example of a user space application that passes an SG I/O data 
> buffer to the kernel that is aligned to a four byte boundary but not 
> to an eight byte boundary if the -s (scattered) command line option is 
> used: 
> https://github.com/osandov/blktests/blob/master/src/discontiguous-io.cpp

Thanks - four byte alignment actually wouldn't be an issue for me. It's 
two byte or smaller that would trip up the SCSI DMA.

While I'm sure such an even more pathological test case could be 
written, I was rather worried about st.c and sr.c input ...

Cheers,

     Michael

>
> Bart.
