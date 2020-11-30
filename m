Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4702C80F9
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 10:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgK3J10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 04:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3J10 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2020 04:27:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0EAC0613D2;
        Mon, 30 Nov 2020 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aCfkGM0vlzXViK81UTEMgfauupgXmRJw3cav7RA9s0E=; b=gPDAemu81O47vOcuWY7I29THXg
        nt+YeRVZDtqqPty2L/qNFCh1BXnXk3Dv7qDJwyEEgVb4dK0GxUXPgcAl8NI/6mp9emA9xbKp47l9S
        Z7Ta23ItKhhlkoOviUnMz2mSEMonmx4Oqc4mal+jvAyXLWU0+aVTvGDOmelPJgvI+OD1anH7/HsfL
        DJWmoiB7pzkyBM45X1RNHYTOPY0QzuSQ2cnM37FR83FpEC9FGwdnNBjiK+sYJ2YlUd9Y5wulyKbiZ
        tXMZ4bNYyY91+m9jhDQwd8fysDaCrorLLb/VGndWhaXGf6ND5jk9XmBHpvJkAGSbmr7ow1twPDl/m
        ypseg8Sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjfS3-00085i-54; Mon, 30 Nov 2020 09:26:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78D48301179;
        Mon, 30 Nov 2020 10:26:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5AE9B2B2690EC; Mon, 30 Nov 2020 10:26:28 +0100 (CET)
Date:   Mon, 30 Nov 2020 10:26:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
Message-ID: <20201130092628.GL2414@hirez.programming.kicks-ass.net>
References: <20201128160141.1003903-1-npiggin@gmail.com>
 <20201128160141.1003903-7-npiggin@gmail.com>
 <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 28, 2020 at 07:54:57PM -0800, Andy Lutomirski wrote:
> Version (b) seems fairly straightforward to implement -- add RCU
> protection and a atomic_t special_ref_cleared (initially 0) to struct
> mm_struct itself.  After anyone clears a bit to mm_cpumask (which is
> already a barrier),

No it isn't. clear_bit() implies no barrier what so ever. That's x86
you're thinking about.

> they read mm_users.  If it's zero, then they scan
> mm_cpumask and see if it's empty.  If it is, they atomically swap
> special_ref_cleared to 1.  If it was zero before the swap, they do
> mmdrop().  I can imagine some tweaks that could make this a big
> faster, at least in the limit of a huge number of CPUs.
