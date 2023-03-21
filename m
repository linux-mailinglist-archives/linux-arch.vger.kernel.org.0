Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820A16C3710
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 17:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCUQjB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCUQi7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 12:38:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C4D521;
        Tue, 21 Mar 2023 09:38:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 72A87221EB;
        Tue, 21 Mar 2023 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679416729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fiTefNQv6KsfbR0rIRmrOlowqpZ0TrVJ2tfkNhbKTuc=;
        b=y4le6YzDNKGZE7pDqi0XmbFhx354gB9++3ZENeDvEmXj9uk6SsyvriF60UJC68Ha6pTL10
        gnJbfjsdq2N0lU9BmGAuoJuXdw4hZYBV4+yc8O7/EEBI+bd1MeI3beJcTQhEHi/F1ynwty
        gMKoN4TJhBY1xJYz2qm1CHnpTw1yxJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679416729;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fiTefNQv6KsfbR0rIRmrOlowqpZ0TrVJ2tfkNhbKTuc=;
        b=FpxXnhJvxNNTJCYST9bbkjxUbzOG0FtybZGvJUmr7v93JA6g/mErZhWTr+fkstfxnETekm
        TBksnJvwfvPXiFDQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 19E662C141;
        Tue, 21 Mar 2023 16:38:47 +0000 (UTC)
Date:   Tue, 21 Mar 2023 16:38:45 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Fix confusion around MAX_ORDER
Message-ID: <20230321163845.qpybxa5rlwclvko2@suse.de>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 02:31:23PM +0300, Kirill A. Shutemov wrote:
> MAX_ORDER currently defined as number of orders page allocator supports:
> user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
> 
> This definition is counter-intuitive and lead to number of bugs all over
> the kernel.
> 
> Fix the bugs and then change the definition of MAX_ORDER to be
> inclusive: the range of orders user can ask from buddy allocator is
> 0..MAX_ORDER now.
> 

Acked-by: Mel Gorman <mgorman@suse.de>

Overall looks sane other than the fixups that need to be added as
flagged by LKP. There is a mild risk for stable backports that reference
MAX_ORDER but that's the responsibilty of who is doing the backport.
There is a mild risk of muscle memory adding off-by-one errors for new
code using MAX_ORDER but it's low.

-- 
Mel Gorman
SUSE Labs
