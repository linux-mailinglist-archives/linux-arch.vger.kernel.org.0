Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB51A26AD
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgDHQEK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 12:04:10 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58758 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbgDHQEK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 12:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y4DQEwKwOH0MUomtnsRqkgQ3Zf9nXVZUuXJQ4PCZDK0=; b=Sh3zQ4guix8l2EQIJKZhE1Lrz
        yLT0fiMB+n4O0i+C7P0VPwU+ufEnLVUErGzSwIXrmptFOBuUw5czJ04XwhnQL0zdhoSy13kV43rJu
        82WbcBn9fWYEgz9DrW9lJFOA+lTh5t1ChiKifhjhPOJ7P4/Dmq84NykyCcdnXtZn2v47dcQirQ6Hh
        a7TJcFZcA97Af/Setp/pqf+52MKYA/S2WaD26BT0wwGH5eVzoazup4gWe/wwdsUs/YWoID6yS0oXc
        usRQ4SJEUqRpP8Xs+UDgPVSfsJyg34vDTJaW4P5vGRyKHv3Z/mvREaNV3P4XglhN4nW7obgJ76tJA
        RnCdU8HGA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:35708)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jMDAr-00075w-Kb; Wed, 08 Apr 2020 17:03:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jMDAi-0001wo-US; Wed, 08 Apr 2020 17:03:24 +0100
Date:   Wed, 8 Apr 2020 17:03:24 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        bpf@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: decruft the vmalloc API
Message-ID: <20200408160324.GS25745@shell.armlinux.org.uk>
References: <20200408115926.1467567-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 01:58:58PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Peter noticed that with some dumb luck you can toast the kernel address
> space with exported vmalloc symbols.
> 
> I used this as an opportunity to decruft the vmalloc.c API and make it
> much more systematic.  This also removes any chance to create vmalloc
> mappings outside the designated areas or using executable permissions
> from modules.  Besides that it removes more than 300 lines of code.

I haven't read all your patches yet.

Have you tested it on 32-bit ARM, where the module area is located
_below_ PAGE_OFFSET and outside of the vmalloc area?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
