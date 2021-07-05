Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF83BB70B
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jul 2021 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhGEGFT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jul 2021 02:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhGEGFS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jul 2021 02:05:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD6BC061574;
        Sun,  4 Jul 2021 23:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+llhNOIjgCgyDen6/AZ5WQb/0oOeSbGr13Ghe4Awmp4=; b=eCBzb8B28v/eRtNCnOjYcGanZS
        6AP+UD1taU3IRqjyHQpirdCiVXbJfwfRfhHR5uBol/N5GxDAeouoBRTNvB0VfGDNVKTlvRN25T7yx
        y0LEs5m7ElpqdSY8DauR0oIplRS3ohiU8NOLRM8RYwmbeWGNwOCk/1o5LoCi2ijZi9gehQ7IHzEOJ
        qwaxfwJawn99uEB40xJH5tVfezYopF0e0d8CtgUgdltEoRr6tArRcNgRIXNk+w1EebweqLkOvq3GF
        dFFF9hQi2QtMn8zeRW+4Eh9DkfW/ve0r5vtWDEJDPPsj0WB1WGdsFy0lfYCZ4Sw3TJeaxvAn9TwAe
        I/TiYzjQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0Hfk-009vtj-HO; Mon, 05 Jul 2021 06:01:41 +0000
Date:   Mon, 5 Jul 2021 07:01:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 0/9] ARM: remove set_fs callers and implementation
Message-ID: <YOKgQCTB6Rd+jIom@infradead.org>
References: <20200918124624.1469673-1-arnd@arndb.de>
 <20200919052715.GF30063@infradead.org>
 <CAK8P3a1LM8SXbzcVv1B05fdmxBZ-PA+P4m4oP1Dgc4JmR2CGMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1LM8SXbzcVv1B05fdmxBZ-PA+P4m4oP1Dgc4JmR2CGMw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Just a ping if we're making some progress on this.  The m68knommu
set_fs implementation is actively misleading, which lead to a problem
this merge window so I'd really like to see this set merged.

Also your improvements to the copy_from_kernel_nofaul loop would be
