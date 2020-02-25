Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1428116BE4F
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 11:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgBYKKP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 05:10:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35900 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgBYKKP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 05:10:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id 185so6936115pfv.3;
        Tue, 25 Feb 2020 02:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DyMpEJKs+8inuT3JzdxHRTYW4XbPRxYmHFS7rJcMiTo=;
        b=FxNo9rOoXFWu5407FfbtyWpGIRbj9KKxjTY8RxTKLZ/mRamBivEBBBF8o7iguYZCS8
         o7FmpgVAUMoOvpOlaV53Ni+rnyeUxpEmSlCDQzAgq3EMp5LZgTchDOR4Rtbjchc0ShZA
         xPmjexB8VS+oFN3Szxr7y2OW1DzelczMzVdBWqwUAnW9cqWia+40vQjvQcPpzoTafSwj
         w2kkhPlcAJE/2wVnad5TQ6WRXyttnLoLu3HSQjyg4YU5qRw4xBJMHDlPb6lt1f80TGTK
         EF8lLM32t+LGLvX18eHSOWak+36hGKwbYTMWsfqp7yTAuT5LIeNmjg2MjynP5A+0ch8j
         3Sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DyMpEJKs+8inuT3JzdxHRTYW4XbPRxYmHFS7rJcMiTo=;
        b=YOMINhG6XNmjQXBsK+ZvuF3P/8kmomItHNjEEBjI19LKzBgwPbM3T/30SPD4O4CvZm
         Nhz/GrI+uzP2DxPchPfBJmJ4HMXa//mMUnzIlu9MkwNJI5+BemdyANKm1ROKGGHJdu+l
         /SZC/CV3qy+m+kFthQtkYkuxFjsr+y+NRaC+bHpo6h+c7SZ2wjnRgy9DHVuPZ1xpEZAV
         DcRhzgBN2yMN8fE9H42q3Axn4xSXcVHPzQ2XCblR5/Pf1WT8SfJv+q07ZykS2iwrttB+
         NvJiuNvmNJuKwLwX/EbB7ntVuFeWjm7l4FGtI4Ikqy2ZotBoarWTVrH4XDUU2QyMtYoF
         fqpw==
X-Gm-Message-State: APjAAAWob8Hkxvdipii5svVA1uMqxKIJ1AntTgzSxpKrYbVOVN0DEojb
        V5+2xSTPJJ8E9NlF0wxZdAI=
X-Google-Smtp-Source: APXvYqz0j531hOiU4KYMfzFOo5zoLMaozISOegwSY9/l8Sa7mBFi1nfsYrnWAhTfioijX7BIKX/e5g==
X-Received: by 2002:aa7:946b:: with SMTP id t11mr55120817pfq.57.1582625414317;
        Tue, 25 Feb 2020 02:10:14 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id r7sm17083740pfg.34.2020.02.25.02.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:10:13 -0800 (PST)
Date:   Tue, 25 Feb 2020 19:10:10 +0900
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
Message-ID: <20200225101010.GC7926@lianli.shorne-pla.net>
References: <20200220170139.387354-1-hch@lst.de>
 <20200220170139.387354-3-hch@lst.de>
 <20200221221447.GA7926@lianli.shorne-pla.net>
 <20200224194528.GA10155@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224194528.GA10155@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 24, 2020 at 08:45:28PM +0100, Christoph Hellwig wrote:
> On Sat, Feb 22, 2020 at 07:14:47AM +0900, Stafford Horne wrote:
> > On Thu, Feb 20, 2020 at 09:01:39AM -0800, Christoph Hellwig wrote:
> > > Switch openrisc to use the dma-direct allocator and just provide the
> > > hooks for setting memory uncached or cached.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Reviewed-by: Stafford Horne <shorne@gmail.com>
> > 
> > Also, I test booted openrisc with linux 5.5 + these patches.  Thanks for
> > continuing to shrink my code base.
> 
> I just resent a new version that changes how the hooks work based on
> feedback from Robin.  Everything should work as-is, but if you have
> some time to retest that would be great.

No problem.
