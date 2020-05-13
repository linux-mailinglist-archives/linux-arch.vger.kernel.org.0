Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841541D0AEC
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 10:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgEMIgv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 04:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMIgv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2020 04:36:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D0BC061A0C;
        Wed, 13 May 2020 01:36:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id v12so19732016wrp.12;
        Wed, 13 May 2020 01:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9RyZJv7HY0Ixg7ftiF9ixqiE/9e7o2gZum7cB+e4h0Y=;
        b=WVP/C7F+2cJKAcbrifCxGKV7t16e5sHZQL3vut7Hfp5rd+UyGwtmjdvAW1voAeqolu
         5ugydIP1OQohKqJvisjZ4lB2qpQTxAmc07MvBs5I7OksQ/Gi3GEEpMk5eXjn/5vbqW+O
         o6Ang5Hy6kGv3D+aZIGzxQG57Uh5Rw5YZjET9GUtNInPuYdpB7Fy76Hpfndfxhk33i+s
         DDQrnk1paUDAx7+5eBq1cSO0Cx9CQqz2upP6KO9SLql/cOhsDr413fk7OqDsmkpp3WMP
         L1CXbRYpuzQ3e7SbY/W1R2BaXVn9XJVss5Z9ecL56Xn/zmsk+6XS55KIq0kxa4u/ggRB
         0dKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9RyZJv7HY0Ixg7ftiF9ixqiE/9e7o2gZum7cB+e4h0Y=;
        b=ag95tr2gt55PRxzFUdmwrLfnQNLvKOXvq/FVv3ES5colDz5d8hxQYk+34ZdOGdrcvq
         2qVD2g8M4Dd9m0Z9Dl0tqLHtxgCtJdvC96W0uvKQgQbmgOxh+XVMxDvkFU4w+oeqM+qg
         rRUSMiSqrjE1Q2DgLEBHgqfMOtw28yROdaKnbeDHMdjGykNcyOznsGl2GalnivDXlXnR
         6Z9u7yKlnJOY4NQtLkYqakxSEdolxdi4AUgcon48pS5G7SkJ4LUva4drAO3NBBHCs9Lh
         bJG2lDOQqYbYgm/QuVIKacfr33owcOTk+bTYiEz+vYukcWO3oOer4ReWqxnabupNvcq3
         9I6g==
X-Gm-Message-State: AGi0PuZLzuj2JzvaWqNwGxzQPzaAUc7wTTT7ZuPkOkAi3s+RtApDUiru
        lv4OivI2Fe6AEEdrvk4fV7TB4qnb
X-Google-Smtp-Source: APiQypKBfhCCUB9bek4i/DCgmt07/TQF/wJbvJEj9l00SAnbye5VS6xrLivOh50PqZsHdYfmkcJEmw==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr27919089wrx.291.1589359009404;
        Wed, 13 May 2020 01:36:49 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id z7sm26435557wrl.88.2020.05.13.01.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 01:36:48 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/14] prctl.2: tfix mis-description of thread ID values
 in procfs
To:     Dave Martin <Dave.Martin@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-4-git-send-email-Dave.Martin@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <8e93c847-9fea-26f0-f872-42cf35d5f8f4@gmail.com>
Date:   Wed, 13 May 2020 10:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589301419-24459-4-git-send-email-Dave.Martin@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/12/20 6:36 PM, Dave Martin wrote:
> Under PR_SET_NAME, the [tid] value seen in procfs as
> /proc/self/task/[tid] is mistakenly described as the name of the
> thread, whereas really the name is on /proc/self/task/[tid]/comm.
> 
> Fix it.

Thanks, Dave. Patch applied.

Cheers,

Michael

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  man2/prctl.2 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index a35b748..9736434 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -808,8 +808,10 @@ and retrieved using
>  The attribute is likewise accessible via
>  .IR /proc/self/task/[tid]/comm ,
>  where
> -.I tid
> -is the name of the calling thread.
> +.I [tid]
> +is the the thread ID of the calling thread, as returned by
> +.BR gettid (2).
> +.\" prctl PR_GET_NAME
>  .TP
>  .BR PR_GET_NAME " (since Linux 2.6.11)"
>  Return the name of the calling thread,
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
