Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8C1E0B5C
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 12:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbgEYKFp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 06:05:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:40252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389302AbgEYKFo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 May 2020 06:05:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AEA73ACE6;
        Mon, 25 May 2020 10:05:45 +0000 (UTC)
Date:   Mon, 25 May 2020 12:05:40 +0200
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
Message-ID: <20200525100540.GB5075@suse.de>
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
> It would be nice to get all this (ie, linux-next) retested before we
> send it upstream, please.

Tested these patches as in next-20200522, with three 2, 3, and 4-level
paging. On 4-level (aka 64-bit) I also re-ran the Stevens trace-cmd
reproducer, no issues found and the trace-cmd problem is still fixed.

Thanks,

	Joerg
