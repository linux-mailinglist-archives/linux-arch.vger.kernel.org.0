Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604791A207D
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgDHL7x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 07:59:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDHL7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2020 07:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=D4AVwc5A5TrYE1qiofwcyRs9OblgHBTIRND69C8WOt0=; b=QxIpR9YcW4zlQv0D1PVx1O4w+e
        6AoH6P9DiQVnTVyvjUFva7uacxcWbVMzi8tT0sThE3M71M9cEiBynkFmchCvGJciEPmeo3/uQvlYR
        wtFUjR78EFF5ZyjMMkVUsanIFNIoeODac3xPuGtXF4l5LbiIBWKxhIDjLLLc1Q/GLriiDWQze3R+Q
        HzQxNu0emx30OMndXqf/TY05OZsMHUiUKaWMhp5bxRFdmw1Sri71kup0Kj2ZHNawF6DygdV6PDlKu
        t+Fxg7riz+HXeU7gVyNlLyFQTkfoS6xNo8kPMIJc0+vSNMB1EinNIuq4wvueXomTQU22Nkr4yCLgo
        zR0nVTaA==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM9Mf-0001Xh-5a; Wed, 08 Apr 2020 11:59:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
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
        Nitin Gupta <ngupta@vflare.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: decruft the vmalloc API
Date:   Wed,  8 Apr 2020 13:58:58 +0200
Message-Id: <20200408115926.1467567-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

Peter noticed that with some dumb luck you can toast the kernel address
space with exported vmalloc symbols.

I used this as an opportunity to decruft the vmalloc.c API and make it
much more systematic.  This also removes any chance to create vmalloc
mappings outside the designated areas or using executable permissions
from modules.  Besides that it removes more than 300 lines of code.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git sanitize-vmalloc-api

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sanitize-vmalloc-api
