Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0087A008B
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 11:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbjINJoK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjINJn6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 05:43:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901F12127;
        Thu, 14 Sep 2023 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=axYPg+kto0nJNL9hl8iLv0sDKfjF50COIQpJVC5Qtaw=; b=y9o36XMaTplPci06WgCoImVV8n
        d0RovaoTBpKr7gNJzrFKhK4j6VnIAfNGEuin8IgO508xznoOSAMU8v7mEyO8Q1w+d+JewjyNHztCT
        si3rOh/smfaFzgZ1LG1aC1fG/mKkg2b12fPFXvwKeITYYMr91dEWS8uOqqHoL+u1MtXPePE6i0phH
        E02qmgG+39ruqyJCugCTGUAvoCwr2dxkmbUkAPkcESni1VtABAWuHsCJbC3T7qCOZIcLZffITyvnF
        ie4bA7HGR/+yUzFkj5tEJqgJk4LDKSq+OWYx+b0Lx7uSidPZmGk5fQNwCtoBifDxNMwHZJOrNFiwg
        IFJNmKDg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47660)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qgiqJ-0003nl-2j;
        Thu, 14 Sep 2023 10:40:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qgiqI-0004eL-CR; Thu, 14 Sep 2023 10:40:58 +0100
Date:   Thu, 14 Sep 2023 10:40:58 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 04/35] drivers: base: Move cpu_dev_init() after
 node_dev_init()
Message-ID: <ZQLVKv6RgH/CM75O@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-5-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913163823.7880-5-james.morse@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 04:37:52PM +0000, James Morse wrote:
> NUMA systems require the node descriptions to be ready before CPUs are
> registered. This is so that the node symlinks can be created in sysfs.
> 
> Currently no NUMA platform uses GENERIC_CPU_DEVICES, meaning that CPUs
> are registered by arch code, instead of cpu_dev_init().
> 
> Move cpu_dev_init() after node_dev_init() so that NUMA architectures
> can use GENERIC_CPU_DEVICES.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

I think this patch should be merged sooner rather than later so that
it gets a longer time to be tested, as moving the order that things
happen in init/main.c can be problematical.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
