Return-Path: <linux-arch+bounces-1475-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 478C383982C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3F51F23EF7
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F064823CA;
	Tue, 23 Jan 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r++rzSzb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ABC823A8;
	Tue, 23 Jan 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035585; cv=none; b=BuK6ob6D3rQhSSs6nbPhB5C4corp9mVDj5WEMfWp4rRGaxeIgtqX+zdWgJ1XPpGp9wb/VaaN/zuDc/k9g0UYfagC9SQVUiEcdZbeJQDeA2EPTZIwMU/htSGe/FVRS0G0oZ+PTsnzI1yzYvtwB4+TfBDh5r7xzYfSJAxXMKlGYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035585; c=relaxed/simple;
	bh=xlETS4vfNKM7NA6UlEXX0jTXt3XzQwXBLD5Nx+jrOU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=naKaqtqBScPjwxf/mUlJFu8mq0jHUyn1mXA5uGc0VFXKumFSqyIUnOOf85KULFuKfg3kXi2lcjKW6QqGEkm/rQMafuf1ppmSbuNx1cBAsj5UXgsuUEatKFX5HwiCO6IIPfnqoX6XQkPBnjeKYNrwBHHqusa5yjjZ92eTaghbZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r++rzSzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D114C433F1;
	Tue, 23 Jan 2024 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706035584;
	bh=xlETS4vfNKM7NA6UlEXX0jTXt3XzQwXBLD5Nx+jrOU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r++rzSzbdOdCg4Bk0FX/ltZades3wcWMo1/cZDk8BsIK2avLSDgrXRVlu66sDs15D
	 k9AJPhr/bXSZRZkZCSMtl/swPKxnNzYP7gn4ONuOqeD1aVEW2yg4OwVIu+k/mJ0V5p
	 krJMR+aBE/hp+oRzL9ujwC2hhYqZMOXu/oP1uMcmGMZoMLskHgeCBIANhwRT+aDUam
	 nv0iym9WNfKYAmSszPhqcOIvlTk6VjKMJmJFMuHvLfnBdIf0NbbI3m+qnVJPhV2zKi
	 IzcaQcLcfGDGKvUxQW0cQFt/pOLPqir/dfbCKLBahPOjoMGsogXqEkKVSMEpuBl/QO
	 CKjRk1JRsUkFQ==
Date: Tue, 23 Jan 2024 12:46:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Randy Dunlap <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, stable@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v5 RESEND 1/5] lib/pci_iomap.c: fix cleanup bugs in
 pci_iounmap()
Message-ID: <20240123184622.GA322265@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111085540.7740-2-pstanner@redhat.com>

On Thu, Jan 11, 2024 at 09:55:36AM +0100, Philipp Stanner wrote:
> pci_iounmap() in lib/pci_iomap.c is supposed to check whether an address
> is within ioport-range IF the config specifies that ioports exist. If
> so, the port should be unmapped with ioport_unmap(). If not, it's a
> generic MMIO address that has to be passed to iounmap().
> 
> The bugs are:
>   1. ioport_unmap() is missing entirely, so this function will never
>      actually unmap a port.

The preceding comment suggests that in this default implementation,
the ioport does not need unmapping, and it wasn't something it was
supposed to do but just failed to do:

 * NOTE! This default implementation assumes that if the architecture
 * support ioport mapping (HAS_IOPORT_MAP), the ioport mapping will
 * be fixed to the range [ PCI_IOBASE, PCI_IOBASE+IO_SPACE_LIMIT [,
 * and does not need unmapping with 'ioport_unmap()'.
 *
 * If you have different rules for your architecture, you need to
 * implement your own pci_iounmap() that knows the rules for where
 * and how IO vs MEM get mapped.

Almost all ioport_unmap() implementations are empty, so in most cases
it's a no-op (parisc is an exception).

I'm happy to add the ioport_unmap() even just for symmetry, but if we
do, I think we should update or remove that comment.

>   2. the #ifdef for the ioport-ranges accidentally also guards
>      iounmap(), potentially compiling an empty function. This would
>      cause the mapping to be leaked.
> 
> Implement the missing call to ioport_unmap().
> 
> Move the guard so that iounmap() will always be part of the function.

I think we should fix this bug in a separate patch because the
ioport_unmap() is much more subtle and doesn't need to be complicated
with this fix.

> CC: <stable@vger.kernel.org> # v5.15+
> Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
> Reported-by: Danilo Krummrich <dakr@redhat.com>

Is there a URL we can include for Danilo's report?  I found
https://lore.kernel.org/all/a6ef92ae-0747-435b-822d-d0229da4683c@redhat.com/,
but I'm not sure that's the right part of the conversation.

> Suggested-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/pci_iomap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index ce39ce9f3526..6e144b017c48 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -168,10 +168,12 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
>  	uintptr_t start = (uintptr_t) PCI_IOBASE;
>  	uintptr_t addr = (uintptr_t) p;
>  
> -	if (addr >= start && addr < start + IO_SPACE_LIMIT)
> +	if (addr >= start && addr < start + IO_SPACE_LIMIT) {
> +		ioport_unmap(p);
>  		return;
> -	iounmap(p);
> +	}
>  #endif
> +	iounmap(p);
>  }
>  EXPORT_SYMBOL(pci_iounmap);
>  
> -- 
> 2.43.0
> 

