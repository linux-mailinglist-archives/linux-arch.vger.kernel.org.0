Return-Path: <linux-arch+bounces-1236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69943821E94
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 16:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A151C22462
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C481401B;
	Tue,  2 Jan 2024 15:20:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577771400D;
	Tue,  2 Jan 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T4GhS49QKz6K622;
	Tue,  2 Jan 2024 23:18:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 434FD1400DB;
	Tue,  2 Jan 2024 23:19:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Jan
 2024 15:19:55 +0000
Date: Tue, 2 Jan 2024 15:19:53 +0000
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
Subject: Re: [PATCH RFC v3 21/21] cpumask: Add enabled cpumask for present
 CPUs that can be brought online
Message-ID: <20240102151953.00001949@Huawei.com>
In-Reply-To: <ZYA3lmPOwIOJq/iY@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOhX-00Dvlg-Ci@rmk-PC.armlinux.org.uk>
	<20231215171831.00004a19@Huawei.com>
	<ZYA3lmPOwIOJq/iY@shell.armlinux.org.uk>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Dec 2023 12:14:14 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Dec 15, 2023 at 05:18:31PM +0000, Jonathan Cameron wrote:
> > On Wed, 13 Dec 2023 12:50:59 +0000
> > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> >   
> > > From: James Morse <james.morse@arm.com>
> > > 
> > > The 'offline' file in sysfs shows all offline CPUs, including those
> > > that aren't present. User-space is expected to remove not-present CPUs
> > > from this list to learn which CPUs could be brought online.
> > > 
> > > CPUs can be present but not-enabled. These CPUs can't be brought online
> > > until the firmware policy changes, which comes with an ACPI notification
> > > that will register the CPUs.
> > > 
> > > With only the offline and present files, user-space is unable to
> > > determine which CPUs it can try to bring online. Add a new CPU mask
> > > that shows this based on all the registered CPUs.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > ---  
> > 
> > Needs docs
> > Documentation/ABI/testing/sysfs-devices-system-cpu
> > seems to have the rest of the similar entries.  
> 
> Any ideas what I put in there as "Date" ? It seems to me that we have
> little idea when this might be merged.. I could use the date of the
> commit (Nov 2022).
> 

That's always a guess at best.  Hopefully whoever picks this up
fixes the date up or asks for a new version with it fixed just before
they do.

J

