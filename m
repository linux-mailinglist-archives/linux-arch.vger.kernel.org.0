Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF6C3C8807
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhGNP5F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhGNP5F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jul 2021 11:57:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56355C06175F;
        Wed, 14 Jul 2021 08:54:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so3799083eds.4;
        Wed, 14 Jul 2021 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z9z77veQvYf+CrIIVK7ReiATjg1L8hRA/kHD8DGPArA=;
        b=XlvkLJZKJzkfpSDLxpjjtPB/VvC1elvK7SlfUsL1tk4XXFsHr68jYGWcSjTYWb54C3
         gT6BkuByC50Egvmp7joDtnqDGyo9YBndzOdFe0TEYhiemj1h43vtA/4LgEvPjZpuLd3A
         n+kSByFLvb1nNFVAUiGaKnZjzuPRiIs59npmCgbDBu9rdeNPVLNO82rTYNUMRqJxgywd
         w7KWPHV7AKUWGVoUcorl1IZA8AP6gBT4+WiRIUPN0IiCaO5RCodoRANVmieqqZgh1Nnz
         gcNkDwoc36MM8nkWQULDUiiEzY0DlMCGhF+nSrddXd8XNb8nvUz4dvPis0ZXevAw1+5Y
         G/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z9z77veQvYf+CrIIVK7ReiATjg1L8hRA/kHD8DGPArA=;
        b=W4eVgyvxNGK9mU1m7YaIEKh8b0BU6Fuk/yywrJ+eQvJl3VQV9AvZuTWrv7QmCqIOkq
         n5WJ662gWqDPRfnGhfBudmwHb6blCspAc5BptpGYM/4s8NsgvoI0wGcmBS2wEsXtYJW0
         giYW/XLacHB7govqMIVIcfUWZIl/WS6YeVQGylgJQ16AOAwReLHnkaqiFP+fWhHIlLsu
         KIRNsx1Dxnp4mT2DUSk3un2zeviR7ytr2LgXwlGOi1lPhIWP4RSkmRRKbn/HZ0q5Xw/c
         LLf7yYuD3ZhmU/B1ztbeiL9i0jXt1EZDzkTvBHkCZPT3arTIFkClWQkjEyTE3dXC7MhU
         TMLA==
X-Gm-Message-State: AOAM532iiEJMDMkdarDDc7SencAK58YlrFZIjvU/xSSwK4cB4Y+Kt8eV
        f4C1Rfcoh/8rVIKJvrWfNQ==
X-Google-Smtp-Source: ABdhPJz7+yeJrAg69dVHYglGFT7uCskR50zp1pU5m7yDCTdcMEo0+gXK3ahm71+arZqE+/CJ42J8Bg==
X-Received: by 2002:a05:6402:1615:: with SMTP id f21mr14568834edv.35.1626278050921;
        Wed, 14 Jul 2021 08:54:10 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.115])
        by smtp.gmail.com with ESMTPSA id m15sm1176431edp.73.2021.07.14.08.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:54:10 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:54:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH] Decouple build from userspace headers
Message-ID: <YO8IoNwXS4h26+9v@localhost.localdomain>
References: <YO3txvw87MjKfdpq@localhost.localdomain>
 <YO7zEFNSXOY8pKCQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO7zEFNSXOY8pKCQ@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 14, 2021 at 03:22:08PM +0100, Christoph Hellwig wrote:
> > -#define signals_blocked false
> > +#define signals_blocked 0
> 
> Why can't we get at the kernel definition of false here?

Variable and other code surrounding this wants "int".
I don't really want to expand into bool conversion.

> > new file mode 100644
> > --- /dev/null
> > +++ b/include/stdarg.h
> > @@ -0,0 +1,9 @@
> > +#ifndef _LINUX_STDARG_H
> > +#define _LINUX_STDARG_H
> > +typedef __builtin_va_list __gnuc_va_list;
> > +typedef __builtin_va_list va_list;
> > +#define va_start(v, l)	__builtin_va_start(v, l)
> > +#define va_end(v)	__builtin_va_end(v)
> > +#define va_arg(v, T)	__builtin_va_arg(v, T)
> > +#define va_copy(d, s)	__builtin_va_copy(d, s)
> > +#endif
> 
> Empty lines before and after the include guards would be nice.
> 
> What do we need the __gnuc_va_list typedef for?

That's because without __gnuc_va_list something didn't compile.
I'm preparing second version with <linux/stdarg.h> where __gnuc_va_list is
unnecessary indeed.

> Otherwise this looks great.  As a follow on maybe move the new header
> to <linux/stdarg.h> to make clear to everyone that we are using our
> own version.
