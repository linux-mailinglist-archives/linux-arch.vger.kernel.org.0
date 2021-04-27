Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840A636BD47
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 04:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhD0CZR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 22:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhD0CZR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Apr 2021 22:25:17 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6013C061574;
        Mon, 26 Apr 2021 19:24:34 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h15so18501613qvu.4;
        Mon, 26 Apr 2021 19:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Epce7Y/3bap3aJbKWMAz6YowhEr9vWrm6Tw9wo6KOtk=;
        b=AvmGPwceUM5kYOZHebAvAVvfRhD7iauNzWksDJHtJ77OSUD1n4R2DMEAkSU4JAjSiA
         wNX0pBFPRHrsYPXPY9ym59Xz2ZaHMiALDVQV7hT9dJ+HJEQXcDSd2BHHpfJWh7Gf4YcZ
         a427yq/G/pqBZkbQBFx37BJ+/xxtxYElaDK0l3q49qaX1z7E75WAcp5pMzkdYFHsqTJ6
         f0Bwl+IrNb15cQMXxgs7n/CZ6UY8CdwMhzxUkjpHm1PIO3Uc3/eMbWklc2Q9bjEiZvKt
         earNJngSMw/beAVMSNik3eewbvcKEYTM18gi608t4UZVF/QKk5KMXvy2Rjp4OIDYvM7w
         GdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Epce7Y/3bap3aJbKWMAz6YowhEr9vWrm6Tw9wo6KOtk=;
        b=QXR7A2hzCQI/MRxLf4O0qyu/T9xfu7R33nVN+kfkkdTSWvm4WvsCXiCVivr/EUUJUo
         4N7oiVvgElSuA/FRdM2Vr9D6wFoFjPbKe8owUOKmwtCKtl4Lo/50tgQajMN7wWdVADBe
         eAs8eOwsMycyzvRUM7YgmEz1RPeho/rWa2TwCBiKezcl/omJh9PoSCwnQeUYjE7iZFXB
         eYP2iFkEh8NP81aRl68AgB8OsmzjMhka6Wt68g0JVIf7waJUqvgLohMnU80NXlLSYiP1
         Iwc//NUg503vO+6a8RBIWTwYgsmwX0Kg71QJADIy/BAHFMDy4nhpjXnBVWqj/wmyljDT
         BJZA==
X-Gm-Message-State: AOAM530WonTopexsuoU4lpVooomeZl2V0MUlZMCzWZBGmjLU9ySf753v
        m1D1aM8q09IeAkXWIpkV7KX53pVLJ3k=
X-Google-Smtp-Source: ABdhPJy5lxVrvvrFE1D2xjRuw8lE74gb8Zmm49+KTMmRZV+Ulmsb/R49/hMDSGKo9Vf0/C+QwtqQow==
X-Received: by 2002:a05:6214:d6d:: with SMTP id 13mr21283135qvs.57.1619490273526;
        Mon, 26 Apr 2021 19:24:33 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id i6sm1919890qkf.96.2021.04.26.19.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 19:24:33 -0700 (PDT)
Date:   Mon, 26 Apr 2021 19:24:31 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] Documentation: syscalls: add a note about  ABI-agnostic
 types
Message-ID: <20210427022431.GA168962@yury-ThinkPad>
References: <20210409204304.1273139-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409204304.1273139-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 09, 2021 at 01:43:04PM -0700, Yury Norov wrote:
> Recently added memfd_secret() syscall had a flags parameter passed
> as unsigned long, which requires creation of compat entry for it.
> It was possible to change the type of flags to unsigned int and so
> avoid bothering with compat layer.
> 
> https://www.spinics.net/lists/linux-mm/msg251550.html
> 
> Documentation/process/adding-syscalls.rst doesn't point clearly about
> preference of ABI-agnostic types. This patch adds such notification.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  Documentation/process/adding-syscalls.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
> index 9af35f4ec728..46add16edf14 100644
> --- a/Documentation/process/adding-syscalls.rst
> +++ b/Documentation/process/adding-syscalls.rst
> @@ -172,6 +172,13 @@ arguments (i.e. parameter 1, 3, 5), to allow use of contiguous pairs of 32-bit
>  registers.  (This concern does not apply if the arguments are part of a
>  structure that's passed in by pointer.)
>  
> +Whenever possible, try to use ABI-agnostic types for passing parameters to
> +a syscall in order to avoid creating compat entry for it. Linux supports two
> +ABI models - ILP32 and LP64. The types like ``void *``, ``long``, ``size_t``,
> +``off_t`` have different size in those ABIs; types like ``char`` and  ``int``
> +have the same size and don't require a compat layer support. For flags, it's
> +always better to use ``unsigned int``.
> +
>  
>  Proposing the API
>  -----------------
> -- 
> 2.25.1

So, what about this patch? Mauro, are you OK with this? If no
objections, I'd like to have it merged in this window.
