Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9586F17DF
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 14:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbjD1MZ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 08:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345781AbjD1MZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 08:25:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28695BB9
        for <linux-arch@vger.kernel.org>; Fri, 28 Apr 2023 05:25:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f1763ee8f8so67790225e9.1
        for <linux-arch@vger.kernel.org>; Fri, 28 Apr 2023 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682684748; x=1685276748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCZD7/skKxELiLiQ/Kgtq9xL2gK3ugZhkE8UlBHv94Q=;
        b=uUgsJRet2rXqZzO39tKpNe1PPCmGNTTEXDP7+XoXX1WhwC7n6SFii4fWBlBlWhWUDh
         Cnf3M/2voFfRkjanUwYgCBz2zCXELwRizuCZBuFMvKdhaRKabEg5/MXCGrzW+C6B6KJw
         mX+2F7apsDTDVgcLM6qxspDdmRl8vNGYIGdV09Q4ePTOB33MExIIjbOChffFbCNI8qoT
         IZdbIkrfFL1rjadYFEWADsvwPALuUxud15Tap5wnQgVssXZJAIpGqFxnqiCbs9SjDET1
         C7TPKyeBELoVR5mTyMPLZTyX9Clh0qZRpKcsOhjsNYZ73uRCw0qLpuqVYlgdzd7Fkeow
         60Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682684748; x=1685276748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCZD7/skKxELiLiQ/Kgtq9xL2gK3ugZhkE8UlBHv94Q=;
        b=hL4ZgXwC9e2wpbwHCfHLsc6uZF/bPB0XFnCRCSdrnR+8CWd6dz8yA4jmKK2sPeFQSd
         i/KmAFrY4v1YD7VHTLmC2SuLnKjiOi1mJU2HTsKCw4mcQfE8EQA9XQt6QEhRZu6I4ngD
         7OKhgWzpCqEwqI0p3Pnacg9px4UguGmNHGmXlx4U6tMYTcA+aRnOwdGsG5tvXkg0rfz3
         Z03E6NLiOW3+TeDrWMeG+V7QgDkT46qUDaCKAp21SLolaXLCtT2J8/L3r8hX4A9PqDoI
         tmTHQKhSA3qQkyCEPgq+P+nmPSic3qlyzyVU5kywiQ/vjUan5Yd9drx/4CgSxFytvX6W
         csug==
X-Gm-Message-State: AC+VfDyLIF94Ui9uiko5CrNbjGHtfd2BSAh6G1KUeDkfMVBt3dxGXa9u
        tuB71uH5g+B56u5mU6q06EvyRg==
X-Google-Smtp-Source: ACHHUZ7jrGfG5E3rVbh1rlyewG/33jkn7z+iNaDOwZOeE24lokjSTMXbm+oex+abJk6U0bKResFC0Q==
X-Received: by 2002:a05:600c:d7:b0:3f1:93c2:4df6 with SMTP id u23-20020a05600c00d700b003f193c24df6mr3758700wmm.12.1682684748414;
        Fri, 28 Apr 2023 05:25:48 -0700 (PDT)
Received: from [172.23.2.142] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id i40-20020a05600c4b2800b003ee6aa4e6a9sm27367821wmp.5.2023.04.28.05.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 05:25:47 -0700 (PDT)
Message-ID: <00e293fc-e5f7-d451-5547-def284ac2214@linaro.org>
Date:   Fri, 28 Apr 2023 14:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/7] GenieZone hypervisor drivers
Content-Language: en-US
To:     Yi-De Wu <yi-de.wu@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230428103622.18291-1-yi-de.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 28/04/2023 12:36, Yi-De Wu wrote:
> This series is based on linux-next, tag: next-20230427.
> 
> Changes in v2:
> - Refactor: move to drivers/virt/geniezone
> - Refactor: decouple arch-dependent and arch-independent
> - Check pending signal before entering guest context
> - Fix reviewer's comments
> 

Please explain what is Geniezone, where we can find it, what's the plan
for open-sourcing it etc.

That's what cover letter is for.

Best regards,
Krzysztof

