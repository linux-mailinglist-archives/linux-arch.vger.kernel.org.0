Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F0497F97
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 13:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiAXMcO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 07:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbiAXMcO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 07:32:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D01FC06173D;
        Mon, 24 Jan 2022 04:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z2gGoEVk8Y/k11EEWsaZZW9coZbG9Md8ydPQy8yxQzo=; b=Vq9EghPrqQ1SCPzCGV/Usy8QQ1
        irUoY6542/6bq7exJ7BO0wU4Je9ALTjesoyZ27H8Y2HNLj0v3eJCXQDKavRRAGAT2qhyG1ESM3X31
        VAvbvol1wOkEx8sXL6kWjL7aKoUXgofoiexsWaCTGNbYy7Eusseno0T7nUAJi0ef98UO8jXVid3DV
        EhuAg0lTdEgmhTpWnZyey3sZehcKL4b/CxiHim1lq0ThJvVzh8z6mlSJArmJZfC41SKgeeM3z6vI3
        dR3dLQ6be5L6Ypu1BAe1oLeC/yHUXJ4J173D29hFAIoyL8y72O2zHLyihqkMBlqAQjiL3CAI4V+2T
        R7EVJJ4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nByW4-003Hmi-5y; Mon, 24 Jan 2022 12:32:12 +0000
Date:   Mon, 24 Jan 2022 04:32:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/7] modules: Refactor within_module_core() and
 within_module_init()
Message-ID: <Ye6cTJKTD9JehwnY@infradead.org>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
 <e5e58875bd15551d0386552d3f9fa9ee8bc183a2.1643015752.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e58875bd15551d0386552d3f9fa9ee8bc183a2.1643015752.git.christophe.leroy@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 09:22:15AM +0000, Christophe Leroy wrote:
> +static inline bool within_range(unsigned long addr, void *base, unsigned int size)

Please avoid the overly long line.

.. But given that this function only has a single caller I see no
point in factoring it out anyway.
