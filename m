Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9971835D1
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 17:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCLQDu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 12:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgCLQDu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 12:03:50 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1E5206FA;
        Thu, 12 Mar 2020 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584029030;
        bh=8013QSNjwl3hVjqclDefXb05VNEWtFHh+9iu+zc6Ugo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r1FbKQMBSjx+u0m/DW4h3Pl+dtRquD3/XyVqRDGIg8vvMoU9Z5E79l4H5v70Qu77i
         qrmaRR2f6kVk3o6FLsq/rljo8kZas1fNZADsxIHzsIhT8jBkrzVvGW/V7bSzu0YL+D
         L2xN3GiwpuAn+Qeo77aa90Et45se/H8aJwJ1AJYk=
Received: by mail-lf1-f41.google.com with SMTP id b13so5277712lfb.12;
        Thu, 12 Mar 2020 09:03:49 -0700 (PDT)
X-Gm-Message-State: ANhLgQ34x+CkQmo7dN3X92wLxQohQszOfOUdZKIOO/TegldnoMEBorf6
        HgMZO+p5lx9uLQeKOulrUJ/X2rYMS3iA6J3CzqA=
X-Google-Smtp-Source: ADFU+vuoqiRPpALaPb3vAH2E88rNtmGTNcB/OqxahlgrnaZFB5AhQlWmriyJa0LvZSP3nMz82H3GA8VVRfVyYeyWYZ4=
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr5770907lfg.70.1584029028030;
 Thu, 12 Mar 2020 09:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <1583854376-15598-1-git-send-email-majun258@linux.alibaba.com>
In-Reply-To: <1583854376-15598-1-git-send-email-majun258@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 13 Mar 2020 00:03:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRFj=aQYHgM6KV7GYM22Nti8D2q_QNi+5WhOHS9-86Wew@mail.gmail.com>
Message-ID: <CAJF2gTRFj=aQYHgM6KV7GYM22Nti8D2q_QNi+5WhOHS9-86Wew@mail.gmail.com>
Subject: Re: [PATCH]arch/csky:Enable the gcov function in csky achitecture
To:     Ma Jun <majun258@linux.alibaba.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Thu, Mar 12, 2020 at 4:59 PM Ma Jun <majun258@linux.alibaba.com> wrote:
>
> Support the gcov function in csky architecture
>
> Signed-off-by: Ma Jun <majun258@linux.alibaba.com>
> ---
>  arch/csky/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 047427f..9c4749d 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -64,6 +64,7 @@ config CSKY
>         select PCI_DOMAINS_GENERIC if PCI
>         select PCI_SYSCALL if PCI
>         select PCI_MSI if PCI
> +       select ARCH_HAS_GCOV_PROFILE_ALL
>
>  config CPU_HAS_CACHEV2
>         bool
> --
> 1.8.3.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
