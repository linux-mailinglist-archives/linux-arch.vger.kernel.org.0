Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDA70603A
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjEQGg2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEQGg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:36:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3444A30F7;
        Tue, 16 May 2023 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LyqwcPubn/JsQWHMskCZBu9QXpuNcB4Hd4xqTmLITsI=; b=eXV2qErwJTXGUoa1Zbhw+gAMw0
        GNVHvOiLHyJvuf62zEKGLEA9V8ORQo+Sl4BroKuAAfHbtj60Yeb1thb73fA2jXbgVOS2ahCdFJ+mE
        VBGPhrJlsTqEaUImKwoyge6oq6QxZSdBip10g6F8tqeDJ8i4+J6TKcBSzLDjh/O0ycop+SMQM+F2v
        ErLvWCCNmc0jDBcTsP3bs2DxNwF3y7u5/NtB9tkK7QEbMxlbzu7B1mE1w0hKm9KQZ8AhgR3r9IIZ6
        Qq0G6b9ARjq5usIYdVJksLo3TS+jsz7aBPqlrnsXxU/iw0KvWkX9m2CiMY0l9RQBar9wTFPyr8Blg
        ptop//Zg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAlr-008UZj-2Q;
        Wed, 17 May 2023 06:36:23 +0000
Date:   Tue, 16 May 2023 23:36:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 10/17] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGR15/aAYufCZ9qV@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-11-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-11-bhe@redhat.com>
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

On Mon, May 15, 2023 at 05:08:41PM +0800, Baoquan He wrote:
> +#define ioremap_wc(addr, size)  \
> +	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERNEL)))

I'd move this out of line and just apply mio_wb_bit_mask directly
instead of the unbox/box/unbox/box dance.

> +#define ioremap_wt(addr, size)  \
> +	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERNEL)))

and just define this to ioremap_wc.  Note that defining _wt to _wc is
very odd and seems wrong, but comes from the existing code.  Maybe the
s390 maintainers can chime on on the background and we can add a comment
while we're at it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
