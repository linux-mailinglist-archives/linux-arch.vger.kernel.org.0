Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D228CC97
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgJML3P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 07:29:15 -0400
Received: from verein.lst.de ([213.95.11.211]:53455 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgJML3P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 07:29:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96AB167373; Tue, 13 Oct 2020 13:29:12 +0200 (CEST)
Date:   Tue, 13 Oct 2020 13:29:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/9] dma-mapping: split <linux/dma-mapping.h>
Message-ID: <20201013112912.GA13438@lst.de>
References: <20200930085548.920261-1-hch@lst.de> <20200930085548.920261-2-hch@lst.de> <20201011143327.GA251807@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011143327.GA251807@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks for the report, I've commited the obvious fix.
