Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B7F7A0115
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 12:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbjINKBg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 06:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbjINKBc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 06:01:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66721BE3;
        Thu, 14 Sep 2023 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NWYclCq21SD5zRFkefDJZFQ2FktRA9qrrbGwyrLJzCg=; b=Fh+T7vPQTOfZeLuGB3lBWXQx0J
        r4MQTwJYLAK4DAwUyC+9XbqxuM1qLsNj64vQU8PioYb2SumU0rcZpqLjHT41sEk5UkvgOIImXq90B
        XXq+k/8iS3mxW8iucyUVpFPWRoSCia/vBHMJLUi2M22IMkUtaRs2196D8Spb6zqk2kOeLIaAMKKHb
        yMQ9G2/Z/54rB//2TQ6eTvc1e7ISNEzqLEu+StA9oHDBVfNAd2QkQraURtILwjS24f5LmV1SAWbcE
        IcKsKNDseeRhjDmL4OPs69kiNrPpDv8B9Jj5EU/SqNEUGzjpCKklkf8pjZIAN2qDc329ZpFynpPJt
        bB1hOCqQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37316)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qgjA2-0003qN-2j;
        Thu, 14 Sep 2023 11:01:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qgjA1-0004ev-DQ; Thu, 14 Sep 2023 11:01:21 +0100
Date:   Thu, 14 Sep 2023 11:01:21 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 08/35] x86/topology: Switch over to
 GENERIC_CPU_DEVICES
Message-ID: <ZQLZ8XcZrwiDfABm@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-9-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913163823.7880-9-james.morse@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 04:37:56PM +0000, James Morse wrote:
> Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
> overridden by the arch code, switch over to this to allow common code
> to choose when the register_cpu() call is made.
> 
> x86's struct cpus come from struct x86_cpu, which has no other members
> or users. Remove this and use the version defined by common code.
> 
> This is an intermediate step to the logic being moved to drivers/acpi,
> where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

I think it should also be noted that this moves the registration of
CPUs from subsys to driver core initialisation (before any other
initcalls are run.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
