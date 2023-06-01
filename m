Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76934719ABE
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 13:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFALNX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFALNW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 07:13:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D48111F;
        Thu,  1 Jun 2023 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8vMskHhtUuRlMIt2Ncz0GeUAC2vyDx9pgosUjZg/dMk=; b=EE58CAOmZjgyHlXe6PwbCLYrPE
        +9I426e7goRJX287noW4a2DkzzDotI4J1/O5HyeG2E1WS+RJr5xIOL6vqV3cmn4C7XUe8D336Zt3U
        Ar4YX+z/WnxLDQHHzLpm3dcbeOkXEqBp2frmsTcmCU9Xr7l7GI6n+O4I0hZpoqr6COQA9VBmVdGvG
        yc2+LWklZABDo76ncn4l6Jxjqy1VUa51l+ztFaYrTUyTtDXwbQpUf4wrmjbbBlmafhds2u0X91rMg
        oR7WhMsQV9Cn4Ds8RF42U18nYrB+7sHNghT1E2nmQjY9wU0uCs1Jl1Tzap2NBht27gmwWlJxvpA88
        a7euVC5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4gF3-003CdT-0T;
        Thu, 01 Jun 2023 11:13:17 +0000
Date:   Thu, 1 Jun 2023 04:13:17 -0700
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
Message-ID: <ZHh9TcwFwzeWU9sx@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
 <ZGR3Ft27kdgXKKfp@infradead.org>
 <ZGR3yWIdjfJTupgY@infradead.org>
 <ZHXD082+VntWgbNo@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHXD082+VntWgbNo@MiWiFi-R3L-srv>
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

On Tue, May 30, 2023 at 05:37:23PM +0800, Baoquan He wrote:
> If we want to consolidate code, we can move is_ioremap_addr() to
> include/linux/mm.h libe below. Not sure if it's fine. With it,
> both kernel/iomem.c and mm/ioremap.c can use is_ioremap_addr().

Can we just add a ne header for this given that no one else really
needs it?

