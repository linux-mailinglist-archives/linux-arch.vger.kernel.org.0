Return-Path: <linux-arch+bounces-215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B78D7EAD87
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 11:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3015E281047
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC07E182C0;
	Tue, 14 Nov 2023 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w4XFJJSu"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C541803D;
	Tue, 14 Nov 2023 10:04:34 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB690199;
	Tue, 14 Nov 2023 02:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MliSkT+C97r/xoKb00has1+pOVRxGmmTM9aHZqmFb/M=; b=w4XFJJSuIadpNAeBv0oFJvheSh
	XwUK9PQmPMEhgdmwSDbAapoeDa9K9HWgMz38zdIGLe/sPLp7TUYkOcvYDg3LX9m6snr5MAMtXZp1G
	vIR6D8/EEfGWaAmd1K5HqJ20zzwHZj47NTHQMs5MZLrvpche7UN5fFTZUSmZeSZsKEMQLad0LQu28
	zunJCFl41N8ZLAphzoOqhGQGVtYmuTDPoGwmCXhpcmyCL6DPgOGWWOwereFReVboNc6aRwnyTdllh
	LRSDUTGxHde7yh8aZ/Yc3qmiS/Sv9HtEFiSqz9Vn7XPbLYjDyO5VYNCX+0/pgAR76YDhy0QX4GYMr
	Kd1NjHnw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44278)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r2qHP-0007em-2q;
	Tue, 14 Nov 2023 10:04:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r2qHO-0005UR-In; Tue, 14 Nov 2023 10:04:22 +0000
Date: Tue, 14 Nov 2023 10:04:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH v2 11/35] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
Message-ID: <ZVNGJuUEkwei+CwY@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-12-james.morse@arm.com>
 <20230914130126.000069db@Huawei.com>
 <ZTKEQz0DJuv/tqNH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTKEQz0DJuv/tqNH@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Okay, after 25 days, I'm now changing James' comment to:

    If the offline CPUs thing is a problem for the tools that consume
    this value, we'd need to move cpu_capacity to be part of cpu.c's
    common_cpu_attr_groups. However, attempts to discuss this just end
    up in a black hole, so this is a non-starter. Thus, if this needs
    to be done, it can be done as a separate patch.

and thus I'm going to consider this patch acceptable to everyone.

On Fri, Oct 20, 2023 at 02:44:35PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 14, 2023 at 01:01:26PM +0100, Jonathan Cameron wrote:
> > On Wed, 13 Sep 2023 16:37:59 +0000
> > James Morse <james.morse@arm.com> wrote:
> > 
> > > register_cpu_capacity_sysctl() adds a property to sysfs that describes
> > > the CPUs capacity. This is done from a subsys_initcall() that assumes
> > > all possible CPUs are registered.
> > > 
> > > With CPU hotplug, possible CPUs aren't registered until they become
> > > present, (or for arm64 enabled). This leads to messages during boot:
> > > | register_cpu_capacity_sysctl: too early to get CPU1 device!
> > > and once these CPUs are added to the system, the file is missing.
> > > 
> > > Move this to a cpuhp callback, so that the file is created once
> > > CPUs are brought online. This covers CPUs that are added late by
> > > mechanisms like hotplug.
> > > One observable difference is the file is now missing for offline CPUs.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > ---
> > > If the offline CPUs thing is a problem for the tools that consume
> > > this value, we'd need to move cpu_capacity to be part of cpu.c's
> > > common_cpu_attr_groups.
> > 
> > I think we should do that anyway and then use an is_visible() if we want to
> > change whether it is visible in offline cpus.
> > 
> > Dynamic sysfs file creation is horrible - particularly when done
> > from an totally different file from where the rest of the attributes
> > are registered.  I'm curious what the history behind that is.
> > 
> > Whilst here, why is there a common_cpu_attr_groups which is
> > identical to the hotpluggable_cpu_attr_groups in base/cpu.c?
> 
> Looking into doing this, the easy bit is adding the attribute group
> with an appropriate .is_visible dependent on cpu_present(), but we
> need to be able to call sysfs_update_groups() when the state of the
> .is_visible() changes.
> 
> Given the comment in sysfs_update_groups() about "if an error occurs",
> rather than making this part of common_cpu_attr_groups, would it be
> better that it's part of its own set of groups, thus limiting the
> damage from a possible error? I suspect, however, that any error at
> that point means that the system is rather fatally wounded.
> 
> This is what I have so far to implement your idea, less the necessary
> sysfs_update_groups() call when we need to change the visibility of
> the attributes.
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 9ccb7daee78e..06c9fc6620d2 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -215,43 +215,24 @@ static ssize_t cpu_capacity_show(struct device *dev,
>  	return sysfs_emit(buf, "%lu\n", topology_get_cpu_scale(cpu->dev.id));
>  }
>  
> -static void update_topology_flags_workfn(struct work_struct *work);
> -static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
> -
>  static DEVICE_ATTR_RO(cpu_capacity);
>  
> -static int cpu_capacity_sysctl_add(unsigned int cpu)
> -{
> -	struct device *cpu_dev = get_cpu_device(cpu);
> -
> -	if (!cpu_dev)
> -		return -ENOENT;
> -
> -	device_create_file(cpu_dev, &dev_attr_cpu_capacity);
> -
> -	return 0;
> -}
> -
> -static int cpu_capacity_sysctl_remove(unsigned int cpu)
> +static umode_t cpu_present_attrs_visible(struct kobject *kobi,
> +					 struct attribute *attr, int index)
>  {
> -	struct device *cpu_dev = get_cpu_device(cpu);
> -
> -	if (!cpu_dev)
> -		return -ENOENT;
> -
> -	device_remove_file(cpu_dev, &dev_attr_cpu_capacity);
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cpu *cpu = container_of(dev, struct cpu, dev);
>  
> -	return 0;
> +	return cpu_present(cpu->dev.id) ? attr->mode : 0;
>  }
>  
> -static int register_cpu_capacity_sysctl(void)
> -{
> -	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "topology/cpu-capacity",
> -			  cpu_capacity_sysctl_add, cpu_capacity_sysctl_remove);
> +const struct attribute_group cpu_capacity_attr_group = {
> +	.is_visible = cpu_present_attrs_visible,
> +	.attrs = cpu_capacity_attrs
> +};
>  
> -	return 0;
> -}
> -subsys_initcall(register_cpu_capacity_sysctl);
> +static void update_topology_flags_workfn(struct work_struct *work);
> +static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
>  
>  static int update_topology;
>  
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index a19a8be93102..954b045705c2 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -192,6 +192,9 @@ static const struct attribute_group crash_note_cpu_attr_group = {
>  static const struct attribute_group *common_cpu_attr_groups[] = {
>  #ifdef CONFIG_KEXEC
>  	&crash_note_cpu_attr_group,
> +#endif
> +#ifdef CONFIG_GENERIC_ARCH_TOPOLOGY
> +	&cpu_capacity_attr_group,
>  #endif
>  	NULL
>  };
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index e117c06e0c6b..745ad21e3dc8 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -30,6 +30,8 @@ struct cpu {
>  	struct device dev;
>  };
>  
> +extern const struct attribute_group cpu_capacity_attr_group;
> +
>  extern void boot_cpu_init(void);
>  extern void boot_cpu_hotplug_init(void);
>  extern void cpu_init(void);
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

