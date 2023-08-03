Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F376E9FD
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 15:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjHCNXI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 09:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjHCNW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 09:22:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC369134;
        Thu,  3 Aug 2023 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LnL/w0gerl2bmZjXzcUrorqUHH4MeidXJZnUY3FnBf8=; b=tl66j6LVXL/8xk7brEEbkOjnTb
        qWzPdVREn0HUGqy0AbZR/JqX2T8Bb0c6IIHM2Pgw7Q9Z4ji8BTbs7cYVdRDvNLu5as/rQFfnoxXsD
        ubsP2nHqvmnJFWHkOsNvw9xLGwiu3TtHORltseCtB4yU4AOe+PFUQDZjzwwEATH5U+UJirW8lA4h2
        nJGxcrFeisAuW9vNDS4lbP1raFOXJZe4RGGW6gRjjXsvKwCK29CnM2IIzSsTwDsVtK2Mn7cvA9eok
        DVxdCD/umCFRYUt37bXhFWjC7xsJGMS776PK1R+VMDAsHIvyqndWJdFJPxgzZOKCFo4ZoP4hw0Lbl
        9juj41AA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRYI2-003td9-EV; Thu, 03 Aug 2023 13:22:54 +0000
Date:   Thu, 3 Aug 2023 14:22:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Phi Nguyen <phind.uet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/38] minmax: Add in_range() macro
Message-ID: <ZMuqLhfsu0tV/tAT@casper.infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
 <20230802151406.3735276-2-willy@infradead.org>
 <cf3085ba-5b2e-c048-20bf-4b9a54443cc8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3085ba-5b2e-c048-20bf-4b9a54443cc8@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 03, 2023 at 09:00:35PM +0800, Phi Nguyen wrote:
> On 8/2/2023 11:13 PM, Matthew Wilcox (Oracle) wrote:
> > +static inline bool in_range64(u64 val, u64 start, u64 len)
> > +{
> > +	return (val - start) < len;
> > +}
> > +
> > +static inline bool in_range32(u32 val, u32 start, u32 len)
> > +{
> > +	return (val - start) < len;
> > +}
> > +
> 
> I think these two functions return wrong result if val is smaller than start
> and len is big enough.

How is it that you stopped reading at exactly the point where I explained
that this is intentional?

+/**
+ * in_range - Determine if a value lies within a range.
+ * @val: Value to test.
+ * @start: First value in range.
+ * @len: Number of values in range.
+ *
+ * This is more efficient than "if (start <= val && val < (start + len))".
+ * It also gives a different answer if @start + @len overflows the size of
+ * the type by a sufficient amount to encompass @val.  Decide for yourself
+ * which behaviour you want, or prove that start + len never overflow.
+ * Do not blindly replace one form with the other.
+ */

