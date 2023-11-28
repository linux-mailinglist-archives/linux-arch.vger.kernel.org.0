Return-Path: <linux-arch+bounces-504-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5BD7FBDD3
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 16:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348EFB21B8F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CFE5CD28;
	Tue, 28 Nov 2023 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42DD41;
	Tue, 28 Nov 2023 07:12:03 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SfmBn0tR3z6D8Wd;
	Tue, 28 Nov 2023 23:11:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E0A5140A9C;
	Tue, 28 Nov 2023 23:12:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 15:12:01 +0000
Date: Tue, 28 Nov 2023 15:12:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse
	<james.morse@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>
Subject: Re: [PATCH RFC 13/22] arm64: setup: Switch over to
 GENERIC_CPU_DEVICES using arch_register_cpu()
Message-ID: <20231128151200.0000737c@Huawei.com>
In-Reply-To: <20231128150854.00005370@Huawei.com>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
	<E1r0JLl-00CTxk-7O@rmk-PC.armlinux.org.uk>
	<20231128150854.00005370@Huawei.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 28 Nov 2023 15:08:54 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 07 Nov 2023 10:30:25 +0000
> Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> > From: James Morse <james.morse@arm.com>
> > 
> > To allow ACPI's _STA value to hide CPUs that are present, but not
> > available to online right now due to VMM or firmware policy, the
> > register_cpu() call needs to be made by the ACPI machinery when ACPI
> > is in use. This allows it to hide CPUs that are unavailable from sysfs.
> > 
> > Switching to GENERIC_CPU_DEVICES is an intermediate step to allow all
> > five ACPI architectures to be modified at once.
> > 
> > Switch over to GENERIC_CPU_DEVICES, and provide an arch_register_cpu()
> > that populates the hotpluggable flag. arch_register_cpu() is also the
> > interface the ACPI machinery expects.
> > 
> > The struct cpu in struct cpuinfo_arm64 is never used directly, remove
> > it to use the one GENERIC_CPU_DEVICES provides.
> > 
> > This changes the CPUs visible in sysfs from possible to present, but
> > on arm64 smp_prepare_cpus() ensures these are the same.
> > 
> > This patch also has the effect of moving the registration of CPUs from
> > subsys to driver core initialisation, prior to any initcalls running.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>  
> 
> Given this series adds an arch_cpu_is_hotpluggable() callback we probably
> want something in this patch description to say why this
> isn't using that, but instead overriding arch_register_cpu()
> 
As per comment on next patch I'm fine with this slight dance.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


