Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F242B395584
	for <lists+linux-arch@lfdr.de>; Mon, 31 May 2021 08:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaGik (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 May 2021 02:38:40 -0400
Received: from verein.lst.de ([213.95.11.211]:48269 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEaGik (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 May 2021 02:38:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4B7F367373; Mon, 31 May 2021 08:36:58 +0200 (CEST)
Date:   Mon, 31 May 2021 08:36:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     palmerdabbelt@google.com
Cc:     Christoph Hellwig <hch@lst.de>, guoren@kernel.org,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        guoren@linux.alibaba.com
Subject: Re: [PATCH V4 2/2] riscv: Use use_asid_allocator flush TLB
Message-ID: <20210531063658.GB1143@lst.de>
References: <20210527070903.GA32653@lst.de> <mhng-cfb5a043-4b59-4698-b732-5cf5ceb49114@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-cfb5a043-4b59-4698-b732-5cf5ceb49114@palmerdabbelt-glaptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 29, 2021 at 04:42:37PM -0700, palmerdabbelt@google.com wrote:
>>
>> Also the non-ASID code switches to a global flush once flushing more
>> than a single page.  It might be worth documenting the tradeoff in the
>> code.
>
> For some reason I thought we'd written this down in the commentary of teh 
> ISA manual as the suggested huersitic here, but I can't find it so maybe 
> I'm wrong.  If it's actually there it would be good to point that out, 
> otherwise some documentation seems fine as it'll probably become a tunable 
> at some point anyway.

The real question is why is the heuristic different for the ASID vs
non-ASID case?  I think that really need a comment.

> LGTM.  I took the first one as IMO they're really distnict issues, LMK if 
> you want to re-spin this one or if I should just take what's here.

What distinct issue?  The fact that the new code is buggy and uses rather
non-optimal calling conventions?
