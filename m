Return-Path: <linux-arch+bounces-1953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804C784497E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 22:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D7F1F285C4
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711D3985A;
	Wed, 31 Jan 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSWiyHKf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE938FB5;
	Wed, 31 Jan 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735557; cv=none; b=abmdRp5UurwZcSSwpzH+XHWPUdlOtRLBt0jP8kGay2bG0UvShf/56scw5YpASKYOFDaYPsnFJy3CqwBtuRnlOuA+FnDq7am3g9TI/TxhUMtBxlla2zBFnaoTSLkbaODP64uOaggCwT0Yu16b1B9Lz7P2ycWiGIg5kfilGZIX2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735557; c=relaxed/simple;
	bh=X217PdmKFGwdrek8hHs1DaJ0sMZ6rWFofXxDn03FD+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ukAGUkoohKnO8HX4+zKkNkV/fZ8oD+sqlNXSbMCej09NJVV1TXHZnTddXQhWO1wbg3gQffNRcuYeFx9wjVCOuMiUKqVqV2v6ySR21is2/WbUppwltXgqk5KO5quAG/D4Z+vU8RMcBiiY2EkSwluR79cv5z4YX6TjDJVXH/WZXYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSWiyHKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C17DC433F1;
	Wed, 31 Jan 2024 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706735556;
	bh=X217PdmKFGwdrek8hHs1DaJ0sMZ6rWFofXxDn03FD+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZSWiyHKfmlF2D6+oG/lCgRaXIobsQk5belEkZlsctJfcKJ7o8t/mQynU+mWOd31m6
	 GEMel+d/iIR15UpuEEbR6bEjV627RsgkP4L5+V0tS1R+KJyn/D4004vO/ZUIcDYP9A
	 DCVyKiNAcA9NAQ++Ku0e9CHmi9BuOZJjo7y7F85k28nyEtkgyuz8YDlU5TeKeo0bvX
	 Oci5wsWFDjyBDZt51QMyvKdtJcH49AS+XpuUNGM8CFfMjM5MdObgUcKt2YhCREtjAX
	 6+pwjgUeR4ycnQqQtVj45/VbgZAgxiW1fvaMeml3MR4Jp0Dy8YCE27cf5XTVui5f70
	 TADnALHem65oA==
Date: Wed, 31 Jan 2024 15:12:35 -0600
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
Subject: Re: [PATCH v6 4/4] PCI: Move devres code from pci.c to devres.c
Message-ID: <20240131211235.GA599807@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131090023.12331-5-pstanner@redhat.com>

On Wed, Jan 31, 2024 at 10:00:23AM +0100, Philipp Stanner wrote:
> The file pci.c is very large and contains a number of devres-functions.
> These functions should now reside in devres.c
> ...

> +struct pci_devres *find_pci_dr(struct pci_dev *pdev)
> +{
> +	if (pci_is_managed(pdev))
> +		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
> +	return NULL;
> +}
> +EXPORT_SYMBOL(find_pci_dr);

find_pci_dr() was not previously exported, and I don't think it needs
to be exported now, so I dropped the EXPORT_SYMBOL.  It's still usable
inside drivers/pci since it's declared in drivers/pci/pci.h; it's just
not usable from modules.  Let me know if I missed something.

> -static struct pci_devres *find_pci_dr(struct pci_dev *pdev)
> -{
> -	if (pci_is_managed(pdev))
> -		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
> -	return NULL;
> -}

