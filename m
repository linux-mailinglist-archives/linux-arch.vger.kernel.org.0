Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D6455F1C3
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 01:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiF1XJM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 19:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiF1XJL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 19:09:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5D20BCC;
        Tue, 28 Jun 2022 16:09:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso31316pjz.0;
        Tue, 28 Jun 2022 16:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dNlrbJyo72p6W86+4oHtq0SFKKEweCfCqBRbkZwsc7M=;
        b=EqbuEMnrslAV+CNK7icH3sIdyHFdJJt4o0XreMd9PWJnnZD3urkUIczP47SLJfHLt2
         a9Hb2RY2iAMPDYrZzzSebZiLkEkZAZ2GjO1a/YmSZkK2Xp17oEjfDGogNixZdLL3HOfT
         MzvWAi3e8vTQIn19ErTtVtK9046FovgWZzO54p+FjfQ0vKr2M4MHFIDFYcsnV6vwqKlZ
         OpVSBU4xgvKUep3BWnCx5mqYbaYMbM8l8r4kRGa0fyiirmqh9Q5Jv5kmLBa0iY42WhAG
         mXPGja9Jz5H3RSM3uxCyFKm/5U62U9tV2w1DJBxZ5P0LBgo5T9Yd1NziQJflQEY9hQZf
         YhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dNlrbJyo72p6W86+4oHtq0SFKKEweCfCqBRbkZwsc7M=;
        b=jyGrbI/614dd85s0B7p7BX43uu+njMNk3UVGtJmEwzOCLrODiz+DM2nhok5WTqhIeD
         1uSnKGyAFzx+tRof8zVdon4TRKm0KSjAXQSp5+o3uA8oKcFmO6aFDcO4xfqfHhIelziL
         zb2vkKsTrAk1rwg+2F+6UPXlfPlAo2TiqyqTacD7fDMzbnasBi/EF8ag3QTaqRFLPAW0
         kL19rcnoz2W+hfYgPZcOs9Nrw9gX9Ja4DZc59AHOrqwHfyG5BVJh5lGrwQDMgP67sBHY
         k69/Q9kk8ZVh0j4NgOhxgkLJT9SmPpsC8Va8iY+G5D9BLqRwIpza/9BrPZ1u9Dy7/Dwt
         XY/A==
X-Gm-Message-State: AJIora+eZxK4mkrRCbhi801aqgreEGhW0chNuHgtoid6QFJY+HniO+kv
        BO/MVpzIJEikfFclfT0jv+s=
X-Google-Smtp-Source: AGRyM1sKFPd7rmb+HZNy3hqqLYOU4RMipHtRZ0GXpNrqgiP6rjxKGk/MTbwV1Q3gFv+zgJ5mODs7jg==
X-Received: by 2002:a17:902:d50e:b0:16a:13d:30ab with SMTP id b14-20020a170902d50e00b0016a013d30abmr7366924plg.31.1656457750171;
        Tue, 28 Jun 2022 16:09:10 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:75aa:d6ca:4354:6033? ([2001:df0:0:200c:75aa:d6ca:4354:6033])
        by smtp.gmail.com with ESMTPSA id jy18-20020a17090b325200b001e31803540fsm450854pjb.6.2022.06.28.16.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 16:09:09 -0700 (PDT)
Message-ID: <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
Date:   Wed, 29 Jun 2022 11:09:00 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
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
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
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

Hi Arnd,

On 29/06/22 09:50, Arnd Bergmann wrote:
> On Tue, Jun 28, 2022 at 11:03 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> On 28/06/22 19:03, Geert Uytterhoeven wrote:
>>>> The driver allocates bounce buffers using kmalloc if it hits an
>>>> unaligned data buffer - can such buffers still even happen these days?
>>> No idea.
>> Hmmm - I think I'll stick a WARN_ONCE() in there so we know whether this
>> code path is still being used.
> kmalloc() guarantees alignment to the next power-of-two size or
> KMALLOC_MIN_ALIGN, whichever is bigger. On m68k this means it
> is cacheline aligned.

And all SCSI buffers are allocated using kmalloc? No way at all for user 
space to pass unaligned data?

(SCSI is a weird beast - I have used a SCSI DAT tape driver many many 
years ago, which broke all sorts of assumptions about transfer block 
sizes ... but that might actually have been in the v0.99 days, many 
rewrites of SCSI midlevel ago).

Just being cautious, as getting any of this tested will be a stretch.

Cheers,

     Michael

>
>        Arnd
