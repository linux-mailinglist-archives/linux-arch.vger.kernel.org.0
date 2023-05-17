Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F41D706005
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjEQG2T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjEQG2T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:28:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153D35BB;
        Tue, 16 May 2023 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Vspge/HY+CqpXSg2weUlsF8Uhf
        7vqByyappM3l++Nu1wyd2H8Iplmyk6CD5d3pnLpLrP1KCFdi/MDOP5Q/lIYLG4fdjk+fWXQGjc4dA
        JgTY3rGmC98X04LV1+e01z1+HsOOLZ+hFlHaZwBVPZgszS/XywZuEj2gkKDYx1G1Kszuq1E3gnejN
        loKUjfagQlP7QiRQ9B2mNIMjMmrAq+YZBu85ksrEERvgzN6rWHq/baU0wGj/DZLn6jkLtTUc8oP8g
        Qa9L/P2a1xVi2bKMAN6Ud2mUrMFrA1HxpbAnalfuOaC+STBlU6LSxuzTJxkSABQ9uCMFwE6Gj+j6O
        k6zpRMbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAdx-008SSt-0W;
        Wed, 17 May 2023 06:28:13 +0000
Date:   Tue, 16 May 2023 23:28:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v5 RESEND 03/17] openrisc: mm: remove unneeded early
 ioremap code
Message-ID: <ZGRz/a7aDla63C2y@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-4-bhe@redhat.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
