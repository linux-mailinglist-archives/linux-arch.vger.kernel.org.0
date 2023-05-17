Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B93706053
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjEQGlb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjEQGlb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:41:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6667C1FE7;
        Tue, 16 May 2023 23:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CykYlbUyBmsKpsUHUyxIc0LEz/CT+ai84PogzOUldYA=; b=z8bR/V26LFSYbui7hpcGxPXyCE
        K+EqwK9dVITZUK9ukOXcaCWNNfqgU/KJ7e+JSCtIYcclkNbCis7+uJttuQhRKsnowxuzFn7m90i5Z
        qpB/+Un0orP8guRw1G/iwV5dbOX2VM546ecPbhqW8x6IwJf3SNklX5TKwn9pHv3a2LA1hkY9XnJNZ
        JyXI5Y4ykRsXoWTmdqa+Plc7H5pwYJe/4yypbhfmmdx7q82Si9rYhA5yYz7NKUt899gqVYeZojZlG
        lHRgh1cB7UlHFbktMnNiCTo8Lhp9rT0fGHGgFJHierOjC2gX91Gw0N6y01Ot4ruNsAxNxaO4QSrFu
        cmNo5kPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAqk-008VgM-1e;
        Wed, 17 May 2023 06:41:26 +0000
Date:   Tue, 16 May 2023 23:41:26 -0700
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
Message-ID: <ZGR3Ft27kdgXKKfp@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-15-bhe@redhat.com>
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

On Mon, May 15, 2023 at 05:08:45PM +0800, Baoquan He wrote:
> @@ -35,8 +35,13 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
>  		return NULL;
>  
> +#ifdef IOREMAP_START
> +	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START,
> +				    IOREMAP_END, __builtin_return_address(0));
> +#else
>  	area = get_vm_area_caller(size, VM_IOREMAP,
>  			__builtin_return_address(0));
> +#endif

I think this would be cleaner if we'd just always use
__get_vm_area_caller and at the top of the file add a:

#ifndef IOREMAP_START
#define IOREMAP_START	VMALLOC_START
#define IOREMAP_END	VMALLOC_END
#endif

Together with a little comment that ioremap often, but not always
uses the generic vmalloc area.
