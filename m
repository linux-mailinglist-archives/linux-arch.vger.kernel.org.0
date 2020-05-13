Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0751D0ADA
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732279AbgEMIa0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 04:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbgEMIaZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 04:30:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB8AC061A0E;
        Wed, 13 May 2020 01:30:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so19764165wrq.2;
        Wed, 13 May 2020 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8l9HrcUFnk7kl0t2CmIVlAAJuCz/BXpTPIzI3hkWiBA=;
        b=uAEo1oCd3RKQgeafKRTc6XK3toSohfZ6YY2sfQqvyt4dH/Li/8vuIjRhFVyOaRkb8N
         bubv6gLtqn9Ncd4b7xp721kIvVZgOGrOq6P2h1jvK5CqCRXoj79JX6r3svZZMddLRSad
         TNbP8ga3zem/nujg/vrQBYTjViwQiEUXfxZWVa7bSdh56BXtNYexy+3rRRFeu7O+JwRT
         v8cGEVbxGMHCboZ0EbrKjpgKczEhIuhk8OVPSbqGqSuig6whJBXagLNzkMcifalny+2T
         oGED0+LeRQnKI7jcrmZNrRekmAqjaq93DpVzxLo9bymt/4mHLmNnrkrEzUoSaMP4QSoF
         gDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8l9HrcUFnk7kl0t2CmIVlAAJuCz/BXpTPIzI3hkWiBA=;
        b=Ck3LEEjQv/twrJGzPzqGp00l59TIPtBd3K0s9RucIxh/db1fE4tgtwJdcvjv4G91JC
         mEKbuagnKICL0oydkua/lKnKisY7tS7EE2RU/KS5Vcl0+Hm7LNfz/FDP7PCKrXmNGx1e
         34N5DwpIAHge9iPI34CfbUAQ8+rThzgeIIhYUOTHWwonH/1U5YtP4J1JI06+wvx5v1pR
         BogzBaVWqcBEg5ZmiAAIUIm2hKDqGk0Lf+lROaNpHl0PF0YSN33RrUsERHHiLMdKyFBf
         pwSA6MHdijQuQvIg/lJ4QANfYxzVxW80KSlaGKaIS/J7DyoSxsGwtipkT2nRi4oRIWAU
         hP8g==
X-Gm-Message-State: AGi0PubreKWQLXY/AHFVFBScdnCyBLao+sQGPMi2OXKFy8tXig73JzLH
        RtLcNeF4oRsaAFFLC1EoIgg=
X-Google-Smtp-Source: APiQypKYBs2sCuo3l1m1ENhx2oY7S1cH2Eu8OgQj7ADDfIbfWFZEz+SFvHs5upX8JcAk98tGebUI8g==
X-Received: by 2002:adf:a285:: with SMTP id s5mr32533885wra.60.1589358624147;
        Wed, 13 May 2020 01:30:24 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id v124sm35279304wme.45.2020.05.13.01.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 01:30:23 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/14] prctl.2: tfix clarify that prctl can apply to
 threads
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-2-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <d15dd1a7-4358-f08c-9149-4a70a7c339ee@gmail.com>
Date:   Wed, 13 May 2020 10:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-2-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/12/20 6:36 PM, Dave Martin wrote:
> The current synopsis for prctl(2) misleadingly claims that prctl
> operates on a process.  Rather, some (in fact, most) prctls operate
> on a thread.
> 
> The wording probably dates back to the old days when Linux didn't
> really have threads at all.
> 
> Reword as appropriate.

Thanks, Dave. Patch applied.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 7a5af76..7932ada 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -53,7 +53,7 @@
>  .\"
>  .TH PRCTL 2 2020-04-11 "Linux" "Linux Programmer's Manual"
>  .SH NAME
> -prctl \- operations on a process
> +prctl \- operations on a process or thread
>  .SH SYNOPSIS
>  .nf
>  .B #include <sys/prctl.h>
> @@ -63,6 +63,10 @@ prctl \- operations on a process
>  .fi
>  .SH DESCRIPTION
>  .BR prctl ()
> +manipulates various aspects of the behavior
> +of the calling thread or process.
> +.PP
> +.BR prctl ()
>  is called with a first argument describing what to do
>  (with values defined in \fI<linux/prctl.h>\fP), and further
>  arguments with a significance depending on the first one.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
