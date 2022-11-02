Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD52615EBA
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 10:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKBJC7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 05:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiKBJCO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 05:02:14 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8044B27FE3
        for <linux-arch@vger.kernel.org>; Wed,  2 Nov 2022 02:01:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y203so1688024pfb.4
        for <linux-arch@vger.kernel.org>; Wed, 02 Nov 2022 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7Zdgirtqci69Swtp5BTZmwtPa1KkHmxW1ALdvVO1eA=;
        b=axpjrmZwJoHqm006PdecGiKFxCVrDtI7fmM+51qQj5/T8wCSt9eLlIOuHkYqtu8uHX
         FEIppYhPZ/F7JWjwBYb22b844jLJgqYJ9fR2AhR9yDVrRXpfyvi+o8nx9PS+wbpGb94z
         5g9U6rL4KdRNHXwtLqWGSv7c+nSF5RltTj6cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7Zdgirtqci69Swtp5BTZmwtPa1KkHmxW1ALdvVO1eA=;
        b=LC3ETw/PT1ksPqL8Sm3+feCXwPygdEtFlhU5DT1t2h68WRjaJ4VXJX36CATbP2qGJ5
         NRQ05u4OF2IBYlqB1V+/KGNtHSxq0l0ZyA9Ao2gd2UFhL8pjn1OUNsmcty2OOrglnWrq
         HLolRsiGrPMZRASlcg/Fxmy0+SRYOOq2tSejdVxat851odheM4Q/kIyh5SroJ46vsAjC
         Et2NXTpAMaUAYlEhVcGdguckFbP8pHsn9G0bxitG4xeTJ3MhzhbpDqfHkqcFnAU9wx5p
         IOthFEGrHMTiMYEUavyuLWc30zLB2JZihRsl46wifZNTbl+RxT0PL+5hx3McYmc5lQwQ
         F0gg==
X-Gm-Message-State: ACrzQf1F6V3FZdbYaJwukmfp+IyualFgp3VbC6udqs3P3SfGgnSNW30D
        XNNs3qoKI6UjM+aLKN+bozqeZQ==
X-Google-Smtp-Source: AMsMyM6vJRkcQJOubMUTLQ3rPRqmAmsqzmIotexq3LlKl74q6mKvTOwCSRfnQPDG7o68l2G984cvVg==
X-Received: by 2002:a63:450c:0:b0:443:94a1:3703 with SMTP id s12-20020a63450c000000b0044394a13703mr20116187pga.565.1667379714982;
        Wed, 02 Nov 2022 02:01:54 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id d62-20020a623641000000b005627ddbc7a4sm7944965pfa.191.2022.11.02.02.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:01:54 -0700 (PDT)
Message-ID: <d2567709-9ce8-a49c-b073-a7d35fd2ec8f@linuxfoundation.org>
Date:   Wed, 2 Nov 2022 03:01:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] selftests/vDSO: Add riscv getcpu & gettimeofday test
To:     guoren@kernel.org, arnd@arndb.de, shuah@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
        "haocheng . zy" <haocheng.zy@linux.alibaba.com>,
        Mao Han <han_mao@linux.alibaba.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Elliott Hughes <enh@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221102081531.882149-1-guoren@kernel.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221102081531.882149-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/2/22 02:15, guoren@kernel.org wrote:
> From: Guo Ren <guoren@kernel.org>
> 
> Enable vDSO getcpu & gettimeofday test for riscv. But only riscv64
> supports __vdso_gettimeofday and riscv32 is under development.
> 
> VERSION
> {
>          LINUX_4.15 {
>          global:
>                  __vdso_rt_sigreturn;
>                  __vdso_gettimeofday;
>                  __vdso_clock_gettime;
>                  __vdso_clock_getres;
>                  __vdso_getcpu;
>                  __vdso_flush_icache;
>          local: *;
>          };
> }
> 
> Co-developed-by: haocheng.zy <haocheng.zy@linux.alibaba.com>
> Signed-off-by: haocheng.zy <haocheng.zy@linux.alibaba.com>
> Suggested-by: Mao Han <han_mao@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Elliott Hughes <enh@google.com>
> ---
>   tools/testing/selftests/vDSO/vdso_test_getcpu.c       | 5 +++++
>   tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 3 +++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> index fc25ede131b8..1e474f406a87 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> @@ -14,8 +14,13 @@
>   #include "../kselftest.h"
>   #include "parse_vdso.h"
>   
> +#if defined(__riscv)
> +const char *version = "LINUX_4.15";
> +const char *name = "__vdso_getcpu";> +#else
>   const char *version = "LINUX_2.6";
>   const char *name = "__vdso_getcpu";
> +#endif

name is same in both cases. Move it out of ifdef.

>   
>   struct getcpu_cache;
>   typedef long (*getcpu_t)(unsigned int *, unsigned int *,
> diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> index 8ccc73ed8240..e411f287a426 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
> @@ -27,6 +27,9 @@
>   #if defined(__aarch64__)
>   const char *version = "LINUX_2.6.39";
>   const char *name = "__kernel_gettimeofday";
> +#elif defined(__riscv)
> +const char *version = "LINUX_4.15";
> +const char *name = "__vdso_gettimeofday";
>   #else
>   const char *version = "LINUX_2.6";
>   const char *name = "__vdso_gettimeofday";

Rest looks fine.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
