Return-Path: <linux-arch+bounces-471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861A27FA404
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 16:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8EAB20FD2
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163A31739;
	Mon, 27 Nov 2023 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B5B1AA;
	Mon, 27 Nov 2023 07:04:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E60E2F4;
	Mon, 27 Nov 2023 07:05:29 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD9413F6C4;
	Mon, 27 Nov 2023 07:04:36 -0800 (PST)
Date: Mon, 27 Nov 2023 15:04:34 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 13/27] arm64: mte: Make tag storage depend on
 ARCH_KEEP_MEMBLOCK
Message-ID: <ZWSwArYMN1LuyGfO@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-14-alexandru.elisei@arm.com>
 <91c5d2e2-57b1-4172-88e0-cd07a8d85af4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91c5d2e2-57b1-4172-88e0-cd07a8d85af4@redhat.com>

Hi,

On Fri, Nov 24, 2023 at 08:51:38PM +0100, David Hildenbrand wrote:
> On 19.11.23 17:57, Alexandru Elisei wrote:
> > Tag storage memory requires that the tag storage pages used for data are
> > always migratable when they need to be repurposed to store tags.
> > 
> > If ARCH_KEEP_MEMBLOCK is enabled, kexec will scan all non-reserved
> > memblocks to find a suitable location for copying the kernel image. The
> > kernel image, once loaded, cannot be moved to another location in physical
> > memory. The initialization code for the tag storage reserves the memblocks
> > for the tag storage pages, which means kexec will not use them, and the tag
> > storage pages can be migrated at any time, which is the desired behaviour.
> > 
> > However, if ARCH_KEEP_MEMBLOCK is not selected, kexec will not skip a
> > region unless the memory resource has the IORESOURCE_SYSRAM_DRIVER_MANAGED
> > flag, which isn't currently set by the tag storage initialization code.
> > 
> > Make ARM64_MTE_TAG_STORAGE depend on ARCH_KEEP_MEMBLOCK to make it explicit
> > that that the Kconfig option required for it to work correctly.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >   arch/arm64/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 047487046e8f..efa5b7958169 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -2065,6 +2065,7 @@ config ARM64_MTE
> >   if ARM64_MTE
> >   config ARM64_MTE_TAG_STORAGE
> >   	bool "Dynamic MTE tag storage management"
> > +	depends on ARCH_KEEP_MEMBLOCK
> >   	select CONFIG_CMA
> >   	help
> >   	  Adds support for dynamic management of the memory used by the hardware
> 
> Doesn't arm64 select that unconditionally? Why is this required then?

I've added this patch to make the dependancy explicit. If, in the future, arm64
stops selecting ARCH_KEEP_MEMBLOCK, I thinkg it would be very easy to miss the
fact that tag storage depends on it. So this patch is not required per-se, it's
there to document the dependancy.

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

