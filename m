Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556567A3FB7
	for <lists+linux-arch@lfdr.de>; Mon, 18 Sep 2023 05:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjIRDev (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Sep 2023 23:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjIRDem (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Sep 2023 23:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18C410C
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2023 20:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695008031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHzH+a1yYhJkfNUv/Dy9j8VaViRqaOEkd87Y+pYRKHg=;
        b=J/DZylmJiU4466XIW6O63v56pPUKKVByorZzCkfjWLh/zqSuEO9xma7wJ89m+x/y38TGyK
        hHQMn4GKRJw/JJYsnwH0IA0/AAoQ5JSGF4Pf/dkIl/p6oqEc1iCQWd8dpbV6mjqqfYkBr8
        bepv4v3sxs0V8HxpPA2mXrddhld7t0Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-8LvIFcd5OY6n5FfrGXQhkg-1; Sun, 17 Sep 2023 23:33:48 -0400
X-MC-Unique: 8LvIFcd5OY6n5FfrGXQhkg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-274ac6d570aso1973489a91.2
        for <linux-arch@vger.kernel.org>; Sun, 17 Sep 2023 20:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695008027; x=1695612827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHzH+a1yYhJkfNUv/Dy9j8VaViRqaOEkd87Y+pYRKHg=;
        b=j+cpPHMJ+cjwV31zOYq9WQnHG8T/x0GY/0len3uY2z5RWVHvh0YG3sqUKyaHTcKj8u
         rJ7Exyo1GCGm3dq4lkGifsqqPk1BDg6DCnNFBGbQDHVrmnLkt4ZSFXZTtBCfT/odIQqx
         LtZZ1eFpvxNZjfAeBh8+Xf0E40JLNf5tsW5z9fpLMP+nqwoLe1tiSXs8aDzT+6mblvEt
         eLYXA+BYeV7ocMWOq5g7+krJNoT2DdaS8HHgU+KL8LIbBS1FmV5+9ugyml0EZW+vM2/d
         VzGFZVbDDWYnK0aC4puZGc93VC/0ADklgg2KvYf9J5AoBK4iEwDEassTqMGn/eiUF258
         3ZFg==
X-Gm-Message-State: AOJu0YyLrNZs/BlIOL13k1VBzwNS6w4bgJ9b3CMCIC6vPpGcOrnM20in
        PX97hwUqXRVoQ7orWgazjd4452jum/2y70QLZmpivAV8VvwdcJ+s0r7Y09+VHpxotQ8SiGBcxRL
        L0kP8TnsX/jZ7Q2RtNU8h6HAY+Iq3Rg==
X-Received: by 2002:a17:90b:890:b0:274:7de7:d6fa with SMTP id bj16-20020a17090b089000b002747de7d6famr7131224pjb.9.1695008027064;
        Sun, 17 Sep 2023 20:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdFVHnxmGek3zqSMDKaRzCcHQAQEv2cIpV7L2yNs7LNSqm4GiEBUNxLVrj5jEdjCAv9J4IOA==
X-Received: by 2002:a17:90b:890:b0:274:7de7:d6fa with SMTP id bj16-20020a17090b089000b002747de7d6famr7131213pjb.9.1695008026727;
        Sun, 17 Sep 2023 20:33:46 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a004800b0026b420ae167sm8825822pjb.17.2023.09.17.20.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 20:33:45 -0700 (PDT)
Message-ID: <2c23ab17-7516-e310-8b79-b8c5fc02984a@redhat.com>
Date:   Mon, 18 Sep 2023 13:33:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 05/35] drivers: base: Print a warning instead of
 panic() when register_cpu() fails
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-6-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 9/14/23 02:37, James Morse wrote:
> loongarch, mips, parisc, riscv and sh all print a warning if
> register_cpu() returns an error. Architectures that use
> GENERIC_CPU_DEVICES call panic() instead.
> 
> Errors in this path indicate something is wrong with the firmware
> description of the platform, but the kernel is able to keep running.
> 
> Downgrade this to a warning to make it easier to debug this issue.
> 
> This will allow architectures that switching over to GENERIC_CPU_DEVICES
> to drop their warning, but keep the existing behaviour.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/base/cpu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 579064fda97b..d31c936f0955 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -535,14 +535,15 @@ int __weak arch_register_cpu(int cpu)
>   
>   static void __init cpu_dev_register_generic(void)
>   {
> -	int i;
> +	int i, ret;
>   
>   	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
>   		return;
>   
>   	for_each_present_cpu(i) {
> -		if (arch_register_cpu(i))
> -			panic("Failed to register CPU device");
> +		ret = arch_register_cpu(i);
> +		if (ret)
> +			pr_warn("register_cpu %d failed (%d)\n", i, ret);
>   	}
>   }
>   

The same warning message has been printed by arch/loongarch/kernel/topology.c::arch_register_cpu().
In order to avoid the duplication, I think the warning message in arch/loongarch needs to be dropped?

Thanks,
Gavin

