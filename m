Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD511D0F70
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgEMKMA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgEMKMA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:12:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FB0C061A0C;
        Wed, 13 May 2020 03:11:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w19so13054214wmc.1;
        Wed, 13 May 2020 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F8y9Jq3gM4jt+LNkvpYhKwbQwo4514/fo/ZdMqLGLI8=;
        b=ZwMMB2IacV7HsQvoqLWpSW/PiCKip5jrhaEJ7G7o/FnK8EMktT4jR8gldcVq1mnLqY
         PmkeE2cXase8ji7LXMrUnPQYaMBRxVpMmuz+2NTmfILK9b7lHKIMQOqoL/oaLtOGci/K
         LU+3WUSnn71y/DNKTRgOybruZWs/HcI1B4F0athdTdJ3IPq5cl96IjU/NnqE0aNtZvpG
         oefus/KTRogocWbJ3XrgXQbVOPTrl4xrSGGKEKumPjY8NmHhJi1b4ijxHzWeEhHg8qps
         Z3xuGnX+5O7wRxcWAfg8J7W5TUEByDwzDFSn5C7I1n5dClks5G9AYpRsN7Et7WOdzLIi
         Im3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F8y9Jq3gM4jt+LNkvpYhKwbQwo4514/fo/ZdMqLGLI8=;
        b=VWmuF5UTDU2SzbjPlzHOQKduXnHuI6u0JQ3G+4zcygreGqOAwuCyLiM0DCCfmmvwdY
         BjeciJNUDHASZ5uM7vH5oy1JFAT0OgUY6eU24mIpwISYbTa6fHYYTbGCIQcmq1u2UiuK
         9cr1Y3kprbutpWFSUaWsZJrfuRy2xhuteh+a5RYDxttD0U1NVba3RFhu3c5X3MvyyWad
         svIuCNs3gQoUU2b6AvsaQjcLFDKfEOxIDzk2huGW2lCrdNeygNych0ixARQ/EmD6IPAQ
         KLRcB59k0w3DUfAM9++p/UEBLCSz0ixJ9y2AI95PF67YpPL61xP1FC9dNdVq5WhrUfcv
         qQSQ==
X-Gm-Message-State: AGi0PuYCZwg8gBCgnnPuC1lp5wD9WTfLRfyjV7kPNGkYA9nK3kE/MLOK
        iiCmHSNH7nODTeXt+27xOy4=
X-Google-Smtp-Source: APiQypIb3Ew6x0NQjcegMNVo8m/WukejRHFGgNTeBGsXzuC7NB3o64nEGlIwqb+R1DBBR4xV8CeyDw==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr33850615wmg.130.1589364718727;
        Wed, 13 May 2020 03:11:58 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id p8sm26376188wre.11.2020.05.13.03.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 03:11:58 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 07/14] prctl.2: Document removal of Intel MPX prctls
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-8-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3201c6e6-bd9e-aef4-fae5-70229e1b1abe@gmail.com>
Date:   Wed, 13 May 2020 12:11:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-8-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/12/20 6:36 PM, Dave Martin wrote:
> The Intel MPX API was removed from Linux 5.4.  See Linux
> commit f240652b6032 ("x86/mpx: Remove MPX APIs")
> 
> Document this change.

Thanks. Patch applied, with Dave H's Acked-by.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  man2/prctl.2 | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 7a3fc5c..a84fb1d 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -784,7 +784,7 @@ option enabled.
>  .RE
>  .\" prctl PR_MPX_ENABLE_MANAGEMENT
>  .TP
> -.BR PR_MPX_ENABLE_MANAGEMENT ", " PR_MPX_DISABLE_MANAGEMENT " (since Linux 3.19) "
> +.BR PR_MPX_ENABLE_MANAGEMENT ", " PR_MPX_DISABLE_MANAGEMENT " (since Linux 3.19, removed in Linux 5.4; only on x86) "
>  .\" commit fe3d197f84319d3bce379a9c0dc17b1f48ad358c
>  .\" See also http://lwn.net/Articles/582712/
>  .\" See also https://gcc.gnu.org/wiki/Intel%20MPX%20support%20in%20the%20GCC%20compiler
> @@ -859,6 +859,12 @@ had been called.
>  .IP
>  For further information on Intel MPX, see the kernel source file
>  .IR Documentation/x86/intel_mpx.txt .
> +.IP
> +.\" commit f240652b6032b48ad7fa35c5e701cc4c8d697c0b
> +.\" See also https://lkml.kernel.org/r/20190705175321.DB42F0AD@viggo.jf.intel.com
> +Due to a lack of toolchain support,
> +.BR PR_MPX_ENABLE_MANAGEMENT " and " PR_MPX_DISABLE_MANAGEMENT
> +are not supported by Linux 5.4 or later.
>  .\" prctl PR_SET_NAME
>  .TP
>  .BR PR_SET_NAME " (since Linux 2.6.9)"
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
