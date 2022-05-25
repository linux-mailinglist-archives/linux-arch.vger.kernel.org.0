Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719915346DC
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 00:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiEYW4N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 18:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238729AbiEYW4M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 18:56:12 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471622E9D6;
        Wed, 25 May 2022 15:56:10 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t144so285549oie.7;
        Wed, 25 May 2022 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DbhXocVdJI108NLqeONWoZkfXcTtzL64FrHc9jEvSMY=;
        b=h7epTynqVLwlSXxaAhGIjxm24IKossrcYupb3DHhPMA/GpRdJolUTuELfnJuXY+lJO
         N7R+5/1pvc3LarzWT0gViUaDDMGGhSY6aP6y0OEHm5Ii7dSWk4G/HawIxMNilpECX9VI
         B4TL3tpmGKQnCc7UioiYqYV6tEVDBN6LKsUkkHRsq+ifHaKiLRADIhbmPhhDahfxI3lm
         ufoXZOxzOdjS27T4qzfPll/Mk/bOgZvBCnPfr83vKV4Qn3WeWt3FyzyL2DcAtD7I297b
         QxoqqhpbotMcYNzg1lWtyoukKFKInSg/SAlaPk54whSvzty2CxgrGeDG+tIr6VKP1PTo
         NF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DbhXocVdJI108NLqeONWoZkfXcTtzL64FrHc9jEvSMY=;
        b=zZeUrWw4FaokPb5TOyOc/Z2Y4X5YhUvmqvShmHeMuS4rn5MHrKutNWUTJV3H7CDyle
         /SrpVuSs3hRN3OBusuH5RUu9eY6Jnqyywg214AdPPouXsMR+91qkQSOHyrIhMk4PN4O1
         dgSfmMO3C0AjCJkQcmJJ4o+D53Sl8RM355X6DL3JC06n43R/iy99F9xF32QlULRVaVwH
         isXGTozDvIaeZl9Wxarby/dDVSRZU+1iJgjpLcD23nDRPltdmPkAj2P+IjKMLjEVJG1N
         Bf+SiIqZg2BeOxU7OIASIcCAa+3LJZXu1xg94ZXKFFE3K1Gkg0AVnKGpbXD2CeqScLIv
         DzTQ==
X-Gm-Message-State: AOAM530MrduyCMftMPEqDoj5/0tlkDnXKhSnhZ1rKHxHXQtNlqHlicZZ
        myjx05cjvKlY2wT9Vjjbc9bZ3hpsEIWF1Q==
X-Google-Smtp-Source: ABdhPJyBxdz/4uWxT28qO5q67jZnYyhrQB81/44lp3PL6QjvdW6IfSt8sgcLAUT3/by8eikrUG+LgQ==
X-Received: by 2002:a05:6808:f0b:b0:328:bad3:2d92 with SMTP id m11-20020a0568080f0b00b00328bad32d92mr6515862oiw.277.1653519369605;
        Wed, 25 May 2022 15:56:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gn9-20020a056870d98900b000f27976b9d9sm32202oab.6.2022.05.25.15.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 15:56:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <48ef770c-75bf-6c37-66fe-9719164bc6e0@roeck-us.net>
Date:   Wed, 25 May 2022 15:56:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] riscv: compat: Using seperated vdso_maps for
 compat_vdso_info
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
References: <mhng-b37ccc06-67ad-4fd8-bcdb-0e5c9e5a4750@palmer-ri-x1c9>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <mhng-b37ccc06-67ad-4fd8-bcdb-0e5c9e5a4750@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/25/22 14:34, Palmer Dabbelt wrote:
> On Wed, 25 May 2022 14:15:03 PDT (-0700), linux@roeck-us.net wrote:
>> On 5/25/22 09:04, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> This is a fixup for vdso implementation which caused musl to
>>> fail.
>>>
>>> [   11.600082] Run /sbin/init as init process
>>> [   11.628561] init[1]: unhandled signal 11 code 0x1 at
>>> 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
>>> [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
>>> 5.18.0-rc7-next-20220520 #1
>>> [   11.629462] Hardware name: riscv-virtio,qemu (DT)
>>> [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
>>> 00ffffffc58199f0
>>> [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
>>> ffffffffffffffff
>>> [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
>>> 00ffffff8ade0cc0
>>> [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
>>> 00ffffffc5819a00
>>> [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
>>> 00ffffffc5819b00
>>> [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
>>> 0000000000000000
>>> [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
>>> 00ffffff8ade0728
>>> [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
>>> 00ffffffc5819e40
>>> [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
>>> 0000000000000000
>>> [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
>>> 0000000000000001
>>> [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
>>> [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
>>> cause: 000000000000000d
>>>
>>> The last __vdso_init(&compat_vdso_info) replaces the data in normal
>>> vdso_info. This is an obvious bug.
>>>
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>> Cc: Heiko Stübner <heiko@sntech.de>
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Sorry I'm a bit buried right now, this is fixing the issue you pointed out earlier?
> 
Yes.

Thanks,
Guenter

>>
>>> ---
>>>   arch/riscv/kernel/vdso.c | 15 +++++++++++++--
>>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
>>> index 50fe4c877603..69b05b6c181b 100644
>>> --- a/arch/riscv/kernel/vdso.c
>>> +++ b/arch/riscv/kernel/vdso.c
>>> @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_init = {
>>>   };
>>>
>>>   #ifdef CONFIG_COMPAT
>>> +static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
>>> +    [RV_VDSO_MAP_VVAR] = {
>>> +        .name   = "[vvar]",
>>> +        .fault = vvar_fault,
>>> +    },
>>> +    [RV_VDSO_MAP_VDSO] = {
>>> +        .name   = "[vdso]",
>>> +        .mremap = vdso_mremap,
>>> +    },
>>> +};
>>> +
>>>   static struct __vdso_info compat_vdso_info __ro_after_init = {
>>>       .name = "compat_vdso",
>>>       .vdso_code_start = compat_vdso_start,
>>>       .vdso_code_end = compat_vdso_end,
>>> -    .dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
>>> -    .cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
>>> +    .dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
>>> +    .cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
>>>   };
>>>   #endif
>>>

