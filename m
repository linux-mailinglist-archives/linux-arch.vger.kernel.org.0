Return-Path: <linux-arch+bounces-2099-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9E084B9AF
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 16:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F151F26429
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF4A13340B;
	Tue,  6 Feb 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vK3OPCHn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1051332BC;
	Tue,  6 Feb 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233646; cv=none; b=h59aDP6FGeNBQlECC00WMvpmGXD5XwYrCv/W0jDNLdEsug5u8zSkkC2xRwBs1GYZ8E/6N9tz/6SIJLxUHbqxhy+Oz+scSzYsMQ6brUd9ClIrxJ7xWBbkaUMZaxofz/0itryqjnLRhkPbLyx+FrRTkwx6sF52Py3ogDOTGFs0Y9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233646; c=relaxed/simple;
	bh=mV3IQfXUED3m7nZ6eR8IfdFIfnHb01zoGzJ3cf6A6kE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zit4VxG/+Mhg3T3G9hKSiJ83MLa18e0T1wBqWDdY6zvO1hJEz8Nv6WDuoXgGuN+hl3oaAqk1NqmJdz3XbmD8KTYoh9bPjpG/WaZkq+hJ5njjOoPusUGIkvyn7WBX6EuOga6y08+Qky+vBg9QoTjIKc7fvf6oxMWozWz/nwFHR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vK3OPCHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560FBC433F1;
	Tue,  6 Feb 2024 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707233645;
	bh=mV3IQfXUED3m7nZ6eR8IfdFIfnHb01zoGzJ3cf6A6kE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vK3OPCHnCFve5b9RytgRk5bjikuZ9r9QhUTB2Ftm0GDGmzSiZ6SEPPInJm/9NfmWp
	 0czS12fX0j2hu06KOn2l2iGPjKRLaymIPPIKc2FPWDSecmNgJ+BM02mIwGYY8t7vVY
	 wDehQUNcnTL6qVbanBPhB645p4RUvI88ej6vhHeBKblYIoq98eV1R25rQoxLLFUqTl
	 z6brer/ZuUBy++ObqYWGqTLD2ejXfxlunm2qWy3+c3kV+jK2cxKaElTvCpes5adgrY
	 THpUvb4ihC1T+zjXIZrfnIBNhvPa62Pa1reyB2m35vF6GRx4EcqiUcMynQnIfaa+hF
	 GEwVyEyYysMag==
Date: Tue, 6 Feb 2024 09:34:03 -0600
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
Message-ID: <20240206153403.GA866283@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f1be7418b6f52854abdd25ad7b1c526a9a7e35d.camel@redhat.com>

On Tue, Feb 06, 2024 at 10:41:13AM +0100, Philipp Stanner wrote:
> On Wed, 2024-01-31 at 15:08 -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 31, 2024 at 10:00:19AM +0100, Philipp Stanner wrote:
> > > @Bjorn:
> > > I decided that it's now actually possible to just embed the docu
> > > updates
> > > to the respective patches, instead of a separate patch.
> > > Also dropped the ioport_unmap() for now.
> > 
> > Thanks.  I didn't see any documentation updates (other than those
> > related to the changed path names) in this series, so I assume the
> > updates you mention would be in a future series.
> 
> No, I actually meant the changed path names.
> 
> The next series (new devres functions) just adds more docstrings to
> iomap.c, devres.c and pci.c in drivers/pci/, which, after this series
> here is applied, are all already added to the Docu.

OK.  Other doc issues, I'm sure you've seen already:
https://lore.kernel.org/r/20240205160908.6df5e790@canb.auug.org.au

I'll squash the fixes into this series when they're ready.

Bjorn

