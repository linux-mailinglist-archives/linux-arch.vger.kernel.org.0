Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DEA67DF4F
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 09:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjA0IdE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 03:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjA0IdC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 03:33:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8299519F2A
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2023 00:33:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4886018wmb.2
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2023 00:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNDzzLve1QZpQMH586QRx6794jByHtxqf4nlX323e/M=;
        b=wr/faRojnYtopasMYIZ7X5nKWJvOwIFDt6H3ZwcJFlrglXBSFYxDO20pRk+2obypGw
         lp6sclR+UR+EHorIMkUXCu8LDlgnas4SNpc653G4SjJSFR1rb/7X/I3yuiJXCETM3EDr
         83A6hXp1UGKXUu8nI40pGKALkiqAnnJSwTfoe6hyBxm7uiUuR3xsh9+osuJIJb55MYPm
         xywXnOVLUbpg5jrSC6ADmSw5oxb91f64hNGPIz4Cicrdjt0iCGcC4T9y2P5LyHewgFxn
         l/6Pay8nOL53WWvAYGjjlZhjdln3wsBScLS8KjDf2HPqdzZ2rbkWVTiShk6sY4zXS+1N
         4Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNDzzLve1QZpQMH586QRx6794jByHtxqf4nlX323e/M=;
        b=MLHQVppgzf/8N6UQkEYY9iIMB6d739mnGiwN3IJIiR7F8U639Pijhz+GSUxUhx2YTd
         vhnNMvFqk5NUK5WD9U8C6s7kA/yCIDo60tVjRiQt2fhLIhnQZuU0jYwIM8+7nIaRmvhM
         UnM6b0H2oi8FyCge+XUKYQhX9SerMd1PzQoW0PYWqeRd18UeYA2zF5FJb94vtaPV+/d0
         FOYB0xn7Y0l4tN7EZ5YJ51+b2wQpjDX0GJcsB+N6JD2Fv4CChJqlJkrE5WVWSNFM2ckt
         02zWJuO4bF+sbDcZ3C6bIPERc539tWFaR6Tx9TOq6o4/SFLsVk1ac9ohwkpRCy0kUBDr
         5X4g==
X-Gm-Message-State: AO0yUKWh3nkQ4hnf/9jE8S9bfe+0mJLaeh9+tW5/jmgrsOpMJ6aGL7SP
        9122V1/gxiUvEkLzEv+BeN9XqQ==
X-Google-Smtp-Source: AK7set8AUVYQ3DMEqB5mb5eVqgQNd79NxSGC2QpLaYfkKjZyelI9gwbfI++aOYEpI1mjO/SKh2lGNQ==
X-Received: by 2002:a05:600c:1caa:b0:3dc:4042:5c30 with SMTP id k42-20020a05600c1caa00b003dc40425c30mr177420wms.10.1674808379017;
        Fri, 27 Jan 2023 00:32:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d10-20020adffbca000000b00287da7ee033sm3318241wrs.46.2023.01.27.00.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 00:32:58 -0800 (PST)
Message-ID: <348c3416-be44-b912-98ef-7f394bd408c0@linaro.org>
Date:   Fri, 27 Jan 2023 09:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v2 02/31] Documentation: Add binding for
 kalray,kv3-1-core-intc
Content-Language: en-US
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
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
        Alexey Dobriyan <adobriyan@gmail.com>,
        Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-3-ysionneau@kalray.eu>
 <d4d998ee-1532-c896-df25-195ec9c72e3f@linaro.org>
 <20230126161032.GH5952@tellis.lin.mbt.kalray.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126161032.GH5952@tellis.lin.mbt.kalray.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 26/01/2023 17:10, Jules Maselbas wrote:

>>> +  reg:
>>> +    maxItems: 0
>>
>> ??? No way... What's this?
> This (per CPU) interrupt controller is not memory mapped at all, it is
> controlled and configured through system registers.
> 
> I do not have found existing .yaml bindings for such devices, only the
> file snps,archs-intc.txt has something similar.
> 
> I do not know what is the best way to represent such devices in the
> device-tree.  Any suggestions are welcome.

You cannot have an array property with 0 items. How would it look like
in DTS? There are many, many bindings which are expressing it. Just drop
the reg.

> 
>>
>>> +  "kalray,intc-nr-irqs":
>>
>> Drop quotes.
>>
>>> +    description: Number of irqs handled by the controller.
>>
>> Why this is variable per board? Why do you need it ?
> This property is not even used in our device-tree, this will be removed
> from the documentation and from the driver as well.
> 
>>> +
>>> +required:
>>> +  - compatible
>>> +  - "#interrupt-cells"
>>> +  - interrupt-controller
>>
>> missing additionalProperties: false
>>
>> This binding looks poor, like you started from something odd. Please
>> don't. Take the newest reviewed binding or better example-schema and use
>> it to build yours. This would solve several trivial mistakes and style
>> issues.
> I am starting over from the example-schema.
> 
>>> +
>>> +examples:
>>> +  - |
>>> +    intc: interrupt-controller {
>>
>> What's the IO address space?
> As said above, this is not a memory mapped device, but is accessed
> through system registers.

Sure, but then you cannot define a reg which was confusing...

Best regards,
Krzysztof

