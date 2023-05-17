Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE59705FFB
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjEQG1X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjEQG1W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:27:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5ED40E7;
        Tue, 16 May 2023 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=n96OXagPNbbIGhllOsTU6Nvko8
        sdV81MymooKBut9cKTfx1gLSQWWCaa6jlrT8eH7yrPPupyjAtYapcazQoVvjyKHLUcvXIWV1w2pxT
        xeW9TqL0mOeNPmcq4lTfcCBC4FNudSRMCVVdr0D0Vz1BBYzce557s6zuwzzW7Gz5uyahP20AW1bLp
        FHE82edsFY215RxbDuhspvBGHS4zp0tJEE41IJ+02oT32S2ekD5S7VDcDnOu+5hFZnCamjfz+q0HS
        sNAVxy+iEYmLV5Yr3KUo0RHzprS0X1vpGjMyvLoHk7e5miodpjhcctEzpbNZDBlwsri0pk/R+FlEX
        wq1XDmrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAd2-008S1R-0i;
        Wed, 17 May 2023 06:27:16 +0000
Date:   Tue, 16 May 2023 23:27:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 01/17] asm-generic/iomap.h: remove
 ARCH_HAS_IOREMAP_xx macros
Message-ID: <ZGRzxAza23HNPeCU@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-2-bhe@redhat.com>
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
