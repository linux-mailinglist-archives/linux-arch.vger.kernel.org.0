Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E755F022
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiF1VDy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 17:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiF1VDt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 17:03:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689637AA5;
        Tue, 28 Jun 2022 14:03:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jb13so12159069plb.9;
        Tue, 28 Jun 2022 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LLK2uhNNvPadjp2Oh/1lKQPTCLeKdmpKaTeJ3RDCHv0=;
        b=Plf/V32RTHjAIcY0bkPGhJbIRr6v2P2QgRVB8+7eP0P4RsyHw26WFtNVMjh4450VSL
         X8EowJeUAPv65bojUQi/l4q/mcLgIz1TUZop7B8mMf4UYeSMN97O5PhtCWd4P5KjohDY
         ALLie3yLHIm0bsPU/TnBkkd6JuMbBayFBbZiLBvLd2yar7+HLEz7eMmp19DAOWF3IuTH
         PHvtCurN4N9bl0vEQmQzWlMPAd2VaDMz3hbsjPHd4Xm7SbhJbAT/RBX6xYjOUAqBtWrm
         FLKt/ZIKzNjI8UX/5SZnYKO15W+v0GW/s3+FFXv5IZLkJGau9LvwFj0fBmt76ie2MA/E
         v/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LLK2uhNNvPadjp2Oh/1lKQPTCLeKdmpKaTeJ3RDCHv0=;
        b=2XuBkufW7ABofm0k0+5GHe6sz1vwTD+OqtBKfEromgYkgGSi8+LM7IehH7F7IPUgff
         UUcFGjXVSEEG7KHFXa7dXtn9J1D7U3KrXksC5+J/cMAsKbU47b162WqESlA0yOjJTxFj
         PU6MZ/aWHN69pSAFhyQdmvuOZZjAeYVJ5myvWUHkqx+EiclNMXj1QD5PZlq5n/1ss1xZ
         S6J5KBbEivUt5MXuEvKOhXi3+0KmAkjopKy9laWz9ISJVe0fka3GepGqqkoVl+VaiYGV
         sbptlbLhplAU1h/Kyx7J3rNAG/RdcJxMaiqKiXz/tMpYYaqvcirRcDwVxBubz5xqukvD
         fZdA==
X-Gm-Message-State: AJIora9Q18JI4dVlroX3gmRGQhyzHHHYWJNmOXhrMLdgVV7/3qxDDkAf
        FPBno+2a+DeFScrpmU2TUMk=
X-Google-Smtp-Source: AGRyM1s3Nd/my/4+QoWL+yZMzu+YZKCug56iAjfd8RAtHTbgADBf9oHlpjvJ/8KE0n/2rDkR0+nsiw==
X-Received: by 2002:a17:90a:1485:b0:1ec:788e:a053 with SMTP id k5-20020a17090a148500b001ec788ea053mr1707919pja.16.1656450227992;
        Tue, 28 Jun 2022 14:03:47 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033? ([2001:df0:0:200c:75aa:d6ca:4354:6033])
        by smtp.gmail.com with ESMTPSA id a14-20020aa795ae000000b005259d99ccffsm6254097pfk.8.2022.06.28.14.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 14:03:47 -0700 (PDT)
Message-ID: <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
Date:   Wed, 29 Jun 2022 09:03:37 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, scsi <linux-scsi@vger.kernel.org>,
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
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
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

Hi Geert,

On 28/06/22 19:03, Geert Uytterhoeven wrote:
>
>> Leaving the bounce buffer handling in place, and taking a few other
>> liberties - this is what converting the easiest case (a3000 SCSI) might
>> look like. Any obvious mistakes? The mvme147 driver would be very
>> similar to handle (after conversion to a platform device).
> Thanks, looks reasonable.
Thanks, I'll take care of Arnd's comments and post a corrected version 
later.
>> The driver allocates bounce buffers using kmalloc if it hits an
>> unaligned data buffer - can such buffers still even happen these days?
> No idea.
Hmmm - I think I'll stick a WARN_ONCE() in there so we know whether this 
code path is still being used.
>
>> If I understand dma_map_single() correctly, the resulting dma handle
>> would be equally misaligned?
>>
>> To allocate a bounce buffer, would it be OK to use dma_alloc_coherent()
>> even though AFAIU memory used for DMA buffers generally isn't consistent
>> on m68k?
>>
>> Thinking ahead to the other two Amiga drivers - I wonder whether
>> allocating a static bounce buffer or a DMA pool at driver init is likely
>> to succeed if the kernel runs from the low 16 MB RAM chunk? It certainly
>> won't succeed if the kernel runs from a higher memory address, so the
>> present bounce buffer logic around amiga_chip_alloc() might still need
>> to be used here.
>>
>> Leaves the question whether converting the gvp11 and a2091 drivers is
>> actually worth it, if bounce buffers still have to be handled explicitly.
> A2091 should be straight-forward, as A3000 is basically A2091 on the
> motherboard (comparing the two drivers, looks like someone's been
> sprinkling mb()s over the A3000 driver).

Yep, and at least the ones in the dma_setup() function are there for no 
reason (the compiler won't reorder stores around the cache flush calls, 
I hope?).

Just leaves the 24 bit DMA mask there (and likely need for bounce buffers).

> I don't have any of these SCSI host adapters (not counting the A590
> (~A2091) expansion of the old A500, which is not Linux-capable, and
>   hasn't been powered on for 20 years).

I wonder whether kullervo has survived - that one was an A3000. Should 
have gone to Adrian a few years ago...

Cheers,

     Michael


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
