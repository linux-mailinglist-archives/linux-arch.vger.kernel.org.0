Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39863248EEA
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 21:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHRTo5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 15:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHRTow (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 15:44:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE5C061344
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:44:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v16so103238plo.1
        for <linux-arch@vger.kernel.org>; Tue, 18 Aug 2020 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i1d+U+ecDxUFOWl6onxWX2qBK/sZMPkIFOLpUTyn6uQ=;
        b=FB2IyJSYdn0VUofa7i8Z80/FH61STbjzPiTrV7pXJ9/PanWHP8N2HBymNiDeDrDJZv
         +bo27DTYRBIRVYJdtoXyyWfeS36z89yBxiuaIdCQyk9PY/jIhvuLnozoYsLcv/l7l7+3
         H8tWRysm6mi5Tfast76wQOHwKrqDkZ0EWMgMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i1d+U+ecDxUFOWl6onxWX2qBK/sZMPkIFOLpUTyn6uQ=;
        b=nAdSLJE6/M70mYkqtOgGbgNHJgGPg0i8eXS6CHfX6QRJK4xF1JJWVVeAJzCD4CBZxe
         urXnhMYD9NGyDCsZr2dq2IGyqzTE6LPzth4Hajt+h4cizQL2QJLqBqwFaLDZ0Aq/z8TB
         vv0aWxvBHEmcRvJvdkP9poGlqWB1tdWvrix1vrz2yJqMZWYJlc6rBGnwWout75hbx/Th
         5hIN0jNC/ZhE7oIELzVjng+pOJJSocTXm1osJtRheLat3MOvd3VT3T6cELr5ZF3Xm9AD
         aKl5gMbep5KPfgxbX8EEVP5n+hot3RqnoFdOtMna4dvZhro4AsLJHV7MtJzuAisCH3EL
         DFcQ==
X-Gm-Message-State: AOAM531pE3uOYB/l10a9ZpLpG6UvzmlAv4gFgY5qtOBEyUN+plLcxRsq
        xL0C0201IJHmiaiZoibaEtVHng==
X-Google-Smtp-Source: ABdhPJy5tKx9/xkhHJM6Odv3AsGblbIMbyJc2oObFFznMoC2GzzBneeXHhCf+Coy4KEA+Rmx1fZaDw==
X-Received: by 2002:a17:90a:7488:: with SMTP id p8mr1244035pjk.158.1597779891291;
        Tue, 18 Aug 2020 12:44:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b12sm22351411pga.87.2020.08.18.12.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:44:50 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:44:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/11] x86: make TASK_SIZE_MAX usable from assembly code
Message-ID: <202008181244.BBDA7DAB@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-9-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:09AM +0200, Christoph Hellwig wrote:
> For 64-bit the only hing missing was a strategic _AC, and for 32-bit we

typo: thing

> need to use __PAGE_OFFSET instead of PAGE_OFFSET in the TASK_SIZE
> definition to escape the explicit unsigned long cast.  This just works
> because __PAGE_OFFSET is defined using _AC itself and thus never needs
> the cast anyway.

Shouldn't this be folded into the prior patch so there's no bisection
problem?

-Kees

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/page_32_types.h | 4 ++--
>  arch/x86/include/asm/page_64_types.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
> index 26236925fb2c36..f462895a33e452 100644
> --- a/arch/x86/include/asm/page_32_types.h
> +++ b/arch/x86/include/asm/page_32_types.h
> @@ -44,8 +44,8 @@
>  /*
>   * User space process size: 3GB (default).
>   */
> -#define IA32_PAGE_OFFSET	PAGE_OFFSET
> -#define TASK_SIZE		PAGE_OFFSET
> +#define IA32_PAGE_OFFSET	__PAGE_OFFSET
> +#define TASK_SIZE		__PAGE_OFFSET
>  #define TASK_SIZE_LOW		TASK_SIZE
>  #define TASK_SIZE_MAX		TASK_SIZE
>  #define DEFAULT_MAP_WINDOW	TASK_SIZE
> diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
> index 996595c9897e0a..838515daf87b36 100644
> --- a/arch/x86/include/asm/page_64_types.h
> +++ b/arch/x86/include/asm/page_64_types.h
> @@ -76,7 +76,7 @@
>   *
>   * With page table isolation enabled, we map the LDT in ... [stay tuned]
>   */
> -#define TASK_SIZE_MAX	((1UL << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
> +#define TASK_SIZE_MAX	((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
>  
>  #define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
>  
> -- 
> 2.28.0
> 

-- 
Kees Cook
