Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931F8E9AE4
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2019 12:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfJ3LhI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 07:37:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54179 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3LhI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Oct 2019 07:37:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4735ym2XKNz9sPL;
        Wed, 30 Oct 2019 22:37:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1572435424;
        bh=Ukmow9kPMiVR7CRBSSLkfrTkYl/luRkDY70O/Ez8ScE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JcbMjt25mjAa/p5TQmHhbYsbMDLQNAWLBgG+KisPaucipwHOlReXn1BMxdr8jiuF/
         TQEhrhfC6nyl4bbiSf04t8hQnvbWd1H4WYlJbNB+6bCe8Xjl1a5dHMhJVaA95XvaTa
         Ctkb/6vSdbVW+3EVC6zycS/u152N053ziA5BCVcW/Mvl0h8h2tEoAjTpvVgorhkZp8
         2Ap8Eh1+sYtQBgpbanoEYCf1FXizsuVA7Iqet41OaDAY0WovQWeV9v+oCfpkBPC9v3
         H4A2rbF05lv18BITDGxmR8CpVkPcCXCSePbv9QWGgcskjrfXANv0wPUA2DKxHv0ONE
         8COwKqErc3MZQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Richard Henderson <richard.henderson@linaro.org>,
        linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/6] powerpc: Mark archrandom.h functions __must_check
In-Reply-To: <20191028210559.8289-6-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net> <20191028210559.8289-6-rth@twiddle.net>
Date:   Wed, 30 Oct 2019 22:37:01 +1100
Message-ID: <87v9s6bh2a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Richard Henderson <richard.henderson@linaro.org> writes:
> We cannot use the pointer output without validating the
> success of the random read.

You _can_, but you must not. </pedant>

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/archrandom.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
> index f8a887c8b7f8..ee214b153a71 100644
> --- a/arch/powerpc/include/asm/archrandom.h
> +++ b/arch/powerpc/include/asm/archrandom.h
> @@ -6,17 +6,17 @@
>  
>  #include <asm/machdep.h>
>  
> -static inline bool arch_get_random_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_long(unsigned long *v)
>  {
>  	return false;
>  }
>  
> -static inline bool arch_get_random_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
>  {
>  	return false;
>  }
>  
> -static inline bool arch_get_random_seed_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  {
>  	if (ppc_md.get_random_seed)
>  		return ppc_md.get_random_seed(v);
> @@ -24,7 +24,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
>  	return false;
>  }
>  
> -static inline bool arch_get_random_seed_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  {
>  	unsigned long val;
>  	bool rc;
> -- 
> 2.17.1
