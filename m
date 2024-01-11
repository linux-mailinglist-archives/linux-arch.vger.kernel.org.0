Return-Path: <linux-arch+bounces-1347-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545182B115
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 15:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17517B26223
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3664F21B;
	Thu, 11 Jan 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii9rTNIH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C694F5EF;
	Thu, 11 Jan 2024 14:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1354C433F1;
	Thu, 11 Jan 2024 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984820;
	bh=+BqtsdmJgllie0f+TedmDOkSJxfwyuvJ7XtBHEWUI+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ii9rTNIHuhCcC5SFO36i+uwShspbZKQIChMO1ToULIRBnM8aehcOxo7Fpwa8NjUph
	 uLv6MGpH5QGiY9wytE3zVj+6SrNeL9P35PUpSgJqAgKY9Q/kmtV9cOzARg7s7LjCQz
	 VmXu4CklM0NEtcGAtnYPq+MDPhqOuy6Tg4ascn0bkMa8VyAoAyk3ScssPWxPN00BjC
	 Ed13owoFf0UZS3HP/dk+UG0HPgar2uFmL8BrDn+D5IkJpj5Og6wFLBJMnU87TysnG0
	 Mj2shKLMrrPdjSUbF8fffW7hYKhTtMs22pDLQGJtqSBmcXdvGG/s4zeML3RPE7wY9L
	 dZq3QqKloPQsQ==
Date: Thu, 11 Jan 2024 08:53:38 -0600
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
Subject: Re: [PATCH v5 RESEND 0/5] Regather scattered PCI-Code
Message-ID: <20240111145338.GA2173492@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111085540.7740-1-pstanner@redhat.com>

On Thu, Jan 11, 2024 at 09:55:35AM +0100, Philipp Stanner wrote:
> Second Resend. Would be cool if someone could tell me what I'll have to
> do so we can get this merged. This is blocking the followup work I've
> got in the pipe

This seems PCI-focused, and I'll look at merging this after v6.8-rc1
is tagged and the merge window closes (probably Jan 21).  Then I'll
rebase it to v6.8-rc1, tidy the subject lines to look like the rest
of drivers/pci/, etc.

> Philipp Stanner (5):
>   lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
>   lib: move pci_iomap.c to drivers/pci/
>   lib: move pci-specific devres code to drivers/pci/
>   pci: move devres code from pci.c to devres.c
>   lib, pci: unify generic pci_iounmap()
> 
>  MAINTAINERS                            |   1 -
>  drivers/pci/Kconfig                    |   5 +
>  drivers/pci/Makefile                   |   3 +-
>  drivers/pci/devres.c                   | 450 +++++++++++++++++++++++++
>  lib/pci_iomap.c => drivers/pci/iomap.c |  49 +--
>  drivers/pci/pci.c                      | 249 --------------
>  drivers/pci/pci.h                      |  24 ++
>  include/asm-generic/io.h               |  27 +-
>  include/asm-generic/iomap.h            |  21 ++
>  lib/Kconfig                            |   3 -
>  lib/Makefile                           |   1 -
>  lib/devres.c                           | 208 +-----------
>  lib/iomap.c                            |  28 +-
>  13 files changed, 566 insertions(+), 503 deletions(-)
>  create mode 100644 drivers/pci/devres.c
>  rename lib/pci_iomap.c => drivers/pci/iomap.c (75%)

