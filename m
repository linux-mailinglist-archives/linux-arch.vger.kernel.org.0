Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B479FDEE
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 10:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjINILA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 04:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbjINIK7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 04:10:59 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C9CD8;
        Thu, 14 Sep 2023 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HUdy2Po7jkHrYIBNhk+jI+VgvBpeOnh7DGyNEaZXmC8=; b=bkA0oxbWLPss0SERrENqthfcJ8
        J2AlYmp8gSKWUqgvF/LkIJQSR2jnXS0SoProXYe/NPjgBy97H8B5MD63O9wkwJ913QPb0JPAxS/su
        ifx+Cg3vCCr84Fk49A8RbqYpk35LK0nLKqs8wFKLz1bX1l7vt/KLpRGFHwiki1U61EacYCmT5KA6P
        sLpr6XFvgyGZgHg+u2pVg0foJqzGL7fn1+T5puA6qN8aGVWdv4lbvHdJYrp/zx5FRFOJbpZ2hcpUP
        q/Hyiuka6cq0lBT8sBicT12Am9bOuYgK9H/fFgY46fGMdIpz4CURTgZaT8MNejPZYfqDU/eV7xasp
        HtzWmZMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59502)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qghR6-0003gX-0X;
        Thu, 14 Sep 2023 09:10:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qghR6-0004aN-UR; Thu, 14 Sep 2023 09:10:52 +0100
Date:   Thu, 14 Sep 2023 09:10:52 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     James Morse <james.morse@arm.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 30/35] irqchip/gic-v3: Add support for ACPI's
 disabled but 'online capable' CPUs
Message-ID: <ZQLADHCbOr5J8TpX@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-31-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913163823.7880-31-james.morse@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 13, 2023 at 04:38:18PM +0000, James Morse wrote:
>  static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
>  {
> -	return (gicc->flags & ACPI_MADT_ENABLED);
> +	return ((gicc->flags & ACPI_MADT_ENABLED ||
> +		 gicc->flags & ACPI_MADT_GICC_CPU_CAPABLE));

... and this starts getting silly with the number of parens.

	return gicc->flags & ACPI_MADT_ENABLED ||
	       gicc->flags & ACPI_MADT_GICC_CPU_CAPABLE;

is entirely sufficient. Also:

	return gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_CPU_CAPABLE);

also works.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
