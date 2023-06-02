Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50EB72054F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jun 2023 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbjFBPGA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jun 2023 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjFBPF7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jun 2023 11:05:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558E1BD;
        Fri,  2 Jun 2023 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ocKE1f0bUukWrMCc7BWG+5wPWxISqRQFWegvqJhpRoU=; b=WIIWHgGdb8DEderqio76Mo8Wmh
        yl3VJD0sw8OCUo67vXf98L6V77Akmq1+qJEdOWefS8Aokrf36ZLeRhL0R/mPvEA2E4gwca288roft
        7ZQUv4PIIBXVQxj+JKCpxS9QxxVqqmoqJwnPlM9SLVw39pAB1haoXDM8PmQjDK4zgXHEmc4u9UZqi
        Bjv/79Pl8p/m0p6pliASi9GjRaq+Cf7+pBYYL77J8u915w5cAsWuMUG51yMxFwBlOPXUCzUa4Ik3X
        Tbq2BK1fHFm2ca5lVcWvaZoqH2nZLJRZ8wiiozVta7u5jmZCY8kRbb1mEu9VHtKnWMjukb4gXDGKg
        3Zqa9VOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q56Lj-007CIv-0v;
        Fri, 02 Jun 2023 15:05:55 +0000
Date:   Fri, 2 Jun 2023 08:05:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de
Subject: Re: [PATCH v5 RESEND 14/17] mm/ioremap: Consider IOREMAP space in
 generic ioremap
Message-ID: <ZHoFU4mshw1lUng3@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
 <ZGR3Ft27kdgXKKfp@infradead.org>
 <ZGR3yWIdjfJTupgY@infradead.org>
 <ZHXD082+VntWgbNo@MiWiFi-R3L-srv>
 <ZHh9TcwFwzeWU9sx@infradead.org>
 <ZHnHs+ro44SBS+lV@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHnHs+ro44SBS+lV@MiWiFi-R3L-srv>
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

On Fri, Jun 02, 2023 at 06:42:59PM +0800, Baoquan He wrote:
> On 06/01/23 at 04:13am, Christoph Hellwig wrote:
> > On Tue, May 30, 2023 at 05:37:23PM +0800, Baoquan He wrote:
> > > If we want to consolidate code, we can move is_ioremap_addr() to
> > > include/linux/mm.h libe below. Not sure if it's fine. With it,
> > > both kernel/iomem.c and mm/ioremap.c can use is_ioremap_addr().
> > 
> > Can we just add a ne header for this given that no one else really
> > needs it?
> 
> Is it OK like below?

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
