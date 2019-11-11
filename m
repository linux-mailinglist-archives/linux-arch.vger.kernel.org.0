Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE5F79A9
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2019 18:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKKRUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Nov 2019 12:20:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52422 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKRUK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Nov 2019 12:20:10 -0500
Received: from zn.tnic (p200300EC2F26BB00D592BD3399DA4BDA.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:bb00:d592:bd33:99da:4bda])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FA4E1EC0C25;
        Mon, 11 Nov 2019 18:20:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573492809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3tu/7JPN4tV5i1X8iQrVSJW+CCc7eYR1Dlq3I5+LVX8=;
        b=qyuqe1jFxo+K8LpqQlIAKT4knwZJson6Dvyz8Q1EbH8WUy/pnEULfJDRJhknMQgBSqHA7b
        0jAl0vdQ6vQKlNAxpErBdf/04xKzI48cJfK3z2WqrCdCYctQTdfSo3SRTzXCzYebnJ3rlb
        lWXbQPBg6M9I7MtRDGog4//j2Gp6meQ=
Date:   Mon, 11 Nov 2019 18:20:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] Improvements for random.h/archrandom.h
Message-ID: <20191111172006.GC2799@zn.tnic>
References: <20191106141308.30535-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 06, 2019 at 03:12:58PM +0100, Richard Henderson wrote:
> During patch review for an addition of archrandom.h for arm64, it was
> suggeted that the arch_random_get_* functions should be marked __must_check.
> Which does sound like a good idea, since the by-reference integer output
> may be uninitialized when the boolean result is false.
> 
> In addition, it turns out that arch_has_random() and arch_has_random_seed()
> are not used, and not easy to support for arm64.  Rather than cobble
> something together that would not be testable, remove the interfaces
> against some future accidental use.
> 
> In addition, I noticed a few other minor inconsistencies between the
> different architectures, e.g. powerpc isn't using bool.
> 
> Change since v1:
>   * Remove arch_has_random, arch_has_random_seed.
> 
> 
> r~
> 
> 
> Richard Henderson (10):
>   x86: Remove arch_has_random, arch_has_random_seed
>   powerpc: Remove arch_has_random, arch_has_random_seed
>   s390: Remove arch_has_random, arch_has_random_seed
>   linux/random.h: Remove arch_has_random, arch_has_random_seed
>   linux/random.h: Use false with bool
>   linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
>   x86: Mark archrandom.h functions __must_check
>   powerpc: Use bool in archrandom.h
>   powerpc: Mark archrandom.h functions __must_check
>   s390x: Mark archrandom.h functions __must_check
> 
>  arch/powerpc/include/asm/archrandom.h | 27 +++++++++-----------------
>  arch/s390/include/asm/archrandom.h    | 20 ++++---------------
>  arch/x86/include/asm/archrandom.h     | 28 ++++++++++++---------------
>  include/linux/random.h                | 24 ++++++++---------------
>  4 files changed, 33 insertions(+), 66 deletions(-)
> 
> -- 

They look good to me.

Is anyone going to take them or should I though the tip tree?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
