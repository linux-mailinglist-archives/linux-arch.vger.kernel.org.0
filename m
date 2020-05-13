Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114851D0FD7
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbgEMKbL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732606AbgEMKbK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:31:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB8DC061A0C;
        Wed, 13 May 2020 03:31:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so12976753wmd.0;
        Wed, 13 May 2020 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WRlPoU8j8jwPDdbu/iEeLTAULhB+gxL0ogeD+3+f2B8=;
        b=XozcPwUBAN3+dA4W9nnU+zgOQan+4HU+pt+gflLw5fYFvegZBgHkrktT9R/5pT6edg
         x7tQ9AwDs8fAQBbsD6Uq6TEYQP1xgoJJd74QE/x8LWgTdzr7tbOu2fw+uNksoAOLXaYs
         9TfQKo5bG7KUHG0cM/XwZH0y4uFpEMXg8JGSvR7qOGYfJ7GJ3W9IdIALyUtAy8JkNpsc
         d/icApJoK15gH1zEJjNNq8z+zMZ8dkfbYT/pf5RrbZmLFT0L690eQxGR7a9EKYKFT+oZ
         9EdBnAbMJLG9ledRiH/oE/RiIS5IFBoh90yoBH26XYaZZtvQXzrZbjlHMB0ci3kvVEU6
         XzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WRlPoU8j8jwPDdbu/iEeLTAULhB+gxL0ogeD+3+f2B8=;
        b=IrgPlGnToorCVOR8DC6zB4j9AkkXMi169LSEhq1m6SWvKITcaeqxMC2R+ohdUW/S7o
         iGHAvfJ4qdFJjD3C92gBKMdRtiPL9ICzRRZ2z4KIONHr4HG7ZHnr28Ds8cmmir+aYQE4
         BMTks0gqb1cSV+OI8UJCua7ycpIG/EkU2xltSK3O4owgjzabBV1Qu3JdywRdwe0HmvWf
         kuOu/0tmztuuJnaTiGl/ZzfDkmc7565HO/5zl71p6nwtCMS9Z/t70p94y2gN7Cy/2i8K
         i4vdSbfhDR1isqa/74yaWA53/iAP4D1wGYgokujtLnt3IoZz4vQy09uu3XCjf5uU9WFa
         hAgQ==
X-Gm-Message-State: AGi0Puao8Fp4GkAfFy80InPDtf+8yttlbFCW6Y2O6c35B1ggcDeTN6l1
        geGqoO3fsgkaSxY/4BVDKy0=
X-Google-Smtp-Source: APiQypLpGOzwYCoVWRsNFuzxi492AvUZ9/doRvpOE/SaJz+6ar4vHi/W99fz/ONEkCHGCi8ih75ecQ==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr20356795wme.48.1589365867783;
        Wed, 13 May 2020 03:31:07 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id n6sm23976073wrt.58.2020.05.13.03.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 03:31:07 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/14] prctl.2: tfix minor punctuation in SPECULATION_CTRL
 prctls
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-10-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <6322d3db-75d0-7539-b61c-252d222f932f@gmail.com>
Date:   Wed, 13 May 2020 12:31:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-10-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/12/20 6:36 PM, Dave Martin wrote:
> Fix a few very minor bits of punctuation in
> PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Thanks, Dave. Patch applied.

Cheers,

Michael

> ---
>  man2/prctl.2 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 1e04859..e8eaf95 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1175,13 +1175,13 @@ The return value uses bits 0-3 with the following meaning:
>  .TP
>  .BR PR_SPEC_PRCTL
>  Mitigation can be controlled per thread by
> -.B PR_SET_SPECULATION_CTRL
> +.BR PR_SET_SPECULATION_CTRL .
>  .TP
>  .BR PR_SPEC_ENABLE
>  The speculation feature is enabled, mitigation is disabled.
>  .TP
>  .BR PR_SPEC_DISABLE
> -The speculation feature is disabled, mitigation is enabled
> +The speculation feature is disabled, mitigation is enabled.
>  .TP
>  .BR PR_SPEC_FORCE_DISABLE
>  Same as
> @@ -1228,11 +1228,11 @@ which is one of the following:
>  The speculation feature is enabled, mitigation is disabled.
>  .TP
>  .BR PR_SPEC_DISABLE
> -The speculation feature is disabled, mitigation is enabled
> +The speculation feature is disabled, mitigation is enabled.
>  .TP
>  .BR PR_SPEC_FORCE_DISABLE
>  Same as
> -.B PR_SPEC_DISABLE
> +.BR PR_SPEC_DISABLE ,
>  but cannot be undone.
>  A subsequent
>  .B
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
