Return-Path: <linux-arch+bounces-3992-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614988B36B8
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 13:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928511C21F55
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 11:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDD145354;
	Fri, 26 Apr 2024 11:49:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7283A1B7;
	Fri, 26 Apr 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132142; cv=none; b=MYH9GDeI2quZz8MQWm8AMg19p+qWDVs7UTU+sz18jv4DEH3g2LPAn781xy5onEpWwVgqEPquw2vVl9OixWrQBTU4Z7hmIZqbcnnSX/3SLx8gyGe9dyQ6n75MLSbl41ft6bIBp3s0ACI+aude7BoapszGoudBX/gxwzUyVYGRwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132142; c=relaxed/simple;
	bh=vuIcmnGQq4w4qRhii36oQpxwxZeKTg+NU3UP9tdpmnQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0CLBWABBF+LonSITg0im/YxbcW6xqv//aok8O8i4miyzA7P//LhcuvK3LySuLwgZLRkzCjWHLJGRk3C9xA8LQlStUT7QUuGhSWiv6L66RkwbeCKyjXOpRTgjzmLjlg5/fAlnd/J3tkF+/Fcn/XNeJUpaRIt+0FB+wgPf83L7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQrbL5Lklz6DBjc;
	Fri, 26 Apr 2024 19:48:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 46E26140447;
	Fri, 26 Apr 2024 19:48:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 12:48:57 +0100
Date: Fri, 26 Apr 2024 12:48:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, "James Morse"
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linuxarm@huawei.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, <justin.he@arm.com>,
	<jianyong.wu@arm.com>
Subject: Re: [PATCH v7 08/16] ACPI: Add post_eject to struct
 acpi_scan_handler for cpu hotplug
Message-ID: <20240426124836.00006cde@huawei.com>
In-Reply-To: <20240418135412.14730-9-Jonathan.Cameron@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-9-Jonathan.Cameron@huawei.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Apr 2024 14:54:04 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: James Morse <james.morse@arm.com>
> 
> struct acpi_scan_handler has a detach callback that is used to remove
> a driver when a bus is changed. When interacting with an eject-request,
> the detach callback is called before _EJ0.
> 
> This means the ACPI processor driver can't use _STA to determine if a
> CPU has been made not-present, or some of the other _STA bits have been
> changed. acpi_processor_remove() needs to know the value of _STA after
> _EJ0 has been called.
> 
> Add a post_eject callback to struct acpi_scan_handler. This is called
> after acpi_scan_hot_remove() has successfully called _EJ0. Because
> acpi_scan_check_and_detach() also clears the handler pointer,
> it needs to be told if the caller will go on to call
> acpi_bus_post_eject(), so that acpi_device_clear_enumerated()
> and clearing the handler pointer can be deferred.
> An extra flag is added to flags field introduced in the previous
> patch to achieve this.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>

Gavin's earlier review showed I can't type.
Fixed up by dropping this RB seeing as I signed off anyway.

> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

