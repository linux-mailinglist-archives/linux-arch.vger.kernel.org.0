Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3356B90F3
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 12:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCNLD5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 14 Mar 2023 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCNLDz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 07:03:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884C99CBDF;
        Tue, 14 Mar 2023 04:03:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PbVw92GJMz6J7Km;
        Tue, 14 Mar 2023 19:02:01 +0800 (CST)
Received: from localhost (10.48.148.120) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 14 Mar
 2023 11:02:51 +0000
Date:   Tue, 14 Mar 2023 11:02:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <kvmarm@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        "Russell King" <linux@armlinux.org.uk>,
        <kangkang.shen@futurewei.com>
Subject: Re: [RFC PATCH 00/32] ACPI/arm64: add support for virtual
 cpuhotplug
Message-ID: <20230314110250.00005685@Huawei.com>
In-Reply-To: <1f21673e-e5e6-a158-94a4-6ae6724c1f93@arm.com>
References: <20230203135043.409192-1-james.morse@arm.com>
        <20230307120050.000032f1@Huawei.com>
        <1f21673e-e5e6-a158-94a4-6ae6724c1f93@arm.com>
Followup-To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.48.148.120]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 13 Mar 2023 15:50:52 +0000
James Morse <james.morse@arm.com> wrote:

> Hi Jonathan,
> 
> On 07/03/2023 12:00, Jonathan Cameron wrote:
> > On Fri,  3 Feb 2023 13:50:11 +0000
> > James Morse <james.morse@arm.com> wrote:  
> 
> >> On a system that supports cpuhotplug the MADT has to describe every possible
> >> CPU at boot. Under KVM, the vGIC needs to know about every possible vCPU before
> >> the guest is started.
> >> With these constraints, virtual-cpuhotplug is really just a hypervisor/firmware
> >> policy about which CPUs can be brought online.
> >>
> >> This series adds support for virtual-cpuhotplug as exactly that: firmware
> >> policy. This may even work on a physical machine too; for a guest the part of
> >> firmware is played by the VMM. (typically Qemu).
> >>
> >> PSCI support is modified to return 'DENIED' if the CPU can't be brought
> >> online/enabled yet. The CPU object's _STA method's enabled bit is used to
> >> indicate firmware's current disposition. If the CPU has its enabled bit clear,
> >> it will not be registered with sysfs, and attempts to bring it online will
> >> fail. The notifications that _STA has changed its value then work in the same
> >> way as physical hotplug, and firmware can cause the CPU to be registered some
> >> time later, allowing it to be brought online.  
> 
> > As we discussed on an LOD call a while back, I think that we need some path to
> > find out if the guest supports vCPU HP or not so that info can be queried by
> > an orchestrator / libvirt etc.  In general the entity responsible for allocating
> > extra vCPUs may not know what support the VM has for this feature.  
> 
> I agree. For arm64 this is going to be important if/when there are machines that do
> physical hotplug of CPUs too.
> 
> 
> > There are various ways we could get this information into the VMM.
> > My immediate thought is to use one of the ACPI interfaces that lets us write
> > AML that can set an emulated register. A query to the VMM can check if this
> > register is set.
> > 
> > So options.
> > 
> > _OSI() - Deprecated on ARM64 so lets not use that ;)  
> 
> News to me, I've only just discovered it!
> 
> 
> > _OSC() - Could add a bit to Table 6.13 Platform-Wide Capabilites in ACPI 6.5 spec.
> >          Given x86 has a similar online capable bit perhaps this is the best option
> >          though it is the one that requires a formal code first proposal to ASWG.  
> 
> I've had a go at writing this one:
> https://gitlab.arm.com/linux-arm/linux-jm/-/commit/220b0d8b0261d7467c8705e6f614d57325798859

From a quick glance that looks good to me.

> 
> It'll appear in the v1 of the series once the kernel and qemu bits are all lined up again.

We'll also need to kick off the spec change with a code-first proposal.
I think current standard way to do that is a bugzilla entry in EDK2 repo 
https://bugzilla.tianocore.org/buglist.cgi?component=Specification%20Update&product=EDK2%20Code%20First&resolution=---
and the get someone in ASWG to create equivalent tracking issue in mantis.

Great if you already have that in hand via relevant ARM folks.

Jonathan

> 
> 
> Thanks,
> 
> James
> 
> 
> > _OSC() - Could add a new UUID and put it under a suitable device - maybe all CPUs?
> >          You could definitely argue this feature is an operating system property.
> > _DSM() - Similar to OSC but always under a device.
> >          Whilst can be used for this I'm not sure it really matches intended usecase.
> > 
> > Assuming everyone agrees this bit of introspection is useful,
> > Rafael / other ACPI specialists: Any suggestions on how best to do this?  
> 

