Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26541A7C12
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502669AbgDNNOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502664AbgDNNON (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 09:14:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F5BC061A0C;
        Tue, 14 Apr 2020 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=s9wO1kktwKhWfxkNKBlR4BadnfNxuXVCWsOuMusKhWU=; b=rg2UNX+oDOoOmlIrOoATZfvHJo
        yXYLxsNWr2T1nJZrGxGk5Lv5RIM+MPtFqTLpUBL+OtQmXF3dvx+r/E34dM9LM/msmhlhCadHxgEIS
        pWLlsjvDOXkWGefwhB3ab1TbSjUnXSZ4O+DhmchdWfxHMd4ltbCqfxvArHED4bAzh+LrU5N0g8RQ/
        sMGiG1d5h+8y+YZLDA1ZDHHjyY6lnNQFIUnXfoqPK7R0pAFuXPpCBcPa9tHT3OZrp88howxBXTV4j
        g8suig+TIKVixAxTM0KrW7filVEfIW9iQoItZ9Ea9AdgUOMqiNFBCHWAFRBbLBwX140HeueDrEM53
        qriivVXQ==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLNu-0006Fe-Le; Tue, 14 Apr 2020 13:13:54 +0000
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
Subject: decruft the vmalloc API v2
Date:   Tue, 14 Apr 2020 15:13:19 +0200
Message-Id: <20200414131348.444715-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/misc.git sanitize-vmalloc-api.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sanitize-vmalloc-api.2

Changes since v1:
 - implement pgprot_nx for arm64 (Mark Rutland)
 - fix a patch description
 - properly pass pgprot to vmap in ion
 - add a new patch to fix vmap() API misuse
 - fix a vmap argument in x86
 - two more vmalloc cleanups
 - cleanup use of the unmap_kernel_range API
 - rename ioremap_pbh to ioremap_phb
