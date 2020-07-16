Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FBF222EF3
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 01:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgGPXZ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 19:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGPXZ7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 19:25:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A2C061755
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 16:25:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so9010223wrs.0
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CZCZw6UIqWa4eGCjjDxYWCcfpSKWkLW/z2join0b1/E=;
        b=djx20166Ifzrkr/PBx+ibbY+7XRIJbbbeYbSp67v/mKoxf4rpIIwsmwY5APU/jOcKk
         7TgeIM8PtP788D8YW8dMk7tOM8NaoAyQhP1MGmipdmEia7IyRdD52m852nfGYNbCpCbh
         jPFvMzGjsHmxm8n2ospOoiPjQJsPPoCO767CCt87u1J4/c639Rq51F7Hy6Pg5bt4VY+U
         LvG7idYriK9JU7031REZjP606u/s0zKLZaXkZqnYTB+qz9tXbPLB91E7CwhdJtnbThSu
         J89uYpNrdQarIsHmfeg7+Z5lGlpJg3RZ9YYVSJUincS9JFrR9VIwFTI6euxE9dNF0Ajv
         o0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CZCZw6UIqWa4eGCjjDxYWCcfpSKWkLW/z2join0b1/E=;
        b=AX+Y3SWcTVLe60pxZuhnHUGilhmne9eHdrQRZjZnWthEDrxUSnkX7MbsA7yF1D/yAA
         i5foCkwzu8r7IOkEijm0N89J83sUduDvtxdVSliiXzlwiXfpGQZueFzZZw4E8eVH79qq
         wMFdCJ8qD7Lqj6MAaCiKMIKYqNFs+bCHk4pXjxMrxsYyoN0YqnHAytzv8QvwQsy15nfJ
         HSSU6baKAqw/QCvSVHYCGPfi4ZbS59SetIAKJlA6AvmxwAwDxeGN/VwlAPXxOgHwvkJO
         L6HLCcwOrwyqMvTUjIK3y+zJ9/KJkca5kYlBOtlc2PRD7ZNALlNf7g/IxnoxE3UmyJHd
         KJMg==
X-Gm-Message-State: AOAM531s0QGsYi3ka3RysmBppqBNUxxIAFrMfadcZuhmzIJ3769ly6Zi
        Vxw043Rq3YHzDtMvM8Pxvw==
X-Google-Smtp-Source: ABdhPJzus8Uaf40w+JktJKlxNdRPX6rleQXh/c9z6onH1BS9Qb6f9cV/vmRw5LKKSzewA2nrJKNWgA==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr7238485wrw.262.1594941957497;
        Thu, 16 Jul 2020 16:25:57 -0700 (PDT)
Received: from [192.168.200.34] (ip5b436a54.dynamic.kabel-deutschland.de. [91.67.106.84])
        by smtp.gmail.com with ESMTPSA id u186sm10923422wmu.10.2020.07.16.16.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 16:25:56 -0700 (PDT)
Subject: Re: [PATCH] linux: arm: vdso: nullpatch vdso_clock_gettime64 for
 non-virtual timers
To:     Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20200716150723.9389-1-knaerzche@gmail.com>
 <ac44a5a3-ca35-cd0a-f823-4b814c01c498@arm.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <2c4484bf-a127-6f07-75f2-e0f0a15fe257@gmail.com>
Date:   Fri, 17 Jul 2020 01:25:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ac44a5a3-ca35-cd0a-f823-4b814c01c498@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Robin,

Am 16.07.20 um 20:46 schrieb Robin Murphy:
> Hi Alex,
>
> On 2020-07-16 16:07, Alex Bee wrote:
>> Along with commit commit 74d06efb9c2f ("ARM: 8932/1: Add clock_gettime64
>> entry point") clock_gettime64 was added for ARM platform to solve the
>> y2k38 problem on 32-bit platforms. glibc from version 2.31 onwards
>> started using this vdso-call on ARM platforms.
>> However it was (probably) forgotten to "nullpatch" this call, when no
>> reliable timer source is available, for example when
>> "arm,cpu-registers-not-fw-configured" is defined in devicetree for
>> "arm,armv7-timer".
>> This results in erratic time jumps whenever "gettimeofday" gets called,
>> since the (non-working) vdso-call will be used instead of a syscall.
>>
>> This patch adds clock_gettime64 to get nullpatched as well. It has been
>> verified to work and solve this issue on Rockchip RK322x, RK3288 and
>> RPi4 (32-bit kernel build) platforms.
>
> FYI, a version of this patch was already submitted, and is just 
> waiting for Russell to apply it:
>
> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8987/1
>
> Robin.
OK - couldn't find this before. You can drop my patch than.
>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   arch/arm/kernel/vdso.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
>> index 6bfdca4769a7..fddd08a6e063 100644
>> --- a/arch/arm/kernel/vdso.c
>> +++ b/arch/arm/kernel/vdso.c
>> @@ -184,6 +184,7 @@ static void __init patch_vdso(void *ehdr)
>>       if (!cntvct_ok) {
>>           vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
>>           vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
>> +        vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
>>       }
>>   }
>>
Regards,

Alex

