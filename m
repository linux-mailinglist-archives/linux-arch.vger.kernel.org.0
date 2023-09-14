Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A113579FE26
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 10:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbjINIVC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 04:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjINIVC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 04:21:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB52DA;
        Thu, 14 Sep 2023 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jFy+WxBhwYo/RJJ6gzVJec734NGNXktDMBEY9ow/Fcg=; b=hyJmh5YCPZYWVjLLnLzcQDRTY7
        ywvl6lBjVSG9cEkIBAf2Hx5RF5uYtKBW1F3qZiT64n+qjI4+g8X47j2unLXPjYgyLaN3QUwWHtWsP
        fW+ULTHC9y3lAiAwozVPKS/GyrQWD8X+T9MKu4B1WO9MHe6UcpNl2cEd5DF40Y6lz+CVxn8Asl1U5
        Bu1IWMEEoMa8ePJ+5z2RutRuCQcnGq6Lk+jujK3UBTi9GKeKgviujNSc3K8lwzCP1NA3Wa4V+Wj1c
        fLJMeHEapLIwlRAHD0OLv0kav5/UwRl9Js5aNjE1xnVdzf+oxFI1F7TJv/G3mjYqUg2VCJ7+XJsDe
        Mno7iVww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53756)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qghao-0003hf-1j;
        Thu, 14 Sep 2023 09:20:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qghao-0004ag-K8; Thu, 14 Sep 2023 09:20:54 +0100
Date:   Thu, 14 Sep 2023 09:20:54 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 02/35] drivers: base: Use present CPUs in
 GENERIC_CPU_DEVICES
Message-ID: <ZQLCZsw+ZGbTM8oK@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-3-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913163823.7880-3-james.morse@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 04:37:50PM +0000, James Morse wrote:
> Three of the five ACPI architectures create sysfs entries using
> register_cpu() for present CPUs, whereas arm64, riscv and all
> GENERIC_CPU_DEVICES do this for possible CPUs.
> 
> Registering a CPU is what causes them to show up in sysfs.
> 
> It makes very little sense to register all possible CPUs. Registering
> a CPU is what triggers the udev notifications allowing user-space to
> react to newly added CPUs.
> 
> To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
> it to use for_each_present_cpu(). Making the ACPI architectures use
> GENERIC_CPU_DEVICES is a pre-requisite step to centralise their
> cpu_register() logic, before moving it into the ACPI processor driver.
> When ACPI is disabled this work would be done by
> cpu_dev_register_generic().
> 
> Of the ACPI architectures that register possible CPUs, arm64 and riscv
> do not support making possible CPUs present as they use the weak 'always
> fails' version of arch_register_cpu().
> 
> Only two of the eight architectures that use GENERIC_CPU_DEVICES have a
> distinction between present and possible CPUs.
> 
> The following architectures use GENERIC_CPU_DEVICES but are not SMP,
> so possible == present:
>  * m68k
>  * microblaze
>  * nios2
> 
> The following architectures use GENERIC_CPU_DEVICES and consider
> possible == present:
>  * csky: setup_smp()
>  * parisc: smp_prepare_boot_cpu() marks the boot cpu as present,
>    processor_probe() sets possible for all CPUs and present for all CPUs
>    except the boot cpu.

However, init/main.c::start_kernel() calls boot_cpu_init() which sets
the boot CPU in the online, active, present and possible masks. So,
_every_ architecture gets the boot CPU in all these masks no matter
what.

Only of something then clears the boot CPU from these masks (which
would be silly) would the boot CPU not be in all of these masks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
