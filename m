Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3516F706001
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjEQG1l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjEQG1k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:27:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06B64209;
        Tue, 16 May 2023 23:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=C/Ip+nZ88Lg16jN150ohkiRv/K
        hw5otNlOy1KIkGun+Ve6l/Hhji8vSexglMjBtUGCv1TLDuUKw7ky06TJFgA3LscjFYb65Oca5NHVK
        ifzQz5GZSs3Vsco5CF1QJ9DDf4685fe4Ga60xa8NYiu33bCtf+4H0UArAAK6POoYoLEDUTBS7W/Pa
        xPJNuROTu0ikKSjmOJFHjB378xCA35GmUxtI9iKS+sVMCOWlWmkkHOzH0q8PUP4cibvvMGFNsuOSI
        E2gEUHfgaJmPO7j4ykABwKMBGnTUq/FbJ7Op/G7RHJ9pfx05dciQlsfrVlYqst/ebMpxzCfR4H4C0
        XaH0RmQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAdN-008SBV-0Z;
        Wed, 17 May 2023 06:27:37 +0000
Date:   Tue, 16 May 2023 23:27:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 02/17] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGRz2Yf5JFEXIQHN@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-3-bhe@redhat.com>
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
