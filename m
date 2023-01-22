Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72643676C84
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 12:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjAVLvr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Jan 2023 06:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjAVLvn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2023 06:51:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246431F5DE
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:51:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk16so8444073wrb.11
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QW4gcfTBDAxCEJmp81ra89ieKaIa7EaBAPXtJreoq+w=;
        b=P/0Gb1PCZZIXYu0NV1Ove+/unx34oDiuMeeBcuZho836SMBMbqREXW49kGJekeeYeP
         fzP+MyKIYe2eiBQ7rukcC1sC5RGH0lkRTyftvfk7x8nkdmK2b31SghHLBEmZzx4NBpCj
         ggDUwzAEC9l9h8CA8lfbAlDSU5T0XYkDKHhlfhfERi9QxU9HQhyxryOH1cbFhtWNtsiP
         k2z2Kh4W04yGAltLW5C0VK+2W2aIXIipP3jMn0F9n1UToYwxL/bNIkx8LTwm1LCYrHf+
         MFUwUoTz9F7H8+vCFHV6UacV3C7BlRYLfN5vIHptYZ9r+5wxB7SAjdxVuc7IX5uB+nMX
         QP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QW4gcfTBDAxCEJmp81ra89ieKaIa7EaBAPXtJreoq+w=;
        b=n04dyldIvaJhPKv6hFfEt6bSNpgiVjNu4evN6K78UGeFI8dkyM4W9UvLwhy3A8qnJH
         M62DTUmkzJ2OHZ2bF/GhAQXDySv4igbtrYNpeSOq9klPVcSf1iRbsrCs84CaC9Duhp+m
         1Js9h6HijgivwOLLAd4p3jD63dxyzPNBdnUQ7X7lB7ByzqaIbI0d5pQpLpC9eD28pMph
         JHtqWwBARIMvV86ESa2DT6XZyQyQ8HmV3oKyxPsI88E6fJSywUg3P4SSALOqJC92jtgL
         mDFh4sfc6oVNUmwWDD19/lRdk2eQ20WqwIi2m+IrqR8QIcDqfdcJ0Ig+dt8B1kXmBJ/W
         EyoA==
X-Gm-Message-State: AFqh2kr7FlZOAnwH4MiQvbGUvONjM1iji1ZOExq9k8qCzY11a7mGLF3U
        qv7LFZM9Dot0V3UmYQOBgFMaLA==
X-Google-Smtp-Source: AMrXdXu3komgmJz3v4UQ6DFMLR2KXaq2N92Bqckcvh43HhbdmlU07p0tmzT8+sQ+olcM02A9d6D9gA==
X-Received: by 2002:adf:f501:0:b0:2ba:dce5:ee28 with SMTP id q1-20020adff501000000b002badce5ee28mr17537961wro.18.1674388299288;
        Sun, 22 Jan 2023 03:51:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d6787000000b0025e86026866sm3554309wru.0.2023.01.22.03.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:51:38 -0800 (PST)
Message-ID: <d02b81ab-fa72-6005-79e9-249225483364@linaro.org>
Date:   Sun, 22 Jan 2023 12:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 07/31] Documentation: Add binding for
 kalray,kv3-1-pwr-ctrl
Content-Language: en-US
To:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        =?UTF-8?Q?Marc_Poulhi=c3=a8s?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-8-ysionneau@kalray.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120141002.2442-8-ysionneau@kalray.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20/01/2023 15:09, Yann Sionneau wrote:
> From: Jules Maselbas <jmaselbas@kalray.eu>
> 
> Add documentation for `kalray,kv3-1-pwr-ctrl` binding.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
> 
> Notes:
>     V1 -> V2: new patch
> 
>  .../kalray/kalray,kv3-1-pwr-ctrl.yaml         | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/kalray/kalray,kv3-1-pwr-ctrl.yaml

All the usual comments plus - wrong directory. Power controllers go to
respective power directory.

> 
> diff --git a/Documentation/devicetree/bindings/kalray/kalray,kv3-1-pwr-ctrl.yaml b/Documentation/devicetree/bindings/kalray/kalray,kv3-1-pwr-ctrl.yaml
> new file mode 100644
> index 000000000000..968674bb0c63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/kalray/kalray,kv3-1-pwr-ctrl.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/kalray/kalray,kv3-1-pwr-ctrl#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray cluster Power Controller (pwr-ctrl)
> +
> +description: |
> +  The Power Controller (pwr-ctrl) control cores reset and wake-up procedure.
> +
> +properties:
> +  compatible:
> +    const: kalray,kv3-1-pwr-ctrl
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    pwr_ctrl: power-controller@a40000 {
> +        compatible = "kalray,kv3-1-pwr-ctrl";
> +        reg = <0x00 0xa40000 0x00 0x4158>;

I really doubt that you tested it... Examples are not run with address
cells 2.


Best regards,
Krzysztof

