Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7574E3FE
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 04:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGKCOt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 22:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGKCOs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 22:14:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800FAE1;
        Mon, 10 Jul 2023 19:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BZDZ6r5wpkW+gDFlK/U7jgzzYLwpzB2atLlaIKBEiEc=; b=AbT6dlqBzLhxoNuN17BMaOZQP2
        aiJzb+0XU5zblE1Gy8s85PfoWZuy+PQzTrG6OdX97x5S4W3zLgr2Y8LYWWNH1kPvHPAdZljIRUN1p
        MK/YNjFJ1a3Md9zICwfNW04jvb2D//EvniyaKnUeD8Cj80VFqfulmV86LQP3QYgMxvgeFzxIzxeLA
        gSI6uR+GMMiuxTCOZKy3lRkoqMVKvkvL3vjBc6jGf7pbtNVSRmxpspl46kzh4wB2PNlCh4FvGiQJf
        7f6trkMKFzWutLX+vz0eWf6/xf+/VraJ5Zn+/De8kDbEvirw03uCdaXbevL9rgHMoTg/EI0M6PcIz
        1XTL/U5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJ2to-00FCaw-53; Tue, 11 Jul 2023 02:14:44 +0000
Date:   Tue, 11 Jul 2023 03:14:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/38] minmax: Add in_range() macro
Message-ID: <ZKy7FIhozutiOaSm@casper.infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <20230710204339.3554919-2-willy@infradead.org>
 <20230710161341.c8d6a8b2cbf57013bf6e0140@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710161341.c8d6a8b2cbf57013bf6e0140@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 10, 2023 at 04:13:41PM -0700, Andrew Morton wrote:
> > +/**
> > + * in_range - Determine if a value lies within a range.
> > + * @val: Value to test.
> > + * @start: First value in range.
> > + * @len: Number of values in range.
> > + *
> > + * This is more efficient than "if (start <= val && val < (start + len))".
> > + * It also gives a different answer if @start + @len overflows the size of
> > + * the type by a sufficient amount to encompass @val.  Decide for yourself
> > + * which behaviour you want, or prove that start + len never overflow.
> > + * Do not blindly replace one form with the other.
> > + */
> > +#define in_range(val, start, len)					\
> > +	sizeof(start) <= sizeof(u32) ? in_range32(val, start, len) :	\
> > +		in_range64(val, start, len)
> 
> There's nothing here to prevent callers from passing a mixture of
> 32-bit and 64-bit values, possibly resulting in truncation of `val' or
> `len'.
> 
> Obviously caller is being dumb, but I think it's cost-free to check all
> three of the arguments for 64-bitness?
> 
> Or do a min()/max()-style check for consistently typed arguments?

How about

#define in_range(val, start, len)					\
	(sizeof(val) | sizeof(start) | size(len)) <= sizeof(u32) ?	\
		in_range32(val, start, len) : in_range64(val, start, len)

