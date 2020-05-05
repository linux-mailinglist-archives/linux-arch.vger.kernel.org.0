Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E8C1C5647
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgEENGf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 09:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgEENGe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 09:06:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21234206B9;
        Tue,  5 May 2020 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588683994;
        bh=Lo70slr8q6hVZZOfAFrq+LmfcmXfJzU5tcB7s2flPV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8IeRlm35Jw/eqhHnmoO30n1tRbJbzSYo/hks7+igLHvWYOrUkLsNjIy28BG4ZV0Y
         ZcE7aM+v3Sil2baOxCPlJFgtl/a+Rm2Fat945rarisdb4FsOfiRP4S9+w0eFr4LPTf
         LXRd2qdFPmDXwCT1mm0TNKF4k39CvvqUYCeXLH+4=
Date:   Tue, 5 May 2020 14:06:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        linux-man@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Message-ID: <20200505130629.GK19710@willie-the-truck>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
 <20200505124351.GF1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505124351.GF1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 05, 2020 at 01:43:51PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
> > Michael has been nagging me on and off about that for, what, 10 years now?
> > I would therefore be very much in favour of having our ptrace extensions
> > documented!
> > 
> > We could even put this stuff under Documentation/arm64/man/ if it's deemed
> > too CPU-specific for the man-pages project, but my preference would still
> > be for it to be hosted there alongside all the other man pages.
> 
> Stuffing random things into the kernel tree is painful for some people.
> 
> For example, if you cross-build your kernel, then the stuff in the
> tools/ subdirectory is totally useless (I think everything except
> perf) because you can't build it.
> 
> Let's stop making the mistake of constantly shoving stuff into the
> kernel source tree.

For userspace tools, I'm inclined to agree, but this is just documentation
so it shouldn't cause any issues with cross building. But to be clear: I'd
still prefer it to be part of the man-pages project, and would only consider
it for inclusion in the kernel tree if it was rejected for being too
CPU-specific.

Will
