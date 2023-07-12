Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D371E74FEB3
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 07:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGLF3b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 01:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGLF31 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 01:29:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9219B;
        Tue, 11 Jul 2023 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qkUipoh9LzckasQjFT3oT/cjBw23ZeCHvwm10bQ21tI=; b=pu63hKu+Y6EW+pxvwVAsG7hhWC
        GMMHP45auERXQ9P6kTrwFsw4uf5OompiG0bnM5muQ7WRBhb1ieo5xuw7jUN/T8j874KXD8i4Ph4Oa
        igN4TK0OjBRVUuSu5FweVlmBI0cf9iOJN6DSxgxiwIi13BSnTmCDXEspuZx4umFBJ5hyy+qND63yi
        nAwbvEHE8h0JVZSe3gWBfNFoTdJ1Y1RbvUSNZ/R3qRBxiTzNy4NNhfu9sXeKYzrqy7zoGOgCB0AOb
        4iUqVmKlkGEMNC4FGJtBeJ9QQRYJas9FLvUmH18sF2Xn/lhNo6Ge0mR+0RM0itbezYj4LCM6PXNDK
        9XmPq/8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJSPh-00GNN6-7t; Wed, 12 Jul 2023 05:29:21 +0000
Date:   Wed, 12 Jul 2023 06:29:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v5 00/38] New page table range API
Message-ID: <ZK46Mb0jAtCxFma2@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <8cfc3eef-e387-88e1-1006-2d7d97a09213@linux.ibm.com>
 <ZK1My5hQYC2Kb6G1@casper.infradead.org>
 <20230711172440.77504856@p-imbrenda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711172440.77504856@p-imbrenda>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 11, 2023 at 05:24:40PM +0200, Claudio Imbrenda wrote:
> On Tue, 11 Jul 2023 13:36:27 +0100
> Matthew Wilcox <willy@infradead.org> wrote:
> > > I think we do use PG_arch_1 on s390 for our secure page handling and
> > > making this perf folio instead of physical page really seems wrong
> > > and it probably breaks this code.  
> > 
> > Per-page flags are going away in the next few years, so you're going to
> 
> For each 4k physical page frame, we need to keep track whether it is
> secure or not.

Do you?  Wouldn't it make more sense to track that per allocation instead
of per page?  ie if we allocate a 16kB anon folio for a VMA, don't you
want the entire folio to be marked as secure vs insecure?

I don't really know what secure means in this context.  I think it has
something to do with which of the VM or the hypervisor can access it, but
it feels like something new that I've never had properly explained to me.

> A bit in struct page seems the most logical choice. If that's not
> possible anymore, how would you propose we should do?

The plan is to shrink struct page down to a single pointer (which
includes a few tag bits to say what type that pointer is -- a page
table, anon mem, file mem, slab, etc).  So there won't be any bits
available for something like "secure or not".  You could use a side
structure if you really need to keep track on a per page basis.
