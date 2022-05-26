Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00D5347A3
	for <lists+linux-arch@lfdr.de>; Thu, 26 May 2022 02:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbiEZAnN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 May 2022 20:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344828AbiEZAnM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 May 2022 20:43:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC11A76D1
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 17:43:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x143so382171pfc.11
        for <linux-arch@vger.kernel.org>; Wed, 25 May 2022 17:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sZBB3cFJmHUKx647UvH8/q/X0Zv3XJtlmYlf4oGcSPQ=;
        b=k79hTMklqRVciCR3lGtpKRUXYMofhOcscF0ctAqoTwqO2GaIXsepK3iVYkd5VLpLDE
         VmGliHiJsqBbCa5Ka5QizTlvASwyKy19TIz8rRKUSiKpFVD4D531/gZpyC4eEPOwnD3z
         R0+d+uwUZNyfZlRIfZrYlRdc+gRLwk3h4j0b61sXHe9B54wRb81lilUNrv3FHPUhfGGN
         ewYwOsvjkGZFpC/5j3nNakOHz+raQjG6KChm/YMdaZuqXCIH1c8+HgPIt0sDatnjE1oF
         Bb+SoHcLYC5aM8ES/8uJHulkcuNU2vPyeZVt+zk/rBGC/5/Zj65hIzgD627evhuRRiaS
         Jx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sZBB3cFJmHUKx647UvH8/q/X0Zv3XJtlmYlf4oGcSPQ=;
        b=JeL4etuWOpVm17iX6nj9iRwE1FXONKdgHFzoZdD8usu1ZOyIQcY8IpoujLLxJHINXd
         7s5qtN0iyRgve9QRxufSJbbS34zwHSYb/NMl3N+JOaFHcVEmsqOmIzPA533HNP7zLXtX
         mQAT4PXzMzXUNR8F+4em8eRQhvkDnGlna4/0kD3L9HS7pnv+VajGzGbivOYdCC93dGdo
         WzekS/Q51xRNDyLozMF76g+bsuhAOgH7sb1eb84JQZk2twwo6TBkfjQQW6Sp5tBuQXpl
         vxBIER0jED4BomVAQr7o1aEUFk1jD/67s/ygkwIyDd4i4x5LG4Kn9+gaQOrVd1Wk1JdI
         MVvQ==
X-Gm-Message-State: AOAM531cattat6H15KeicA2bwq8xefWyAfw1w9dzHXdSoED8F/F41NFP
        tOsMHEKE5Gl0qZOlCtIeXArQ3Q==
X-Google-Smtp-Source: ABdhPJx8vwGw6JLFkrwBwLIK5yJUQGsA2KqzjYt3TFr6QV9jVWuq3AzgqDtE5ELg2KebDykhsTkZlQ==
X-Received: by 2002:a05:6a00:194f:b0:518:81fe:fcc6 with SMTP id s15-20020a056a00194f00b0051881fefcc6mr24241050pfk.64.1653525791230;
        Wed, 25 May 2022 17:43:11 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902ce0d00b001635b86a790sm27389plg.44.2022.05.25.17.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:43:10 -0700 (PDT)
Date:   Wed, 25 May 2022 17:43:10 -0700 (PDT)
X-Google-Original-Date: Wed, 25 May 2022 17:42:57 PDT (-0700)
Subject:     Re: [PATCH] riscv: compat: Using seperated vdso_maps for compat_vdso_info
In-Reply-To: <mhng-7a88227d-dc64-4d87-9e1a-0ea802ddf0a1@palmer-ri-x1c9>
CC:     linux@roeck-us.net, Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-54a3577b-2ae9-4ca0-a27d-f75f13807a29@palmer-ri-x1c9>
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

