Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030F81689D9
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 23:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgBUWOw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 17:14:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45435 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUWOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 17:14:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so1969599pfg.12;
        Fri, 21 Feb 2020 14:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W8KaZGmDosurwlNJD9BGtUyzNAa4jQOZ04o70/FjZgc=;
        b=kGkAs4Nbpvsh0LSiFUur6Wb/TbQ7PlbWJAOcbz65Qdv1Uw+Vl3ItNQQMcq77KAYZtJ
         m2urSGoIRXXmBgm7E9zWqbYRJ+5nnXrjCjuYwEMSV5irgIy80/nbHWZ2XU6OXDiBPYJv
         szqdDyeVflofbn6119zAg2Af45wfFrvegUCV58BoK/8EFrO8aWmVrRGB0AEm3jHvnZwq
         g1wiEIh+kkSJDiHR4tM7g/to6tuY6/ds7sh5OENeLGPrw7vXXN0mSnsFAVAAIUn5CXPR
         b8xb4ji8dTq0+IsQw7wVgeeGwqWP+aZc8EV+CmH2yRI8/SyKIhiNvK3/B5nUMCwO2jKu
         gxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W8KaZGmDosurwlNJD9BGtUyzNAa4jQOZ04o70/FjZgc=;
        b=UAlkI0guNtddGYE8vWPPpuxWNEgm2EEaoMCcCxoSc3j0hwpb3804V3R7yQ30u+oDB1
         /2RTY9rH6WaeyFr3yVsxypmZc8oCeDtzae49RCO+n6iWy2E5375I8Sy5vwVdnPATP4j3
         kUII0A+1pLVHhOaQIO2j+qqUk3sJsIwkSnHf0P9kaltYhQW2plrke/CIgLZMZ7pSbMJD
         tyyIMCD8h1vqYHm+ui72a9GMY2lvm1uCh/WI3SwDysRZ3fTMCgf5S8qaee/QhOMj4kQW
         ukcPyC79dm3HXAxuH/TDB/a+XDWGbl6mnIP0S6k8Z22V0ky0blj1bTX8RKL9MrnEq8qT
         sF1g==
X-Gm-Message-State: APjAAAXJKqF7ec4m9+ScflebulMjoyT+GykfySusl0FZrg+443M8h1Jz
        qI5LHYO8H2CNNGtkIHpVhUeNH4Xww5c=
X-Google-Smtp-Source: APXvYqzuFzGOe6xFIcYN9MIIJZs1pHKUSIf83YFRjQMgSwSuWxPGqeqGheyj2Ocv0clngLUDLTvy9A==
X-Received: by 2002:aa7:8805:: with SMTP id c5mr17210828pfo.142.1582323291138;
        Fri, 21 Feb 2020 14:14:51 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id h3sm4051033pfr.15.2020.02.21.14.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 14:14:50 -0800 (PST)
Date:   Sat, 22 Feb 2020 07:14:47 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] openrisc: use the generic in-place uncached DMA
 allocator
Message-ID: <20200221221447.GA7926@lianli.shorne-pla.net>
References: <20200220170139.387354-1-hch@lst.de>
 <20200220170139.387354-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220170139.387354-3-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 09:01:39AM -0800, Christoph Hellwig wrote:
> Switch openrisc to use the dma-direct allocator and just provide the
> hooks for setting memory uncached or cached.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stafford Horne <shorne@gmail.com>

Also, I test booted openrisc with linux 5.5 + these patches.  Thanks for
continuing to shrink my code base.
 
