Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9201CD29C
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 09:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgEKHcV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbgEKHcV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2020 03:32:21 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E3C061A0C;
        Mon, 11 May 2020 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UQU0B9NH1zcG5ih3frGbvcAoJriOpbADo62D6un1kGw=; b=P8dhMvRZsO8HVSTS2DKAhF4+Dz
        l3+qc9UNmKUvRNxyjm1fe3xdICnaYrQKfmOFATzkAIA+m/55V7+aGGbsb24aXS93rtFf+TDD+3h/j
        +WcquBE0T/zxLzUhRauRp/opgqKE8XryQTA+G8Jmp+J5XSJsHCIjLysjbehvGdp++fWujWmpOufCo
        Dcht8qJgNXr3YA1l6sNQunsdCYslASmkMQkVQHwf7C4FfAK3lWRfXTjd4ogg08M0tlXXtbM+P+kwF
        6tRNzMrRnuylt7QDtGn75SzZsYyEcmnzBnt0g5sDJk7XFLqH2SdQm72ztyhSO6ysYzo/nYNoAMH1y
        PSfnKYpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY2uY-0006aH-EN; Mon, 11 May 2020 07:31:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94E02301A80;
        Mon, 11 May 2020 09:31:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 792BB2077D3FE; Mon, 11 May 2020 09:31:34 +0200 (CEST)
Date:   Mon, 11 May 2020 09:31:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200511073134.GD2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508192000.GB2957@hirez.programming.kicks-ass.net>
 <20200508213407.GT8135@suse.de>
 <20200509092516.GC2957@hirez.programming.kicks-ass.net>
 <20200510011157.GU16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510011157.GU16070@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 09, 2020 at 06:11:57PM -0700, Matthew Wilcox wrote:
> Iterating an XArray (whether the entire thing
> or with marks) is RCU-safe and faster than iterating a linked list,
> so this should solve the problem?

It can hardly be faster if you want all elements -- which is I think the
case here. We only call into this if we change an entry, and then we
need to propagate that change to all.
