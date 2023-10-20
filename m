Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277557D0F2B
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 13:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377258AbjJTLxm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 07:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377257AbjJTLxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 07:53:41 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA0D41;
        Fri, 20 Oct 2023 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZnH9rsDzGO6weBMybmlTOxejgjbXoW+kfLP/Bw4OXUE=; b=PHFGq+CDzvcu05j4/9OwcnhS+3
        dniZKELXdzZ7oE3K2oURHH1f7vOrijKdYXMxblKLxLQmksJTA+Mt1qwTWLN0NwzyHRluOQ8lEZtAu
        HO4GZ8rV19IGOzem3PNfDR9XeB4gH23tXyd21o7vRK9lx96fXGBSWBAanRKe1HlchPKpVvCy6pKZf
        ca456Hj718geltF8hQwoAYhOiW6BppDwcbxBVUtresfOLi2DSCWYrWw4884RjpK6mccRd8M3wL1IT
        VVeCBJYEoy1nrzTjZPmVe77zFRN6Luib8s+HX9uw2MImjvcrudZ2J7RK6bffVuxYVtslyuJqU7Adp
        XMNN3wlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48178)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qto4K-0000LD-0H;
        Fri, 20 Oct 2023 12:53:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qto4H-0001Vh-On; Fri, 20 Oct 2023 12:53:29 +0100
Date:   Fri, 20 Oct 2023 12:53:29 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        gregkh@linuxfoundation.org
Cc:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 11/35] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
Message-ID: <ZTJqOTfDEnL9wgtY@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-12-james.morse@arm.com>
 <20230914130126.000069db@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914130126.000069db@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 01:01:26PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:37:59 +0000
> James Morse <james.morse@arm.com> wrote:
> 
> > register_cpu_capacity_sysctl() adds a property to sysfs that describes
> > the CPUs capacity. This is done from a subsys_initcall() that assumes
> > all possible CPUs are registered.
> > 
> > With CPU hotplug, possible CPUs aren't registered until they become
> > present, (or for arm64 enabled). This leads to messages during boot:
> > | register_cpu_capacity_sysctl: too early to get CPU1 device!
> > and once these CPUs are added to the system, the file is missing.
> > 
> > Move this to a cpuhp callback, so that the file is created once
> > CPUs are brought online. This covers CPUs that are added late by
> > mechanisms like hotplug.
> > One observable difference is the file is now missing for offline CPUs.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> > If the offline CPUs thing is a problem for the tools that consume
> > this value, we'd need to move cpu_capacity to be part of cpu.c's
> > common_cpu_attr_groups.
> 
> I think we should do that anyway and then use an is_visible() if we want to
> change whether it is visible in offline cpus.
> 
> Dynamic sysfs file creation is horrible - particularly when done
> from an totally different file from where the rest of the attributes
> are registered.  I'm curious what the history behind that is.
> 
> Whilst here, why is there a common_cpu_attr_groups which is
> identical to the hotpluggable_cpu_attr_groups in base/cpu.c?
> 
> 
> +CC GregKH
> Given changes in drivers/base/

It would be good to have a comment on this from Greg before I post
an updated series of James' patches with most of the comments
addressed, possibly later today.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
