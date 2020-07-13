Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9460A21D318
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgGMJpm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMJpl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 05:45:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90175C061755
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2020 02:45:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cm21so5980612pjb.3
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2020 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0olB/Kj5+mM078/bHyZqezPaPK0WajdFbhRfxVSilRM=;
        b=Gn2xMHlOBxombYzdcOBeNb7/n3j/kqRvvaLLW0WODfv8XcYN4wvPkv/VelKSuBP69N
         UqYAzOFnTRyOXYGP4stWtS1e2WJ0541MZUrW7Jn4EzmpRWNfZnAHVFxP4CCNc+KNr+va
         otUTk2GbD0GCOa0jrU4/V+OEz7yEdEQbnY273ksNxPIWRSHkSE9A04vZDs/2YxcHamFI
         TDYExsyQlQ3acmCutMiKev+tyJl0jWuD2kpvnT7lXyVT6nqpoW6VhD6egu6RJJVIgVsS
         7pnNeiJwjDebLCS0ZkRE3+BoAGVWSRHbiIEEviLgMmkeayuCOeqeCxxGfQsNP4fU3PFy
         mckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0olB/Kj5+mM078/bHyZqezPaPK0WajdFbhRfxVSilRM=;
        b=JGaxLso/H9ZrrrQTvAsePzVC+6r1oBtFAIVHGlO50Sr9MGvPSqMS0ZFIVc9+YB6Qrt
         Z21INsCf2PP6v24Ns5EZ5RT7wPsN14A6lEDhsQNyueM1REhjiHEgk6qIk+GxxCwNUqw7
         yYjqH9n4GY1IjyTkApojhsi9/qpLBkphUJBz2htoKdXNqn4+9LISHFTuiO5msl3584lp
         vDRj1Jrf1SO+S8uzfKGF6H5G5xpEKJsp7MCGFT3S4Dpc4gyHlR90e9ElkXPN6xDiXAuV
         cdWrMW700tCOKRyrK/jnKnkFzst3SEW24MytKaiWNvNMbKDui1UYLH00MVoyv3WkozjM
         uQcg==
X-Gm-Message-State: AOAM5326zuPEX4CqBsI2pXZ9foac4492XN9GEURKdykrtxmp9rMJ3sO4
        CNGgN566VApu2zudWRVgvilJctcoQ14=
X-Google-Smtp-Source: ABdhPJw6RpvjZvtN9GfY5lgA9lyTRdntA6c5g4jImyUp+kuNOOIMz04NipT9in353pzQI6555/bXiA==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr59195104plz.8.1594633541141;
        Mon, 13 Jul 2020 02:45:41 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id u2sm13654333pfl.21.2020.07.13.02.45.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 02:45:40 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:15:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic/sembuf: Update architecture related
 information in comment
Message-ID: <20200713094538.ix5g5bt6ss55kwrn@vireshk-i7>
References: <64efe033394b6f0dfef043a63fd8897a81ba6d16.1589970173.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64efe033394b6f0dfef043a63fd8897a81ba6d16.1589970173.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20-05-20, 15:53, Viresh Kumar wrote:
> The structure came originally from x86_32 but is used by most of the
> architectures now. Update the comment which says it is for x86 only.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/uapi/asm-generic/sembuf.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
> index 0e709bd3d730..f54e48fc91ae 100644
> --- a/include/uapi/asm-generic/sembuf.h
> +++ b/include/uapi/asm-generic/sembuf.h
> @@ -6,9 +6,9 @@
>  #include <asm/ipcbuf.h>
>  
>  /*
> - * The semid64_ds structure for x86 architecture.
> - * Note extra padding because this structure is passed back and forth
> - * between kernel and user space.
> + * The semid64_ds structure for most architectures (though it came from x86_32
> + * originally). Note extra padding because this structure is passed back and
> + * forth between kernel and user space.
>   *
>   * semid64_ds was originally meant to be architecture specific, but
>   * everyone just ended up making identical copies without specific

Arnd, Ping.

-- 
viresh
