Return-Path: <linux-arch+bounces-1442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE44838BDF
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 11:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EF7284039
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 10:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE35BAF1;
	Tue, 23 Jan 2024 10:29:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E75A784;
	Tue, 23 Jan 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005774; cv=none; b=DZm3euRVCNutT4SsZDJckjW7rhEd9Px/cqMUWydtEr6ieO+uj29rKgN/iNr0Az3oA9uDf5eCrpnZiOOguazKl2v/3BneMl0xdbQQjXGPrUUjzgfUXwGDoqPSdI7si0DmP17SmlTGapcj9Xl5N+JwJK7XpNbFy8jUxLMS1yZTUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005774; c=relaxed/simple;
	bh=1z304UMB9iwNDgxznbQ/na098G6JM2egcJawzjYAgFU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERhRc5Hb++LNIU/64VugtridSW1xiRX3h9nyNNc6zgvhBTxQcFtjDFfWUUyLKrhgvmffmBvrDCbEqqXaTBZ0IoCcvHLf/udcme9zLhCKyWR1LC+rJBeHHOkr5XFPIFAMiHB6y176sZmfIGUBCxeGqxhvyjTFHKndB9SoTAbSjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TK3Ct523Lz6K91D;
	Tue, 23 Jan 2024 18:26:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B7F05140A90;
	Tue, 23 Jan 2024 18:29:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Jan
 2024 10:29:29 +0000
Date: Tue, 23 Jan 2024 10:29:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 18/21] ACPI: processor: Only call
 arch_unregister_cpu() if HOTPLUG_CPU is selected
Message-ID: <20240123102928.0000270c@Huawei.com>
In-Reply-To: <ZYBB32fMWB6of7Jb@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOhH-00DvlO-UP@rmk-PC.armlinux.org.uk>
	<20231215165009.000035f2@Huawei.com>
	<ZYBB32fMWB6of7Jb@shell.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Dec 2023 12:58:07 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Dec 15, 2023 at 04:50:09PM +0000, Jonathan Cameron wrote:
> > On Wed, 13 Dec 2023 12:50:43 +0000
> > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> >   
> > > From: James Morse <james.morse@arm.com>
> > > 
> > > The kbuild robot points out that configurations without HOTPLUG_CPU
> > > selected can try to build acpi_processor_post_eject() without success
> > > as arch_unregister_cpu() is not defined.
> > > 
> > > Check this explicitly. This will be merged into:
> > > | ACPI: Add post_eject to struct acpi_scan_handler for cpu hotplug
> > > for any subsequent posting.
> > > 
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > ---
> > > This should probably be squashed into an earlier patch.  
> > 
> > Agreed. If not
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> I'm not convinced that "ACPI: Add post_eject to struct acpi_scan_handler
> for cpu hotplug" is the correct commit to squash this into.
> 
> As far as acpi_processor.c is concerned, This commit merely renames
> acpi_processor_remove() to be acpi_processor_post_eject(). The function
> references arch_unregister_cpu() before and after this change, and its
> build is dependent on CONFIG_ACPI_HOTPLUG_PRESENT_CPU being defined.
> 
> Commit "ACPI: convert acpi_processor_post_eject() to use IS_ENABLED()"
> removed the ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU surrounding
> acpi_processor_post_eject, and that symbol depends on
> CONFIG_HOTPLUG_CPU, so I think this commit is also fine.
> 
> Commit "ACPI: Check _STA present bit before making CPUs not present"
> rewrites the function - the original body gets called
> acpi_processor_make_not_present() and a new acpi_processor_post_eject()
> is created. At this point, it doesn't reference arch_unregister_cpu().
> 
> Commit "ACPI: add support to register CPUs based on the _STA enabled
> bit" adds a reference to arch_unregister_cpu() in this new
> acpi_processor_post_eject() - so I think this is the correct commit
> this change should be merged into.

That or where that change ends up given your earlier suggestion to
move that change as well.  I find it hard to care as long as
the bisection issue is squashed by the change.  If we make the code
drop out before the build issue is introduced that's fine because
we are arguing we shouldn't be running it anyway so such protection
is fine if not necessary for build fix purposes.

J

> 


