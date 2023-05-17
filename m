Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810DD706026
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjEQGdK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjEQGdI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:33:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26440359E;
        Tue, 16 May 2023 23:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mxkdlDqyUpwq2T00umhrhBcnqh9XBG0TKSm9fXSA9Sc=; b=IzlvxhjbxQwrfiXgp7vofG8iRA
        3rSVv47naGjy5yBlsCXmBFo0P9BGl4m1f0VVw4LUzJnErB+de4aK+BFgWRpTGgdC4pfm/uFJU4Dlh
        0Hu2ZymcFCRd9WHxlZ9qMDbIkfui0s2xxNNgaMTvS1EOChnS3j0ixKLfKexwHyMQbwk2/PSpSYaFw
        dauSVuDbeVqiWqwt085XxovPwY4LfcOIsv/SzWhAet5ERSxhPfBArznjMkhzGygvFOtQ0pFWACOPi
        ZLXtnKcURHR5uJ9LY1DjW4ebmWgvjd2dqeHyU5e4JsXgDfiPBeE8OfnOOqPJnq68B3CqfQtNEiZVQ
        JSzI/lOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAig-008Tw8-0Q;
        Wed, 17 May 2023 06:33:06 +0000
Date:   Tue, 16 May 2023 23:33:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 08/17] ia64: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGR1IlBpIDe6fQms@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-9-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-9-bhe@redhat.com>
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

> +#define ioremap_prot ioremap_prot
> +#define ioremap_cache ioremap
>  #define ioremap_uc ioremap_uc
>  #define iounmap iounmap

Same comment about the placement here, I'm not going to repeat it if
it shows up in more patches.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
