Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB37D3A0CB6
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 08:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhFIGyQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 02:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhFIGyP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 02:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F40D661249;
        Wed,  9 Jun 2021 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623221541;
        bh=1NOcR9X1qrsVWC8pZ+WOBsJYlerWmKCJZFjAHZSyi1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3Ua7SSrAmPcigjQENQSeeEMj920XMPbd0mRAH+B4DHPNXP+taIOYwYUWcVIXb5j6
         VJBySmzsOYZnbE6P4kMoE9ZvUpFBLiddGWhEYtU+E0KEUzEdWHkJqeLVtgBH6jO4C9
         Pe9x2UVR5RoSXUB4d6262LpkrrGlAOAE5RSKB4ZbL931VU3fcHDPQIgBFXazdDNmx0
         KYGm7I3vStPQPXah/NfmgtdSVOkJw8ewGPxvh3kYk2hvG8vZe26iLuJ3PqURc/rI07
         p6tkwWjdfIcQ6IB7Wn8wiS2wG0e2oDGZCpnQAvL+zgWVSStPrtFhj2bz5Vv7w2pP3G
         OCNYfrxKsGSKw==
Date:   Wed, 9 Jun 2021 09:52:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 8/9] mm: replace CONFIG_NEED_MULTIPLE_NODES with
 CONFIG_NUMA
Message-ID: <YMBlGBxaWDPV1ouT@kernel.org>
References: <20210608091316.3622-1-rppt@kernel.org>
 <20210608091316.3622-9-rppt@kernel.org>
 <20210608172544.d9bf17549565d866fbb18451@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608172544.d9bf17549565d866fbb18451@linux-foundation.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 08, 2021 at 05:25:44PM -0700, Andrew Morton wrote:
> On Tue,  8 Jun 2021 12:13:15 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > After removal of DISCINTIGMEM the NEED_MULTIPLE_NODES and NUMA
> > configuration options are equivalent.
> > 
> > Drop CONFIG_NEED_MULTIPLE_NODES and use CONFIG_NUMA instead.
> > 
> > Done with
> > 
> > 	$ sed -i 's/CONFIG_NEED_MULTIPLE_NODES/CONFIG_NUMA/' \
> > 		$(git grep -wl CONFIG_NEED_MULTIPLE_NODES)
> > 	$ sed -i 's/NEED_MULTIPLE_NODES/NUMA/' \
> > 		$(git grep -wl NEED_MULTIPLE_NODES)
> > 
> > with manual tweaks afterwards.
> > 
> > ...
> >
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -987,7 +987,7 @@ extern int movable_zone;
> >  #ifdef CONFIG_HIGHMEM
> >  static inline int zone_movable_is_highmem(void)
> >  {
> > -#ifdef CONFIG_NEED_MULTIPLE_NODES
> > +#ifdef CONFIG_NUMA
> >  	return movable_zone == ZONE_HIGHMEM;
> >  #else
> >  	return (ZONE_MOVABLE - 1) == ZONE_HIGHMEM;
> 
> I dropped this hunk - your "mm/mmzone.h: simplify is_highmem_idx()"
> removed zone_movable_is_highmem().  

Ah, right.
Thanks!

-- 
Sincerely yours,
Mike.
