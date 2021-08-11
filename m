Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186603E8A47
	for <lists+linux-arch@lfdr.de>; Wed, 11 Aug 2021 08:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhHKGkZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Aug 2021 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhHKGkZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Aug 2021 02:40:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F77C061765;
        Tue, 10 Aug 2021 23:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wDtqYRYWlWPnT0PCudtoRPv80QSFhqOeRGIUg0AkvSc=; b=svimTblmN88zLa/SIpuezncrKK
        3YOLns6srJ40UXmLoVyZZCEgRT/6eXrZUx0iaJBk7KYkZH7AYHdvVGnEV8PQ0FMazfltwbyU8ATWf
        LxRxxzVroLEdXyJTmc+nN1ArBV+Pl/8L3VN6xmqZsy2Yw6r9+r2N5QbtEvXNUR5cfmS/fLhEFendc
        qZ6cm9SpI3NR2ZUZOLxh2Sa4R4XoaPDHZzINJuTbNnIAbRnNfqIDF2uVMTpe5ehEAB0c6wa6z7yCR
        tXZLJPtjKNUyOglBgNgXhjfW85LdFtxhlSm2DY0CyAEJMrnk9n2zmskjoiS/vkXPR6LIqG1IEek35
        5TnLpeMA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDhtY-00D58g-Ub; Wed, 11 Aug 2021 06:39:24 +0000
Date:   Wed, 11 Aug 2021 07:39:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 00/10] ARM: remove set_fs callers and implementation
Message-ID: <YRNwmGL2b52dQUuv@infradead.org>
References: <20210726141141.2839385-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726141141.2839385-1-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From my high-level perspective this looks great and I'd love to see it
merged:

Acked-by: Christoph Hellwig <hch@lst.de>
