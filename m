Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D910B8FAEB
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2019 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfHPG1H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Aug 2019 02:27:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfHPG1H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Aug 2019 02:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uBlDv/1G+IgsUhlm43y/mFkJBkzGrCkwGGW4KRg1WIM=; b=Wmcwc0aj6CAeJvPoN6pBK5R6b
        i5YXqMFaEGami53EUAEYW5H9LP5RV2vw6BQ2GKNw4UVGF7Pwjge5MdyR82FT+o0xH6mc3+JoPhptL
        +tYQkTLvihOeG5Q1/uvFbymhEmW5tGt1hxdQ3AfdLRPHhf/t6XmTEoxxoyUliePoCJ7oYf5k8pNMq
        GEYj2QQzOjp49Cld+WmpqDus7lpxzFfO1b60p1QXD19DFumJMRiDYLdByA1yvWDGJ928Xf3gFMSKm
        TmzZ3hL9ygmIeis9H93XDRrqRmRUsN43ePZB8ghFZRniMK1PL78+NnUbbjavFiwzeazT92ZwSh6u2
        xE2vRzB6w==;
Received: from 089144199030.atnat0008.highway.a1.net ([89.144.199.30] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyVhG-0005Ro-J6; Fri, 16 Aug 2019 06:26:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Gavin Li <git@thegavinli.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geoff Levand <geoff@infradead.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: next take at setting up a dma mask by default for platform devices v2
Date:   Fri, 16 Aug 2019 08:24:29 +0200
Message-Id: <20190816062435.881-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

this is another attempt to make sure the dma_mask pointer is always
initialized for platform devices.  Not doing so lead to lots of
boilerplate code, and makes platform devices different from all our
major busses like PCI where we always set up a dma_mask.  In the long
run this should also help to eventually make dma_mask a scalar value
instead of a pointer and remove even more cruft.

The bigger blocker for this last time was the fact that the usb
subsystem uses the presence or lack of a dma_mask to check if the core
should do dma mapping for the driver, which is highly unusual.  So we
fix this first.  Note that this has some overlap with the pending
desire to use the proper dma_mmap_coherent helper for mapping usb
buffers.  The first two patches have already been queued up by Greg
and are only included for completeness.

Changes since v1:
 - fix a compile error in the ppc of ohci driver
 - revamp the last patch to get rid of the archdata callout entirely.
