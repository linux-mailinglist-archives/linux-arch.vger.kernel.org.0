Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41F72D50E
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 01:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjFLXkw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 19:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbjFLXkw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 19:40:52 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296891BC
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 16:40:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51873e1d564so144039a12.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 16:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686613248; x=1689205248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0plznu46M2amPYKPK8ZShoxVxxLpYp87ml9xhcEannU=;
        b=iylhla0TLJOHJ7YHwNZvblc32iC04Dj2fukw4IkvwHF6HOMdTOBMVkcBA6f0ioZOlq
         rP9W8XD2DgUW8AGMnhwikHTLgo4yq4AH3DMAqkVEfIKvlnfgrQlROk9ENg72G+8niOmB
         UH58ThMEnrXe9q6wdezMeMbOrDO46P0rcOameor6+BkRe2IDTqwNRD4KK5fOIp1LEH0m
         EFRJu63MX5e/S1O2nwL9Kx9x9i2CwgvbZ59shdEyiPkz1YdtkA6tkVvCi1c2PAh+uolg
         OrhL54V41Zt8LZ5Tm00jRMetnsCUQtziE04+Is7tQQ3zgf0/gvheGbK4tFFfA8Ax46l8
         w4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686613248; x=1689205248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0plznu46M2amPYKPK8ZShoxVxxLpYp87ml9xhcEannU=;
        b=kxIC1Wvb2IDL4L69nYaZ8GlzXRTjC5RyeZyvqJ9KmPbVwVlRlQRvasrcJp+2YuF3w+
         JgQfcBudALugJ/sBzTd5b8tgnVJ7xUgxR2ngg4FGEJMiolfo6H9PxUJZAZ0S0Do1bGsj
         LMfs3zd5hSl9CqxbN4Hp1ZcftbbcyNYuVxpiD5u7px10qNqikC6AR6zH2W35RErGwRAp
         1oAyjm33jQQNFnSlMmjkWdFOUuaHULhfPGMdF/EMok2Y3nOyG7faTY1KtVkqK/dGq1Tg
         ncGkWIZLUm5m/Ug04MdiRWJnC3QfJ5JUGBuB8cQTT6ZhteNeaY74cMuSCKyeK4ZWgXgW
         UFfg==
X-Gm-Message-State: AC+VfDzVXlLlkYepcyDz1thnt3zXxjWHs2zNy+6IekozXCHmoUjIL0YS
        hcbMw/Hr/zYJVMel+KED9GOvBQ==
X-Google-Smtp-Source: ACHHUZ77MZwbIKwyjdjJH4wSPQIhZQXuxZ5o4bsqJJFoMk2Jtj2w5fhlm9UpqhqLOuDiov0zmcH6TA==
X-Received: by 2002:a17:907:a411:b0:96f:2315:29fe with SMTP id sg17-20020a170907a41100b0096f231529femr11761796ejc.0.1686613248692;
        Mon, 12 Jun 2023 16:40:48 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
        by smtp.gmail.com with ESMTPSA id w8-20020aa7cb48000000b0051632dc69absm5598949edt.86.2023.06.12.16.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 16:40:48 -0700 (PDT)
Message-ID: <50955a66-f8eb-9999-1685-763c3f2ceda0@linaro.org>
Date:   Tue, 13 Jun 2023 01:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 4/7] mips: update a reference to a moved Arm Document
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <20230519164607.38845-1-corbet@lwn.net>
 <20230519164607.38845-5-corbet@lwn.net>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519164607.38845-5-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19/5/23 18:46, Jonathan Corbet wrote:
> Arm documentation has moved to Documentation/arch/arm; update a reference
> in arch/mips/bmips/setup.c to match.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>   arch/mips/bmips/setup.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

