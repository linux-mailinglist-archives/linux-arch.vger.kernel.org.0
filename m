Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352F014018A
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 02:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbgAQBqa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jan 2020 20:46:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgAQBq2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jan 2020 20:46:28 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38BFA2075B;
        Fri, 17 Jan 2020 01:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579225587;
        bh=kF0McEzzIna+OlNxDDvv0BFj+tanfJPabCZ9hgpDZTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YLuQ4iN8bF+tZrRX09LQTvkHEz92ULIHS5nIyWSwrfb4VbMtXxH/Oe5XZvuePIEYo
         sF47+mV/+zMy6nfyYfcd5nDd1MXB36Ni+9+XvwIfqY6iK0mnRcIs4F6WqZkN0XwLIK
         SBIuF6vqcLWRDG/ZIbepRDIL+/bqD5sHlh96ZRAA=
Date:   Thu, 16 Jan 2020 17:46:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     peterz@infradead.org, will@kernel.org, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/9] asm-generic/tlb: Avoid potential double flush
Message-Id: <20200116174626.0244f71bbff64eee6c7faa1d@linux-foundation.org>
In-Reply-To: <c12bb139-9eda-74a9-b4de-b147a88ed1b0@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
        <20200116064531.483522-4-aneesh.kumar@linux.ibm.com>
        <c12bb139-9eda-74a9-b4de-b147a88ed1b0@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 16 Jan 2020 12:19:59 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> On 1/16/20 12:15 PM, Aneesh Kumar K.V wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Aneesh reported that:
> > 
> > 	tlb_flush_mmu()
> > 	  tlb_flush_mmu_tlbonly()
> > 	    tlb_flush()			<-- #1
> > 	  tlb_flush_mmu_free()
> > 	    tlb_table_flush()
> > 	      tlb_table_invalidate()
> > 		tlb_flush_mmu_tlbonly()
> > 		  tlb_flush()		<-- #2
> > 
> > does two TLBIs when tlb->fullmm, because __tlb_reset_range() will not
> > clear tlb->end in that case.
> > 
> > Observe that any caller to __tlb_adjust_range() also sets at least one
> > of the tlb->freed_tables || tlb->cleared_p* bits, and those are
> > unconditionally cleared by __tlb_reset_range().
> > 
> > Change the condition for actually issuing TLBI to having one of those
> > bits set, as opposed to having tlb->end != 0.
> > 
> 
> 
> We should possibly get this to stable too along with the first two 
> patches. I am not quiet sure if this will qualify for a stable backport. 
> Hence avoided adding Cc:stable@kernel.org

I'm not seeing any description of the user-visible runtime effects. 
Always needed, especially for -stable, please.

It appears to be a small performance benefit?  If that benefit was
"large" and measurements were presented then that would be something
we might wish to backport.


