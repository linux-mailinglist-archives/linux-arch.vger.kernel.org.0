Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E04479FDDF
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 10:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjINIJc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 04:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjINIJc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 04:09:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA49B;
        Thu, 14 Sep 2023 01:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V/HxvkqbaFoEQh0p6Z3aJgJbBAL0SNdKKsE6KdqG0nE=; b=KhfLjilliuR7OQ+8EDr63FTB4v
        6d+97T4jo2zB5AAn+T5RS1DCNlEsaeb5wOLcreZIM5Na+eZk55qGGLA5xUf5nxiY8k21kfWlR16PF
        7Z81lh6wIe6EhAowPDpP84Xnf9Pzh1MQtHV6UmOJUab/33630JIRctho5GODeY5BgxlNPzzvzZuyG
        sW3XRKEJ3o3MfAD3x7SzKPvMFP01dNFuvp66fX9BFjqArv2MLU7jl5QGQ8O79cQU8O4sdyN4dHcFg
        3lATjUULKaMiw7VOjintw3rKhil4Qn/rc6qF2n6GUV0ApCFQwTNRS2MrIdCHPQ0J1+WT+FxxeGpu4
        4jUVLgoQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55678)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qghPc-0003g5-37;
        Thu, 14 Sep 2023 09:09:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qghPY-0004ZU-U9; Thu, 14 Sep 2023 09:09:17 +0100
Date:   Thu, 14 Sep 2023 09:09:16 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 28/35] arm64, irqchip/gic-v3, ACPI: Move MADT GICC
 enabled check into a helper
Message-ID: <ZQK/rM/+1fGhM18m@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-29-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913163823.7880-29-james.morse@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 04:38:16PM +0000, James Morse wrote:
> +static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
> +{
> +	return (gicc->flags & ACPI_MADT_ENABLED);

These parens are not needed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
