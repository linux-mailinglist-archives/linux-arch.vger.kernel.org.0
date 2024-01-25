Return-Path: <linux-arch+bounces-1671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F09983CB2B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 19:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33E31F2240C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD50135A53;
	Thu, 25 Jan 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4wtXRhi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34413399E;
	Thu, 25 Jan 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207470; cv=none; b=c6rcsRGiysT06u3B5vfAPAB0vetgxUznZ0YdgRa8m+qHFR3pBgOTKGRqdwoOroTAd9nQHzOGYnLVSI/TNOvOGRmenBkRZs9gXELYD4xyNVL6UlqqQWT9qFCVnD59gj8ZRq9MpJhC9B01ARFKtzEE/t26RiOtAUwk0mxxiDhAhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207470; c=relaxed/simple;
	bh=LTM9Rq0ah24lwvVn1y8YRCHc6j5ROIsgGb706zCSPEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QK91g528v5d+AXFY78YA3hDlkK0LNcTjXrSxCoH2thZf/M86CwAzMsdd1F6896a2xY+YCkvjD3I5APkkkkeMFvOd27VQK4gSkBrzbryZkUf5seE7PTLJ4pDzOzFeSZcOLECPd0lVgNJjzyatQvm/QHfZxxnmCZvK9aqfHnNOjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4wtXRhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC4DC433F1;
	Thu, 25 Jan 2024 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706207469;
	bh=LTM9Rq0ah24lwvVn1y8YRCHc6j5ROIsgGb706zCSPEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S4wtXRhiDkmqHfxDMkUhXRmGNOlc2t6Dxgow2TFcrq/mWLHuIVpkF9dTF3+NdSXEw
	 jZmifn0eFFKIR8Hf3ZuJ1j0R6xhj4QvHqIz9eeW9NbXopCjBKQQJ0CZF2PDzpL1Jjl
	 zHbWVTgyhu11TS7DO4fXyVOMnXjWjP7l3x6q0o5Xqug0ySRSOwCA95u2546yaYGRFw
	 8c0o6Y8RJu0qV+KNPupq3A4FZK8BPZy50azhxOYhmYcBFK/zC7qj6gfujx6g4V140i
	 n6tmfWv63Jx/zDFXdWVrAHs8lCM8GhxbySSBkxwbNzQ0FbR7fC3hxlKeYpfyZjTjGm
	 LMjxQ2FYEQPAg==
Date: Thu, 25 Jan 2024 12:31:07 -0600
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
	linux-arch@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 2/5] lib: move pci_iomap.c to drivers/pci/
Message-ID: <20240125183107.GA393314@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3abf071d12de5b69e146665dfb57386e3b0ddfe0.camel@redhat.com>

On Thu, Jan 25, 2024 at 03:54:51PM +0100, Philipp Stanner wrote:
> On Tue, 2024-01-23 at 14:20 -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 11, 2024 at 09:55:37AM +0100, Philipp Stanner wrote:
> > > This file is guarded by an #ifdef CONFIG_PCI. It, consequently,
> > > does not
> > > belong to lib/ because it is not generic infrastructure.
> > > 
> > > Move the file to drivers/pci/ and implement the necessary changes
> > > to
> > > Makefiles and Kconfigs.
> > > ...
> > 
> > > --- a/drivers/pci/Kconfig
> > > +++ b/drivers/pci/Kconfig
> > > @@ -13,6 +13,11 @@ config FORCE_PCI
> > >         select HAVE_PCI
> > >         select PCI
> > >  
> > > +# select this to provide a generic PCI iomap,
> > > +# without PCI itself having to be defined
> > > +config GENERIC_PCI_IOMAP
> > > +       bool
> > 
> > > --- a/lib/pci_iomap.c
> > > +++ b/drivers/pci/iomap.c
> > > @@ -9,7 +9,6 @@
> > >  
> > >  #include <linux/export.h>
> > >  
> > > -#ifdef CONFIG_PCI
> > 
> > IIUC, in the case where CONFIG_GENERIC_PCI_IOMAP=y but CONFIG_PCI was
> > not set, pci_iomap.c was compiled but produced no code because the
> > entire file was wrapped with this #ifdef.
> > 
> > But after this patch, it looks like pci_iomap_range(),
> > pci_iomap_wc_range(), etc., *will* be compiled?
> > 
> > Is that what you intend, or did I miss something?
> 
> They *will* be compiled when BOTH, CONFIG_PCI and
> CONFIG_GENERIC_PCI_IOMAP have been set.

I was asking about CONFIG_GENERIC_PCI_IOMAP=y but CONFIG_PCI unset.

But the Makefile contains this:

  ifdef CONFIG_PCI
  obj-$(CONFIG_GENERIC_PCI_IOMAP) += iomap.o
  endif

So iomap.c will not be compiled when CONFIG_PCI is unset, which is
what I missed.

Bjorn

