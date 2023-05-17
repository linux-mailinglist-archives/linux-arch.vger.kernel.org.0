Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF883706237
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjEQIIY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQIIT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 04:08:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54CD10C3;
        Wed, 17 May 2023 01:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MYYEfQ7vzuqCApSKZNujoQFgvRYxeJUWWx069C/3rJE=; b=FnoH+cpgQsF1pchwLsW21vr4yq
        rfGG5f0tyOZwvmSMI5RyYHyRKIcn/5VvaTBInEHEdxo/1FxUq81ni93lqeXYeDx+qq7x0a01FVAPo
        0ozgqxiGnypQ6GkAoTaTosBZHVJMymNQLhfGSekd/hn+aRYYFGfqZ54Qr4XgmuetWL2h0F9zGpRX+
        Xhm57JDouW8VZbNg8g1f8K02HbDsqBpIazBHMHWWQykH3UsM+JutLWQ1QWyeaNOdFH0HUGi6R9KZ6
        4iBmFAZeNfFYiQA8b1rQU/Jk2ehGWyS5GcZACHZmquFPcEM9I1wTlTTGv3mePU8PxuvW7s+YwkIIR
        D+aGP5pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzCCi-008nDb-0c;
        Wed, 17 May 2023 08:08:12 +0000
Date:   Wed, 17 May 2023 01:08:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 10/17] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGSLbNJKQGbtvL0S@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-11-bhe@redhat.com>
 <ZGR15/aAYufCZ9qV@infradead.org>
 <6a6f5552fac1427eafbca1288fe5d5cb0cb6a333.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a6f5552fac1427eafbca1288fe5d5cb0cb6a333.camel@linux.ibm.com>
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

On Wed, May 17, 2023 at 09:58:26AM +0200, Niklas Schnelle wrote:
> > and just define this to ioremap_wc.  Note that defining _wt to _wc is
> > very odd and seems wrong, but comes from the existing code.  Maybe the
> > s390 maintainers can chime on on the background and we can add a comment
> > while we're at it.
> 
> I'm a bit confused where you see ioremap_wt() defined to ioremap_wc()
> in the existing code? Our current definitions are:

No, it's me wo is confused.  They clearly are different.  But the same
comment about just moving ioremap_wc applies to ioremap_wt based
on how pgprot_writethrough is implemented then.

