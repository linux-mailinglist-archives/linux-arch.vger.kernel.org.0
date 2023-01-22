Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6F676C76
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 12:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjAVLtk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Jan 2023 06:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjAVLtj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2023 06:49:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923C316AC0
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:49:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bk16so8441758wrb.11
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L18XUoVuVYI0pnqHwuAZ/a/gl46rC1ac5Z5pGu4tjjA=;
        b=caIlICVgjiM2KQmWSw2+dwCmFwH/QmHP5Tpt6H6wVsFqVFanIJ1vuRkXD5LMYCDALE
         NRjmF+0baehzfnLLnyNncgVe/LMpVF+yHU61SKAbBoH7z61KGzW5m7flF/bFqihPw1Fn
         O2fP7zc3nkMy81LxNCpHIWtu94zfu5UQvaOFSsNE8v5AYfQqfr8/s8K8Erb8fkRN+yAG
         wkyY17RV1LAoGfa7M6MaWtFsVRYyBEJ/Cn1lnFbJ+7C3TkgZU6XRz0KkmJz40bv2YJcl
         sWZRDoQaWXDOf5NedqV2uevyts9HBVC/g4grs5Il5oF6YrOPf4Yvjvay3LwHgph5/uVF
         hkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L18XUoVuVYI0pnqHwuAZ/a/gl46rC1ac5Z5pGu4tjjA=;
        b=n3GOHtlMe70svB23luqCnz5UDweKGgXEOM1U6QkCjmJyS3+TqW2bQQKxREs6T5R58l
         XmzQArLf+gW4mWZn8Y+eyahxFct1Hf7iKGJSyKe7T313ZA7PRr+f1WqJxx46FwoDfwBh
         IrQzt9rVyWRnBHtB9MghArA/aU33k2YROLcwP8sgViLIiQ7N8fMl2jXubyGc279rOmgC
         bv3I6SmQ65eESaDlPlKEdmuZg3xztuBGPg/CUHckBYEZj9De8K4LLWg3kVGGnIoc6Cr/
         mNopQntnWlM98BzMc9m4xx+FcaVTCbzI7gb8HuNJKZZWhB3l8kUfS0iMFYjqygGRObhU
         DlOQ==
X-Gm-Message-State: AFqh2kpu1b0yRtO+P9I/VpJeyY76iwcWQ3BwknNyEeDj1L2+J6mcL8hW
        0t5l5Ac2ht8ibWjDnQwWqj2dSQ==
X-Google-Smtp-Source: AMrXdXuO4A8xyx6+67tnt5vSccGnQfMst13iHm3i0RgTmN8zIeWyW0hP20D/R/sapznzyBbbSLIUpw==
X-Received: by 2002:adf:f606:0:b0:24b:b74d:8012 with SMTP id t6-20020adff606000000b0024bb74d8012mr17321312wrp.18.1674388176056;
        Sun, 22 Jan 2023 03:49:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m8-20020adfa3c8000000b00236545edc91sm1740479wrb.76.2023.01.22.03.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:49:35 -0800 (PST)
Message-ID: <c8f7294d-6522-40f6-7923-c379ec8ca6bb@linaro.org>
Date:   Sun, 22 Jan 2023 12:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 05/31] Documentation: Add binding for
 kalray,coolidge-itgen
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
 <20230120141002.2442-6-ysionneau@kalray.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120141002.2442-6-ysionneau@kalray.eu>
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
> Add documentation for `kalray,coolidge-itgen` binding.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>

The same comments apply plus more...

> ---
> 
> Notes:
>     V1 -> V2: new patch
> 
>  .../kalray,coolidge-itgen.yaml                | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-itgen.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-itgen.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-itgen.yaml
> new file mode 100644
> index 000000000000..47b503bff1d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,coolidge-itgen.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license. Checkpatch should complain about this - did you run it?

This applies to all your other patches (both, run checkpatch and use
proper license).


> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/kalray,coolidge-itgen#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray Coolidge SoC Interrupt Generator (ITGEN)
> +
> +description: |
> +  The Interrupt Generator (ITGEN) is an interrupt controller block.
> +  It's purpose is to convert IRQ lines coming from SoC peripherals into writes
> +  on the AXI bus. The ITGEN intended purpose is to write into the APIC mailboxes.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: kalray,coolidge-itgen
> +

So why suddenly this patch has proper blank lines...

Missing reg.

> +  "#interrupt-cells":
> +    const: 2
> +    description: |
> +      - 1st cell is for the IRQ number
> +      - 2nd cell is for the trigger type as defined dt-bindings/interrupt-controller/irq.h
> +
> +  interrupt-controller: true
> +
> +  msi-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +  - msi-parent
> +
> +examples:
> +  - |
> +    itgen: interrupt-controller@27000000 {
> +        compatible = "kalray,coolidge-itgen";
> +        reg = <0 0x27000000 0 0x1104>;
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +        msi-parent = <&apic_mailbox>;
> +    };
> +
> +...

Best regards,
Krzysztof

