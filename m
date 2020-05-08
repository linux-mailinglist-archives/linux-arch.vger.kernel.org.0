Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC18B1CB9E2
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 23:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgEHVeL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 17:34:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:36542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVeK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 17:34:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D51EAAD60;
        Fri,  8 May 2020 21:34:11 +0000 (UTC)
Date:   Fri, 8 May 2020 23:34:07 +0200
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
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200508213407.GT8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508192000.GB2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508192000.GB2957@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

thanks for reviewing this!

On Fri, May 08, 2020 at 09:20:00PM +0200, Peter Zijlstra wrote:
> The only concern I have is the pgd_lock lock hold times.
> 
> By not doing on-demand faults anymore, and consistently calling
> sync_global_*(), we iterate that pgd_list thing much more often than
> before if I'm not mistaken.

Should not be a problem, from what I have seen this function is not
called often on x86-64.  The vmalloc area needs to be synchronized at
the top-level there, which is by now P4D (with 4-level paging). And the
vmalloc area takes 64 entries, when all of them are populated the
function will not be called again.

On 32bit it might be called more often, because synchronization happens
on the PMD level, which is also used for large-page mapped ioremap
regions. But these don't happen very often and there are also no VMAP
stacks on x86-32 which could cause this function to be called
frequently.


	Joerg
