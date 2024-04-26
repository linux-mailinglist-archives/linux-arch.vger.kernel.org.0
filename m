Return-Path: <linux-arch+bounces-4019-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056A38B3E8C
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 19:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02202838DB
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5148015FA7C;
	Fri, 26 Apr 2024 17:49:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542214EC4C;
	Fri, 26 Apr 2024 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153798; cv=none; b=awyRfxCOWdxsMXHv/T/mHje/T5/5snki4q0e9Sb9Tk01h8n+B4Vb6FKzZhWUoCvQmjKaXfKH9uR2imUP+LGp2xBxYeHYj6Mje2ifpkH3Wr27VgYoZrDM5BiZlRuZhXf+IZ0W4ZOJ8LjIVL5qS9MgUDJVppe8oq8LUUZateoBw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153798; c=relaxed/simple;
	bh=erZZi9wDZX0ZOYNS/RLIvpcm6ff+QRDxGu84IpUs1F4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpLKZGcSd5BEVQ+clX5o+JPwEgpxef6iJTlVkBWvcbXK5soj12sGzfJbXnDVEBxjsmqVb2lAKqOqamNnINt2zGI3pUzTqBGj3xCy4Ab3qZ6WIP8YTG09LR8anUC3FGJpIJQbS+aesoDmWPEXv1QZWUuqwAsmue/w+DY8ezRwTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VR0Y95yrxz6JBFj;
	Sat, 27 Apr 2024 01:47:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E2B51408F9;
	Sat, 27 Apr 2024 01:49:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 18:49:50 +0100
Date: Fri, 26 Apr 2024 18:49:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miguel Luis <miguel.luis@oracle.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, "James
 Morse" <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com"
	<jianyong.wu@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Sudeep
 Holla" <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 01/16] ACPI: processor: Simplify initial onlining to
 use same path for cold and hotplug
Message-ID: <20240426184949.0000506d@Huawei.com>
In-Reply-To: <2E688E98-F57F-444F-B326-5206FB6F5C1E@oracle.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
	<20240426135126.12802-2-Jonathan.Cameron@huawei.com>
	<6347020E-CB49-44ED-87B2-3BB2AA2F59E0@oracle.com>
	<2E688E98-F57F-444F-B326-5206FB6F5C1E@oracle.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Apr 2024 17:21:41 +0000
Miguel Luis <miguel.luis@oracle.com> wrote:

> Hi Jonathan, 
> 
> > On 26 Apr 2024, at 16:05, Miguel Luis <miguel.luis@oracle.com> wrote:
> > 
> > 
> >   
> >> On 26 Apr 2024, at 13:51, Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >> 
> >> Separate code paths, combined with a flag set in acpi_processor.c to
> >> indicate a struct acpi_processor was for a hotplugged CPU ensured that
> >> per CPU data was only set up the first time that a CPU was initialized.
> >> This appears to be unnecessary as the paths can be combined by letting
> >> the online logic also handle any CPUs online at the time of driver load.
> >> 
> >> Motivation for this change, beyond simplification, is that ARM64
> >> virtual CPU HP uses the same code paths for hotplug and cold path in
> >> acpi_processor.c so had no easy way to set the flag for hotplug only.
> >> Removing this necessity will enable ARM64 vCPU HP to reuse the existing
> >> code paths.
> >> 
> >> Leave noisy pr_info() in place but update it to not state the CPU
> >> was hotplugged.  
> 
> On a second thought, do we want to keep it? Can't we just assume that no 
> news is good news while keeping the warn right after __acpi_processor_start ?

Good question - my inclination was to keep this in place for now as removing
it would remove a source of information people may expect on x86 hotplug.

Then maybe propose dropping it as overly noisy kernel as a follow up
patch after this series is merged.  Felt like a potential rat hole I didn't
want to go down if I could avoid it.

If any x86 experts want to shout that no one cares then I'll happily drop
the print.  We've carefully made it so that on arm64 we have no way to tell
if this is hotplug or normal cpu bring up so we can't just print it on
hotplug.

Jonathan


