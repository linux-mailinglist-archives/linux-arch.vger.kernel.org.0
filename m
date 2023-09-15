Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49F7A16F2
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 09:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjIOHJq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 03:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjIOHJo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 03:09:44 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3D10C9;
        Fri, 15 Sep 2023 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IO8svM9r91GxPSxrPIglbeq86oJ/FKDbJ+lBe36BJYc=; b=nLlE6W1QoxubyvNpaxsJh8jzSR
        /d5Lf0iTnNQyN9DC4SlP84mxxOmAcgYGHW9si9eE8NiFR9lGM1kX2SNH6SfP+LOj9Q0yDw90kQIl4
        9P5GRkhAmpz8ushDyws83FOx0ZaDux9kxNevsrN6bb08cRo1sEhN0NDRwMTyXk8KaK2T630WX+MSa
        ZhvPIz8oIWSgu3WCEn1Zl3zJglEsl7TSxhMRq4kLqYITKU5X8LHgc13rfTd0aFODSmtXLQ2yShJbY
        EQ0RSbcqGMXPe4bGcqG9ns6yl1/JX3Mg3ep6z6Tf6ife4cVQjnjij5Trg+ivckApl2S9ZSJ/YTZZc
        g94ctEMg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37980)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qh2xD-0005H3-1N;
        Fri, 15 Sep 2023 08:09:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qh2xB-0005bU-2C; Fri, 15 Sep 2023 08:09:25 +0100
Date:   Fri, 15 Sep 2023 08:09:25 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        James Morse <james.morse@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>
Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
 [code first?]
Message-ID: <ZQQDJT6MOaIOPmq5@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-28-james.morse@arm.com>
 <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
 <20230914155459.00002dba@Huawei.com>
 <CAMj1kXFquiLGCMow3iujHUU4GBZx2t9KfKy1R9iqjBFjY+acaA@mail.gmail.com>
 <f5d9beea95e149ab89364dcdb0f8bf69@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d9beea95e149ab89364dcdb0f8bf69@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 02:29:13AM +0000, Salil Mehta wrote:
> On x86, during init, if the MADT entry for LAPIC is found to be
> online-capable and is enabled as well then possible and present

Note that the ACPI spec says enabled + online-capable isn't defined.

"The information conveyed by this bit depends on the value of the
Enabled bit. If the Enabled bit is set, this bit is reserved and
must be zero."

So, if x86 is doing something with the enabled && online-capable
state (other than ignoring the online-capable) then technically it
is doing something that the spec doesn't define - and it's
completely fine if aarch64 does something else (maybe treating it
strictly as per the spec and ignoring online-capable.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
