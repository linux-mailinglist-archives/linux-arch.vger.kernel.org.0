Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E6952EE0C
	for <lists+linux-arch@lfdr.de>; Fri, 20 May 2022 16:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350233AbiETOXP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 May 2022 10:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350230AbiETOXO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2022 10:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DCCE166D58
        for <linux-arch@vger.kernel.org>; Fri, 20 May 2022 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653056592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJC1yK9IYkMDQ2u1869gK2NvV1iKqVWIKXw6SqG9e5g=;
        b=ZhKreSA486nntNPN1kSNfsOim/uMqk9XOp756U+h5Wot7DJEUtgH4WHGJR7Km9YZ5VGYBV
        b2DpTzqmSgDKHgDEQh4djjKQzh8gaI/0SEBVXoRJlgeru560tXomKrLxlw4gnoaR36mR6S
        EIZSWU24AwP4W9nWE6ZkOoGySJP09aY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-Qb7NEY66OMW60FppBmd69A-1; Fri, 20 May 2022 10:23:10 -0400
X-MC-Unique: Qb7NEY66OMW60FppBmd69A-1
Received: by mail-wr1-f72.google.com with SMTP id e17-20020adfe391000000b0020e64e7dd15so2193974wrm.4
        for <linux-arch@vger.kernel.org>; Fri, 20 May 2022 07:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YJC1yK9IYkMDQ2u1869gK2NvV1iKqVWIKXw6SqG9e5g=;
        b=HsQGsMhkuFrClwhJEyB6/OKUDeq1MhTNAM9bD9CrYzJNFQRhZFBDn1TqTE2/mFzqIQ
         6SBPGnoGkAN/IMf7baNnhyqCR18KuPDR5mwv8VFSkLZdLyjGrk+HeN/bcsvxxXAr2fAm
         uPIWWwrZqszpWYDKQMAKAJBC6XEfmM5rathcj0+h4Th9tptijJQ3bwvI4X9lOfPlAT7h
         e0pCLKSfhH/Tk05D/flFfoTbkHUzYE1QsFImIT0TUrX7ox0vkFuDhxFzWlqgdTGMiw18
         m/GoO0oipX3sTO4+nu7VuzwyVPY9dmfK3qOa4HSEy5WIkrKxS/a1N7/Th2czBcR3PaFH
         OTFg==
X-Gm-Message-State: AOAM533nMcF4EMmWjcw3LBajy6hC6cRzMU7jGqfhegbY4a5F/JIeEeto
        uGsZ28Wq9hy6U/X2GcBWWsmIaQoPCqQF8JuzfJqEDV2OQNWKT9oXtgmAkYRnDaD4nV+RmKzVuSD
        16dVpxANTOVV0mLgV33EZlA==
X-Received: by 2002:adf:f584:0:b0:20d:431:27f8 with SMTP id f4-20020adff584000000b0020d043127f8mr8650005wro.577.1653056589486;
        Fri, 20 May 2022 07:23:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjZMXOW3Se1xcwWM1GByTHWAdauwNMswM1vYef9PHHlEOhrXQN4r8cthb7UZYLjMT4wI6OcA==
X-Received: by 2002:adf:f584:0:b0:20d:431:27f8 with SMTP id f4-20020adff584000000b0020d043127f8mr8649980wro.577.1653056589274;
        Fri, 20 May 2022 07:23:09 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t16-20020adfa2d0000000b0020d0a070c80sm2683251wra.35.2022.05.20.07.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:23:08 -0700 (PDT)
Message-ID: <cdbb002a-9f0a-caa9-445e-4ba20328171a@redhat.com>
Date:   Fri, 20 May 2022 16:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V11 09/22] LoongArch: Add boot and setup routines
Content-Language: en-US
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn>
 <CAMj1kXEBVWi2ZdR5Le5-G0DA43u-AMxmSO=pVt39qwN=PkzQfw@mail.gmail.com>
 <0bae0df1-48ae-d02f-bce4-d1f69acf269e@redhat.com>
 <CAAhV-H5dqNiecER3fChkBjQUGGszj6gwcpOFM1b4Kaax5vz27g@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAAhV-H5dqNiecER3fChkBjQUGGszj6gwcpOFM1b4Kaax5vz27g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Huacai,

On 5/20/22 16:09, Huacai Chen wrote:

[snip]

>>
>> In summary, just enable the following to use the firmware framebuffer:
>>
>> CONFIG_DRM_SIMPLEDRM=y
>> CONFIG_DRM_FBDEV_EMULATION=y
>> CONFIG_SYSFB=y
>> CONFIG_SYSFB_SIMPLEFB=y
> Thank you very much, since 5.15 sysfb_init() do all things of
> register_gop_device(), so register_gop_device() here can be removed.

Correct.

> But there is another small problem: if simpledrm or efifb driver is
> built-in, there is no display. The reason is both sysfb_init() and
> display driver are in the same initcall level (device_initcall()).
> From the comments I know that sysfb_init() should after PCI
> enumeration which is in subsys_initcall(), so, could we make
> sysfb_init() to be a subsys_initcall_sync()?
>

I don't understand why we would need that... it shouldn't matter the order
in which the driver's init and sysfb_init() are done. If the driver's init
is executed first, then the driver will be registered and later when the
sysfb_init() registers the device, it will match the driver and probe.

Conversely, if the sysfb_init() is executed first then the platform device
will be registered and latter when the driver's init register the driver
this will match the already registered device.

In other words, it will be handled by the Linux device model and we should
not attempt to hand pick the initcall level for each. That's quite fragile.

Or am I missing something here ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

