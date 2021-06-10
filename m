Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442893A3302
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFJSZU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 14:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhFJSZT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 14:25:19 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521DC061574
        for <linux-arch@vger.kernel.org>; Thu, 10 Jun 2021 11:23:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g12so600648qtb.2
        for <linux-arch@vger.kernel.org>; Thu, 10 Jun 2021 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gi/arimkSHwydb+IRl+gsdmHypvcrITgoc6X6YtJlzo=;
        b=CrpNFLANQtl2GqFCm/Mz6BQVoy4o0fpyIY/77ZSfpYBaIeULYm8mLaFcXsUWOrAoLX
         fUyrO2xKcER0ZP1XfghZP9dAZMU0rPFSlongJWsbBnFZR486z2lfsjXFwJ1ObzDnlAxH
         UbJ5ykLFkF8nMeTFIWNH6jwuqEHk1CbSzdh0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gi/arimkSHwydb+IRl+gsdmHypvcrITgoc6X6YtJlzo=;
        b=si5Kr2Hc1e6oNCAh2b6OFGEVcPRhYgiPNW/ItPGqtKz8169uAYayuYvhYrcToMRIJp
         w2ZBN6AIR2E1ZYwJl1BWlZe8Mi3ra0CfR26xBPLS2uQqlNdb+qInNLqFSd18rUbWmeoa
         p8FbDC4cN7strz5suZVYDfS6uX2cLlF6KdAxiEOEzwbwBhumtmKPtRfBlObE+5eyNfdG
         KOKeKKH8OSmd1LRxVgzrQK7g1Ha95MQQb/cBrifbmrBV7RE52L2V1QuOSGcN1rXMlx7i
         eEXkg5LjhT2E9hEPSlrmhqo7DAPUYqLF5lcgGcysjN9+fvf6ViC3VpeGD7FTwqwHYCcP
         znJA==
X-Gm-Message-State: AOAM531kT3+ap8l+tTafxNx3Lz0sRnUUBfC9bVX2nLCVZQHt0dn/aWAV
        rd+CR6hjCVyCQuepbzd+Yx22hA==
X-Google-Smtp-Source: ABdhPJzr/jg7uCK65jVADwAaDfKz6xQnTjHNB4oz9W8d9VnSPRV6hubXEEk8+XcP16M7322WdLinRQ==
X-Received: by 2002:a05:622a:1495:: with SMTP id t21mr98910qtx.63.1623349401115;
        Thu, 10 Jun 2021 11:23:21 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id k9sm2770435qkh.11.2021.06.10.11.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 11:23:20 -0700 (PDT)
Date:   Thu, 10 Jun 2021 14:23:18 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     David Hildenbrand <david@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
Message-ID: <20210610182318.jrxe3avfhkqq7xqn@nitro.local>
References: <YH2hs6EsPTpDAqXc@mit.edu>
 <nycvar.YFH.7.76.2104281228350.18270@cbobk.fhfr.pm>
 <YIx7R6tmcRRCl/az@mit.edu>
 <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com>
 <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <b32c8672-06ee-bf68-7963-10aeabc0596c@redhat.com>
 <5038827c-463f-232d-4dec-da56c71089bd@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5038827c-463f-232d-4dec-da56c71089bd@metux.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 10, 2021 at 08:07:55PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 09.06.21 12:37, David Hildenbrand wrote:
> > On 28.05.21 16:58, James Bottomley wrote:

*moderator hat on*

I'm requesting that all vaccine talk is restricted solely to how it would
impact international travel to/from ksummit.

-K
