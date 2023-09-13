Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C310979ECF7
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjIMP3q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjIMP3c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 11:29:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9F61BEB;
        Wed, 13 Sep 2023 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XdtCAZyx/MZYsEBg/jFRSdFTbFPWHLuZyAfo/8U5/tw=; b=FKQnCx1yL4RyEEWc6jQCHdQzMK
        szsOP/bu+Hp+kcV7jfsv1j9W2fK3qrHVMhjiwW3Sv5KUUSSTSuAP9ppITyPWNkSa6GOsWotDD0hxb
        grFlbm2z2X/FlaUtQqKyYXfOPJzmLZZNI29Yskokx19istLJS7pHSdkbMIWTSma9/50YnAHqtoFXz
        +du9ZJd2CpX2TaFbf3S8XiUmtfYMWHiiLBKiSIdjUV3LYH0jjF25i2xitRWIsHEztFKiLs74AKyn8
        ui29Pde6io2w+oPRoE0ORQ495MO5MipHx015n6Q5DbY3l/PQa+T2ru1WA/cVybHgDAqM34yXV92wK
        zjCw8DCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59522)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qgRnY-0002gL-2z;
        Wed, 13 Sep 2023 16:29:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qgRnT-0003q4-B5; Wed, 13 Sep 2023 16:28:55 +0100
Date:   Wed, 13 Sep 2023 16:28:55 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Gavin Shan <gshan@redhat.com>
Cc:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC PATCH 00/32] ACPI/arm64: add support for virtual cpuhotplug
Message-ID: <ZQHVN4QqSvx4ndW4@shell.armlinux.org.uk>
References: <20230203135043.409192-1-james.morse@arm.com>
 <41dd71ab-a6a7-fd93-73ec-64a6b0ca468e@redhat.com>
 <1ca1fb8f-1dec-74a3-ee44-94609f6aba2c@arm.com>
 <5a5fb237-c28b-d6b5-0425-8f8f0fe1ac79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5fb237-c28b-d6b5-0425-8f8f0fe1ac79@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 08:38:51AM +1000, Gavin Shan wrote:
> 
> Hi James,
> 
> On 9/13/23 03:01, James Morse wrote:
> > On 29/03/2023 03:35, Gavin Shan wrote:
> > > On 2/3/23 9:50 PM, James Morse wrote:
> > 
> > > > If folk want to play along at home, you'll need a copy of Qemu that supports this.
> > > > https://github.com/salil-mehta/qemu.git
> > > > salil/virt-cpuhp-armv8/rfc-v1-port29092022.psci.present
> > > > 
> > > > You'll need to fix the numbers of KVM_CAP_ARM_HVC_TO_USER and KVM_CAP_ARM_PSCI_TO_USER
> > > > to match your host kernel. Replace your '-smp' argument with something like:
> > > > | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1
> > > > 
> > > > then feed the following to the Qemu montior;
> > > > | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
> > > > | (qemu) device_del cpu1
> > > > 
> > > > 
> > > > This series is based on v6.2-rc3, and can be retrieved from:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/ virtual_cpu_hotplug/rfc/v1
> > 
> > > I give it a try, but the hot-added CPU needs to be put into online
> > > state manually. I'm not sure if it's expected or not.
> > 
> > This is expected. If you want the CPUs to be brought online automatically, you can add
> > udev rules to do that.
> > 
> 
> Yeah, I usually execute the following command to bring the CPU into online state,
> after the vCPU is hot added by QMP command.
> 
> (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
> guest# echo 1 > /sys/devices/system/cpu/cpux/online
> 
> James, the series was posted a while ago and do you have plan to respin
> and post RFCv2 in near future? :)

I'll pipe up here, because I've been discussing this topic with James
privately.

In James' last email to me, he indicated that he's hoping to publish
the next iteration of the patches towards the end of this week. I
suspect that's conditional on there being no major issues coming up.

One of the things that I think would help this patch set along is if
people could test it on x86, to make sure that there aren't any
regressions on random x86 hardware - and report successes and
failures so confidence in the patch series can be gained.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
