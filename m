Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5471534793
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 02:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbiEZAjo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 20:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbiEZAjn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 20:39:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B73312A86
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 17:39:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a9so46097pgv.12
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lmgayds5UtNEFyHbtMEOI/udLkmrlP9KZ5Zh1sLLZwU=;
        b=Ki9BjClaDu10N/8XW3YdIW+aM9JwTsK5eJ7ZRizWaJukpFsCAC9ZVrj4tbtrzZxBxG
         q+3cCEvBD0cDVSaL4Tr+XC1OghoMfUyMa4uN2DTbk69pTjL7mdMbSom+dpWfKDxBW6y/
         xqc91eVk9bYknMBKuiJAKdA7vLgLi7sNExBcT9eaRTbBCMEyBduY+COgJy7RZ8KrViWs
         vuH+NavQ0uvbD3M8F+vNl1yrN18rEJDYdhcHqWFCy6D3jpCs2l37ztahBQNKMYvjgqop
         eRzAbYDCBI+hhnfZoV2RHkO+21j4mh7Np3kZeFUYbeSB6fkV+XCclNIDWT5FbtUNjM0k
         avnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lmgayds5UtNEFyHbtMEOI/udLkmrlP9KZ5Zh1sLLZwU=;
        b=Xk1RpKQy7iDrmKwDKHzDq5VSddr712j/1eZPJ2h8zy6rdfzC9vxsLne0KsCWPb6TIN
         QXzMYVKrylCza2tOTrPTx+ALaKsuZrbsmGKxmarYmPj/fjaOUapOyH/GMWsugZRDN5J/
         OGpRywp7N8KdmXhgaER7mBuleeuV33LMnEcs2BCUzyMTeWlcCZUBfIDZlUeycRgDZjcU
         +y5URrgGnRtQTbspYQR32j+SCjCxKqom9r+D8TjSGg+naPH8/zslW9ELx5VQGXM4K3mQ
         nXpAe1ike20EaO7y2IaHag/xy1NS/+4M3v1t9D/CP4F0zmACL7cvzo7cur7ihnK8Z6iS
         p0cQ==
X-Gm-Message-State: AOAM5338XLXQLR0nQCSvvTp2IEOyjzIGXZTVkZ/xqhECsgH785cn0rxY
        BrZhyEkO+fn9Wq8Pbw8lriV5Ow==
X-Google-Smtp-Source: ABdhPJzkH9LzH2tzaLtZljf2U0KKdd7VDbdj19BDT+3tyKSkGkp0zFoN2Hm3IE7OoLNAWn5cRUCeyA==
X-Received: by 2002:a65:6e9b:0:b0:3c5:f761:2d94 with SMTP id bm27-20020a656e9b000000b003c5f7612d94mr30378283pgb.79.1653525581600;
        Wed, 25 May 2022 17:39:41 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090a170800b001d93118827asm85801pjd.57.2022.05.25.17.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:39:39 -0700 (PDT)
Date:   Wed, 25 May 2022 17:39:39 -0700 (PDT)
X-Google-Original-Date: Wed, 25 May 2022 17:39:37 PDT (-0700)
Subject:     Re: [PATCH] riscv: compat: Using seperated vdso_maps for compat_vdso_info
In-Reply-To: <48ef770c-75bf-6c37-66fe-9719164bc6e0@roeck-us.net>
CC:     guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@roeck-us.net
Message-ID: <mhng-7a88227d-dc64-4d87-9e1a-0ea802ddf0a1@palmer-ri-x1c9>
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

On Wed, 25 May 2022 15:56:07 PDT (-0700), linux@roeck-us.net wrote:
> On 5/25/22 14:34, Palmer Dabbelt wrote:
>> On Wed, 25 May 2022 14:15:03 PDT (-0700), linux@roeck-us.net wrote:
>>> On 5/25/22 09:04, guoren@kernel.org wrote:
>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>
>>>> This is a fixup for vdso implementation which caused musl to
>>>> fail.
>>>>
>>>> [   11.600082] Run /sbin/init as init process
>>>> [   11.628561] init[1]: unhandled signal 11 code 0x1 at
>>>> 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
>>>> [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
>>>> 5.18.0-rc7-next-20220520 #1
>>>> [   11.629462] Hardware name: riscv-virtio,qemu (DT)
>>>> [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
>>>> 00ffffffc58199f0
>>>> [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
>>>> ffffffffffffffff
>>>> [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
>>>> 00ffffff8ade0cc0
>>>> [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
>>>> 00ffffffc5819a00
>>>> [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
>>>> 00ffffffc5819b00
>>>> [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
>>>> 0000000000000000
>>>> [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
>>>> 00ffffff8ade0728
>>>> [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
>>>> 00ffffffc5819e40
>>>> [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
>>>> 0000000000000000
>>>> [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
>>>> 0000000000000001
>>>> [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
>>>> [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
>>>> cause: 000000000000000d
>>>>
>>>> The last __vdso_init(&compat_vdso_info) replaces the data in normal
>>>> vdso_info. This is an obvious bug.
>>>>
>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>>> Cc: Heiko Stübner <heiko@sntech.de>
>>>
>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Sorry I'm a bit buried right now, this is fixing the issue you pointed out earlier?
>>
> Yes.

Awosome, I think that was the only big blocker so far.

I added a musl-based userspace to my test setup, which is rv64-only 
(buildroot doesn't have rv32 musl, I thought upstream had it but maybe 
i'm misremembering).  This patch fixes the bug, so I've added it to 
for-next with

Fixes: 3092eb456375 ("riscv: compat: vdso: Add setup additional pages implementation")

which I think is correct, but LMK if there's an issue.  

Thanks!

(and also sorry I poked Geert instead of you about this one, oops ;))

>
> Thanks,
> Guenter
>
>>>
>>>> ---
>>>>   arch/riscv/kernel/vdso.c | 15 +++++++++++++--
>>>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
>>>> index 50fe4c877603..69b05b6c181b 100644
>>>> --- a/arch/riscv/kernel/vdso.c
>>>> +++ b/arch/riscv/kernel/vdso.c
>>>> @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_init = {
>>>>   };
>>>>
>>>>   #ifdef CONFIG_COMPAT
>>>> +static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
>>>> +    [RV_VDSO_MAP_VVAR] = {
>>>> +        .name   = "[vvar]",
>>>> +        .fault = vvar_fault,
>>>> +    },
>>>> +    [RV_VDSO_MAP_VDSO] = {
>>>> +        .name   = "[vdso]",
>>>> +        .mremap = vdso_mremap,
>>>> +    },
>>>> +};
>>>> +
>>>>   static struct __vdso_info compat_vdso_info __ro_after_init = {
>>>>       .name = "compat_vdso",
>>>>       .vdso_code_start = compat_vdso_start,
>>>>       .vdso_code_end = compat_vdso_end,
>>>> -    .dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
>>>> -    .cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
>>>> +    .dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
>>>> +    .cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
>>>>   };
>>>>   #endif
>>>>
