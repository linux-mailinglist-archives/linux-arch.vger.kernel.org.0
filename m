Return-Path: <linux-arch+bounces-1125-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54481777B
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DDA1C2318F
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3549886;
	Mon, 18 Dec 2023 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgPaNxRa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9253D57F;
	Mon, 18 Dec 2023 16:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E77EC433C7;
	Mon, 18 Dec 2023 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916941;
	bh=cuIJ/8s2AYcAKCRZwOwQRNGRaRi9/bICEVQ2fASqZdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pgPaNxRa19QteSUajSmhwIBygIXOwyglTsgblC6uEftO+XTQg6+O3kXAj9XX2OmcC
	 rQOpqnvB5+xOO/ow7seOv1CdwV13FbembY2BokFhPnwSM4b0DvGeATzzmDK+AEOLHw
	 6DaCbWimil/lLwi/MxyvK5Y12TLnf9HBPcW++ZT9x3tzMvn7KL4GnLx7Lcu5QvqSQp
	 eltb1y4JDmA5690dgcONdt9hmYC6CU/Xhok/FJZ/y98obP8l0G4B7kd38/bxCcL5CD
	 m0hJV4fUjPoN82jbVmU9YShGfagm/C07b9jmlsrqKjpLRJaGDiIiVu6scxMm9bEVQ6
	 YQAI2eQ+xkSew==
Date: Mon, 18 Dec 2023 17:28:53 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 13/21] ACPICA: Add new MADT GICC flags fields
Message-ID: <ZYBzRWs7v1PsF6qV@lpieralisi>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOgs-00Dvko-6t@rmk-PC.armlinux.org.uk>
 <20231215162322.00007391@Huawei.com>
 <ZXyEiHLFBsoUkfNI@shell.armlinux.org.uk>
 <ZYAPhlwPUT/7dN4n@lpieralisi>
 <CAJZ5v0hyUqJspPbGTgTMSVHVBe=wHR6swPx-O3UcsH5dXDFpTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hyUqJspPbGTgTMSVHVBe=wHR6swPx-O3UcsH5dXDFpTA@mail.gmail.com>

On Mon, Dec 18, 2023 at 02:14:30PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 18, 2023 at 10:23 AM Lorenzo Pieralisi
> <lpieralisi@kernel.org> wrote:
> >
> > On Fri, Dec 15, 2023 at 04:53:28PM +0000, Russell King (Oracle) wrote:
> > > On Fri, Dec 15, 2023 at 04:23:22PM +0000, Jonathan Cameron wrote:
> > > > On Wed, 13 Dec 2023 12:50:18 +0000
> > > > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> > > >
> > > > > From: James Morse <james.morse@arm.com>
> > > > >
> > > > > Add the new flag field to the MADT's GICC structure.
> > > > >
> > > > > 'Online Capable' indicates a disabled CPU can be enabled later. See
> > > > > ACPI specification 6.5 Tabel 5.37: GICC CPU Interface Flags.
> > > > >
> > > > > Signed-off-by: James Morse <james.morse@arm.com>
> > > > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > >
> > > > I see there is an acpica pull request including this bit but with a different name
> > > > For reference.
> > > > https://github.com/acpica/acpica/pull/914/commits/453a5f67567786522021d5f6913f561f8b3cabf6
> > > >
> > > > +CC Lorenzo who submitted that.
> > >
> > > > > +#define ACPI_MADT_GICC_CPU_CAPABLE      (1<<3)   /* 03: CPU is online capable */
> > > >
> > > > ACPI_MADT_GICC_ONLINE_CAPABLE
> > >
> > > It's somewhat disappointing, but no big deal. It's easy enough to change
> > > "irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs"
> > > to use Lorenzo's name when that patch hits - and it becomes one less
> > > patch in this patch set when Lorenzo's change eventually hits mainline.
> > >
> > > Does anyone know how long it may take for Lorenzo's change to get into
> > > mainline? Would it be by the 6.8 merge window or the following one?
> >
> > I wish I knew. I submitted ACPICA changes for the online capable bit
> > since I had to add additional flags on top (ie DMA coherent) and it
> > would not make sense to submit the latter without the former.
> >
> > I'd be great if the ACPICA headers can make it into Linux for the upcoming
> > merge window, not sure what I can do to fasttrack the process though
> > (I shall ping the maintainers).
> 
> If your upstream pull request has been merged, I can pick up Linux
> patches carrying Link: tags pointing to the upstream ACPICA commits in
> that pull request.

Thank you, I don't think it has been merged yet (and it requires
review because I am not that familiar with the ACPICA code base).

Hopefully it should be an extended kernel cycle so it might be
possible to get these headers in v6.8, if you deem that reasonable
of course once the PR is merged.

Thanks,
Lorenzo