> 
> Miguel
> 
> >> 
> >> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> >> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> >> Reviewed-by: Gavin Shan <gshan@redhat.com>
> >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> 
> >> ---
> >> v8: No change
> >> ---
> >> drivers/acpi/acpi_processor.c   |  1 -
> >> drivers/acpi/processor_driver.c | 44 ++++++++++-----------------------
> >> include/acpi/processor.h        |  2 +-
> >> 3 files changed, 14 insertions(+), 33 deletions(-)
> >> 
> >> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> >> index 7a0dd35d62c9..7fc924aeeed0 100644
> >> --- a/drivers/acpi/acpi_processor.c
> >> +++ b/drivers/acpi/acpi_processor.c
> >> @@ -216,7 +216,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> >> * gets online for the first time.
> >> */
> >> pr_info("CPU%d has been hot-added\n", pr->id);
> >> - pr->flags.need_hotplug_init = 1;
> >> 
> >> out:
> >> cpus_write_unlock();
> >> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> >> index 67db60eda370..55782eac3ff1 100644
> >> --- a/drivers/acpi/processor_driver.c
> >> +++ b/drivers/acpi/processor_driver.c
> >> @@ -33,7 +33,6 @@ MODULE_AUTHOR("Paul Diefenbaugh");
> >> MODULE_DESCRIPTION("ACPI Processor Driver");
> >> MODULE_LICENSE("GPL");
> >> 
> >> -static int acpi_processor_start(struct device *dev);
> >> static int acpi_processor_stop(struct device *dev);
> >> 
> >> static const struct acpi_device_id processor_device_ids[] = {
> >> @@ -47,7 +46,6 @@ static struct device_driver acpi_processor_driver = {
> >> .name = "processor",
> >> .bus = &cpu_subsys,
> >> .acpi_match_table = processor_device_ids,
> >> - .probe = acpi_processor_start,
> >> .remove = acpi_processor_stop,
> >> };
> >> 
> >> @@ -115,12 +113,10 @@ static int acpi_soft_cpu_online(unsigned int cpu)
> >> * CPU got physically hotplugged and onlined for the first time:
> >> * Initialize missing things.
> >> */
> >> - if (pr->flags.need_hotplug_init) {
> >> + if (!pr->flags.previously_online) {
> >> int ret;
> >> 
> >> - pr_info("Will online and init hotplugged CPU: %d\n",
> >> - pr->id);
> >> - pr->flags.need_hotplug_init = 0;
> >> + pr_info("Will online and init CPU: %d\n", pr->id);
> >> ret = __acpi_processor_start(device);
> >> WARN(ret, "Failed to start CPU: %d\n", pr->id);
> >> } else {
> >> @@ -167,9 +163,6 @@ static int __acpi_processor_start(struct acpi_device *device)
> >> if (!pr)
> >> return -ENODEV;
> >> 
> >> - if (pr->flags.need_hotplug_init)
> >> - return 0;
> >> -
> >> result = acpi_cppc_processor_probe(pr);
> >> if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
> >> dev_dbg(&device->dev, "CPPC data invalid or not present\n");
> >> @@ -185,32 +178,21 @@ static int __acpi_processor_start(struct acpi_device *device)
> >> 
> >> status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> >>    acpi_processor_notify, device);
> >> - if (ACPI_SUCCESS(status))
> >> - return 0;
> >> + if (!ACPI_SUCCESS(status)) {
> >> + result = -ENODEV;
> >> + goto err_thermal_exit;
> >> + }
> >> + pr->flags.previously_online = 1;
> >> 
> >> - result = -ENODEV;
> >> - acpi_processor_thermal_exit(pr, device);
> >> + return 0;
> >> 
> >> +err_thermal_exit:
> >> + acpi_processor_thermal_exit(pr, device);
> >> err_power_exit:
> >> acpi_processor_power_exit(pr);
> >> return result;
> >> }
> >> 
> >> -static int acpi_processor_start(struct device *dev)
> >> -{
> >> - struct acpi_device *device = ACPI_COMPANION(dev);
> >> - int ret;
> >> -
> >> - if (!device)
> >> - return -ENODEV;
> >> -
> >> - /* Protect against concurrent CPU hotplug operations */
> >> - cpu_hotplug_disable();
> >> - ret = __acpi_processor_start(device);
> >> - cpu_hotplug_enable();
> >> - return ret;
> >> -}
> >> -
> >> static int acpi_processor_stop(struct device *dev)
> >> {
> >> struct acpi_device *device = ACPI_COMPANION(dev);
> >> @@ -279,9 +261,9 @@ static int __init acpi_processor_driver_init(void)
> >> if (result < 0)
> >> return result;
> >> 
> >> - result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> >> -   "acpi/cpu-drv:online",
> >> -   acpi_soft_cpu_online, NULL);
> >> + result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> >> +   "acpi/cpu-drv:online",
> >> +   acpi_soft_cpu_online, NULL);
> >> if (result < 0)
> >> goto err;
> >> hp_online = result;
> >> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> >> index 3f34ebb27525..e6f6074eadbf 100644
> >> --- a/include/acpi/processor.h
> >> +++ b/include/acpi/processor.h
> >> @@ -217,7 +217,7 @@ struct acpi_processor_flags {
> >> u8 has_lpi:1;
> >> u8 power_setup_done:1;
> >> u8 bm_rld_set:1;
> >> - u8 need_hotplug_init:1;
> >> + u8 previously_online:1;  
> > 
> > Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
> > 
> > Miguel
> >   
> >> };
> >> 
> >> struct acpi_processor {
> >> -- 
> >> 2.39.2
> >>   
> >   
> 


