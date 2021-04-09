Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0833592A3
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 05:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhDIDKQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 23:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhDIDKI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 23:10:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F0C061764
        for <linux-arch@vger.kernel.org>; Thu,  8 Apr 2021 20:09:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d8so2038326plh.11
        for <linux-arch@vger.kernel.org>; Thu, 08 Apr 2021 20:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+nMIbA331gZ017Kv1DaJC+x8jGEIptaSKcTZoI0JL0=;
        b=BdwR1wCgFydJCUmPE+JRM63bwWPQb6enrE4kOSOAsyfeDithJlPJ4em7RY+EwKvSiv
         7BGHC59v+Nt0QVRFMvxdUcip3s5wGm9xUwuZxSbxJZqnXUBlrCWxvGIhd+gZJ2WsKl4z
         fbv700bUkw9/yj8+Nyt7n23U0VTczP89QQMfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+nMIbA331gZ017Kv1DaJC+x8jGEIptaSKcTZoI0JL0=;
        b=uQ5l4BkKQ5/3sUwdli0AVyCnfUVe46lDhIBBpdGCMq8jfE0cSHSGnMsYx6BxRtOmZL
         /HWd9Wcc0jsN8Cuuk7EFBUe6jnBJMsf9h/Hw6TTq81qgEdK6YjLzcCcGmubv5HMTGuEl
         6bPWQd6hwbV64Ow81OjEnVKjA3oN64tPHIkiNW5bOekdq197y2GpEo+J9C/Vw8K05r42
         wOuejJ7bSyjOAta2uAyVpfjq+clbDwU3ngf7YQb7PnnQ0Jrx14hpyjaBZ2Lt2w7yTeWf
         zhyUfGwA8EDUnA6QK/OzXv9pY470YhuGBBOM/pXSdfHz1o8oDFYWzE47iwpSj6jgqi1v
         /YJw==
X-Gm-Message-State: AOAM530otJRLdprkKYseZ3N9nqMTTvDf6iW6LPlz0+Stp268xHTWyobI
        vQ07+yiKmPrYj8E4Vzs34a4/kg==
X-Google-Smtp-Source: ABdhPJwKBOO9LJs6QqDup2F8LEFV9/9U2LnFQcD0hU8EBR42JzBpo+AZPQAGhoCJ0SS+hywMaacuhw==
X-Received: by 2002:a17:902:d64f:b029:e7:1f02:5741 with SMTP id y15-20020a170902d64fb02900e71f025741mr10668144plh.48.1617937796244;
        Thu, 08 Apr 2021 20:09:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z18sm686667pfa.39.2021.04.08.20.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:09:55 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:09:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: Re: [PATCH 14/20] kbuild: nios2: use common install script
Message-ID: <202104082009.59171B9E0C@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-15-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-15-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:13AM +0200, Greg Kroah-Hartman wrote:
> The common scripts/install.sh script will now work for nios2, all that
> is needed is to add it to the list of arches that do not put the version
> number in the installed file name.
> 
> With that we can remove the nios2-only version of the install script.
> 
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
