Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3E1D1034
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbgEMKs4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgEMKs4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:48:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC18DC061A0E;
        Wed, 13 May 2020 03:48:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y16so13120415wrs.3;
        Wed, 13 May 2020 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sO6BEKMLJDnGkUHjWQKUCP+ZMX/Ww5RqBHbOyanaXJA=;
        b=aly/NyYQrfZmTDdjjX0N7GhJJxddUzBQDRMzhy2jAgnfv6XLG+emDrnDB6w5Idc/IU
         TG3gybeup5BLkvP/+TBj+S3HidnwRr4T4CljOHE/nudbJCxvjnveHSQpWPMOGEyUhr2o
         M6RQYzW8iHAKKIa/LAvNbBdpSCeb08k4NmGblEttU0cOr62an5t/KKoZ8E90xgU6OCls
         P4RJd3+iVYW4j0wyvwPvJ00SpkYl5zn1Klzp2qyG2Ds4u2w67MZR1dmuBiv8CZh2lkww
         HONB/90Oo8RRJgylca7IAeAE+3yZPPsgZnt1bL59pgKeybrBnrLjzDEEWIxs+gZS1m5P
         QpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sO6BEKMLJDnGkUHjWQKUCP+ZMX/Ww5RqBHbOyanaXJA=;
        b=gtwdxkteQuWHF6Rr248OGbT6dcleI0faoJAZeafE8OXfKyO4hBMC5nfIFM1qtbZZtO
         +st7Pz0++etPNipaLL03HqkUzN6UTO6QoLu//zri5N/RtLnyZtE/off0d2spn962Kmzh
         MhM72nk7dZKE9B5OyBclX/6h/QHPDU/6+YMUoASYXgbiYgXqt7Y9KzGcqfbjBfnX4KH/
         FRN65J92aSWgLYgP2hFKJ4EbJoNiFpiSVus+8HETYjNYsEHwGFkAP8OC8C8Kc8rriOMD
         u/3dDdYtliDyns1uTecu7FBUEA+mlrY+bOid7DiI6Z9ifqyRc5aFmgAT9nJOEHygDhdW
         LAxQ==
X-Gm-Message-State: AOAM533GCsB9JPq2uPJn3Eg4nl/sNe5J1UcshF5cPSOywfxyjsmJr+H3
        XDWrdzARvgDKn7UcP1kILP4=
X-Google-Smtp-Source: ABdhPJwZuFy2lPpOfVeUIpq8oWa8K5Ux3L8zpnGkjtAWw18u7oXEDFSPBvFtH8JtgZxhwWzqe3QIoQ==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr7598535wrw.256.1589366933342;
        Wed, 13 May 2020 03:48:53 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id l18sm5516910wmj.22.2020.05.13.03.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 03:48:52 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/14] prctl.2: Clarify the unsupported hardware case of
 EINVAL
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-13-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <12b559c1-21c9-833f-1a5e-37ddad284880@gmail.com>
Date:   Wed, 13 May 2020 12:48:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-13-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> prctls that are architecture-specific won't work on other
> architectures, and arch-specific prctls that manipulate optional
> hardware features likewise won't work if that hardware feature is
> not present.
> 
> The established pattern seems to be to treat such prctls as if they
> are unimplemented, when attempted on the wrong hardware.
> 
> Cover these cases with some generic weasel words in the closet
> existing EINVAL clause.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Thanks. Patch applied

Cheers,

Michael

> ---
>  man2/prctl.2 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 2361b44..7f511d2 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1616,7 +1616,8 @@ is an invalid address.
>  .B EINVAL
>  The value of
>  .I option
> -is not recognized.
> +is not recognized,
> +or not supported on this system.
>  .TP
>  .B EINVAL
>  .I option
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
