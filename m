Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE7D52E907
	for <lists+linux-arch@lfdr.de>; Fri, 20 May 2022 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347764AbiETJlo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 May 2022 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347780AbiETJll (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2022 05:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2517EBAB9
        for <linux-arch@vger.kernel.org>; Fri, 20 May 2022 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653039698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDIoJ4xlMzZE/j3q78dU9+IH8OxDgewtkK08b3RHhh0=;
        b=Cj9Kd/f8HLFnfM5KxQItcgoa009SD6R9ltHiVbJFcO4m0RAemwNfpDl4+i7s1owogVfkYR
        fAbPUjd3dNKdyJox8rJrD3Tks4IxsH7WPkoMJV/LirXkWYrOZEICCrdvI4MqKaGGDDZ/iC
        Wbz/hJUuMkk300uJWBiwVApRBKe0hjw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-jHI_BZDlMt2pIruiOX0r5A-1; Fri, 20 May 2022 05:41:37 -0400
X-MC-Unique: jHI_BZDlMt2pIruiOX0r5A-1
Received: by mail-wm1-f71.google.com with SMTP id k35-20020a05600c1ca300b003946a9764baso5872901wms.1
        for <linux-arch@vger.kernel.org>; Fri, 20 May 2022 02:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UDIoJ4xlMzZE/j3q78dU9+IH8OxDgewtkK08b3RHhh0=;
        b=izTdV+MdzRa99YFpw1EkQ0pO2k6+ZaKm6bmjm4+RAWjwa0lwRrPhq5f8D4QikpYJrt
         K4tw/97HNgs4r1p63ZdkWNQ7Ap0ADmfc3MUOg56Kyoh6kRmv1KKPdP3UyPQVGiH/xGbi
         T5indocAYKvhKgulkw9RwHeoeEXQV5nPy1ulwFrwGid9jsVSmMPQQWajgJ/bYb8RYWSf
         AZdXuLSndqLvMAkTBF9KWXO3+A+b0yWQZivsFUb2VhZ450c2rtTc55bvNUfvvqGVuXeP
         SpOIhJ1EsHw3oD6e/PdixTwOKfyHOzBMHxp4HWslSsFZROvBz0TbtWHL+Z3pJLmISu8n
         LPHw==
X-Gm-Message-State: AOAM531b+Noz+E4h5efnAhzwZcxiAVizRu1RXFIqGf8k6UtcPTOh+40s
        fx2150v/r3TT7TtJ71IFp+K84heKq72g/knFqT0Cn02WpQTkEEB7nLNxN/kHZO3qnml1Cqsptt0
        X07hWErSne5B09Dx3pYUDiA==
X-Received: by 2002:a5d:540a:0:b0:20e:69db:4dc5 with SMTP id g10-20020a5d540a000000b0020e69db4dc5mr6044927wrv.337.1653039695981;
        Fri, 20 May 2022 02:41:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAWOyAYBWPLP3Fa+QhzSstcGeXffiNEAPAANu05JcjywYdYz0VkDgMO2Q6v4rP6xlM04OyOw==
X-Received: by 2002:a5d:540a:0:b0:20e:69db:4dc5 with SMTP id g10-20020a5d540a000000b0020e69db4dc5mr6044896wrv.337.1653039695587;
        Fri, 20 May 2022 02:41:35 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s1-20020adf8901000000b0020c547f75easm1881682wrs.101.2022.05.20.02.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 02:41:35 -0700 (PDT)
Message-ID: <0bae0df1-48ae-d02f-bce4-d1f69acf269e@redhat.com>
Date:   Fri, 20 May 2022 11:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V11 09/22] LoongArch: Add boot and setup routines
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
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
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn>
 <CAMj1kXEBVWi2ZdR5Le5-G0DA43u-AMxmSO=pVt39qwN=PkzQfw@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMj1kXEBVWi2ZdR5Le5-G0DA43u-AMxmSO=pVt39qwN=PkzQfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Ard and Huacai,

On 5/20/22 11:17, Ard Biesheuvel wrote:

[snip]

>> +
>> +static int __init register_gop_device(void)
>> +{
>> +       void *pd;
>> +
>> +       if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>> +               return 0;
>> +       pd = platform_device_register_data(NULL, "efi-framebuffer", 0,
>> +                       &screen_info, sizeof(screen_info));
>> +       return PTR_ERR_OR_ZERO(pd);
>> +}
>> +subsys_initcall(register_gop_device);
> 
> Not sure this is now the correct way to do this - cc'ing Javier.
> 

Is not the correct way to do it indeed, that can just be dropped.

We have unified now all the system framebuffer platform device
registration under drivers/firmware/sysfb.c (and the EFI quirks
if needed under drivers/firmware/efi/sysfb_efi.c).

So the only thing that a platform should do, is to enable the
the CONFIG_SYSFB config option. The screen_info should be set
correctly from the EFI GOP, but it seems that's already working
since you were already using it in register_gop_device().

But also, the "efi-framebuffer" platform device matches against
the legacy efifb fbdev driver. And now there's a simpledrm driver
that is also able to use the firmware-provided framebuffer.

You can enable that driver with CONFIG_DRM_SIMPLEDRM.

That driver though doesn't match against "efi-framebuffer" but with
a "simple-framebuffer", to make sysfb register that instead of the
"efi-framebuffer" device, you need to set CONFIG_SYSFB_SIMPLEFB too.

If for some reasons you need to provide a fbdev interface to the
user-space, you can enable CONFIG_DRM_FBDEV_EMULATION to have that.

In summary, just enable the following to use the firmware framebuffer:

CONFIG_DRM_SIMPLEDRM=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

