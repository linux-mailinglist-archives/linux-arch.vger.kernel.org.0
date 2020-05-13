Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3A1D0FD5
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbgEMKbC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732741AbgEMKbB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 06:31:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A1C061A0C;
        Wed, 13 May 2020 03:31:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so25935334wmj.3;
        Wed, 13 May 2020 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=enpUZvjkQss8gHomlUnSJVUnHMRo4OMFu6aNUmI7cJ4=;
        b=YJZXUtqvodAsDEAf8liUg5EebEMCVfcwdF+S37QudHwBTaFeVTXICF8fmGc9hsSbEU
         6mO1q2+iQpPOvTiAgtCtWscTusqwUk4WfIO/+P9a7N60X8ffCDAdslOtQUNe4T/4d99k
         iqxgILhx9JssUqZp7/yNm92/C8mDTTISFKYlX9hfZFgwBf5OhMuAUsWaAvbnjbycyZJD
         CQqmOQj2dFgywfolXjGcPfHc/ZF7Qiuo2oeNvkcVYzamt5i6FQtsixGNVm2L0JTGKbh9
         JMBAY1IIDLnYLDdp5CHPoOfg58WTWRhVdp7GX6IFdJEULr3wPb+5XSP0aBcZ5S9yoGAg
         g0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=enpUZvjkQss8gHomlUnSJVUnHMRo4OMFu6aNUmI7cJ4=;
        b=tyn3flNWqHk4Sc7lovm4nNSQvCOUisk1AKBUbhRIh9W6J+5GqDJ5DAPmjpBGqtTec+
         WbC8pxOm4ZphX8Bngn4M1DROmJ7g7GS+6vyzfjA3p/9aqxIx3T3NrrPXkdedAPQ3nHXR
         Ke94YhBw5Kjg//rLKdcntGbCl5dcHRyASOkcuMW888Sa1e6W5XgwVz4tCHP+z8gIAEke
         FSSqkL2JSQv1McxBld0nJ3qP7QAKLPhDd0K/dDnqcZ8rCd7JN8hnjodV9Rpn8f3Uy5d2
         SFla8EeTDqClVTZo6X7aJTVozd4VC5uHbIJBT1xZqH2ovWoTB4dLhaKCg0XLgsyg84uo
         fBnw==
X-Gm-Message-State: AGi0PuZUg7Q62CkMVGwXyZb+0RmcyBqJ/K8EF5umCUXUhO+Txtl0qPuR
        u4GbvfNCl8EmExJpyIcyeh7B10Xq
X-Google-Smtp-Source: APiQypJQORUtkZqQlGqp/s6dtCIjUd8w0QNwTR/GG97rIJs3hRduo1O9Z1SpkPRdRxCUbOTLcXc4Zg==
X-Received: by 2002:a1c:b354:: with SMTP id c81mr34844461wmf.136.1589365859942;
        Wed, 13 May 2020 03:30:59 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id h20sm14642904wma.6.2020.05.13.03.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 03:30:59 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/14] prctl.2: Work around bogus constant "maxsig" in
 PR_SET_PDEATHSIG
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-9-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <4f7bee2a-1db6-1cf5-6561-b24397c33707@gmail.com>
Date:   Wed, 13 May 2020 12:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-9-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/12/20 6:36 PM, Dave Martin wrote:
> The description of PR_SET_PDEATHSIG refers to "maxsig", which is
> apparently intended to stand for the maximum defined signal number.
> 
> maxsig seems not to be a thing, even in the kernel.
> 
> Reword to use the standard constant NSIG.  (Discussion of SIGRTMIN
> and SIGRTMAX seems out of scope here, and anyway is not relevant to
> the kernel.)

Thanks, Dave. Patch applied.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index a84fb1d..1e04859 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -955,7 +955,9 @@ will operate in the privilege-restricting mode described above.
>  .BR PR_SET_PDEATHSIG " (since Linux 2.1.57)"
>  Set the parent-death signal
>  of the calling process to \fIarg2\fP (either a signal value
> -in the range 1..maxsig, or 0 to clear).
> +in the range 1 ..
> +.BR NSIG " \-"
> +1, or 0 to clear).
>  This is the signal that the calling process will get when its
>  parent dies.
>  .IP
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
