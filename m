Return-Path: <linux-arch+bounces-3917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD158AE597
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69379282E6C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19BC84DE9;
	Tue, 23 Apr 2024 12:06:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662584A44;
	Tue, 23 Apr 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874015; cv=none; b=CuZhfU69cYqGSbbQKvlvl+T+skzU2HtS+ZvxwmlHMbkd7fmiYosmFR5CSl9A0wZ7i9QXGo36BzuK8rE3FPEDNwXYzZR6G3Pa+7Wqo0rBN+qTPDuuOgjmuAfu2HgEsROJF9KNceyDy8wmJIZL6rPm8gcVNmMXjHl4db9nuOAwv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874015; c=relaxed/simple;
	bh=WlZYqWhdAH7netYQkFAGYZjAaa89jWNhRzERNv5h2Kk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ixEfHzr9ZYPGoDSDPHbyt4XHoU43FiAUjZk2C2OWEIzTO7HpFzvRRWvVqPXXOiYQntBMTUzWo1r1IkiHFRxzUU4mZN4XjRexwwmfQ5VAPtHQFqrVg8rpWMKLK6wS2OGI6qycxfLo/q2NdlDlC8JstJgBHdwe2m4eM+gDtt2RM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VP1460Qk8z1R9LL;
	Tue, 23 Apr 2024 20:03:50 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D77118007D;
	Tue, 23 Apr 2024 20:06:50 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 20:06:49 +0800
Subject: Re: [PATCH v7 08/16] ACPI: Add post_eject to struct acpi_scan_handler
 for cpu hotplug
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	<linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel
 Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-9-Jonathan.Cameron@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <df2388a1-45d8-c42e-fca0-0e21f1810a9d@huawei.com>
Date: Tue, 23 Apr 2024 20:06:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240418135412.14730-9-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/4/18 21:54, Jonathan Cameron wrote:
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
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

