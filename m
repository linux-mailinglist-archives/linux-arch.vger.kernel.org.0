Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4C3C61D8
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 19:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhGLR3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jul 2021 13:29:51 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:36420 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhGLR3v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jul 2021 13:29:51 -0400
Received: by mail-wm1-f50.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so5123154wms.1;
        Mon, 12 Jul 2021 10:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0MQqVwvutjc/uEdEJQm7ixxF9gWemfLf7asyrtfZ53I=;
        b=DZh+Sa69wpEhKs5gWP7LxyGTLKOcEioQUNRhzNg/obtGCys5u/9MAfuKr+q5ZEAVzp
         DocgSlwthvRVUgmfjC11UwDS5OGG8Wkb+cSrmqEkr2nYY3e75C9E9dr7LjVdNYdDRhDH
         UQ1JtDUmHLW/ErvQ5uzS4eT9WjaF+7vcp0YrecCS995HZJT4C3FPqHgGBRx9qclftx/C
         ND1vQrYPGvUT4u/gZ2TnclZ3xSMJh3QXbd+CSzhxIQzGBh5UG7plaRSXWn3mJJ79a7Ij
         tZH1bseT1uC3gwjKvJCpovRoqKvngHoqyhUn6Ap5FmUo8GweYbvh4RiC6d9VfsnnVz5D
         tjig==
X-Gm-Message-State: AOAM533HnOcqJy96W43d2AIC4lLAHXl188G2X4O3eLRrsL+ECETMwn0h
        yUrXb0wEbuOoeyRg1SlCBrQ=
X-Google-Smtp-Source: ABdhPJzVd6rhjl9r5O8mGuAnl4DP6LGRPTAV/kajtCaEslDxHIUIixer64RuAlp5MTMJm++6khv1aQ==
X-Received: by 2002:a1c:790a:: with SMTP id l10mr369013wme.8.1626110820969;
        Mon, 12 Jul 2021 10:27:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o11sm12749056wmq.1.2021.07.12.10.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:27:00 -0700 (PDT)
Date:   Mon, 12 Jul 2021 17:26:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] asm-generic/hyperv: Add missing #include of nmi.h
Message-ID: <20210712172658.l53gudfvrqxbgd76@liuwe-devbox-debian-v2>
References: <1626058204-2106-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626058204-2106-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 11, 2021 at 07:50:04PM -0700, Michael Kelley wrote:
> The recent move of hv_do_rep_hypercall() to this file adds
> a reference to touch_nmi_watchdog(). Its function definition
> is included indirectly when compiled on x86, but not when
> compiled on ARM64. So add the explicit #include.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.

> ---
>  include/asm-generic/mshyperv.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 2a187fe..60cdff3 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -22,6 +22,7 @@
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/cpumask.h>
> +#include <linux/nmi.h>
>  #include <asm/ptrace.h>
>  #include <asm/hyperv-tlfs.h>
>  
> -- 
> 1.8.3.1
> 
