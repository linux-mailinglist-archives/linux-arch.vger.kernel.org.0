Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE370605F
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjEQGo2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEQGo1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:44:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A962F5;
        Tue, 16 May 2023 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BmH0qWrbShxIwLQjFwhKQ2xbwDXtOMyKJ7ZdDUHvgls=; b=Ubg7KZoqpGLfixImSbIdJAj9En
        jUqu+kataka3wirto7TkRILjk6/oQB0kQ5w4ud9tT2SXicS3hMqi6wejow4KhSCVP7i8d0rEOmsJe
        C8evKLeUBrWF1gdyDcKHrBMVdM1MjTovB9f360DHQDrrxZLtEzWGBUitxnXOBlq9Cj30j9WPoIb1W
        BVuTzcrgBTj9rEQgGlouy/yPASlheqckxCi0JAKWc9xlVqH3CC1wOmWnlJcogAdy03NNNe9Wro/bd
        6J4qfSHi8Ff+fXX23LeS7dY5M/OuyfANausaI+0pnqDjake0FXHH0OKybCCQy0VyqG1h4tH5LIn0Z
        KExUOmUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAtd-008WMI-1S;
        Wed, 17 May 2023 06:44:25 +0000
Date:   Tue, 16 May 2023 23:44:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de
Subject: Re: [PATCH v5 RESEND 14/17] mm/ioremap: Consider IOREMAP space in
 generic ioremap
Message-ID: <ZGR3yWIdjfJTupgY@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
 <ZGR3Ft27kdgXKKfp@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGR3Ft27kdgXKKfp@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023 at 11:41:26PM -0700, Christoph Hellwig wrote:
> I think this would be cleaner if we'd just always use
> __get_vm_area_caller and at the top of the file add a:
> 
> #ifndef IOREMAP_START
> #define IOREMAP_START	VMALLOC_START
> #define IOREMAP_END	VMALLOC_END
> #endif
> 
> Together with a little comment that ioremap often, but not always
> uses the generic vmalloc area.

.. and with that we can also simply is_ioremap_addr by moving it
to ioremap.c and making it always operate on the IOREMAP constants.
