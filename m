Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4571C5ED0
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 19:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgEERal (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 13:30:41 -0400
Received: from foss.arm.com ([217.140.110.172]:46370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEERal (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 13:30:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39A4B31B;
        Tue,  5 May 2020 10:30:40 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE3D63F305;
        Tue,  5 May 2020 10:30:36 -0700 (PDT)
Date:   Tue, 5 May 2020 18:30:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200505173029.GB81129@C02TF0J2HF1T.local>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-24-catalin.marinas@arm.com>
 <20200505103232.GE23080@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505103232.GE23080@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 05, 2020 at 11:32:33AM +0100, Szabolcs Nagy wrote:
> The 04/21/2020 15:26, Catalin Marinas wrote:
> > +PROT_MTE
> > +--------
> > +
> > +To access the allocation tags, a user process must enable the Tagged
> > +memory attribute on an address range using a new ``prot`` flag for
> > +``mmap()`` and ``mprotect()``:
> > +
> > +``PROT_MTE`` - Pages allow access to the MTE allocation tags.
> > +
> > +The allocation tag is set to 0 when such pages are first mapped in the
> > +user address space and preserved on copy-on-write. ``MAP_SHARED`` is
> > +supported and the allocation tags can be shared between processes.
> > +
> > +**Note**: ``PROT_MTE`` is only supported on ``MAP_ANONYMOUS`` and
> > +RAM-based file mappings (``tmpfs``, ``memfd``). Passing it to other
> > +types of mapping will result in ``-EINVAL`` returned by these system
> > +calls.
> > +
> > +**Note**: The ``PROT_MTE`` flag (and corresponding memory type) cannot
> > +be cleared by ``mprotect()``.
> 
> i think there are some non-obvious madvise operations that may
> be worth documenting too for mte specific semantics.
> 
> e.g. MADV_DONTNEED or MADV_FREE can presumably drop tags which
> means that existing pointers can no longer write to the memory
> which is a change of behaviour compared to the non-mte case.
> (affects most malloc implementations that will have to deal
> with this when implementing heap coloring) there might be other
> similar problems like MADV_WIPEONFORK that wont work as
> currently expected when mte is enabled.
> 
> if such behaviour changes cause serious problems to existing
> software there may be a need to have a way to opt out from
> these changes (e.g. MADV_ flag variant that only affects the
> memory content but not the tags) or to make that the default
> behaviour. (but i can't tell how widely these are used in
> ways that can be expected to work with PROT_MTE)

Thanks. I'll document this behaviour as it may not be obvious.

For the record (as we discussed this internally), I think the kernel
behaviour is entirely expected. On mmap(PROT_MTE), the kernel would
return pages with tags set to 0. On madvise(MADV_DONTNEED), the kernel
may free the pages but map them back on access using the same conditions
they were previously given to the user, i.e. tags set to 0. There isn't
any expectations for the kernel to preserve the tags of
MADV_DONTNEED/FREE pages (which defeats the point of dontneed/free).

-- 
Catalin
