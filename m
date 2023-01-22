Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D09676C89
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 12:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjAVLyW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Jan 2023 06:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjAVLyV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2023 06:54:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C5B125B4
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:54:18 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so8443277wrz.12
        for <linux-arch@vger.kernel.org>; Sun, 22 Jan 2023 03:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SufkmAjwbNPzx+QZI0to5Uf48TUW+IZPLNjbNqCZpfI=;
        b=agLJLLTVda4vzbo+pBm1nc5uVfx6hrGX4HQkgIojkD/1cyQqIJv/dW6ozQQZxh9acO
         0GIArSOuUVD0jo2VEYapOBIRUz5rU0ickudZecB/MxBJcXysLhAmHyMc4oBteDTIVZMP
         gWC6imLaRflwc3jb3Je1wClPZlQKNp6xyUYD3v0X33auCHxc+qD/ZA/jJBtt4IwIx7rF
         gSScl4TsJrIet9k0uAS97cSICY1543XxKH25XG+KtqbOQ1xwZB+O3y7k0SPxq0AYdW3y
         nsmpTPaZyS0wpbBSnQCu92eqyFbTR8SK3YHX60WCqpdfFl3mYAplQ0n+AxAh2HMkH8Q8
         TEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SufkmAjwbNPzx+QZI0to5Uf48TUW+IZPLNjbNqCZpfI=;
        b=ypVSZTGokXCuviRpHuZwVr4NriO3wTf60uLRY14gGAF6q/q30IN7d556IfvdL94tl8
         Pbt1vkTtrubF5F84jTPrroNPf//Xw3nOWGZV1GfC45HAw/3Ua9jGdMStyZHsBHM1YOuT
         uVwoAFoXJZtExIjwjNT1ctH4BncrpX0h93MgP+bCPoHzSP6HQi+yd9jX3UQvS8lZu0Uq
         dEB3QGbmKdngCjPgoFpjN9mxub1kwljidNjUZvoXilBCNg6l69TnECJHzMhW7s011It0
         Ly0dr3L5IJvwH+MFDjZzafz0nm4gS1Qh0HWUEopFxo6LTRwEdFGgPxuYXmqzWsY180bu
         m0rw==
X-Gm-Message-State: AFqh2krTSjRRnI4SmP3lRLMRVNZ83+tMI3AYXuseVvdHnUMuUi2a+0H3
        JJj8o8YfXyve2gx2DGXopuBhcg==
X-Google-Smtp-Source: AMrXdXt21M3CsHbnhN4nC75KtRaK9snE7H1KnN8u8SuCQjR3lZXo7Zes1x4/j1347YU7bM+ZYlALNg==
X-Received: by 2002:adf:e9d2:0:b0:2bd:e6f5:5122 with SMTP id l18-20020adfe9d2000000b002bde6f55122mr17418436wrn.65.1674388457426;
        Sun, 22 Jan 2023 03:54:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ba9-20020a0560001c0900b002b57bae7174sm2174746wrb.5.2023.01.22.03.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:54:16 -0800 (PST)
Message-ID: <f69adaf2-6582-c134-5671-4d6fd100fcf1@linaro.org>
Date:   Sun, 22 Jan 2023 12:54:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH v2 30/31] kvx: Add power controller driver
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
 <20230120141002.2442-31-ysionneau@kalray.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120141002.2442-31-ysionneau@kalray.eu>
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

On 20/01/2023 15:10, Yann Sionneau wrote:
> From: Jules Maselbas <jmaselbas@kalray.eu>
> 
> The Power Controller (pwr-ctrl) control cores reset and wake-up
> procedure.


> +
> +static struct device_node * __init get_pwr_ctrl_node(void)
> +{
> +	const phandle *ph;
> +	struct device_node *cpu;
> +	struct device_node *node;
> +
> +	cpu = of_get_cpu_node(raw_smp_processor_id(), NULL);
> +	if (!cpu) {
> +		pr_err("Failed to get CPU node\n");
> +		return NULL;
> +	}
> +
> +	ph = of_get_property(cpu, "power-controller", NULL);
> +	if (!ph) {
> +		pr_err("Failed to get power-controller phandle\n");
> +		return NULL;
> +	}
> +
> +	node = of_find_node_by_phandle(be32_to_cpup(ph));
> +	if (!node) {
> +		pr_err("Failed to get power-controller node\n");
> +		return NULL;
> +	}
> +
> +	return node;
> +}
> +
> +int __init kvx_pwr_ctrl_probe(void)
> +{
> +	struct device_node *ctrl;
> +
> +	ctrl = get_pwr_ctrl_node();
> +	if (!ctrl) {
> +		pr_err("Failed to get power controller node\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!of_device_is_compatible(ctrl, "kalray,kvx-pwr-ctrl")) {
> +		pr_err("Failed to get power controller node\n");

No. Drivers go to drivers, not to arch directory. This should be a
proper driver instead of some fake stub doing its own driver matching.
You need to rework this.

Best regards,
Krzysztof

