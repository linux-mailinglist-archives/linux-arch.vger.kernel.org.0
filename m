Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD71D1120
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbgEMLVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732496AbgEMLVR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 07:21:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B6C061A0C;
        Wed, 13 May 2020 04:21:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w7so20417603wre.13;
        Wed, 13 May 2020 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jJGX0HJKQeSAIMx0QuPyHcLf5tHScfVxF8rrxRd+KcI=;
        b=ZynZ/iRcE0VPeKlcjAMhPW8FoWXbPsrMrp76LsfHrGYN2u3Aukqnhr/FYgUuZwsyti
         LbMvSIvBRKKFzO0BIAPm7go2rDQ/ImA2r0BlzSHGP91Rmsi1BAxy7Lbp77tlyrbxy5s6
         GDMoaqNZP3JoYQJLEVpBRcWeiDZ59FQqW4GOZWp1GcRnkh/+zPTYtmmcxb4ja4J9D4Xc
         6P4m+vWgs2mutMmnRfjGmup8qM4InsR04ZOd+qvCNiiFpySEezRW1/r6/+6R6eO6iXEB
         OoAt03DuTK6RyIjfySFsS/BgEJcN1ICg2zq0RyjMGtlM4v8MvzzGMMcBC6tEojtvrZT0
         qwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jJGX0HJKQeSAIMx0QuPyHcLf5tHScfVxF8rrxRd+KcI=;
        b=GIXF0mg9KePDICcFkIRuEuIFRaHnnq5dOSgoXdWr12Mr1StvbAtl6gujG5kVutd11y
         /xrr7gkWClWqkngcB2ciMqP+H2QLvZluoL5T6HII7iElOWfN7sA3z+jj6xTNB/+Mn6kW
         FQy8ORqeNmgqAjFfshbJnHIE+R7+aFm8fxyfn+5csdbCyRugl1ymJzEKBdIka2NqrR/j
         rqypxqD6sXyJiZVJTOmJjB4XUOQnIcR9hjGMBhHpsr+KL2lUYZiYe2GGEScGy+PL6TGH
         /fzX/ttbJAXv3RY1pvaAGRf99rU1KEvhx4im0aTNjiY1M3olsfBGP3A6jdKBwi/o/0OF
         6zQg==
X-Gm-Message-State: AOAM532b1hQJOkF8thipm87jszNkPdXYtgTydIOpSGjqHRhpmO8d65ZV
        J7AqoU16XXQCITLoz3FYNuNXfjaG
X-Google-Smtp-Source: ABdhPJx156skmH5/zruMIOwqYcn513DkFzRi+VMhpVx38bixqxdbWVhqP/3Rq3nuEfRvduOHtOamuw==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr7984918wrq.41.1589368875933;
        Wed, 13 May 2020 04:21:15 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id i17sm35842104wml.23.2020.05.13.04.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 04:21:15 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/14] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-11-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <bd548916-11c8-a53f-67b5-876c79088258@gmail.com>
Date:   Wed, 13 May 2020 13:21:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-11-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Dave,

On 5/12/20 6:36 PM, Dave Martin wrote:
> Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
> for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Thanks. Patch applied, but not yet pushed while I wait to see if any
Review/Ack arrives.

Also, could you please check the tweaks I note below.

> ---
>  man2/prctl.2 | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index e8eaf95..66417cf 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1213,11 +1213,20 @@ arguments must be specified as 0; otherwise the call fails with the error
>  .\" commit 356e4bfff2c5489e016fdb925adbf12a1e3950ee
>  Sets the state of the speculation misfeature specified in
>  .IR arg2 .
> -Currently, the only permitted value for this argument is
> +Currently, this argument must be one of:
> +.RS
> +.TP
>  .B PR_SPEC_STORE_BYPASS
> -(otherwise the call fails with the error
> +speculative store bypass control, or

s/speculative/enable speculative/

> +.\" commit 9137bb27e60e554dab694eafa4cca241fa3a694f
> +.TP
> +.BR PR_SPEC_INDIRECT_BRANCH " (since Linux 4.20)"
> +indirect branch speculation control.

s/indirect/enable indirect/

> +.RE
> +.IP
> +(Otherwise the call fails with the error
>  .BR ENODEV ).
> -This setting is a per-thread attribute.
> +These settings are per-thread attributes.
>  The
>  .IR arg3
>  argument is used to hand in the control value,
> @@ -1235,13 +1244,16 @@ Same as
>  .BR PR_SPEC_DISABLE ,
>  but cannot be undone.
>  A subsequent
> -.B
> -prctl(..., PR_SPEC_ENABLE)
> +.BR prctl (\c
> +.IR arg2 ,
> +.BR PR_SPEC_ENABLE )
> +with the same value for
> +.I arg2
>  will fail with the error
>  .BR EPERM .
>  .RE
>  .IP
> -Any other value in
> +Any unsupported value in
>  .IR arg3
>  will result in the call failing with the error
>  .BR ERANGE .

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