On Wed, 25 May 2022 17:39:39 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 25 May 2022 15:56:07 PDT (-0700), linux@roeck-us.net wrote:
>> On 5/25/22 14:34, Palmer Dabbelt wrote:
>>> On Wed, 25 May 2022 14:15:03 PDT (-0700), linux@roeck-us.net wrote:
>>>> On 5/25/22 09:04, guoren@kernel.org wrote:
>>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>>
>>>>> This is a fixup for vdso implementation which caused musl to
>>>>> fail.
>>>>>
>>>>> [   11.600082] Run /sbin/init as init process
>>>>> [   11.628561] init[1]: unhandled signal 11 code 0x1 at
>>>>> 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
>>>>> [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted
>>>>> 5.18.0-rc7-next-20220520 #1
>>>>> [   11.629462] Hardware name: riscv-virtio,qemu (DT)
>>>>> [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp :
>>>>> 00ffffffc58199f0
>>>>> [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 :
>>>>> ffffffffffffffff
>>>>> [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 :
>>>>> 00ffffff8ade0cc0
>>>>> [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 :
>>>>> 00ffffffc5819a00
>>>>> [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 :
>>>>> 00ffffffc5819b00
>>>>> [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 :
>>>>> 0000000000000000
>>>>> [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 :
>>>>> 00ffffff8ade0728
>>>>> [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 :
>>>>> 00ffffffc5819e40
>>>>> [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10:
>>>>> 0000000000000000
>>>>> [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 :
>>>>> 0000000000000001
>>>>> [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
>>>>> [   11.629699] status: 0000000000004020 badaddr: 0000000000000000
>>>>> cause: 000000000000000d
>>>>>
>>>>> The last __vdso_init(&compat_vdso_info) replaces the data in normal
>>>>> vdso_info. This is an obvious bug.
>>>>>
>>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>>>> Cc: Heiko Stübner <heiko@sntech.de>
>>>>
>>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> Sorry I'm a bit buried right now, this is fixing the issue you pointed out earlier?
>>>
>> Yes.
>
> Awosome, I think that was the only big blocker so far.
>
> I added a musl-based userspace to my test setup, which is rv64-only
> (buildroot doesn't have rv32 musl, I thought upstream had it but maybe
> i'm misremembering).  This patch fixes the bug, so I've added it to
> for-next with

Just saw the v2, so I'm using that instead.

>
> Fixes: 3092eb456375 ("riscv: compat: vdso: Add setup additional pages implementation")
>
> which I think is correct, but LMK if there's an issue.
>
> Thanks!
>
> (and also sorry I poked Geert instead of you about this one, oops ;))
>
>>
>> Thanks,
>> Guenter
>>
>>>>
>>>>> ---
>>>>>   arch/riscv/kernel/vdso.c | 15 +++++++++++++--
>>>>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
>>>>> index 50fe4c877603..69b05b6c181b 100644
>>>>> --- a/arch/riscv/kernel/vdso.c
>>>>> +++ b/arch/riscv/kernel/vdso.c
>>>>> @@ -206,12 +206,23 @@ static struct __vdso_info vdso_info __ro_after_init = {
>>>>>   };
>>>>>
>>>>>   #ifdef CONFIG_COMPAT
>>>>> +static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
>>>>> +    [RV_VDSO_MAP_VVAR] = {
>>>>> +        .name   = "[vvar]",
>>>>> +        .fault = vvar_fault,
>>>>> +    },
>>>>> +    [RV_VDSO_MAP_VDSO] = {
>>>>> +        .name   = "[vdso]",
>>>>> +        .mremap = vdso_mremap,
>>>>> +    },
>>>>> +};
>>>>> +
>>>>>   static struct __vdso_info compat_vdso_info __ro_after_init = {
>>>>>       .name = "compat_vdso",
>>>>>       .vdso_code_start = compat_vdso_start,
>>>>>       .vdso_code_end = compat_vdso_end,
>>>>> -    .dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
>>>>> -    .cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
>>>>> +    .dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
>>>>> +    .cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
>>>>>   };
>>>>>   #endif
>>>>>
