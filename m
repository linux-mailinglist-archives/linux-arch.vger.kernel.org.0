Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3A4F1022
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377735AbiDDHnx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 03:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377713AbiDDHnw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 03:43:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0AC237D7;
        Mon,  4 Apr 2022 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NXCC3mq27NRP426V19RkJC9UlDEf6yaiAlrmmbZ8vxM=; b=f2cENj3WOzzFtBz4B+aSceoC3T
        sKJVIx3e0dXzorWkEhA7lzyB/ichaKQZJNFf+fEjMAQtGaRLXzrB0kqROgBl4jS55dGHv1Z++6lzI
        BBsSCrlfWjq6PisMH6/vKeT+oB/N1LQxStUy3H0DsGfvYrsA6H4wiyXSOwV0URsv+vk/oPjsU5w1k
        wlb+bf/EgPZQqlzqHFjw+PouIF0j73FOcPhn+YljmnBQbyUSIoHdNM3BYNkxL4etjZsSSEhLBcD8t
        DEr4p5sOAXH+1TVG86jSmdz4X6zxww0mKtkRanDFqyYjso4SP2sz9mELqbdEvu6JmUyZ5M4i9uSq6
        iLhMrOfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbHLW-00Df49-C8; Mon, 04 Apr 2022 07:41:54 +0000
Date:   Mon, 4 Apr 2022 00:41:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/8] kbuild: prevent exported headers from including
 <stdlib.h>, <stdbool.h>
Message-ID: <YkqhQhJIQEL2qh8C@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-3-masahiroy@kernel.org>
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

On Mon, Apr 04, 2022 at 03:19:42PM +0900, Masahiro Yamada wrote:
> If we can make kernel headers self-contained (that is, none of exported
> kernel headers includes system headers), we will be able to add the
> -nostdinc flag, but that is much far from where we stand now.

What is still missing for that?
