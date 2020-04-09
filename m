Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB41A37A4
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgDIQAE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Apr 2020 12:00:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35139 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDIQAE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2020 12:00:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id a13so4312205pfa.2;
        Thu, 09 Apr 2020 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aQRKpekxDIbOTQGjAcEIQGsYobF8qM0SxjsCWTw2ZsI=;
        b=sih21yydVRFHZsFGgg59HNuBfeOLWxP9lrEPMN105FfVz58rnW/GDEcO4zsmsi+D4H
         wfVsCAsfHYhb74tml4QNYR7f9EYK10v4PgVx53AGyktrCWIvgakaRU3DkpUR+Lp5/V+G
         lLb/WOY+7lne5P6uJPBpxjiGqkkRjtOHRD+VYpIGgdyip5zJPYNfganUG5rlt+iX65Ia
         G+O1XkANhyv7aIffHK9DPrr3KKB0tuS8o3hYzz5dANw43pLgXhhewQpf8p3UQzu7jaUX
         vklovoYaq3tUs05JhS/KPyXwPS2z6JKDw0gxXTNpi9Odm5NtE18/784OJMXo1euPhq2F
         NSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aQRKpekxDIbOTQGjAcEIQGsYobF8qM0SxjsCWTw2ZsI=;
        b=ryIH6lCL9fNkiW/ajPCA9mke8HL3Du5neIEbHM8dODhD4xi5kuF2Fz1Mkxf5pra6k5
         ZgyKmiAsb4p02HScM24gmR3tEdk/gzw4Zq4rYrJwfazEXC/9Ppa34lk7T8v4AYy+dvWv
         edJdkyMa8Vohs0Iz2229MC8e+KZC14YteFQqGIY6mpL2d8PCdrIszhm3CJ+PrViOKXi4
         ohWoEUJO2W4CEM/wTfQfk41NxugUnbXZFYxtkP9BJXG2p13Zn3bjzpgNCqDL6CA+iii5
         N40ijHmo/8pY3d3nel5SkmdgV/YfLfXUKsEUr32om62rIgMZ1A777ktV7urXAOfbX38B
         fqzA==
X-Gm-Message-State: AGi0PuZNxoheX3oRcu4Zb/I40Md2RfUiunJYmHc4nPDGv/gPlpCVT0Tn
        wNyDIrvIszXqGyKZhXBpoaU=
X-Google-Smtp-Source: APiQypJjp3TKUZfafGLvg6qEU9KISYf3/iG0IoFzAvoBFmETLO9Bl0QvCAR/K1DmpfYnyGtmiu0e2g==
X-Received: by 2002:a65:580d:: with SMTP id g13mr110923pgr.45.1586448003209;
        Thu, 09 Apr 2020 09:00:03 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id a24sm10081726pgd.50.2020.04.09.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:00:01 -0700 (PDT)
Date:   Thu, 9 Apr 2020 08:59:59 -0700
From:   Minchan Kim <minchan@kernel.org>
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
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mm: rename CONFIG_PGTABLE_MAPPING to
 CONFIG_ZSMALLOC_PGTABLE_MAPPING
Message-ID: <20200409155959.GB247701@google.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-10-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 01:59:07PM +0200, Christoph Hellwig wrote:
> Rename the Kconfig variable to clarify the scope.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Minchan Kim <minchan@kernel.org>
