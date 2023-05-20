Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B693670A573
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 07:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjETFEn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 May 2023 01:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjETFEm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 May 2023 01:04:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC5F1;
        Fri, 19 May 2023 22:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kyno7uaGol+0Au+jeyK6ifVXccyu7nII+Bbwm/hovJU=; b=s7UP4Sx7JFz6PF8XhGe3p/f0aQ
        2HHxn/9xS3MpXXSgWN2Aw8vUybKc87OsnzpwHYyHpCwiFaKdvrs1h8u8c0yJJ0hxloX9XVBrDfbZ9
        L7y6hSznUFJK8I7ZAx4x3tmnrDwrx9ElsRHn5Cya5odTKRqHa6nRBvQnpbMkbN3VV01mh5LZN2P0W
        pONzrYAHEDCUtLpUxD9d9fJMiRJOZtXAcLcPEzoPaxnX7iHb9uj25vOoxaX9I0tzjUPBeLEO8Nvh8
        ORXsXdIsyjvCkOZkvKcpcS95zsw7CvW2pKYujFxNKsFZK0OssXoFItZouzDjTYMbnGVFPKnT01ynT
        HqtudESw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q0Elh-000jwN-0t;
        Sat, 20 May 2023 05:04:37 +0000
Date:   Fri, 19 May 2023 22:04:37 -0700
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
Message-ID: <ZGhU5bjVLaqAE1j1@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
 <ZGR3Ft27kdgXKKfp@infradead.org>
 <ZGR3yWIdjfJTupgY@infradead.org>
 <ZGg++JKsQh/tOZHI@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGg++JKsQh/tOZHI@MiWiFi-R3L-srv>
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

On Sat, May 20, 2023 at 11:31:04AM +0800, Baoquan He wrote:
> > > Together with a little comment that ioremap often, but not always
> > > uses the generic vmalloc area.
> > 
> > .. and with that we can also simply is_ioremap_addr by moving it
> > to ioremap.c and making it always operate on the IOREMAP constants.
> 
> Great idea too, will do. Put this into a separate patch?

Yes.
