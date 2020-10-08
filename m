Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A11287BA1
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 20:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgJHSWm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJHSWm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 14:22:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E86C061755
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FiPnDThNoLXX1zlhDJEgZkR9/Wj0N97KtfaVAawxLWM=; b=KUA+ih560K7n+C58xiu/WUHLLk
        fXkqLtLpjYkIHzX7fwkOO4ZXdKqYaXm7QGF1XU28sr8ujzmzdLIH6iRyZ2m3EH9LXPTsOKW/UBfhi
        iHRG7ggPw5Pvg46PFLrTRahf5Sle7he6foNTBxZnwEW8GNj9ETNIwa4+WTphrKEe53SuNJSpSlZ3n
        SYZVzV2EfhkC2qdK0voDwCr7Jkvj7FpOZH9zynh7/EtJz96+8UA/U9lKGSvucFWrC/TLk6CuQdanf
        IAw9dU5NGBggs5RU790+R8S5kiLIL9XaE1IqeqtxpNgx2ob5UUa69g76QqFWjoXqQu2U3EqbjAlmP
        LnLRB9ww==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQaYp-0005gm-Pp; Thu, 08 Oct 2020 18:22:40 +0000
Subject: Re: [RFC PATCH 2/3] arm64: Add support for asymmetric AArch32 EL0
 configurations
To:     Qais Yousef <qais.yousef@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-3-qais.yousef@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e1fe1a9-4ebc-bd20-701e-844d5c16dd42@infradead.org>
Date:   Thu, 8 Oct 2020 11:22:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201008181641.32767-3-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/8/20 11:16 AM, Qais Yousef wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..591853504dc4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1868,6 +1868,20 @@ config DMI
>  
>  endmenu
>  
> +config ASYMMETRIC_AARCH32
> +	bool "Allow support for asymmetric AArch32 support"

Please drop one "support" or reword the prompt string.

> +	depends on COMPAT && EXPERT
> +	help
> +	  Enable this option to allow support for asymmetric AArch32 EL0
> +	  CPU configurations. Once the AArch32 EL0 support is detected
> +	  on a CPU, the feature is made available to user space to allow
> +	  the execution of 32-bit (compat) applications. If the affinity
> +	  of the 32-bit application contains a non-AArch32 capable CPU
> +	  or the last AArch32 capable CPU is offlined, the application
> +	  will be killed.
> +
> +	  If unsure say N.


-- 
~Randy

