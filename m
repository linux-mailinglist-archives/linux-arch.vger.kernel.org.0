Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E337E719AC3
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjFALOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjFALOH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 07:14:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A17E107;
        Thu,  1 Jun 2023 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OIufl889eq/2NVmm5s2z1YKzTZVQ8MLyGENaRWiosds=; b=Swos2CA7Pk1ZTVxGnpFfCgc4p6
        9J5bjqQ1wbsmIrN23klLIamI5kOVtkz0v/ReGmbv+510j6AgDIB8yK/p8FjwDlzswgr/XOKI7lhEY
        6LYslG6hOt/6G48KhzoUbSx63bQAkh0NUlQcSEZT4sOxHkRSnapxdD3N/juZ16QxoqT2lXjTO1uRT
        lKI3EUP/wr2LPlt2d5kQ+kEYxONUhFzFeZ7RCgQ/8fPdhxGRCOqPMY9CgfgBsW6yHVKDECAy7glNH
        hif/U88rETGzRKT0UxYq76GA1GdS9jzOmFjkJybDhL6vRxO1n94OuepZOVkqnM8F7u5TZBYirToNq
        I0nEa9Jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4gFp-003Cnd-0D;
        Thu, 01 Jun 2023 11:14:05 +0000
Date:   Thu, 1 Jun 2023 04:14:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com,
        willy@infradead.org, deller@gmx.de,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v5 RESEND 07/17] arc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZHh9fdJJeq4cQMkV@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-8-bhe@redhat.com>
 <ZGR01vnozJmVIVEi@infradead.org>
 <ZHXA7RP9bv4Cz4VA@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHXA7RP9bv4Cz4VA@MiWiFi-R3L-srv>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 30, 2023 at 05:25:01PM +0800, Baoquan He wrote:
> On 05/16/23 at 11:31pm, Christoph Hellwig wrote:
> > > +#define ioremap ioremap
> > > +#define ioremap_prot ioremap_prot
> > > +#define iounmap iounmap
> > 
> > Nit:  I think it's cleaner to have these #defines right next to the
> > function declaration.
> 
> For this one, I didn't add function declaration of ioremap_prot and
> iounmap in arch/arc/include/asm/io.h and the same to other arch's
> asm/io.h. Because asm-generic/io.h already has those function
> declaration, then ARCH's asm/io.h includeasm-generic/io.h. I tried
> adding function declarations for ioremap_prot() and iounmap(), building
> passed too. Do you think we need add extra function declarations in
> ARCH's asm/io.h file?

No, sorry.
