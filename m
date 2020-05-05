Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B111C5389
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 12:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgEEKpA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 06:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgEEKpA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 06:45:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E451206A5;
        Tue,  5 May 2020 10:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588675499;
        bh=J8dSAo1NkSjvZvb30jTZhQbKGZ1WYsmYm2gswSFV5RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pc0Jpyt+vWwwHoLo73p8Vc6s1jyECtwd+SzEDzEOh1CgA7+Ynw6w5KLGRlJpIVh+K
         GhPCIzhCRMcSIrIkCk4OmS674kxNUmzoocg4/kDYIxZnAiflBNhZkT1kuPZ+F4y3R9
         K9i4Rdw3VXSbPuD9xT12RHGONOAN/UuEijWzSnVk=
Date:   Tue, 5 May 2020 11:44:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Message-ID: <20200505104454.GC19710@willie-the-truck>
References: <20200504153214.GH30377@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504153214.GH30377@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On Mon, May 04, 2020 at 04:32:35PM +0100, Dave Martin wrote:
> I considering trying to plug some gaps in the arch-specific ABI
> documentation in the linux man-pages, specifically for arm64 (and
> possibly arm, where compat means we have some overlap).
> 
> For arm64, there are now significant new extensions (Pointer
> authentication, SVE, MTE etc.)  Currently there is some user-facing
> documentation mixed in with the kernel-facing documentation in the
> kernel tree, but this situation isn't ideal.
> 
> Do you have an opinion on where in the man-pages documentation should be
> added, and how to structure it?
> 
> 
> Affected areas include:
> 
>  * exec interface
>  * aux vector, hwcaps
>  * arch-specific signals
>  * signal frame
>  * mmap/mprotect extensions
>  * prctl calls
>  * ptrace quirks and extensions
>  * coredump contents
> 
> 
> Not everything has an obvious home in an existing page, and adding
> specifics for every architecture could make some existing manpages very
> unwieldy.
> 
> I think for some arch features, we really need some "overview" pages
> too: just documenting the low-level details is of limited value
> without some guide as to how to use them together.
> 
> 
> Does the following sketch look reasonable?
> 
>  * man7/arm64.7: new page: overview of arm64-specific ABI extensions
> 
>  * man7/sve.7 (or man7/arm64-sve.7 or man7/sve.7arm64): new page:
>    overview of arm64 SVE ABI
> 
>  * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
>    arm64 ptrace extensions

Michael has been nagging me on and off about that for, what, 10 years now?
I would therefore be very much in favour of having our ptrace extensions
documented!

We could even put this stuff under Documentation/arm64/man/ if it's deemed
too CPU-specific for the man-pages project, but my preference would still
be for it to be hosted there alongside all the other man pages.

Will
