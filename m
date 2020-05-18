Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD021D7714
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgERLbJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 07:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgERLbJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 07:31:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B0920756;
        Mon, 18 May 2020 11:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589801468;
        bh=mA5LuL+NZ4U22EpIeu1yY/QuHzmG+4ZlK35nDxAZ3lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XF7NkBh2RpP7Djhlw6gtpIkyVTqRimk+VriVrbaCTcWm/aslkIwjKrKCrs5T2jQ4v
         B9xYMQiqzJR3hkd0a/BLad5a4SW3AkDSXqzrObZQ4NfAO9jrtvsYsOiJ/lEIeuhY3z
         c01YbNXnW0VfZBr3F1izfcNFuOr49q89HEZl1o5I=
Date:   Mon, 18 May 2020 12:31:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Message-ID: <20200518113103.GA32394@willie-the-truck>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 18, 2020 at 12:26:30PM +0100, Vladimir Murzin wrote:
> On 5/15/20 6:16 PM, Catalin Marinas wrote:
> > For performance analysis it may be desirable to disable MTE altogether
> > via an early param. Introduce arm64.mte_disable and, if true, filter out
> > the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> > user.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> > 
> > Notes:
> >     New in v4.
> > 
> >  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> >  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2a93c8679e8..7436e7462b85 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -373,6 +373,10 @@
> >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> >  			Format: <io>,<irq>,<nodeID>
> >  
> > +	arm64.mte_disable=
> > +			[ARM64] Disable Linux support for the Memory
> > +			Tagging Extension (both user and in-kernel).
> > +
> 
> Should it really to take parameter (on/off/true/false)? It may lead to expectation
> that arm64.mte_disable=false should enable MT and, yes, double negatives make it
> look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?

I don't think "performance analysis" is a good justification for this
parameter tbh. We don't tend to add these options for other architectural
features, and I don't see why MTE is any different in this regard.

Will
