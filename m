Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4010253DAD
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 08:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgH0GYh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 02:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgH0GYh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 02:24:37 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E6012177B;
        Thu, 27 Aug 2020 06:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598509477;
        bh=uk+W9b3nyOTd17BruOaKw2TwWmN6jLYYAy6DEz/dU0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTh7L97kiPMnbXtcJXINdnG9+lx4wO5nMVdIIpGr7C/E1pMyaQAQS0Z+3RTg6K31Q
         iFrtYGcNKSph4lmm8sL7G9NxSRuPjd5rjE+dp7exhSut8Z3xyBQamiahIHgRoXYo7s
         35LTLeMCISST3pK2SlumjcncWZPCJQdug4QUI68E=
Date:   Thu, 27 Aug 2020 09:24:31 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] include/asm-generic/bug.h: add ASSERT_FAIL() and
 ASSERT_WARN() wrapper
Message-ID: <20200827062431.GC69706@kernel.org>
References: <2a79d3f5feb628ab318fcebe004e398b8124ce46.1598481550.git.brookxu@tencent.com>
 <7d916ac76e7823efbf88828dc6c61737555434a1.1598481550.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d916ac76e7823efbf88828dc6c61737555434a1.1598481550.git.brookxu@tencent.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 07:04:53AM +0800, Chunguang Xu wrote:
> The kernel has not yet defined ASSERT(). Indeed, BUG() and WARN() are very
> clear and can cover most application scenarios. However, some applications
> require more debugging information and similar behavior to assert(), which
> cannot be directly provided by BUG() and WARN().
> 
> Therefore, many modules independently implement ASSERT(), and most of them
> are similar, but slightly different. This makes the code redundant and
> inconvenient to troubleshoot the system. Therefore, perhaps we need to
> define two wrappers for BUG() and WARN(), provide the implementation of
> ASSERT(), simplify the code and facilitate problem analysis.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  include/asm-generic/bug.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

It would be useful to convert at least one occurrence of the existing
ASSERT()s to the new implementation in the same patch series.

> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index 18b0f4e..28f8c27 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -174,6 +174,31 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  	unlikely(__ret_warn_once);				\
>  })
>  
> +/*
> + * ASSERT_FAIL() and ASSERT_WARN() can be used to check whether some
> + * conditions have failed. We generally use ASSERT_FAIL() to check
> + * critical conditions, and other use ASSERT_WARN().
> + */
> +#ifndef ASSERT_FAIL
> +#define ASSERT_FAIL(condition) do {					\
> +	if (unlikely(!(condition))) {					\
> +		pr_emerg("Assertion failed: %s, file: %s, line: %d\n",	\
> +			  #condition, __FILE__, __LINE__);		\
> +		BUG();							\
> +	}								\
> +} while (0)
> +#endif
> +
> +#ifndef ASSERT_WARN
> +#define ASSERT_WARN(condition) do {					\
> +	if (unlikely(!(condition))) {					\
> +		pr_warn("Assertion failed: %s, file: %s, line: %d\n",	\
> +			 #condition, __FILE__, __LINE__);		\
> +		WARN_ON(1);						\
> +	}								\
> +} while (0)
> +#endif
> +
>  #else /* !CONFIG_BUG */
>  #ifndef HAVE_ARCH_BUG
>  #define BUG() do {} while (1)
> @@ -203,6 +228,14 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  #define WARN_TAINT(condition, taint, format...) WARN(condition, format)
>  #define WARN_TAINT_ONCE(condition, taint, format...) WARN(condition, format)
>  
> +#ifndef ASSERT_FAIL
> +#define ASSERT_FAIL(condition) do { } while (0)
> +#endif
> +
> +#ifndef ASSERT_WARN
> +#define ASSERT_WARN(condition) do { } while (0)
> +#endif
> +
>  #endif
>  
>  /*
> -- 
> 1.8.3.1
> 

-- 
Sincerely yours,
Mike.
