Return-Path: <linux-arch+bounces-1488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BA3839A2D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 21:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8251F2A9DB
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42D385C46;
	Tue, 23 Jan 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Slrg1J/D"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553350276;
	Tue, 23 Jan 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041224; cv=none; b=Crmkx4PtQtS72/MjSwpmn6172FRqfgEuallN2Em49duiVzMeU8PAd1m1OYcPbKVBl6E1//1kEO3CGCAziXpHnwZdvaMNedDMp/G9YdU5CxTXh1ZHCrQ0STwTPS9csr2uH3KtumKyfxCRnf6uPelmuWYO1lwHZUCjxGhnoHO8RxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041224; c=relaxed/simple;
	bh=xM133hD/HSCXT1KX4H7xbcfslhLaVzrqvIsmxWzuX+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ObrBzYTIEwN7S+fJXrku0iveS4Wo7TlISb+G1zFezykxVq+nbTLpegf3jjloUUNZ273v1PtT+uwI1l/vOfakVcwpVsV4zXmalkhvUTzVgcgEspXWW43zmE7JnaKv36RdhYiFza3kQ7pMvlIZFq2tWZDBAfX2QQDB4/6f5PwbHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Slrg1J/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B4BC433C7;
	Tue, 23 Jan 2024 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706041224;
	bh=xM133hD/HSCXT1KX4H7xbcfslhLaVzrqvIsmxWzuX+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Slrg1J/DScPziQN8aDITgYI9KV9hL7CVUWaDyVEig+sEaT86kWUWDlf1pBHqNorQ2
	 D7uAMrxpbUsQ2XESO3soOP8uR/JkEXjbHKIU9fIvov8K6SDdb4jgXgQBj9HoixB+qe
	 8VoXP5mbwqnR9u08d/bIFDOH+3SUVQeMBM0m95fjlqZG2HpH79124uVsUFaRTnS2GY
	 GgHc3BmbLMhFncHqIV+F0WIAWNnLi/lJPPrcbng9gZ/JdPY1IQQ0VZl2ihzbIWHSwS
	 iKvCNYAWzY8pKBd5VDpn+NYFnrvcMzWEexhF4OMNt+G5GpcSUldUvF6EK9jwpgKV4G
	 Qjz4j8Gxn+y7g==
Date: Tue, 23 Jan 2024 14:20:22 -0600
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
Message-ID: <20240123202022.GA325908@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111085540.7740-3-pstanner@redhat.com>

On Thu, Jan 11, 2024 at 09:55:37AM +0100, Philipp Stanner wrote:
> This file is guarded by an #ifdef CONFIG_PCI. It, consequently, does not
> belong to lib/ because it is not generic infrastructure.
> 
> Move the file to drivers/pci/ and implement the necessary changes to
> Makefiles and Kconfigs.
> ...

> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -13,6 +13,11 @@ config FORCE_PCI
>  	select HAVE_PCI
>  	select PCI
>  
> +# select this to provide a generic PCI iomap,
> +# without PCI itself having to be defined
> +config GENERIC_PCI_IOMAP
> +	bool

> --- a/lib/pci_iomap.c
> +++ b/drivers/pci/iomap.c
> @@ -9,7 +9,6 @@
>  
>  #include <linux/export.h>
>  
> -#ifdef CONFIG_PCI

IIUC, in the case where CONFIG_GENERIC_PCI_IOMAP=y but CONFIG_PCI was
not set, pci_iomap.c was compiled but produced no code because the
entire file was wrapped with this #ifdef.

But after this patch, it looks like pci_iomap_range(),
pci_iomap_wc_range(), etc., *will* be compiled?

Is that what you intend, or did I miss something?

Bjorn

