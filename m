Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843523271A1
	for <lists+linux-arch@lfdr.de>; Sun, 28 Feb 2021 09:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhB1Inx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 03:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhB1Inv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 03:43:51 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB1C06174A;
        Sun, 28 Feb 2021 00:43:10 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id k9so649560lfo.12;
        Sun, 28 Feb 2021 00:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OFyGOtSWzDrjV/94yIkSczgXO+fv1Av7VC7qHGGIZTc=;
        b=YJ1sEPS/er2MDdeZGD6TNU/9C7bWuBe8s2GkkQLn4EDUvQ+YG8Q+GfJ/o/ANy+JHJs
         myBz+norrZcGBMBR9dHibEl2jwat1MkebmMh7lmxgkNdsBZ1XvIRXaoVztZfmfaHOcH9
         n4SPv5zyzzZm00bkBdSeVuvUhrAjhurilfbnnSqKnYOHeUnrt/2Ahx85rFRHS4aH2w9l
         65jad1z5Hqii4YrdlRgwOcTrBfJM2lDyE7ni/4VRxDV5qOf8IOUROpvsx3l5OsOlD4o0
         Q80SRCtQNFLs0akX1M/DQmvEi1VteQ1Uiia9iKuAGmuaIK/QY83ykPw+eYqnbTGCLOKi
         UBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OFyGOtSWzDrjV/94yIkSczgXO+fv1Av7VC7qHGGIZTc=;
        b=S40t6l7aVDMwMlF35oZPkutfIvEsUJTz5R+yHAqeSFf6/JbvifHpTQpn7uK00hrJuK
         pgfVQO2qzHzfkMRC6Zbo9vsbn+qYPTXOddmu+DQw50KpB5VN+9AKnx56PHwfUq/BVqt2
         l4akQBM60RfwikUp53+UInoiQ1GaGghf7U5rj7Wa+jo7NY4kP/Zk30UvpFTe51HtDEDj
         fhVfSFmeyrCtMVoYpqXk0PM5KTRf1oKK+RixQCDBTGUyeZ+V7k3hqggghbc5PRjtMpDv
         xicXxf+3KprI3FsoRIJLdEbIpXnUBKSfhmNVSRVCKruYRJUSlIxwLLHReRIevC/D+0NQ
         i7NQ==
X-Gm-Message-State: AOAM531Lge2NnpvDL7U1KA2K/YkQGhNC4XXwNmClJfJW4VH6V4EBityM
        g83RRnM0gyKmv3ejBJF+d7n+YwtGXbNE9w==
X-Google-Smtp-Source: ABdhPJzyTfCWiZYth3RfZ0g3RViHE993pYqXeg3HFbdSb9OKcXrbSaqZM1T33df8b++dh625MLQL1A==
X-Received: by 2002:a05:6512:208:: with SMTP id a8mr6028858lfo.397.1614501788683;
        Sun, 28 Feb 2021 00:43:08 -0800 (PST)
Received: from [192.168.1.100] ([31.173.86.90])
        by smtp.gmail.com with ESMTPSA id s3sm2021193ljp.23.2021.02.28.00.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 00:43:08 -0800 (PST)
Subject: Re: [PATCH] MIPS: loongson64: alloc pglist_data at run time
To:     Huang Pei <huangpei@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
References: <20210227062957.269156-1-huangpei@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <a56885eb-a6dc-75dc-8061-491de73ab462@gmail.com>
Date:   Sun, 28 Feb 2021 11:43:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210227062957.269156-1-huangpei@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

On 27.02.2021 9:29, Huang Pei wrote:

> It can make some metadata of MM, like pglist_data and zone
> NUMA-aware
> 
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>   arch/mips/loongson64/numa.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> index cf9459f79f9b..5912b2e7b10c 100644
> --- a/arch/mips/loongson64/numa.c
> +++ b/arch/mips/loongson64/numa.c
[...]
> @@ -183,6 +194,7 @@ static void __init node_mem_init(unsigned int node)
>   			memblock_reserve((node_addrspace_offset | 0xfe000000),
>   					 32 << 20);
>   	}
> +

    Unrelated whitespace change?

>   }
>   
>   static __init void prom_meminit(void)

MBR, Sergei
