Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313C7706045
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjEQGip (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjEQGio (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:38:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5EFCE;
        Tue, 16 May 2023 23:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=qSZOzl/GbjfR8D1W/SjoaoSXvQ
        tgjEAAAF/Q9ZgheWRmqZ+0qjlPLiIW7a9/9VLP7UgXUp2IVxoIMD6LDWhr/TZhkkRQRTV1esYIPhT
        X9+92IVsJO9YDDya3Bo/8qabpLaBgCDp4Hb7d2As+T1QChsvw6xRvh90jk+8Nqu2K0IFPS/C/vq+d
        jarOkchcJXjkIzI32AUAaQKfb1D6zk+Eo+x9XETCQpn4qKaTJgxFNQ2waPvZ+Vs2QTznTOs0NrsCD
        Vk2xL+PJmpHqxSWRb174LQEAt5rL/sM3c4TBblJwYuNvRTgCJkOs64lBl0MX6lmgDTC7R4Idy1CiF
        fFC/O4pg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAo6-008UzG-10;
        Wed, 17 May 2023 06:38:42 +0000
Date:   Tue, 16 May 2023 23:38:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 13/17] parisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGR2cqukkLJrppOw@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-14-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-14-bhe@redhat.com>
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
