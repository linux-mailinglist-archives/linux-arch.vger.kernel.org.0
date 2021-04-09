Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DD73592A9
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 05:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhDIDKo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 23:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhDIDKi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 23:10:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8846AC061762
        for <linux-arch@vger.kernel.org>; Thu,  8 Apr 2021 20:10:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m11so3278841pfc.11
        for <linux-arch@vger.kernel.org>; Thu, 08 Apr 2021 20:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W/gxTebIuNNAwMjKB3+BU0hgs4+ZjFg2VBpLALBCaj4=;
        b=Lzp69HuDVcwoZM6gIfhTiGdsMicJC5qgLDxqnuVipvtmYxXh+0Is2AmRZgANnMl/Gw
         HE7lQupmx/xnuVlFIF8ZGi0sqfToAn8KfKhO6UweZZx6t9fk/pVvwsshMG7qOa0if7Wz
         /9FS4jYO2YeURqpZohFOIE76pETAllyl++qH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W/gxTebIuNNAwMjKB3+BU0hgs4+ZjFg2VBpLALBCaj4=;
        b=H3dANzAye/fTMhwDQbEGYEMNQQBC33wg4g/dOh1LrmyJTnfjurO/BsX26sZbNEzOt5
         9mgXjJzwrNSD+yK0ezpBLkiFkyPH9i1G5qYfsEGl9pd9ov7dtqqYHmK2MG+8c5fgbZo7
         H2xLJ8VQLRQIFJ1y5s4GZvO42G5w7BXwTpcv5AJRGhHEtVUDPQFuxxkZLgZPzrvkYfHy
         TaR1pBQO25OvOY3dmoukn4Jl+zlENTOvdjxiF7NcjfWuBpGaolTJUdM9mS63aacMYyjT
         tN9oZ3lKTIoSLrVX+XS9TEXePFkTexGxbBLMTVC0BirhnXTy52jJbnKEbTnSepARqVI6
         DXYw==
X-Gm-Message-State: AOAM530z4O00g7GFKQAc6SAmk+HKFq1u6YQDyPtD/ynZ9nYcv3QMdaI1
        3sVfnCdADnfcZXDbygiPfEk5RGTRT6IaLw==
X-Google-Smtp-Source: ABdhPJySgoPy+PEzklKXAxMILqgt3WPSJ2/LtblYYFapCX8p5to4reN2SIEv4hYSU5Egyjj/6jovQw==
X-Received: by 2002:a05:6a00:1484:b029:214:23e5:a4f3 with SMTP id v4-20020a056a001484b029021423e5a4f3mr10550239pfu.26.1617937826180;
        Thu, 08 Apr 2021 20:10:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c14sm676048pfj.46.2021.04.08.20.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:10:25 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:10:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 11/20] kbuild: ia64: use common install script
Message-ID: <202104082010.6976DE0B@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-12-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-12-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:10AM +0200, Greg Kroah-Hartman wrote:
> The common scripts/install.sh script will now work for ia64, all that
> is needed is to add the compressed image type to it.  So add that file
> type check and the ability to call /usr/sbin/elilo after copying the
> kernel.  With that we can remove the ia64-only version of the file.
> 
> Cc: linux-ia64@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
