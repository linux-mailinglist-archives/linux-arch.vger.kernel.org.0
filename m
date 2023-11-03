Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E617E0248
	for <lists+linux-arch@lfdr.de>; Fri,  3 Nov 2023 12:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjKCLiB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Nov 2023 07:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjKCLiA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Nov 2023 07:38:00 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A350D49;
        Fri,  3 Nov 2023 04:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=plA7feRLjmw4qX8KHH4SK8cHKzi6R1RnGQsSzHXmiyI=; b=r8gKUdsct6x4xUzkDbnVrAliys
        rU49OJZGVR/coPFqdct2gl3oH8umMdcw78VUvbESCMCAkfM1BwnJZ3Ph0C45+elImNUCpr60BqSsH
        539nSH/dnv/1zwwWt2HOm3bEUk+vWS0Wb0jqiMy4Iz2c2QcWlv6e8NnvBAxX4OSyrSuJI8JjcPM/6
        faPhoJ57lVoPb/s24YOWGJeMJ4E24vPer/AYqlbG6QT/lZTSodAEzGt7NWfZhoMB/ItsbabE7KPyC
        ZlxVdQBM2mEMWzCRZUQscCv1BgID5FJi8m5rOU62HUGCiIGYAfh1CjAzm/rE0HQbqLaN9Yvdsxlth
        T8Ya2edg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33780)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qysUl-0005UH-1j;
        Fri, 03 Nov 2023 11:37:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qysUi-0008MP-VI; Fri, 03 Nov 2023 11:37:44 +0000
Date:   Fri, 3 Nov 2023 11:37:44 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 15/35] ACPI: processor: Add support for processors
 described as container packages
Message-ID: <ZUTbiO2/SSFcTPAV@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-16-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913163823.7880-16-james.morse@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 04:38:03PM +0000, James Morse wrote:
> ACPI has two ways of describing processors in the DSDT. Either as a device
> object with HID ACPI0007, or as a type 'C' package inside a Processor
> Container.

I'm struggling with the reference to a "type 'C' package inside a
Processor Container".

ACPI 6.0, which introduced the Processor Container, says: "This optional
device is a container object that acts much like a bus node in a
namespace. It may contain child objects that are either processor devices
or other processor containers"

For "Processor device":

"For more information on the declaration of the processor device object,
see Section 19.6.30, "Device (Declare Device Package).""

which leads one to the Device() object, not the Processor() object.
It also states:

"A Device definition for a processor is declared using the ACPI0007
hardware identifier (HID)."

My understanding from this is that Processor() is not allowed to be
used within a Processor Container, only Device()s with _HID of
ACPI0007 are permitted.

In light of this, please could you clarify your first sentence, as it
seems to be contrary to what is stated in ACPI 6.x specs. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
