Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7637A2000
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjIONn0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 09:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjIONn0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 09:43:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BEA10D;
        Fri, 15 Sep 2023 06:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MDmOVUGFw7psqGT5ektePsIj1IbCfn8TY/XxeJGVNTw=; b=rtC74pAlfCcyhcB3Wyl8LKCPB0
        Xwz14Qd36TL0PKhw7Zk+LHnxUd5XgAmKuJEe7akvV+FC/sROu11SxSxKI+0wEMV+5tyG+iCX3Olrr
        lO0y6WnYO8QsojbcRYxX9UrQdN/L/OAffvM0kt7yypxuwclbo3I2J8b4RIOb+s/+WUwGejgTGc/Xo
        dStNDrPrXV6sXo2DJ/ln2JUAiLUi/5f/0lMGJHd3Kav6/MEdvhDb63mrP0ECRMh5DT6Wb67I6BORS
        s9AtdfQyX3WJB4LjYZCrgQaddENsVW+TeUjrQddQqbbbUdsUALBFXgdcFgNaR305NNyFce8J7knKh
        AzEeS2ng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40636)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qh96C-0005hw-0w;
        Fri, 15 Sep 2023 14:43:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qh969-0005qV-Do; Fri, 15 Sep 2023 14:43:05 +0100
Date:   Fri, 15 Sep 2023 14:43:05 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <ZQRfaYYwrYQEfICN@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-28-james.morse@arm.com>
 <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
 <20230914155459.00002dba@Huawei.com>
 <CAMj1kXFquiLGCMow3iujHUU4GBZx2t9KfKy1R9iqjBFjY+acaA@mail.gmail.com>
 <f5d9beea95e149ab89364dcdb0f8bf69@huawei.com>
 <ZQQDJT6MOaIOPmq5@shell.armlinux.org.uk>
 <CAJZ5v0jUQ+4G5ArYAtu1gvYF4356CK_QVTO4oWn0ukwdOiZaHA@mail.gmail.com>
 <80e36ff513504a0382a1cbce83e42295@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80e36ff513504a0382a1cbce83e42295@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 09:34:46AM +0000, Salil Mehta wrote:
> > > Note that the ACPI spec says enabled + online-capable isn't defined.
> > >
> > > "The information conveyed by this bit depends on the value of the
> > > Enabled bit. If the Enabled bit is set, this bit is reserved and
> > > must be zero."
> > >
> > > So, if x86 is doing something with the enabled && online-capable
> > > state (other than ignoring the online-capable) then technically it
> > > is doing something that the spec doesn't define
> > 
> > And so it is wrong.
> 
> Or maybe, specification has not been updated yet. code-first?

What is the point in speculating. If you want to speculate about it,
fine, but please don't use speculation as a reason that "oh we need
to sort this out before we can merge the patches".

This is precisely why engineers are bad at producing products. They
like to continually tweak the design, and the design never gets out
the door. You need someone who is a project manager to tell engineers
when to stop. Without a project manager to do that, eventually the
project fades into insignificance because it becomes no longer relevant
or has its funding cut.

Hotplug VCPU on aarch64 feels exactly like that - it seems to be an
engineer project that is just going to for-ever rumble on and never
actually see the light of day.

So please - stop speculating and lets get vCPU hotplug *actually*
delivered and usable. Even if it's not 100% perfect.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
