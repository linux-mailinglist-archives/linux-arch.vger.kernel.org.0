Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73080676C69
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 12:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjAVLo5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Jan 2023 06:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAVLo4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2023 06:44:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A9D1E9EE
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:44:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so8432266wrz.12
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9d3PHM1i18b1wVBT1Cbc8b3/F4tYcjxcOJc7IXM78Rc=;
        b=K0ogjQy2dBIWpRyp2G9Qo7zgLe2LmkcCsc+/SJfNrUrZoMYVAXj6EBfqqAOZO90TQV
         8dFrqB0UpP/FL5YLyW8DaYdSIo3BYZ6jWVhbXvikqhFRDlopOedRj2dISYn4JPdf7JlA
         KzsoTNkcC/dbTzg7fLyddp/61eGwSN2pamhISQfxDpHBGfDt3yL8nejAvTR/KmsWSzBc
         ZctPEB9rXXjRaaTZa8ZJCKpvyefetvL+86WKhHd1yI+EgTIvtBe9bo4ok2He/FWqHs64
         qAR5wQT5taDHiDtKTbA0eAIGDoMBI78QD27Fart3ivhlaqTZYemt5SCMPsmsKsWIv5F1
         gxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9d3PHM1i18b1wVBT1Cbc8b3/F4tYcjxcOJc7IXM78Rc=;
        b=Ft6DUMGR15PRMoeQcj0M10Z1r0B58Pb1TdvaYeMddobf38wPxv7hQYxQenIobV00qC
         1SrtY/XUdFHuyIICaGwBHH8d+AZab6YaWQEMmo3pjdZUQovwhXYVnJealeG4gD9S7ev1
         EhnrmRb90p9vko6uEfKl9r086H3qHB5dGX3a/+NdqMNbHJgjz/GAAASx8XSevhKANjcI
         2UYW+o1f2DVOdgCEBWgJsI8M+5FEIQXLb2Y01uSx4gqWRaHYPpYr91BVb9P4ZJa7KZ0G
         QsTmiIHG0zrn87A5kfBNbpFjEWfQocmLzmoiBCDeERPvLJqVgxNVABSOYRpUlvn3tK1n
         1aQg==
X-Gm-Message-State: AFqh2kpEURQ/J0yKiInegOcljzwWsfv7KEIJi80XQc7j/dLmsCblmsEV
        kZYedPK2c9GTRniO/6AGC4GQ7g==
X-Google-Smtp-Source: AMrXdXu83lehx7RbHAkRbhG1oMGJmZelEHb0lgNU+pigubgLCdZ9/atDxUOwXiCGtf72XF5Pmi0c8Q==
X-Received: by 2002:a05:6000:1f14:b0:2bb:5adc:9f92 with SMTP id bv20-20020a0560001f1400b002bb5adc9f92mr18054855wrb.50.1674387892997;
        Sun, 22 Jan 2023 03:44:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0027323b19ecesm2830431wrx.16.2023.01.22.03.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:44:52 -0800 (PST)
Message-ID: <d4d998ee-1532-c896-df25-195ec9c72e3f@linaro.org>
Date:   Sun, 22 Jan 2023 12:44:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 02/31] Documentation: Add binding for
 kalray,kv3-1-core-intc
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
 <20230120141002.2442-3-ysionneau@kalray.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120141002.2442-3-ysionneau@kalray.eu>
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

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).


> 
> Add documentation for `kalray,kv3-1-core-intc` binding.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---
> 
> Notes:
>     V1 -> V2: new patch
> 
>  .../kalray,kv3-1-core-intc.yaml               | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml
> new file mode 100644
> index 000000000000..1e3d0593173a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-core-intc.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-core-intc#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray kv3-1 Core Interrupt Controller
> +
> +description: |
> +  The Kalray Core Interrupt Controller is tightly integrated in each kv3 core
> +  present in the Coolidge SoC.
> +
> +  It provides the following features:
> +  - 32 independent interrupt sources
> +  - 2-bit configurable priority level
> +  - 2-bit configurable ownership level
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: kalray,kv3-1-core-intc

Blank line between each of these,

> +  "#interrupt-cells":
> +    const: 1
> +    description:
> +      The IRQ number.
> +  reg:
> +    maxItems: 0

??? No way... What's this?

> +  "kalray,intc-nr-irqs":

Drop quotes.

> +    description: Number of irqs handled by the controller.

Why this is variable per board? Why do you need it ?

> +
> +required:
> +  - compatible
> +  - "#interrupt-cells"
> +  - interrupt-controller

missing additionalProperties: false

This binding looks poor, like you started from something odd. Please
don't. Take the newest reviewed binding or better example-schema and use
it to build yours. This would solve several trivial mistakes and style
issues.

> +
> +examples:
> +  - |
> +    intc: interrupt-controller {

What's the IO address space?


Best regards,
Krzysztof

