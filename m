Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D912A676C90
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 12:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjAVL5N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Jan 2023 06:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAVL5L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2023 06:57:11 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84522125BF
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:57:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id y1so3972928wru.2
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckWviSxANZfcro+bBRfyc+cenkmtjOkiW7r6SzucWlg=;
        b=rVyqAJqcbEVO2mLYQVAhfnqaxyKeML/dcpxmRaA391AWy18uZOcTusGjMi44ncpTql
         vRUlbx31k3vofUNP4vsPJVAi8lmlvkVa9EF7D+g1STXssK/sO9udFfYn+8KZstXrK7qh
         xd8yLliT4+F15t5bWD1hE7T1GDf9FwKdq6LRDIE6AKZfPND9W8ihbB18IBlG77AI1lAD
         h2yHlmJaQeszTJT/hh3lV1J+dPT8wAe85E0VKkfG7d3OdVi0bTLkjAqcxHch+rOespJa
         a741p3AQgK6ZAVKTC3L2Wy3ECwJcIx3YubDD3GwhhX5WXjHjZWZq6eG8muWvlHTdzBqb
         Y8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckWviSxANZfcro+bBRfyc+cenkmtjOkiW7r6SzucWlg=;
        b=QmvEITFNL9eV3s0va/EWVeVR/OGW1zwnujcqZxljPv2RPbA55KEQ8PsH0Vh+tCN4DI
         9qWNa8icWVriYkB8nZSia5DjehFvB7URcivs6jUkb4JdDo0P1HVnrCnIVZpKGmx1VfDM
         9iK4HBo6kDE6K9af9cVpoIsMxlRzIPBazVqxnK78s7sElsH1RclUhWQljpggV7DnQm38
         nJg2FZokacAopUCZlCDdQYK7QEvi6a1YG/Q2mfYgaRpZzn19zEGCmQD8EQYD/+YV6zTu
         5CsBipnlwMZQk09Damlwa16t8btqZuWAm7SFNmh3fTfjtO3ep6JqwM78NZXGuGAtrjr6
         0fog==
X-Gm-Message-State: AFqh2kogdse492A6wO9X9IpVrB1eHScnAGjQo52Zh2HOBqAD7VhEKaAf
        qBQUtl1DCPmgg6LS6S8O0v0tUQ==
X-Google-Smtp-Source: AMrXdXvUmSo3jcsu3xojfTukvrhpzxz6e7Xp9tLFomGzgShSJjiyaBJUGl7NNs6LSU7eztbkOMG0ag==
X-Received: by 2002:a5d:5224:0:b0:2bd:bbf7:1f87 with SMTP id i4-20020a5d5224000000b002bdbbf71f87mr20620225wra.60.1674388629088;
        Sun, 22 Jan 2023 03:57:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d16-20020adfef90000000b002b9b9445149sm3306165wro.54.2023.01.22.03.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:57:08 -0800 (PST)
Message-ID: <3043df6d-8cc1-6969-09d4-50ad6195c924@linaro.org>
Date:   Sun, 22 Jan 2023 12:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 29/31] kvx: Add support for cpuinfo
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
 <20230120141002.2442-30-ysionneau@kalray.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120141002.2442-30-ysionneau@kalray.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20/01/2023 15:10, Yann Sionneau wrote:
> +static int __init setup_cpuinfo(void)
> +{
> +	int cpu;
> +	struct clk *clk;
> +	unsigned long cpu_freq = 1000000000;
> +	struct device_node *node = of_get_cpu_node(0, NULL);
> +
> +	clk = of_clk_get(node, 0);
> +	if (IS_ERR(clk)) {
> +		printk(KERN_WARNING
> +		       "Device tree missing CPU 'clock' parameter. Assuming frequency is 1GHZ");
> +		goto setup_cpu_freq;
> +	}
> +
> +	cpu_freq = clk_get_rate(clk);

What about cpufreq? I don't think this is useful.

Best regards,
Krzysztof

