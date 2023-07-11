Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE874F440
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGKQCD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 12:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGKQBs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 12:01:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA5B1722;
        Tue, 11 Jul 2023 09:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BEAC614F8;
        Tue, 11 Jul 2023 16:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F54C433C7;
        Tue, 11 Jul 2023 16:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689091292;
        bh=W4jQlbMQdBvo7/FDTvEj5jeyPtiEw/LF6hLHC5rkPRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zckNfeTjVADMHyofLUUTnGXURxoqX+nnQXOrhYQsdGHTcpkU7xuK9xU1TSXohKsZV
         Gr4B10jt8jyme7faeeuTKSh30IQgpSlLSfzECc8YC+IbUApBm71TAmZxgCP2soKfc5
         S8VuU6DES5kr7V1aK0NlvWdhFt324C2tZXCp0gjM=
Date:   Tue, 11 Jul 2023 09:01:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v5 04/38] mm: Add folio_flush_mapping()
Message-Id: <20230711090131.20d61e87e4b6983357105e9e@linux-foundation.org>
In-Reply-To: <ZKy/hk/tdPftCOyc@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
        <20230710204339.3554919-5-willy@infradead.org>
        <20230710161727.7a676996b64e9885cc15eaeb@linux-foundation.org>
        <ZKy/hk/tdPftCOyc@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 11 Jul 2023 03:33:42 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Jul 10, 2023 at 04:17:27PM -0700, Andrew Morton wrote:
> > On Mon, 10 Jul 2023 21:43:05 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > > +static inline struct address_space *folio_flush_mapping(struct folio *folio)
> > > +{
> > > +	if (unlikely(folio_test_swapcache(folio)))
> > > +		return NULL;
> > > +
> > > +	return folio_mapping(folio);
> > > +}
> > 
> > The name makes it sound like it flushes something.  Wouldn't
> > folio_flushable_mapping() be clearer?
> 
> Yes; I wasn't a big fan of the name, but I wasn't a fan of perpetuating
> the page_file_mapping / page_mapping_file confusio either.  Do you want
> me to send you a set of fixup patches, or will you run them through sed
> -i ?  ;-)

I sedded.
