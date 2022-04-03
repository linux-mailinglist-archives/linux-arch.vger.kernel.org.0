Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0943B4F097C
	for <lists+linux-arch@lfdr.de>; Sun,  3 Apr 2022 14:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbiDCMpu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Apr 2022 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiDCMpu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Apr 2022 08:45:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8221E3E3;
        Sun,  3 Apr 2022 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j3momSurDvEWtOQHXCIGt/ufqwRjPTKzPyz3hbCrGFc=; b=aCY4goj4uDrke10AUZQQkJ83YV
        339X9CKTTJsiHeswk2noi0yAvOyY2c5JXvgKwc/eabXqN1qEjR3KJhW9uJCOJJf2rDhe9QdiDKwXH
        qEfSR7BpM2fgkN4vfoVuqt4kOVYLEty5oXDqgy/HvKp8WGVdF/O/pNlqKMzqXGxHF6f6+l8z+UzOB
        LZGRwZT5KVFaxIt9vjDbVKHAdi+B3xKkFGGTslUdYDaVdm+6tLsv3dqTq4cEc7o6sOmoUfnV8NYYZ
        ZukQzSMZ0FNAUvI2ERiQgZf62M7SYeldKOMuHiLarcc/MI1hXVE94MKChDvSGpTdhzYJYJyu4yy4d
        jN+qnM0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nazaB-00BNy7-Iv; Sun, 03 Apr 2022 12:43:51 +0000
Date:   Sun, 3 Apr 2022 05:43:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Subject: Re: [RFC PULL] remove arch/h8300
Message-ID: <YkmWh2tss8nXKqc5@infradead.org>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
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

On Tue, Mar 08, 2022 at 09:19:16AM +0100, Arnd Bergmann wrote:
> If there are no other objections, I'll just queue this up for 5.18 in
> the asm-generic
> tree along with the nds32 removal.

So it is the last day of te merge window and arch/h8300 is till there.
And checking nw the removal has also not made it to linux-next.  Looks
like it is so stale that even the removal gets ignored :(
