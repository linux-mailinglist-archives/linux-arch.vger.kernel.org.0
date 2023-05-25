Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FAB7103DA
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 06:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbjEYEIC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 00:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbjEYEHW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 00:07:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FCA1711;
        Wed, 24 May 2023 21:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Rcg59tq5Dl+6L+r8l6uwmuQm/aS0R/EBEonRbKOuco=; b=Vpkjy/zPqLAbxZf6ITNl+lGwjS
        nZwEanDG+mDgOewsGVfDM/uPyMY/vLDHgN9HUb32EbjT9dm9j8GWHEFIEcAD3KJ2S2APD70rT1aYq
        PWrA4DCdUJvyxk1XlvD5OJzRNU0z8XPOni5p290SZUGrL7h5SLcUG6a612QRkvOLbPzxkHVECZJoi
        0jvFoo5OToVmjcTFuYzEG+Mfxmc7DGXTQs42v3hE2g2R0FTObPuNWgBYkdIvpgnjcZhq/5BdgcKX+
        nGl5XTusfjuyS7BYl5GycouUlMSaW4ctAmtjq0dYdVQpAwD/mpB+4evqKKLpwU7OeEGOlX7nCHImW
        amBlZbHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q22Ds-00BpM4-4Y; Thu, 25 May 2023 04:05:08 +0000
Date:   Thu, 25 May 2023 05:05:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 09/36] arm64: Implement the new page table range API
Message-ID: <ZG7edJ+ovIqiULj+@casper.infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-10-willy@infradead.org>
 <592942c0-00dc-0317-0411-f9e17870fb11@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592942c0-00dc-0317-0411-f9e17870fb11@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 25, 2023 at 09:05:35AM +0530, Anshuman Khandual wrote:
> > @@ -127,6 +127,8 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
> >   */
> >  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> >  extern void flush_dcache_page(struct page *);
> > +void flush_dcache_folio(struct folio *);
> 
> This is giving a checkpatch.pl warning
> 
> WARNING: function definition argument 'struct folio *' should also have an identifier name
> #36: FILE: arch/arm64/include/asm/cacheflush.h:130:
> +void flush_dcache_folio(struct folio *);

Yes, but checkpatch is *stupid*.  Don't just follow tools blindly.
How is naming the parameter here helping anyone?
