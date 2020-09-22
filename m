Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746EA27460C
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIVQEb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Sep 2020 12:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgIVQEY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Sep 2020 12:04:24 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA01208A9;
        Tue, 22 Sep 2020 16:04:21 +0000 (UTC)
Date:   Tue, 22 Sep 2020 17:04:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200922160418.GG15643@gaia>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
 <20200917081107.GA29031@willie-the-truck>
 <20200917090229.GA10662@gaia>
 <20200917161550.GA6642@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917161550.GA6642@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 17, 2020 at 05:15:53PM +0100, Dave P Martin wrote:
> On Thu, Sep 17, 2020 at 10:02:30AM +0100, Catalin Marinas wrote:
> > On Thu, Sep 17, 2020 at 09:11:08AM +0100, Will Deacon wrote:
> > > Wasn't there a man page kicking around too? Would be good to see that
> > > go upstream (to the manpages project, of course).
> > 
> > Dave started writing one for the tagged address ABI, not sure where that
> > is. For the MTE additions, we are waiting for the ABI to be upstreamed.
> 
> The tagged address ABI control stuff is upstream in the man-pages-5.08
> release.
> 
> I don't think anyone drafted anything for MTE yet.  Do we consider the
> MTE ABI to be sufficiently stable now for it to be worth starting
> drafting something?

Yes, the ABI is stable. The patches are in linux-next and, unless
something broken is found, we aim for 5.10.

-- 
Catalin
