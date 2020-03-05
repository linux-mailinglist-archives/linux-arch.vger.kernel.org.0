Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7357D17AAA5
	for <lists+linux-arch@lfdr.de>; Thu,  5 Mar 2020 17:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCEQiO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Mar 2020 11:38:14 -0500
Received: from foss.arm.com ([217.140.110.172]:50950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCEQiO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 11:38:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAC3930E;
        Thu,  5 Mar 2020 08:38:13 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FFEE3F534;
        Thu,  5 Mar 2020 08:38:12 -0800 (PST)
Date:   Thu, 5 Mar 2020 16:38:10 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 04/19] arm64: mte: Use Normal Tagged attributes for
 the linear map
Message-ID: <20200305163810.GC1729062@arrakis.emea.arm.com>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
 <20200226180526.3272848-5-catalin.marinas@arm.com>
 <946fcd05-ba8f-90ec-d30b-458b327df59c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <946fcd05-ba8f-90ec-d30b-458b327df59c@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 05, 2020 at 04:21:34PM +0000, Steven Price wrote:
> On 26/02/2020 18:05, Catalin Marinas wrote:
> > +	if (system_supports_mte()) {
> > +		/*
> > +		 * Changing the memory type between Normal and Normal-Tagged
> > +		 * is safe since Tagged is considered a permission attribute
> > +		 * from the mismatched attribute aliases perspective.
> > +		 */
> > +		if ((old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
> > +		    (old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED) ||
> > +		    (new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
> > +		    (new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED))
> > +			mask |= PTE_ATTRINDX_MASK;
> > +	}
> > +
> >  	return ((old ^ new) & ~mask) == 0;
> >  }
> 
> This is much more permissive than I would expect. If either the old or
> new memory type is NORMAL (or NORMAL_TAGGED) then the memory type is
> ignored altogether.
> 
> Should this check be:
> 
> if (((old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
>      (old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED)) &&
>     ((new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
>      (new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED)))

You are right, I think my patch allows many other memory type
combinations. Thanks.

-- 
Catalin
