Return-Path: <linux-arch+bounces-1952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E64844979
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 22:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56471C22D0B
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 21:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F7838FB9;
	Wed, 31 Jan 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+UBbeYy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682638DE4;
	Wed, 31 Jan 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735386; cv=none; b=t6XNK0XOWZGII+lUZgt7kQUpNxr/Vi+zB4dwcKociyiGzbT2BFCPh1HdoJtoz4eZKEOeHDwNmoRwCz1Jw5XI6ADX4+9p70wDoywnQ03rAMCFs2FBma5BVeyff1Kn2QUcydPgbdzx3vLgOGoJGSotGwaDGRVMc7PwErqoI3lWQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735386; c=relaxed/simple;
	bh=7bVKxwIoaeqCS0+5AkL8/ahDS4KgCUDPD8Zj2gZaMa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FRBJHJi2IJlWT/pYH6zsXe4ApkqtgGPYu+N4noHLf+fua5NHpJv8SSNx28bkKm1XeophnJPNiQhOexaaSl0cqyg9WMgu3myUUpjiLsNzl2SU/gtFHW1o7AGPuACMKum3+bMzg7RDSDy2FGVvtOnUyvBskhsoLjGNnvoaOoMJUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+UBbeYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33A8C433F1;
	Wed, 31 Jan 2024 21:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706735386;
	bh=7bVKxwIoaeqCS0+5AkL8/ahDS4KgCUDPD8Zj2gZaMa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k+UBbeYyHR6ZTwLYivg54Ff5rluVBj9+W52TMTxMWv/37OJmHdLH8E0a3etwswaNe
	 QBzJEApL416/pZKTTY5O7WK3aabKPkVIFJpfnHG4F+AtpIskS9lRo4MBFdzxAQFpVf
	 qHGelaGAq/uEGGiR7kP7S6In6IichuUBevuOA86fu3ZarPyYhV5nHRKRsDs9LT1j80
	 Peg0cBwOnDz7/fR+rSx4qCb1A9neoAFbbaQ6e5Ou2ZfojnMsWB5th1OoxPlbiDM1E4
	 M15ObeoyW0z7wnwWo0ppwen/sgbGdvUQ8HzCQezH83al+Fbn+D8VNUw7eof4vlM4Az
	 IxoHjjAJYunqQ==
Date: Wed, 31 Jan 2024 15:09:44 -0600
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
Subject: Re: [PATCH v6 1/4] lib/pci_iomap.c: fix cleanup bug in pci_iounmap()
Message-ID: <20240131210944.GA599710@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131090023.12331-2-pstanner@redhat.com>

On Wed, Jan 31, 2024 at 10:00:20AM +0100, Philipp Stanner wrote:
> The #ifdef for the ioport-ranges accidentally also guards iounmap(),
> potentially compiling an empty function. This would cause the mapping to
> be leaked.
> 
> Move the guard so that iounmap() will always be part of the function.

I tweaked the subject and commit log to be more explicit about what
the bug is.  Let me know if I got it wrong:

  pci_iounmap(): Fix MMIO mapping leak

  The #ifdef ARCH_HAS_GENERIC_IOPORT_MAP accidentally also guards iounmap(),
  which means MMIO mappings are leaked.

  Move the guard so we call iounmap() for MMIO mappings.

Bjorn

