Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC995345CE
	for <lists+linux-arch@lfdr.de>; Wed, 25 May 2022 23:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbiEYVef (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 17:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiEYVed (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 17:34:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154EA8889
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 14:34:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z11so68270pjc.3
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=kPNpHNPesicxzaCcEtEsWOLOzkBCoEdcbvtndvUitaI=;
        b=GZJ6r6hGPK0878azss/NiKgNXXS1INfpKbEe6Femzd30Ooi7j1VXIikHfRMVoq6p9R
         yeYCIaiFCxQ0kKm8dHub+AExEfHt1M2nb04Ve3Xe6lGjXDkvbfXRZqitEjfneyLGVx+b
         PZXY8LkVwv3/T85hUnODR7FpzQ+8176jKYbaJ7RRQ5CGtFKsyb1uJOl6IJWJ9cSjZATr
         +tAI3PuK3PShNHQLKy0TPikyysz0ahP6i1X6ezZhKXSEa4Tu3lAVBvy9aWdAHkNmPt6Z
         jMTLgNI+io3vgJsQqikiK/HULD37O+TiNF19fb7DRwZA8H5MrrAuZB6435xh4UBLXHTo
         Xl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=kPNpHNPesicxzaCcEtEsWOLOzkBCoEdcbvtndvUitaI=;
        b=6kuTxlh27hVNdcq/fG+3apEsMijQHk+fKA1/EouEFf3/9jYdtAdJcvEP6gXbYjIMlA
         myoh/2TxudUpdUyE8ocBfUc/30anRGBgZvnS5vBK5Gad6TfCA13kMKalvStvP7v4be3l
         43cfdCOTE7WPgd5+X3CAcMU95Y2mxIF7cl3I/mZnZp5urXgMwx6FUwL6ZR7PzHEbtVxy
         MKR9dtklmU9tlTTCeUv7FhLzVOIK7iVY+ZjulAMeAEW8PC/jhkj9kFsFgkDvIb+l3RsS
         voQRvLIq5ap5WDTAuMJGQuSUxEJKjSlSFHGd1T74sFxyVt2Hj7xmnAo0C6AWKQXFbnub
         wuNA==
X-Gm-Message-State: AOAM531RYqoZfHOpGUQ9Mt9GZED2I55ZV/1oy67blUqaWQrJeir4VO0/
        Xckkhq9Mbevf7Cp/nBeWIrJ4d9/6WaP4CA==
X-Google-Smtp-Source: ABdhPJz/LdGkcESESmnRNERZMScRzqZEi9Ypwrp2YHAI9fkbGLI/uwQgRWDQXU/lIlswtxfVlWycTw==
X-Received: by 2002:a17:90b:1b42:b0:1df:f6bb:aa2b with SMTP id nv2-20020a17090b1b4200b001dff6bbaa2bmr12798436pjb.99.1653514470426;
        Wed, 25 May 2022 14:34:30 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b0015e8d4eb2e0sm9799934plp.298.2022.05.25.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:34:29 -0700 (PDT)
Date:   Wed, 25 May 2022 14:34:29 -0700 (PDT)
X-Google-Original-Date: Wed, 25 May 2022 14:34:28 PDT (-0700)
Subject:     Re: [PATCH] riscv: compat: Using seperated vdso_maps for compat_vdso_info
In-Reply-To: <a0bffec3-cf43-417e-3804-9248325266c3@roeck-us.net>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@roeck-us.net
Message-ID: <mhng-b37ccc06-67ad-4fd8-bcdb-0e5c9e5a4750@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 25 May 2022 14:15:03 PDT (-0700), linux@roeck-us.net wrote:
> On 5/25/22 09:04, guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> This is a fixup for vdso implementation which caused musl to
>> fail.
>>
>> [   11.600082] Run /sbin/init as init process
>> [   11.628561] init[1]: unhandled signal 11 code 0x1 at
>> 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
>> [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
>> 5.18.0-rc7-next-20220520 #1
>> [   11.629462] Hardware name: riscv-virtio,qemu (DT)
>> [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
>> 00ffffffc58199f0
>> [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
>> ffffffffffffffff
>> [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
>> 00ffffff8ade0cc0
>> [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
>> 00ffffffc5819a00
>> [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
>> 00ffffffc5819b00
>> [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
>> 0000000000000000
>> [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
>> 00ffffff8ade0728
>> [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
>> 00ffffffc5819e40
>> [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
>> 0000000000000000
>> [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
>> 0000000000000001
>> [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
>> [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
>> cause: 000000000000000d
>>
>> The last __vdso_init(&compat_vdso_info) replaces the data in normal
>> vdso_info. This is an obvious bug.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guo Ren <guoren@kernel.org>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Heiko Stübner <heiko@sntech.de>
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Sorry I'm a bit buried right now, this is fixing the issue you pointed 
out earlier?

>
>> ---
>>   arch/riscv/kernel/vdso.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
>> index 50fe4c877603..69b05b6c181b 100644
>> --- a/arch/riscv/kernel/vdso.c
>> +++ b/arch/riscv/kernel/vdso.c
>> @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_init = {
>>   };
>>
>>   #ifdef CONFIG_COMPAT
>> +static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
>> +	[RV_VDSO_MAP_VVAR] = {
>> +		.name   = "[vvar]",
>> +		.fault = vvar_fault,
>> +	},
>> +	[RV_VDSO_MAP_VDSO] = {
>> +		.name   = "[vdso]",
>> +		.mremap = vdso_mremap,
>> +	},
>> +};
>> +
>>   static struct __vdso_info compat_vdso_info __ro_after_init = {
>>   	.name = "compat_vdso",
>>   	.vdso_code_start = compat_vdso_start,
>>   	.vdso_code_end = compat_vdso_end,
>> -	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
>> -	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
>> +	.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
>> +	.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
>>   };
>>   #endif
>>
