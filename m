Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FFC51F4AF
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiEIGq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 02:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbiEIGfB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 02:35:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9690E87204;
        Sun,  8 May 2022 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=o+pQ2wGG2YVWS04fCC8y8+WAIR
        OMv/pg4hxMPTD5mPiCT91kL+mAyrLelwTcwQ07UY9WfUCxctEn/0fZ+K6CnVCzuGg3JC3G8zkg+Yl
        6WlVZyz4KU4W7nzIiD1myHbqCRByD7J59wpGzBohi7UMmJ5MPQjRWTNe9M1IHLbNSe1747n8AA4TF
        4bM6O/7hSbCgH42ZfLYGmyFALaHZvcqYXWJPWpwkU6r87XSNhTpH3vjhzuBCn/StFI5LgwFkUXzYV
        PQIFWOA940r35Nxv7DVXtr6tXAEI9VQfACQXdaRWXH0xCOPX4/txiFZADLOBqCBQf1F46BPDj/iQZ
        ZIIwvI6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnwv5-00Cgzc-Gk; Mon, 09 May 2022 06:30:59 +0000
Date:   Sun, 8 May 2022 23:30:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH v3 1/2] kernel: add platform_has() infrastructure
Message-ID: <Yni1IxTY5lxDj9aU@infradead.org>
References: <20220504155703.13336-1-jgross@suse.com>
 <20220504155703.13336-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504155703.13336-2-jgross@suse.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
