Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB47316BE4A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgBYKJs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 05:09:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38167 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbgBYKJr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 05:09:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so6928301pfc.5;
        Tue, 25 Feb 2020 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wh/aV6f8G9P8NFi86qh7LhwbQJ/WhimCuc3W3RTKcZE=;
        b=KFlPaymx0DYUd8m3GIFgxt2xLl5otTfghyORLQBRAKY/JXiEDUAVl14Fq0LOhXd3OP
         BYs0TTqBSzUJQeeX7D3QoHk0dHWQ31xJXe+Yhrn6loPk/pLsuoBW+58LUUXeOXRh5c4w
         kffKXxC0pxA6WaWERdiPRpxhwX4LvfZiHeRe4FHKqZqX9dnUHAkMt105JgVtuxkqstNQ
         vsXEPlFVreZI4LBgeEL7pSmHeS89OnPs9SVG1whCPo0FQwDWSHtqcR46u2munqOjGTcX
         ihNvpq9o2/M6Upu2oD0eRNWLuFAl9lX6S9T4Zfx/vjya35tC5JBP2LWBRFdbbFNtXaRP
         EOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wh/aV6f8G9P8NFi86qh7LhwbQJ/WhimCuc3W3RTKcZE=;
        b=Zz5GYATvtMAusECLILgCSVQDl2qaM7nXX0oIDFDOjQAzCbIwW1N+E4FHNANa7JWppn
         xtLRLmqJrBHMVHWyxvOFVCOflBq3PQv8EUPdx8dAyJeBPMgfAbhdptQyMB4OxID7AQNk
         jglSFmZRyNF4d92diAqxTcdyBEAslPU90eqcqxi912/gfuSeLG3v71J++i98/LX5sM5N
         bfhVz5COow5Q7+m8y6XfMLL4yTN4q3G7h8u0uvB6IGf5Ilm0KFRtlU2QCT7QFfj9gooa
         S5qtttun6UaqHJe6eQ2TjfGu6yA/++r9F0TJ2ojgzuPpqn/5X45xVrTzBc5T3WAPrDpI
         TW7w==
X-Gm-Message-State: APjAAAULta+FY4tFefb481HMAqtj1wuoncdFtPpDccDXTzsozG2tJS+x
        TTTQWx2kn74EvRPPEKDCXOM=
X-Google-Smtp-Source: APXvYqx8Yfc4lFhAWYyQXx8bh8cKTSKSygqvlznUOWE2jNOZJYYzwPYWixn6hqZq7vx8iXGletOiug==
X-Received: by 2002:a63:3c4b:: with SMTP id i11mr58936564pgn.123.1582625385752;
        Tue, 25 Feb 2020 02:09:45 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id b27sm16151184pgl.77.2020.02.25.02.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:09:44 -0800 (PST)
Date:   Tue, 25 Feb 2020 19:09:42 +0900
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
Subject: Re: [PATCH 5/5] openrisc: use the generic in-place uncached DMA
 allocator
Message-ID: <20200225100942.GB7926@lianli.shorne-pla.net>
References: <20200224194446.690816-1-hch@lst.de>
 <20200224194446.690816-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224194446.690816-6-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 24, 2020 at 11:44:45AM -0800, Christoph Hellwig wrote:
> Switch openrisc to use the dma-direct allocator and just provide the
> hooks for setting memory uncached or cached.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stafford Horne <shorne@gmail.com>

I also test booted this series with linux 5.5 on my OpenRISC target.  There are
no issues.  Note, I had an issue with patch 3/5 not cleanly applying with 'git am'
but it worked fine using just patch, I didn't get any other details.

-Stafford
