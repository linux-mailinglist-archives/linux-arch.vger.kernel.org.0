Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2440775F8D8
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jul 2023 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGXNta (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jul 2023 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGXNtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jul 2023 09:49:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D725649FC;
        Mon, 24 Jul 2023 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=D6sS3m9PCfQQCgChQFd64/ztcN
        J1BT/4Ep720JKQxclMaEPt3e8GmiMsjThxSOol7lkRQTT4GS39ra31w6kVoBaFoxdMY85bX1vjeu2
        8UIifL2QW5nvSAkzXMXMrhcbPTlcop1TuvhBZFPfNI31C71JvBGupM3izG2n9cotmhbgINc7HnoIU
        YQtn7OnT40XSJEYFtLtTJEITe6AAuTC2kRTKVMREkWPz25we7Fo9e1Hj82FqR/egnH+NxRPJ/r6DC
        UnnNMebwCS5ax/j/QYUdWltq1zX8O1iaFBmlg9LOxR3jvQpwm+kCl0Mkpnq4L+NSBhfSkq6r6wsGa
        cRRxYmjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNvtP-004VZ3-32;
        Mon, 24 Jul 2023 13:46:31 +0000
Date:   Mon, 24 Jul 2023 06:46:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>,
        urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
Subject: Re: [PATCH v1 10/14] mm: Add vmalloc_huge_node()
Message-ID: <ZL6AtxPWlNPZpGDA@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105744.367616679@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721105744.367616679@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
