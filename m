Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD201CF842
	for <lists+linux-arch@lfdr.de>; Tue, 12 May 2020 17:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgELPCz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 May 2020 11:02:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:46198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgELPCy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 11:02:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 95DD1AB64;
        Tue, 12 May 2020 15:02:55 +0000 (UTC)
Date:   Tue, 12 May 2020 17:02:50 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Message-ID: <20200512150250.GC8135@suse.de>
References: <20200511191414.GY8135@suse.de>
 <8D6745B7-0EC2-4FCC-B6FC-E7E1557EB18E@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8D6745B7-0EC2-4FCC-B6FC-E7E1557EB18E@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 11, 2020 at 12:36:19PM -0700, Andy Lutomirski wrote:
> I’m guessing the right solution is either your series or your series
> plus preallocation on 64-bit. I’m just grumpy about it...

Okay, so we can do the pre-allocation when it turns out the pgd_list
lock-times become a problem on x86-64. The tracking code in vmalloc.c is
needed anyway for 32-bit and there is no reason why 64-bit shouldn't use
it as well for now.
I don't think that taking the lock _will_ be a problem, as it is only
taken when a new PGD/P4D entry is populated. And it is pretty unlikely
that a system will populate all 64 of them, with 4-level paging each of
these entries will map 512GB of address space. But if I am wrong here
pre-allocating is still an option.


	Joerg
