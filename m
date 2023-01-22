Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452FE676C6F
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 12:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjAVLrK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Jan 2023 06:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVLrJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2023 06:47:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1080F1F5C4
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:47:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l8so7089653wms.3
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2dS08c5mDDQCSEte2hJr4AncAP49BS6JfkPW/bfJ8w=;
        b=x60lhg9Ma84/nhgHooGxFDRzaGCTbna6N3OaUhRahz7oFK/Ej2LoBvR8cIclfA+YEc
         075GAFy/Z+6wvaDI7Vtr/jDBAOmZuEsq7tCWLkeLwtI7bPex58Pm6EjC3JMzpJ+57MIn
         5T0guh+4iRpkxNWNtfXUGJ63DWXecs+xrEq2+1kGSbEQy5zzLYNSKRU3hy9nS/WC9k2z
         Gw7aqPry1lPoo9c8A0gEHtEbhMhcD45BAJ6wFHyQcSt+myMtZ/qlgR2AaS8964Zn2P4p
         UWrCS1Ld/U0RPkqYhhWftQwPG1iq5ZpzAjpwY1XCjBtkkZztPouO1E9exFAGh5clvnfx
         PSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2dS08c5mDDQCSEte2hJr4AncAP49BS6JfkPW/bfJ8w=;
        b=iOV9fSnDYgnit3dvave5uuKMsFK9yvT5R6wZLOSUm7fvBvAOig2r+w6ni8sf3cd06h
         qBE4gtrqcY/9+nFfsV5Cb2cPIV1lHTCRj3MsKyBKa2YkXXCf1QrEYgqqtuLWqkjhfmS6
         FWL9N0Qd5JB/x/4O1l0TTRy7XNSJqM3YIQXsr7TVfuTuY2ag7lWhMhN49QD61OAfLgwG
         zsUg/ymo/AhzhlGx3LYjomXGiWeGojPHLySBhohJGUPG2QJwR6KStViI3DR4AE1B7Qye
         JoEcJ9Bji3SKFUh0F7I57fXV15CDwI6tZbo1wuVjkZPqBfN11baxbLO6mnpD9BtWYSh8
         s3Bg==
X-Gm-Message-State: AFqh2kpuM74BdtgCvo/9JLvPHSI2aTobUCSLhhnNF1B/EUKZRBoUQEbu
        WHs8WJWqDSKWsxAKxr2E8am39w==
X-Google-Smtp-Source: AMrXdXvv5SOq8oLh4MHQyQrfcxkhDTk8DLHjQASO2lJraohGjZ9veTwuZ0pwUHGY71DEX8EYBAct8g==
X-Received: by 2002:a05:600c:4f82:b0:3db:25a0:ca5b with SMTP id n2-20020a05600c4f8200b003db25a0ca5bmr11762781wmq.37.1674388025485;
        Sun, 22 Jan 2023 03:47:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003db0b0cc2afsm8452351wmq.30.2023.01.22.03.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:47:04 -0800 (PST)
Message-ID: <faa9ee85-60d7-6495-2376-384946720f60@linaro.org>
Date:   Sun, 22 Jan 2023 12:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 03/31] Documentation: Add binding for
 kalray,kv3-1-apic-gic
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
 <20230120141002.2442-4-ysionneau@kalray.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120141002.2442-4-ysionneau@kalray.eu>
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
> Add documentation for `kalray,kv3-1-apic-gic` binding.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> ---

All the comments apply here and to all your other patches - wrong
subject, missing blank lines, missing additionalProperties, missing
tests (patches were for sure not tested as you can see from bot's
answers) etc. Really, please start from scratch on example-schema.

> 
> Notes:
>     V1 -> V2: new patch
> 
>  .../kalray,kv3-1-apic-gic.yaml                | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-gic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-gic.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-gic.yaml
> new file mode 100644
> index 000000000000..7a37f19db2fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-gic.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-apic-gic#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray kv3-1 APIC-GIC
> +
> +description: |
> +  Each cluster in the Coolidge SoC includes an Advanced Programmable Interrupt
> +  Controller (APIC) which is split in two part:
> +    - a Generic Interrupt Controller (referred as APIC-GIC)
> +    - a Mailbox Controller           (referred as APIC-Mailbox)
> +  The APIC-GIC acts as an intermediary interrupt controller, muxing/routing
> +  incoming interrupts to output interrupts connected to kvx cores interrupts lines.
> +  The 139 possible input interrupt lines are organized as follow:
> +     - 128 from the mailbox controller (one it per mailboxes)
> +     - 1   from the NoC router
> +     - 5   from IOMMUs
> +     - 1   from L2 cache DMA job FIFO
> +     - 1   from cluster watchdog
> +     - 2   for SECC, DECC
> +     - 1   from Data NoC
> +  The 72 possible output interrupt lines:
> +     -  68 : 4 interrupts per cores (17 cores)
> +     -  1 for L2 cache controller
> +     -  3 extra that are for padding
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: kalray,kv3-1-apic-gic

Missing reg

> +  "#interrupt-cells":
> +    const: 1
> +    description:
> +      The IRQ number.
> +  interrupt-controller: true
> +  interrupt-parent: true

Drop, should not be needed.

> +  interrupts:
> +    maxItems: 4
> +    description: |
> +     Specifies the interrupt line(s) in the interrupt-parent controller node;
> +     valid values depend on the type of parent interrupt controller
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +  - interrupt-parent
> +  - interrupts
> +
> +examples:
> +  - |
> +    apic_gic: interrupt-controller@a20000 {
> +        compatible = "kalray,kv3-1-apic-gic";
> +        reg = <0 0xa20000 0 0x12000>;
> +        #interrupt-cells = <1>;
> +        interrupt-controller;
> +        interrupt-parent = <&intc>;
> +        interrups = <4 5 6 7>;
> +    };
> +
> +...

Best regards,
Krzysztof

