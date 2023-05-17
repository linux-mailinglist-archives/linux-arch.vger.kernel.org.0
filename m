Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B959E70601D
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjEQGbA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjEQGbA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:31:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E74435A0;
        Tue, 16 May 2023 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lHYduRAGXCkDUrS8b4Gx5zxhlIgk1+vCGXqqxRlJ+eA=; b=XfGkZqYR9+Q+PUUQxBnxaKZfBQ
        wLIDVA84yn737aw7Dc93fZzAfT2HRb7k6gxeXJHlj73m6oMreWWh+dGd0ZpoAI+dP/DxcpvFTynRX
        ZuInH2ELv2cUK/JYU5gTgshp4n6SToNn3y+cAluXnl9ef8oddhikSoy99RcE+0B4bQqv+exTUeJJT
        Qk5dsPTyfh5hnxes6whp8YustSHdySbuoHhxBWqWZqIFN7R7AP0/3gTf67zk77eItoQdJAsvtDOat
        m4LPom31pYeicRdHLNVclWMmNcmf3vSrg61hNpMFdbf0+lzMkxcVuxNySZaR2H/E988yDbgb3IJtl
        OMOXdcWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAgS-008TRG-0s;
        Wed, 17 May 2023 06:30:48 +0000
Date:   Tue, 16 May 2023 23:30:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de
Subject: Re: [PATCH v5 RESEND 06/17] mm/ioremap: add slab availability
 checking in ioremap_prot
Message-ID: <ZGR0mLozn5OQzAEN@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-7-bhe@redhat.com>
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

On Mon, May 15, 2023 at 05:08:37PM +0800, Baoquan He wrote:
> Several architectures has done checking if slab if available in
> ioremap_prot(). In fact it should be done in generic ioremap_prot()
> since on any architecutre, slab allocator must be available before
> get_vm_area_caller() and vunmap() are used.
> 
> Add the checking into generic_ioremap_prot().

Should we add a WARN_ON/WARN_ON_ONCE to aid debugging?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
