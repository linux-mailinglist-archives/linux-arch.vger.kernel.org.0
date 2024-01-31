Return-Path: <linux-arch+bounces-1951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED70844973
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 22:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB6028957F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C0638FA4;
	Wed, 31 Jan 2024 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAmnWm2K"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AD208C1;
	Wed, 31 Jan 2024 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735324; cv=none; b=K0laPuR+1fEVR48DacFtYSuUj69R36r85FSVMdX6YaUv9DIocNGeDgQN6wOv+9kVnBuqyhucRKVTCAmFaKEZw/ViPYRkew35tOKm7XSPXGPUeAGO+FsqY8S4NVScX8pF2aOcX0rKk1z8NfwtMp6n8f3PdBfhcBXgplN23GTk1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735324; c=relaxed/simple;
	bh=mPdxKMA4TO8+Xlg5A+CwfU4Swk6EiBQt8M+MwAE+A9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mz6xenj5MtIgRZhNMwxaI2ugppveAfK4At/jQ5Y6PlRus4jypgBSY81iN3ScIm9emzD10s8jP3vPqZLYGFUrWUNt2xJ2FIhKrt2CbXEdYpyVoyD7GBSpGQvH2KOJqRCWDXTDgQ9Oxm69HefmJxZtEmzYBWP3Kf0MXvEzzDcuhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAmnWm2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C105C433C7;
	Wed, 31 Jan 2024 21:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706735324;
	bh=mPdxKMA4TO8+Xlg5A+CwfU4Swk6EiBQt8M+MwAE+A9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IAmnWm2Khijpnkr6+s7eGe7eKAY9kr9n65yeY4+GU1D2/Waw3scOm98jGXxSqIVcB
	 mJhI8uigahJTRcPJ55ywp+eCcK+NNsqA1FX+DvCoW1ASny01qN6+s+ojH2qt2jBJXk
	 WUqomUxeDgp92F7cIZDY4q5Aa37xRgLxWY/4AAlWgRFMIscK7eKP7EPWRs6P58rOvD
	 RU9cXdhVOSKqtLUNy/so4ROd77BJTh7+f/8ewTx2suyTei6oZ8xH2z4KkeQiX4J48J
	 h/0Dxtr067sUwkqspHjIq0wR4EUT4Q/FuDO+bdccXugBMFpoPla+qb62iJBVJaVB4P
	 JpSs40a0FSALw==
Date: Wed, 31 Jan 2024 15:08:42 -0600
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
Subject: Re: [PATCH v6 0/4] Regather scattered PCI-Code
Message-ID: <20240131210842.GA599075@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131090023.12331-1-pstanner@redhat.com>

On Wed, Jan 31, 2024 at 10:00:19AM +0100, Philipp Stanner wrote:
> @Bjorn:
> I decided that it's now actually possible to just embed the docu updates
> to the respective patches, instead of a separate patch.
> Also dropped the ioport_unmap() for now.

Thanks.  I didn't see any documentation updates (other than those
related to the changed path names) in this series, so I assume the
updates you mention would be in a future series.

> ...
> Philipp Stanner (4):
>   lib/pci_iomap.c: fix cleanup bug in pci_iounmap()
>   lib: move pci_iomap.c to drivers/pci/
>   lib: move pci-specific devres code to drivers/pci/
>   PCI: Move devres code from pci.c to devres.c
> 
>  Documentation/driver-api/device-io.rst |   2 +-
>  Documentation/driver-api/pci/pci.rst   |   6 +
>  MAINTAINERS                            |   1 -
>  drivers/pci/Kconfig                    |   5 +
>  drivers/pci/Makefile                   |   3 +-
>  drivers/pci/devres.c                   | 450 +++++++++++++++++++++++++
>  lib/pci_iomap.c => drivers/pci/iomap.c |   5 +-
>  drivers/pci/pci.c                      | 249 --------------
>  drivers/pci/pci.h                      |  24 ++
>  lib/Kconfig                            |   3 -
>  lib/Makefile                           |   1 -
>  lib/devres.c                           | 208 +-----------
>  12 files changed, 490 insertions(+), 467 deletions(-)
>  create mode 100644 drivers/pci/devres.c
>  rename lib/pci_iomap.c => drivers/pci/iomap.c (99%)

Applied to pci/devres for v6.9, thanks!

