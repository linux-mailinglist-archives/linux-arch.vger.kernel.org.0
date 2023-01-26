Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECACD67CA78
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 13:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbjAZMEa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 07:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbjAZME3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 07:04:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D23E8688;
        Thu, 26 Jan 2023 04:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VOYYOFluZ3iiE3C4UV5w2zwSbmkrX31OvmObcOHb8QY=; b=a4Dxr3QUr9TtmHfliGOtcckkzx
        BrP5GWkLqc27yiUm4kwh19HaOVWBXahjBqw/wPDcEhVzPchelLHiGctMWCq8KVERaxBV+MzPRs7YD
        s7xFIhhUHFTBcr0IBv19oaJvydg7OHzPC9cZD3k9h8yXi9iumBnFnHKj7fbxel0aGk6MTYEI8n7rz
        VJWfPck6gySngS1vUKbLJbhJsn7dmxZonWOTlYAnzhCXODc79DpGm0cv4Ct/FtpQKWmz2xi7E/5Y5
        mgtej+AQW8D2kRVq+Ru0p5qzcwJ9vdCP54+cxPk9OJYRNIX6YKokDu1hmNfkpTOHL5hQ4w8qDBU6c
        ml/cqMcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL0yo-006hzg-Em; Thu, 26 Jan 2023 12:03:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDDFC3002BF;
        Thu, 26 Jan 2023 13:03:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96DF92082E0E1; Thu, 26 Jan 2023 13:03:44 +0100 (CET)
Date:   Thu, 26 Jan 2023 13:03:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] iopoll: Call cpu_relax() in busy loops
Message-ID: <Y9JsIJat3sZU2rl1@hirez.programming.kicks-ass.net>
References: <8d492ee4a391bd089a01c218b0b4e05cf8ea593c.1674729407.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d492ee4a391bd089a01c218b0b4e05cf8ea593c.1674729407.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 11:45:37AM +0100, Geert Uytterhoeven wrote:
> It is considered good practice to call cpu_relax() in busy loops, see
> Documentation/process/volatile-considered-harmful.rst.  This can not
> only lower CPU power consumption or yield to a hyperthreaded twin
> processor, but also allows an architecture to mitigate hardware issues
> (e.g. ARM Erratum 754327 for Cortex-A9 prior to r2p0) in the
> architecture-specific cpu_relax() implementation.
> 
> As the iopoll helpers lack calls to cpu_relax(), people are sometimes
> reluctant to use them, and may fall back to open-coded polling loops
> (including cpu_relax() calls) instead.
> 
> Fix this by adding calls to cpu_relax() to the iopoll helpers:
>   - For the non-atomic case, it is sufficient to call cpu_relax() in
>     case of a zero sleep-between-reads value, as a call to
>     usleep_range() is a safe barrier otherwise.
>   - For the atomic case, cpu_relax() must be called regardless of the
>     sleep-between-reads value, as there is no guarantee all
>     architecture-specific implementations of udelay() handle this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

In addition to these dodgy architecture fails, cpu_relax() is also a
compiler barrier, it is not immediately obvious that the @op argument
'function' will result in an actual function call (inlining ftw).

Where a function call is a C sequence point, this is lost on inlining.
Therefore, with agressive enough optimization it might be possible for
the compiler to hoist the:

	(val) = op(args);

'load' out of the loop because it doesn't see the value changing. The
addition of cpu_relax() will inhibit this.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> Resent with a larger audience due to lack of comments.
> 
> This has been discussed before, but I am not aware of any patches moving
> forward:
>   - "Re: [PATCH 6/7] clk: renesas: rcar-gen3: Add custom clock for PLLs"
>     https://lore.kernel.org/all/CAMuHMdWUEhs=nwP+a0vO2jOzkq-7FEOqcJ+SsxAGNXX1PQ2KMA@mail.gmail.com/
>   - "Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the PLL set_rate ops"
>     https://lore.kernel.org/all/20200811164628.GA7958@kozik-lap
> ---
>  include/linux/iopoll.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index 2c8860e406bd8cae..73132721d1891a2e 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -53,6 +53,8 @@
>  		} \
>  		if (__sleep_us) \
>  			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
> +		else \
> +			cpu_relax(); \

There's a simplicitly argument to be had for making it unconditional
here too I suppose. usleep() is 'slow' anyway.

>  	} \
>  	(cond) ? 0 : -ETIMEDOUT; \
>  })
> @@ -95,6 +97,7 @@
>  		} \
>  		if (__delay_us) \
>  			udelay(__delay_us); \
> +		cpu_relax(); \
>  	} \
>  	(cond) ? 0 : -ETIMEDOUT; \
>  })
> -- 
> 2.34.1
> 
