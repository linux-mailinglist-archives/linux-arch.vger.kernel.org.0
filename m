Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8A1E5803
	for <lists+linux-arch@lfdr.de>; Thu, 28 May 2020 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgE1G6C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1G6B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 02:58:01 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862D0C05BD1E;
        Wed, 27 May 2020 23:58:01 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so30814202ejb.10;
        Wed, 27 May 2020 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=l30+XH7GIqcPUFeaZG9f/zXlLL1cUH8oN11gUUpIQH8=;
        b=t/IILzIyVUFJKLVaKcWqmVulVV3hiYboHW7owxFQMjo4HkTxeqiIsWaaSi3tTSXQGG
         JyD/vL32GnFKt7rYUM1qP4DY80SPsqSSuI2uxfO1vn+MwSc1L5ijQ6E62up8o9IT0NBW
         UWBqRM499LidI+guRHky7fd5LI/B9TwFXwQYqLa0Rt8jNCFftaM8QM1DrWDjje9TcDWx
         F2d62XVAKpy6CAMNUDe1YEBMiD7GOdU2wUX2wKiQWMXcI9hSto4X9kcyiZ0R7u9uHdJo
         x1utqSDzWcHW+N8BB20XbgfeOQTBLrU+50zkBsPrZjmLnfHUw+CagIdoSgh6Jy0SRJ2L
         ++uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=l30+XH7GIqcPUFeaZG9f/zXlLL1cUH8oN11gUUpIQH8=;
        b=t6Zyjz8aaBg6go9Jrk7EgnPRZAXKh2PYWQxP2JhilHXwfze1dpw2U5FUqz6CSjvX77
         uU3lyM6Lmlvobbjcl63uKkJpwtVPAO4pG/dtxvnljdt9BhMNH1kkX9Y+Ah8HnXt7V16D
         8KJTay1RtVwnletRswwn5XItNDUATcFSdW8xi34nvKLEeIcl9wByQDNXG+gIrjAVmBl0
         T9WJif4Q6bwXKAhMdraK0gxQma2IWDhY6I8Zakn350Eea+DCiSVOr1f4+11r9zMT+Si2
         o3ZTKlgDo5PNcWmAyYByVkeOKF7GVHGjDhqt0T+epDTTdjYO3Qyn2zZYcBb6bskDA0BK
         obAg==
X-Gm-Message-State: AOAM532Rjtl+SHJ6Hri8Cu4q42nDFdVe4xMAeLdxDSTHD/BnN2vyp6LN
        MUyEsY3mp64QTAu7JJZU8WOE5Z0U96qNZwtBDYw=
X-Google-Smtp-Source: ABdhPJwIUqdDsy4Ne4drAA5CiYn8Fuz53Xu/Z9G4g6JWO0nsFtF7JHCXsyBvqrV+JFPNGYy9fdNYyuD2DqhoY2pJa/g=
X-Received: by 2002:a17:906:8492:: with SMTP id m18mr1660565ejx.168.1590649080199;
 Wed, 27 May 2020 23:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com> <1590614258-24728-4-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1590614258-24728-4-git-send-email-Dave.Martin@arm.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 28 May 2020 08:57:49 +0200
Message-ID: <CAKgNAkg4P4GTVEoVXZd6yzpr97S0H+N8pdtwptJXaJBHfLAzKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] prctl.2: Add PR_SPEC_DISABLE_NOEXEC for
 SPECULATION_CTRL prctls
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On Wed, 27 May 2020 at 23:18, Dave Martin <Dave.Martin@arm.com> wrote:
>
> Add the PR_SPEC_DISABLE_NOEXEC mode added in Linux 5.1
> for the PR_SPEC_STORE_BYPASS "misfeature" of
> PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

I had already applied your earlier send of this patch (in a private
branch). I'll push those changes shortly.

Cheers,

Michael

> ---
>  man2/prctl.2 | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index b6fb51c..cab9915 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1187,6 +1187,12 @@ The speculation feature is disabled, mitigation is enabled.
>  Same as
>  .B PR_SPEC_DISABLE
>  but cannot be undone.
> +.TP
> +.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
> +Same as
> +.BR PR_SPEC_DISABLE ,
> +but but the state will be cleared on
> +.BR execve (2).
>  .RE
>  .IP
>  If all bits are 0,
> @@ -1251,6 +1257,17 @@ with the same value for
>  .I arg2
>  will fail with the error
>  .BR EPERM .
> +.\" commit 71368af9027f18fe5d1c6f372cfdff7e4bde8b48
> +.TP
> +.BR PR_SPEC_DISABLE_NOEXEC " (since Linux 5.1)"
> +Same as
> +.BR PR_SPEC_DISABLE ,
> +but but the state will be cleared on
> +.BR execve (2).
> +Currently only supported for
> +.I arg2
> +equal to
> +.B PR_SPEC_STORE_BYPASS.
>  .RE
>  .IP
>  Any unsupported value in
> @@ -1899,11 +1916,12 @@ was
>  .BR PR_SET_SPECULATION_CTRL
>  and
>  .IR arg3
> -is neither
> +is not
>  .BR PR_SPEC_ENABLE ,
>  .BR PR_SPEC_DISABLE ,
> +.BR PR_SPEC_FORCE_DISABLE ,
>  nor
> -.BR PR_SPEC_FORCE_DISABLE .
> +.BR PR_SPEC_DISABLE_NOEXEC .
>  .SH VERSIONS
>  The
>  .BR prctl ()
> --
> 2.1.4
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
