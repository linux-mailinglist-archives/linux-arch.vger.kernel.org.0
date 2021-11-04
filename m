Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131B74459E3
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 19:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhKDSmw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 14:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhKDSmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Nov 2021 14:42:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48354C061714;
        Thu,  4 Nov 2021 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i3yErMeEVElHCsw4wyrp8I0BlcKHj/KRuLthwWRSHBU=; b=LqXwIstX8b4GBZbTO3TLFRk7Zw
        +7LCIu5/EiQjRqH7LDBDT49duNQNThLmg1ar4gFTf5tXeOSO/ryiX8qIzSJOYApBvLr+yM2zdQswJ
        Kud9+J2T30jhHTcQJRNUwNqZWEe9PQAg43ltudbNtP0O0VTDgv139rbjfE8YExWpcwaBI+k4uCfWi
        KyqUl6MsqHz11LQJPWjvBpaD+Q2WDeFVa2X0ZF8t0YbhruveDrA1TP/0JS+LAkgdqQVJO/VGIfB4q
        09qmEPqkdWXmWQQN6nuXSW+MZ8n5IIoH/2FOFkWK0pwj4B1K3ho95YzrdZXueCbQel7CE0U3PUSAu
        F+OpblNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mihdY-00641C-Dg; Thu, 04 Nov 2021 18:39:10 +0000
Date:   Thu, 4 Nov 2021 18:38:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: flush_dcache_page vs kunmap_local
Message-ID: <YYQowGK3oIAA5Yei@casper.infradead.org>
References: <YYP1lAq46NWzhOf0@casper.infradead.org>
 <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 04, 2021 at 08:30:55AM -0700, Linus Torvalds wrote:
> Why did this come up? Do you actually have some hardware or situation
> that cares?

Oh, we're doing review of the XFS/iomap folio patches, which led to
looking at zero_user_segments(), and I realised that memzero_page()
was now functionally identical to zero_user().  And you'd been quite
specific about not having flush_dcache_page() in there, so ... I wondered
if you'd had a change of mind.
