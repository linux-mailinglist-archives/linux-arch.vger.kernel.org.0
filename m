Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEAD1CB9ED
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 23:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEHVgO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 17:36:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:36998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVgN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 17:36:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96C9FAD60;
        Fri,  8 May 2020 21:36:14 +0000 (UTC)
Date:   Fri, 8 May 2020 23:36:09 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200508213609.GU8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 08, 2020 at 02:33:19PM -0700, Andy Lutomirski wrote:
> On Fri, May 8, 2020 at 7:40 AM Joerg Roedel <joro@8bytes.org> wrote:

> What's the maximum on other system types?  It might make more sense to
> take the memory hit and pre-populate all the tables at boot so we
> never have to sync them.

Need to look it up for 5-level paging, with 4-level paging its 64 pages
to pre-populate the vmalloc area.

But that would not solve the problem on x86-32, which needs to
synchronize unmappings on the PMD level.


	Joerg
