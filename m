Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02782C75
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2019 09:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbfHFHSv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Aug 2019 03:18:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731807AbfHFHSu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Aug 2019 03:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oLYhz3paV5MkuuulGm1xoGGN9XCcqSM1IHMqI7nhK4c=; b=l2v8MJqVGbUTCnoAcTYdcSsg8
        iL4Rx1SvnIoyPj5tt0HHf2cGKEJEkSm2rPtqB3xwN3Pi0u3erVD2zycQncT3dEsVKu+lsmeXyknPF
        UV4VfWvZyUVw39nEj+W9aDTztjYs6KEfbiqGwNMmEhZF26G+QJhwWLkpHsvsHCT+qKBSSbwZ4Y9Vy
        Jq96s5cX6W4sylbDHqYgV+xjml/O8mznc/eik84kRokkVbMGfNZExX6Eq1HoKQbi9X9+E0nFwzZR9
        Xtj+W26r7wyCqZZIyKwcM3fcplXLsqKb+/qUIsZtSHth9j1w179c+vZZmGAS55++rGJKP3waA8TV2
        oovG3jW1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hutk6-0002dB-5e; Tue, 06 Aug 2019 07:18:46 +0000
Date:   Tue, 6 Aug 2019 00:18:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com,
        zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com,
        zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 3/4] csky/dma: Fixup cache_op failed when cross memory
 ZONEs
Message-ID: <20190806071846.GA10032@infradead.org>
References: <1564488945-20149-1-git-send-email-guoren@kernel.org>
 <1564488945-20149-3-git-send-email-guoren@kernel.org>
 <20190806064933.GA2508@infradead.org>
 <CAJF2gTR1vCz504X20rBnQkAXGhJ-QbL4pORxnJTRVJqXx2t4uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTR1vCz504X20rBnQkAXGhJ-QbL4pORxnJTRVJqXx2t4uQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 06, 2019 at 03:11:13PM +0800, Guo Ren wrote:
> On Tue, Aug 6, 2019 at 2:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Jul 30, 2019 at 08:15:44PM +0800, guoren@kernel.org wrote:
> > > diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> > > index 80783bb..3f1ff9d 100644
> > > --- a/arch/csky/mm/dma-mapping.c
> > > +++ b/arch/csky/mm/dma-mapping.c
> > > @@ -18,71 +18,52 @@ static int __init atomic_pool_init(void)
> > >  {
> > >       return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
> > >  }
> > > -postcore_initcall(atomic_pool_init);
> >
> > Please keep the postcore_initcall next to the function it calls.
> Ok. Change arch_initcall back to postcore_initcall. :)

Well, if you have a good reason to change it please keep the type
init level change, but put it in a separate patch.  But most importantly
don't move the place where is called around.
