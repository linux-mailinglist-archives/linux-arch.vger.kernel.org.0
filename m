Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800CD42B838
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbhJMHBk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbhJMHBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 03:01:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F308C061746
        for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2021 23:59:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n11so1162892plf.4
        for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2021 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EtO4v1hmknoQ9CC5pTvq/sjyHsZmxJYafaGuFh9dADA=;
        b=Aj4KOWPH1k1PgbvL+pTY/xACU9Pwn9MUiqpjhM6IVuirnFFqehXtyynR0cRL2JC99T
         X2BS5sniIcL0i7UDJuPo3mr7cogBrx2R6mTJAooH9lgbXGgOBqhKd622U9AX9BlAOHRw
         9KG1Rg/hzG7yZQgql7BR3km2UfZPusbGWwkVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EtO4v1hmknoQ9CC5pTvq/sjyHsZmxJYafaGuFh9dADA=;
        b=FOm2nKJSKCUE8fPbtrqthD/DID9kMdm5O2rGIJjmeisGPzpLLtbE3AtD9o9GpkvlRY
         bQr9+S4/gNp0IruMaFmwUcHjlWiwQ779agc+3j8nrORgx0sC3URfbuaOxn3abR/OJAWY
         QcaDNZCmf9jCtEoJN3gTi9WMsEsy5goXpm0kObhPsBLR3RO89JWtFsHzDq8jRlSEfZlf
         f3y/qS9PMDsW3p4t2qNgvMMAOJU8T8ks/SKvdETXwNICWiK1MbxRNX2JgsRdx1Nl4ejw
         utcymKWWy9TvtNKZo1BE+bfbLggL5AWBETsN0LxCwiDvy8Xn7mEKs6dBzaD0pSroqipm
         +kNw==
X-Gm-Message-State: AOAM531qT4R16qxmZM8vHLU1WGlj4RXs2/4PxeBhu9Vchk4AepZPzLhm
        4FtszMc8YHEyhe4Kato6Pk5n5A==
X-Google-Smtp-Source: ABdhPJyxiDFdmaS1K7BtHQLBKPUYqjjdyZfqGoeYI4TMfzgjIuLL/822k5Q++d2NaSjkZUCum4PHbw==
X-Received: by 2002:a17:90b:2248:: with SMTP id hk8mr11473279pjb.102.1634108375787;
        Tue, 12 Oct 2021 23:59:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m22sm13283364pfo.176.2021.10.12.23.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:59:35 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:59:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 03/10] ia64: Rename 'ip' to 'addr' in 'struct fdesc'
Message-ID: <202110122359.4FF2BA38@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <a2443adcd006cb8004fe0602e2f8c43c30a7c504.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2443adcd006cb8004fe0602e2f8c43c30a7c504.1633964380.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 11, 2021 at 05:25:30PM +0200, Christophe Leroy wrote:
> There are three architectures with function descriptors, try to
> have common names for the address they contain in order to
> refactor some functions into generic functions later.
> 
> powerpc has 'funcaddr'
> ia64 has 'ip'
> parisc has 'addr'
> 
> Vote for 'addr' and update 'struct fdesc' accordingly.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
