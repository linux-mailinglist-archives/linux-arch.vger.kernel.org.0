Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7636DF3CF
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 13:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDLLfV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 07:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjDLLfD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 07:35:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880AA83D3;
        Wed, 12 Apr 2023 04:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ptb2avmE0b7kYpkD6HQ5sKXtmJgMCEPhKl497g20A1Q=; b=OeJpnwPQVQrSrkQnsPYnkVz6Xn
        MQHlpDq4OctaeZMIotctQRvuZFYgTUiewZ7yhKiM52JM3lAIDo3z9I7QtTxis1qzyh+z8drUYv/WV
        bfbaBd2P8XywYXeiBMI5PritExaKlrWXJd7/wY7wiQAHiZblhmhYLud/MzynJ+MYFFW0+5xyzQc6I
        virTasGQ1pP9Bw2IUpE4ZnHiiBOZdruaGxw9KZH5HnVc+61Syh0q79vu8y30TAFx7q+e26Z3cuEp/
        bsMrHDSoGfQD+fNsEp4WZY7Lu2KON5AN0m6qsqM2FWXzkMBO2BMwFxx8Is50hsXaD3MySaIdcQUTV
        LkPO9Wwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmYiM-006owg-IO; Wed, 12 Apr 2023 11:32:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3F083002A6;
        Wed, 12 Apr 2023 13:32:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7D4525E5A38B; Wed, 12 Apr 2023 13:32:31 +0200 (CEST)
Date:   Wed, 12 Apr 2023 13:32:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/5] locking/arch: Wire up local_try_cmpxchg
Message-ID: <20230412113231.GA628377@hirez.programming.kicks-ass.net>
References: <20230405141710.3551-1-ubizjak@gmail.com>
 <20230405141710.3551-4-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405141710.3551-4-ubizjak@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 05, 2023 at 04:17:08PM +0200, Uros Bizjak wrote:
> diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
> index bc4bd19b7fc2..45492fb5bf22 100644
> --- a/arch/powerpc/include/asm/local.h
> +++ b/arch/powerpc/include/asm/local.h
> @@ -90,6 +90,17 @@ static __inline__ long local_cmpxchg(local_t *l, long o, long n)
>  	return t;
>  }
>  
> +static __inline__ bool local_try_cmpxchg(local_t *l, long *po, long n)
> +{
> +	long o = *po, r;
> +
> +	r = local_cmpxchg(l, o, n);
> +	if (unlikely(r != o))
> +		*po = r;
> +
> +	return likely(r == o);
> +}
> +

Why is the ppc one different from the rest? Why can't it use the
try_cmpxchg_local() fallback and needs to have it open-coded?
