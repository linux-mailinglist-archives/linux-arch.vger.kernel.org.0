Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8083D1E5818
	for <lists+linux-arch@lfdr.de>; Thu, 28 May 2020 09:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgE1HCM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 May 2020 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgE1HCM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 03:02:12 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D317C05BD1E;
        Thu, 28 May 2020 00:02:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z5so30897622ejb.3;
        Thu, 28 May 2020 00:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=WaItKJRCBat4XMITP05DOJ0vrN7SQihwq33TZYRmdLs=;
        b=n7vVqx+Z5lnOfcJhZGB36iMnkqTyTgkgBJGJUOOwzYsjkaYIHKFDhL6D+2d2S7eHbe
         RALIc54ulwNDOBjj1iK3Wgmjde11GdMHywyEdRGwCtcaX0Md3GRE8ZJHjM8mFO/ZCQvX
         mClUbvdTMgsEd641E8lm2ST88yshg4Otc6X+ZJuzTYfgjgrRf4i6NmzOGk5rLOYr8YCd
         McfCsuNW4XGwUT0aGxqX1jtWIbG3Ta8+LIPj2dn7+bXZuMY219gG8iBz2hN+RXY1pnuN
         pZLTKXzlsI75VIMNUELkniiwoL1lyZwSthy/27kvRh+kt5FYOoWPBaauZwiZghdC/I9+
         7oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=WaItKJRCBat4XMITP05DOJ0vrN7SQihwq33TZYRmdLs=;
        b=d3/TOPJVlziQ+fc9IrzjHdKY265UHKqAFATMyFILbSGVeLLg7P/mdV96Z1DJSs+awu
         68uu1NNl8RCaWJmLdA4oZrh90ItR6Mw+M1MTqTUU0t2tz1bG5eMSea+irhp0pGJee7yz
         I7xAZztuk/LxY4EKE2y6KgvSmezWVjh1eu/KOCddRXfwr3wrxHYx1VWFIZE3b1oJyMP8
         XjOB4/PRb6tGbQ1+iYSEc0CLiTODIThzCDB9TEub5/wbdlhPPMVCkM5dlxe39PpjAK4V
         IKoWikoYUQt9AGEcGB0JjjhUAqMiY6v59CMZeBTaaKvEj1rTn7DAgMq4km/W9jrtGwXR
         fb5A==
X-Gm-Message-State: AOAM531FCbNF4q+nA5fkEnvnEe0Ff1+L/K/DyFJdPWVBoA8O/E5yBsf3
        VYE0RAeMg3bLHqgWTyUUeNofenP9W8MqMwbxNno=
X-Google-Smtp-Source: ABdhPJxtQKImAJSqXwa6UQU7yyDXiXDfNjBoTpRYI3HzUIJEZ9dzVyLB6BZLFSMGOK929j1yFP2fQ3GuU9HZceHtCZ8=
X-Received: by 2002:a17:906:2dc8:: with SMTP id h8mr1816818eji.108.1590649330841;
 Thu, 28 May 2020 00:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com> <1590614258-24728-3-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1590614258-24728-3-git-send-email-Dave.Martin@arm.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 28 May 2020 09:01:59 +0200
Message-ID: <CAKgNAkhwYASEM+wqaDZQ-ftcB3jnsVN2cXq4E_1ep1rqv+4aLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On Wed, 27 May 2020 at 23:18, Dave Martin <Dave.Martin@arm.com> wrote:
>
> Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
> for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

I had also applied this patch from the email you sent earlier. I've
pushed those changes to master now.

Thanks,

Michael

> ---
>  man2/prctl.2 | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index dc99218..b6fb51c 100644
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
> +.\" commit 9137bb27e60e554dab694eafa4cca241fa3a694f
> +.TP
> +.BR PR_SPEC_INDIRECT_BRANCH " (since Linux 4.20)"
> +indirect branch speculation control.
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
> --
> 2.1.4
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
