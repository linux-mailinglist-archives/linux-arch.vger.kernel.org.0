Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E995C1D8AA8
	for <lists+linux-arch@lfdr.de>; Tue, 19 May 2020 00:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgERWSa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 18:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgERWSa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 18:18:30 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BC62081A;
        Mon, 18 May 2020 22:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589840309;
        bh=GAsP72OzLRqNeGGIYQczDNH78GgALiPWljn3TChp7vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zZ+klVAaZtV27MGlVb0LzirdC6IcRNdxtR8vdL8+p1v703lmi5J9HVBsa59wZfYS2
         rcHhIFOwmI6Yc/w9iEWdmxMN/U7GWNm4qd9W6owTNY+8aCiuJZFmriA8jGFyro1lnf
         B2QLoucZDhxzU0xGGj8zNn76nXG71emZmJGgdURs=
Date:   Mon, 18 May 2020 15:18:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joerg Roedel <jroedel@suse.de>
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
Message-Id: <20200518151828.ad3c714a29209b359e326ec4@linux-foundation.org>
In-Reply-To: <20200516125641.GK8135@suse.de>
References: <20200515140023.25469-1-joro@8bytes.org>
        <20200515140023.25469-3-joro@8bytes.org>
        <20200515130142.4ca90ee590e9d8ab88497676@linux-foundation.org>
        <20200516125641.GK8135@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 16 May 2020 14:56:41 +0200 Joerg Roedel <jroedel@suse.de> wrote:

> Hi Andrew,
> 
> On Fri, May 15, 2020 at 01:01:42PM -0700, Andrew Morton wrote:
> > On Fri, 15 May 2020 16:00:18 +0200 Joerg Roedel <joro@8bytes.org> wrote:
> > Lots of collisions here with Christoph's "decruft the vmalloc API" series
> > (http://lkml.kernel.org/r/20200414131348.444715-1-hch@lst.de).
> > 
> > I attempted to fix things up.
> > 
> > unmap_kernel_range_noflush() needed to be redone.
> > 
> > map_kernel_range_noflush() might need the arch_sync_kernel_mappings() call?
> 
> Yes, map_kernel_range_noflush() needs the arch_sync_kernel_mappings()
> call as well.
> 

This?

--- a/mm/vmalloc.c~mm-vmalloc-track-which-page-table-levels-were-modified-fix
+++ a/mm/vmalloc.c
@@ -309,6 +309,9 @@ int map_kernel_range_noflush(unsigned lo
 			return err;
 	} while (pgd++, addr = next, addr != end);
 
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+
 	return 0;
 }
 

It would be nice to get all this (ie, linux-next) retested before we
send it upstream, please.  
