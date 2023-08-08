Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D707743B6
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjHHSId (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Aug 2023 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjHHSIO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2023 14:08:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6326163D60
        for <linux-arch@vger.kernel.org>; Tue,  8 Aug 2023 10:09:27 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so94876571fa.2
        for <linux-arch@vger.kernel.org>; Tue, 08 Aug 2023 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691514565; x=1692119365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0zLEburh9ZFfE548pNOj7q2UOj2GGR4k/WQno4jj70=;
        b=S+AucvGTkY09UO3Bc6ry7Q5Xi0gdFFTpRS0Cj/AXdz4163H9qhmfp7v+r+Hm29wCqf
         O2qWaNHdBntMCRXP2W9ZpC1f6s/5X6AVSpb0m6Uu9xbPGipIT5cyztACYuJCQS1sL1Ht
         XA/q56Djn16kH9WYzmZpYg+vUw5FGv8NL9Pg3IdmHRv68sxOt9mXJTsMK735enVChD2I
         wC8D37wrVs4cUJQTYexrtcycng+M8WwHLfFEpPswymOX8S/aWWg7CU3C2fn7Kpgi3SCc
         B/YxdfU53iumsVj7ualt/8a6yukVkAN5HjsSdz2eRgzGEupRHSavUv73cW4BS9bYosXm
         urFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514565; x=1692119365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0zLEburh9ZFfE548pNOj7q2UOj2GGR4k/WQno4jj70=;
        b=dFoc+HMGfrJQ0MnB13INPgRWh4DWXEDDL6oIx1tO3LIBI49pWoCmEGpimqNR3aHKn3
         jP4GOiX/3AgnT79Rn900E1L6/S8rF39mvGxea2qASl6NUNTA0AugophrpuCzrV7Luj2N
         jYV0h8qs/2N35WTnihJrnosCUHcUKYm6suHD5oEIEKn/AYNemlzVkjSYqlR2gaOUgJoD
         FjRS99gLCSc2iERQhYFBYzH2ZCB/HCK/osa9aT3k0z4aVp74F+/nECQHjhSI8BW6V9EI
         BtlB33QWZtwcJQeKgmxIk+8B4zhOg4+DDiufi2Xxy84uyp8bWp+VE6BvYeCdNMXiDhpe
         /WxA==
X-Gm-Message-State: AOJu0Yxhm9wH5GFBksZlhmvfaD67yEpYfB2vun8amLIFp6bqg/4HU8rb
        tbwSabSKO3+w15nsSB+QzQhqpDxeCONNYbLBheE=
X-Google-Smtp-Source: AGHT+IENaoLogdmwEquxviK7pRALZnOeydEhILSaohDlqrXatiaCu5M9MfM3jQOl2xSE+z2HLZbssA==
X-Received: by 2002:a05:600c:2213:b0:3fe:2b76:3d7 with SMTP id z19-20020a05600c221300b003fe2b7603d7mr9376833wml.10.1691487533357;
        Tue, 08 Aug 2023 02:38:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.177.253])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c218d00b003fe2bea77ccsm13219267wme.5.2023.08.08.02.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:38:53 -0700 (PDT)
Message-ID: <60ac32e8-5fea-84d4-ff3f-f09e6f8ad499@linaro.org>
Date:   Tue, 8 Aug 2023 11:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] mips: replace #include <asm/export.h> with #include
 <linux/export.h>
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230807153243.996262-1-masahiroy@kernel.org>
 <20230807153243.996262-2-masahiroy@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230807153243.996262-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/8/23 17:32, Masahiro Yamada wrote:
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.
> 
> Replace #include <asm/export.h> with #include <linux/export.h>.
> 
> After all the <asm/export.h> lines are converted, <asm/export.h> and
> <asm-generic/export.h> will be removed.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   arch/mips/cavium-octeon/octeon-memcpy.S | 2 +-
>   arch/mips/kernel/mcount.S               | 2 +-
>   arch/mips/kernel/r2300_fpu.S            | 2 +-
>   arch/mips/kernel/r4k_fpu.S              | 2 +-
>   arch/mips/lib/csum_partial.S            | 2 +-
>   arch/mips/lib/memcpy.S                  | 2 +-
>   arch/mips/lib/memset.S                  | 2 +-
>   arch/mips/lib/strncpy_user.S            | 2 +-
>   arch/mips/lib/strnlen_user.S            | 2 +-
>   arch/mips/mm/page-funcs.S               | 2 +-
>   arch/mips/mm/tlb-funcs.S                | 2 +-
>   11 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

