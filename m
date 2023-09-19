Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD23C7A56D2
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 03:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjISBKs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 21:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjISBKm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 21:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3954910D
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695085780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xhYDTylANariynyECyDawRfZxSRk3P2GMXADURjfrY=;
        b=g5gvk9Cbldzwgf1whkpv1bhkeCidpWMGTQkiHzikYV0NVbdBS1aIs/VRwtCX6tEFH/wuRz
        iTN6ISnycsk01kDlCaUiLKxQFNmOzupCQcDAjbHQgG/yE0nQkLF2hUGNYJMh9rLl9Fp2Yq
        XHRv1G6U4v1beJPrgRuM+xpXGkSDI/k=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-irB7nfz-MSu6vE2w53Zlwg-1; Mon, 18 Sep 2023 21:09:39 -0400
X-MC-Unique: irB7nfz-MSu6vE2w53Zlwg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6903b59d3a8so4067269b3a.3
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 18:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695085778; x=1695690578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xhYDTylANariynyECyDawRfZxSRk3P2GMXADURjfrY=;
        b=tWDSd7YQHO21YrhSPtcDPtvbD1XGVqdENUAMqu7gU1O5ka+/CaHILPmDbnzuEBkPFN
         AA77bMv4HcWuugjKObEUtQikquWChuv3Majta3za9iY5ddFu9eIZ/9SppRlFNq1r/jz3
         fgTFveoaSKa98Pusf626gTvTwMtAJB3pqyA7n28QypTHOl9dt7bHNS2j21Zdq612NgBc
         PUybllgB+fc8MpptL6f9hSHVmarEpwRou6haS7kB3nnYCJHU5/8I2B67Vv3MONVnJM+2
         Sd1AVoEn8sDusCVvgu/xQglwHZzeqUzIdIpqV46VmGLrs4QSUZl0E4fb8tnJhxYa0HLv
         Bsnw==
X-Gm-Message-State: AOJu0YwBHvJOXS/4xqseFN0Umf+Wg5zlaNrCb+V9kOMz4swfGGZlVUBZ
        n3lEOQbewK3+r+5tQubws7Jbme4UNeDnorkrzDiIdX57EYrrFOQNC61o/xVWS7OraKVy3NSX+rR
        dmbtyqnPEW78mNMj1SuisTw==
X-Received: by 2002:a05:6a20:7faa:b0:140:324c:124c with SMTP id d42-20020a056a207faa00b00140324c124cmr10255877pzj.62.1695085778231;
        Mon, 18 Sep 2023 18:09:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdG9bCpdvmZ3ZQXnGhuch/qDkbh0mPQBnni4kkBKZ4ohjirIgnh97Jnx/y/Pt40AJLReKTog==
X-Received: by 2002:a05:6a20:7faa:b0:140:324c:124c with SMTP id d42-20020a056a207faa00b00140324c124cmr10255863pzj.62.1695085777865;
        Mon, 18 Sep 2023 18:09:37 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id bh3-20020a170902a98300b001c55d591f07sm3082096plb.260.2023.09.18.18.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 18:09:37 -0700 (PDT)
Message-ID: <23ed10ee-b88f-8681-35a4-cefc2e3a7800@redhat.com>
Date:   Tue, 19 Sep 2023 11:09:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 25/35] LoongArch: Use the __weak version of
 arch_unregister_cpu()
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
 <20230913163823.7880-26-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-26-james.morse@arm.com>
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

On 9/14/23 02:38, James Morse wrote:
> LoongArch provides its own arch_unregister_cpu(). This clears the
> hotpluggable flag, then unregisters the CPU.
> 
> It isn't necessary to clear the hotpluggable flag when unregistering
> a cpu. unregister_cpu() writes NULL to the percpu cpu_sys_devices
> pointer, meaning cpu_is_hotpluggable() will return false, as
> get_cpu_device() has returned NULL.
> 
> Remove arch_unregister_cpu() and use the __weak version.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/loongarch/kernel/topology.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
I think arch/x86/kernel/topology.c::arch_unregister_cpu() can be dropped either.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
> index 8e4441c1ff39..5a75e2cc0848 100644
> --- a/arch/loongarch/kernel/topology.c
> +++ b/arch/loongarch/kernel/topology.c
> @@ -16,13 +16,4 @@ int arch_register_cpu(int cpu)
>   	return register_cpu(c, cpu);
>   }
>   EXPORT_SYMBOL(arch_register_cpu);
> -
> -void arch_unregister_cpu(int cpu)
> -{
> -	struct cpu *c = &per_cpu(cpu_devices, cpu);
> -
> -	c->hotpluggable = 0;
> -	unregister_cpu(c);
> -}
> -EXPORT_SYMBOL(arch_unregister_cpu);
>   #endif

Thanks,
Gavin

