Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF671CB9B7
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 23:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEHVX0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 17:23:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:32814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgEHVX0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 17:23:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D471AE2A;
        Fri,  8 May 2020 21:23:26 +0000 (UTC)
Date:   Fri, 8 May 2020 23:23:21 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/7] mm/vmalloc: Track which page-table levels were
 modified
Message-ID: <20200508212321.GR8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508144043.13893-3-joro@8bytes.org>
 <20200508191048.GA2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508191048.GA2957@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 08, 2020 at 09:10:48PM +0200, Peter Zijlstra wrote:
> On Fri, May 08, 2020 at 04:40:38PM +0200, Joerg Roedel wrote:
> > +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> > +		arch_sync_kernel_mappings(start, end);
> 
> So you're relying on the compiler DCE'ing the call in the 'normal' case.
> 
> Works I suppose, but I went over the patches twice to look for a default
> implementation of it before I figured that out ...

Yes, works on all architectures I compile-tested this on, with gcc-9.3.
I should probably add a comment about that.


	Joerg
