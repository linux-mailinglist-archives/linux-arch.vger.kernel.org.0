Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B71D611C
	for <lists+linux-arch@lfdr.de>; Sat, 16 May 2020 14:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgEPM4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 May 2020 08:56:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:60782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgEPM4p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 16 May 2020 08:56:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3754AB8F;
        Sat, 16 May 2020 12:56:46 +0000 (UTC)
Date:   Sat, 16 May 2020 14:56:41 +0200
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
Message-ID: <20200516125641.GK8135@suse.de>
References: <20200515140023.25469-1-joro@8bytes.org>
 <20200515140023.25469-3-joro@8bytes.org>
 <20200515130142.4ca90ee590e9d8ab88497676@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515130142.4ca90ee590e9d8ab88497676@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

On Fri, May 15, 2020 at 01:01:42PM -0700, Andrew Morton wrote:
> On Fri, 15 May 2020 16:00:18 +0200 Joerg Roedel <joro@8bytes.org> wrote:
> Lots of collisions here with Christoph's "decruft the vmalloc API" series
> (http://lkml.kernel.org/r/20200414131348.444715-1-hch@lst.de).
> 
> I attempted to fix things up.
> 
> unmap_kernel_range_noflush() needed to be redone.
> 
> map_kernel_range_noflush() might need the arch_sync_kernel_mappings() call?

Yes, map_kernel_range_noflush() needs the arch_sync_kernel_mappings()
call as well.

Regards,

	Joerg

