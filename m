Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F601D9B10
	for <lists+linux-arch@lfdr.de>; Tue, 19 May 2020 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgESPZR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 May 2020 11:25:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgESPZQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 May 2020 11:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5A5FB275;
        Tue, 19 May 2020 15:25:17 +0000 (UTC)
Date:   Tue, 19 May 2020 17:25:12 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 2/7] mm/vmalloc: Track which page-table levels were
 modified
Message-ID: <20200519152512.GO8135@suse.de>
References: <20200515140023.25469-1-joro@8bytes.org>
 <20200515140023.25469-3-joro@8bytes.org>
 <20200515130142.4ca90ee590e9d8ab88497676@linux-foundation.org>
 <20200516125641.GK8135@suse.de>
 <20200518151828.ad3c714a29209b359e326ec4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518151828.ad3c714a29209b359e326ec4@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 18, 2020 at 03:18:28PM -0700, Andrew Morton wrote:
> On Sat, 16 May 2020 14:56:41 +0200 Joerg Roedel <jroedel@suse.de> wrote:
> --- a/mm/vmalloc.c~mm-vmalloc-track-which-page-table-levels-were-modified-fix
> +++ a/mm/vmalloc.c
> @@ -309,6 +309,9 @@ int map_kernel_range_noflush(unsigned lo
>  			return err;
>  	} while (pgd++, addr = next, addr != end);
>  
> +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> +		arch_sync_kernel_mappings(start, end);
> +
>  	return 0;
>  }

Yes, this is the right call.

> It would be nice to get all this (ie, linux-next) retested before we
> send it upstream, please.

Will do and report back.


Thanks,

	Joerg

