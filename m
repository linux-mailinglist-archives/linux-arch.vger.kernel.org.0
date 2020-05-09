Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5B1CC361
	for <lists+linux-arch@lfdr.de>; Sat,  9 May 2020 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEIRyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 May 2020 13:54:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgEIRyv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 May 2020 13:54:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8F4DAC26;
        Sat,  9 May 2020 17:54:52 +0000 (UTC)
Date:   Sat, 9 May 2020 19:54:48 +0200
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
Message-ID: <20200509175448.GW8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508192000.GB2957@hirez.programming.kicks-ass.net>
 <20200508213407.GT8135@suse.de>
 <20200509092516.GC2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509092516.GC2957@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 09, 2020 at 11:25:16AM +0200, Peter Zijlstra wrote:
> Right; it's just that the moment you do trigger it, it'll iterate that
> pgd_list and that is potentially huge. Then again, that's not a new
> problem.
> 
> I suppose we can deal with it if/when it becomes an actual problem.
> 
> I had a quick look and I think it might be possible to make it an RCU
> managed list. We'd have to remove the pgd_list entry in
> put_task_struct_rcu_user(). Then we can play games in sync_global_*()
> and use RCU iteration. New tasks (which can be missed in the RCU
> iteration) will already have a full clone of the PGD anyway.

Right, it should not be that difficult to rcu-protect the pgd-list, but
we can try that when it actually becomes a problem.


	Joerg
