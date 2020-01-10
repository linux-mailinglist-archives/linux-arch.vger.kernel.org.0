Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB1941371C6
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 16:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgAJPwC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 10:52:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55556 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgAJPwC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 10:52:02 -0500
Received: from zn.tnic (p200300EC2F0ACA0005C6612E529EFC59.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ca00:5c6:612e:529e:fc59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 54E781EC02C1;
        Fri, 10 Jan 2020 16:52:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578671520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PG559ixUh7Dx/k476pfGogc1Fgz5iKSv3jts5x2RJcE=;
        b=Ma+x5ECbcd8uQhY7OlRNSrHvPFMNPluXa2lr+PMdOUNQd0XtvgG24DD0Bn42megLWZ2d2c
        KqhyncnHnzTU5kmIxXP7BIr54gmpABvKWNsV/r81n4nlTaMwiSzJWB9fmGX+pIjFlzVIBH
        D4YxpSccbuvyLndmoojSLj1ovwg8rYc=
Date:   Fri, 10 Jan 2020 16:51:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        x86@kernel.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/10] Impveovements for random.h/archrandom.h
Message-ID: <20200110155153.GG19453@zn.tnic>
References: <20200110145422.49141-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110145422.49141-1-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 10, 2020 at 02:54:12PM +0000, Mark Brown wrote:
> This is a resend of a series from Richard Henderson last posted back in
> November:
> 
>    https://lore.kernel.org/linux-arm-kernel/20191106141308.30535-1-rth@twiddle.net/
> 
> Back then Borislav said they looked good and asked if he should take
> them through the tip tree but things seem to have got lost since then.

Or, alternatively, akpm could take them. In any case, if someone else
ends up doing that, for the x86 bits:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
