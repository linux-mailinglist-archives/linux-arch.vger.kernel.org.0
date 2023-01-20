Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5DA67572E
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjATOaT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjATOaS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:30:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772A979297;
        Fri, 20 Jan 2023 06:29:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8C81B82853;
        Fri, 20 Jan 2023 14:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237E9C4339B;
        Fri, 20 Jan 2023 14:29:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NTHbstKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1674224971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9kOqvxWdJiZ6o7rLV7rek2JVGrJsZXSaK0nvleVzCA=;
        b=NTHbstKfPp3u89snVVs+oFRiOmLj7/9+v4hS84e1+clIoPhsJ2kSbFe1y7Ve3fpUvfhDFY
        RBcamZ38ta96TPzy+pU4lTKfZ8wbvpW/izzz3c6W+tHXCN5ZL8y0SX+AqrocY7EgB2oo7F
        1Nc0qLsaQSetYUtiIFFpE6YtUNUcr48=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c179fd18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 20 Jan 2023 14:29:31 +0000 (UTC)
Date:   Fri, 20 Jan 2023 15:29:14 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
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
        Marc =?utf-8?B?UG91bGhpw6hz?= <dkm@kataplop.net>,
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
Subject: Re: [RFC PATCH v2 12/31] kvx: Add other common headers
Message-ID: <Y8qlOpYgDefMPqWH@zx2c4.com>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-13-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230120141002.2442-13-ysionneau@kalray.eu>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Yann,

On Fri, Jan 20, 2023 at 03:09:43PM +0100, Yann Sionneau wrote:
> +#include <linux/random.h>
> +#include <linux/version.h>
> +
> +extern unsigned long __stack_chk_guard;
> +
> +/*
> + * Initialize the stackprotector canary value.
> + *
> + * NOTE: this must only be called from functions that never return,
> + * and it must always be inlined.
> + */
> +static __always_inline void boot_init_stack_canary(void)
> +{
> +	unsigned long canary;
> +
> +	/* Try to get a semi random initial value. */
> +	get_random_bytes(&canary, sizeof(canary));
> +	canary ^= LINUX_VERSION_CODE;
> +	canary &= CANARY_MASK;
> +
> +	current->stack_canary = canary;
> +	__stack_chk_guard = current->stack_canary;
> +}


You should rewrite this as:

    current->stack_canary = get_random_canary();
    __stack_chk_guard = current->stack_canary;

which is what the other archs all now do. (They didn't used to, and this
looks like it's simply based on older code.)

> +#define get_cycles get_cycles
> +
> +#include <asm/sfr.h>
> +#include <asm-generic/timex.h>
> +
> +static inline cycles_t get_cycles(void)
> +{
> +	return kvx_sfr_get(PM0);
> +}

Glad to see this CPU has a cycle counter. Out of curiosity, what is
its resolution?

Also, related, does this CPU happen to have a "RDRAND"-like instruction?
(I don't know anything about kvx or even what it is.)

Jason
