Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1776235EBFB
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 06:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhDNEko (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 00:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhDNEkn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Apr 2021 00:40:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9974BC061574;
        Tue, 13 Apr 2021 21:40:22 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h7so14578974qtx.3;
        Tue, 13 Apr 2021 21:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9BCnDgTYwbVMwDnN4eWFAK2W985VQMQVft27SbY4QTY=;
        b=GGMyP8RVsvdwPgOFd1CrPyPEqN8Nm/Hz9bJ4al7HNqaQHbwGpUoldGFL4rgCniwC++
         R54j6hEUgTW6g40XFYedO4bqHV5aYZkeWjEoZKfmy+1aquWz9eZ0UKAjUghSlqAdaDko
         Zm4GvFZxi9uFixVDbsGLnI+skx91HjzGru6b4ExfM8lZyL/qZetVX1Nwt6ndwgtCNC67
         /v8FQEMkejGT28tvRZSbWG23VmkO6/exbjz/4IjXytXtoFeUntk8G7v//sOjoGojl7Qb
         YXp2KcaVl6JmiJvExO/QVXHeoqGcR3KCp7DNr7h2fXRLjPgRk+y5YAd24mQAtCutMMqh
         TY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9BCnDgTYwbVMwDnN4eWFAK2W985VQMQVft27SbY4QTY=;
        b=by9gwWuNENQ9De9iDw7mPPYrlqUohv0YCE781holozKHhLT4ADcKB+Zu4Dqd3WfobN
         5Afjjm9aMNv2DgDrUSIzuGTqLNc5MO6GZVhrgYtp9b1AIMGrt9iTEO9qOM+FMgrhhbeJ
         21Filqp1TWzzkUeXrLAxdj0aXrCtdXAwDehrKlPI/dWzDbE0aL2vf3x/tHZbXKu3iWn1
         x7AXx2ycE0mdP+0LOlkd7nreocK2Q/KfZlVsxp536FWrJ2B4G3D2K0I2LZ+JfkkZOrkh
         DVKtxyqsitsxfknGUainXd2w5XXb4hiuj4Rg05Kp289vzthi4i028iuDoowcOVqsc2Zj
         WWfQ==
X-Gm-Message-State: AOAM530JLX1bjOeNj3R6Xg0U0vtcFQV4FQaBHUoMWkti+vmoAdJVZczI
        9XaNokKkBS3id8BeZzKJuaBZ9hfhguE=
X-Google-Smtp-Source: ABdhPJzXKIUj0I/LTjOOZ9Q3r/ZvWXA4butRYDA48FJpRVe3BL+JVdYczzYZf8GtnewuKU+2251ylA==
X-Received: by 2002:ac8:59c9:: with SMTP id f9mr33576466qtf.234.1618375221607;
        Tue, 13 Apr 2021 21:40:21 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id l24sm2625079qtp.18.2021.04.13.21.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 21:40:21 -0700 (PDT)
Date:   Tue, 13 Apr 2021 21:40:20 -0700
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
Message-ID: <20210414044020.GA44464@yury-ThinkPad>
References: <20210409204304.1273139-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409204304.1273139-1-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ping?

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
