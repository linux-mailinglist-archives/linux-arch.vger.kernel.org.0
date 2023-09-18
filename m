Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB87A4478
	for <lists+linux-arch@lfdr.de>; Mon, 18 Sep 2023 10:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbjIRITe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbjIRISa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 04:18:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF8ECD6;
        Mon, 18 Sep 2023 01:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=55eakHJGO5EUrnz8oyp7PKJxWNPGSy80I5cTzshJrkE=; b=myT6AGwYEqN4ejdUWPmq/Vgm33
        9LHv7QtZCxGnRh5zp3aH21FUpOdswe89NrYUPkEuLSxMij/dzTSJnPKxPNxWOKIr9v5IDurA7RgRp
        Ngu+OvnLtLDXU4IqhgFOC2OFmdTzOSv3ybe4MbIbyulmtvaRDW94Zki3h0wxFTLtSGRZrs7AmhHAL
        +6Hk+rTi4fROJlzaaBVMSrNgX9buhvwWc1cvzWCsXhXlkLplPUTaEK2V7YGxLotX36irVNhAlldLy
        ujqumRivrAWrKHqFKbb/0IgbB7smGynZW1fmuRD/xzSGuw9asiX4xW7dgTDj1S9+ghdoUhqqmb6nn
        AwkOQ45w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52138)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qi9Qe-0008Ne-0S;
        Mon, 18 Sep 2023 09:16:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qi9QY-0000Jt-WD; Mon, 18 Sep 2023 09:16:19 +0100
Date:   Mon, 18 Sep 2023 09:16:18 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Salil Mehta <salil.mehta@huawei.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH RFC v2] cpu-hotplug: provide prototypes for arch CPU
 registration
Message-ID: <ZQgHUvW8qgyj5Puv@shell.armlinux.org.uk>
References: <E1qgnh2-007ZRZ-WD@rmk-PC.armlinux.org.uk>
 <871qez1cfd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qez1cfd.ffs@tglx>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 09:09:10PM +0200, Thomas Gleixner wrote:
> On Thu, Sep 14 2023 at 15:51, Russell King wrote:
> > Provide common prototypes for arch_register_cpu() and
> > arch_unregister_cpu(). These are called by acpi_processor.c, with
> > weak versions, so the prototype for this is already set. It is
> > generally not necessary for function prototypes to be conditional
> > on preprocessor macros.
> >
> > Some architectures (e.g. Loongarch) are missing the prototype for this,
> > and rather than add it to Loongarch's asm/cpu.h, lets do the job once
> > for everyone.
> >
> > Since this covers everyone, remove the now unnecessary prototypes in
> > asm/cpu.h, and we also need to remove the 'static' from one of ia64's
> > arch_register_cpu() definitions.
> >
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > Spotted during the review of James Morse's patches, I think rather than
> > adding prototypes for loongarch to its asm/cpu.h, it would make more
> > sense to provide the prototypes in a non-arch specific header file so
> > everyone can benefit, rather than having each architecture do its own
> > thing.
> >
> > I'm sending this as RFC as James has yet to comment on my proposal, and
> > also to a wider audience, and although it makes a little more work for
> > James (to respin his series) it does mean that his series should get a
> > little smaller.
> 
> And it makes tons of sense.
> 
> > See:
> >  https://lore.kernel.org/r/20230913163823.7880-2-james.morse@arm.com
> >  https://lore.kernel.org/r/20230913163823.7880-4-james.morse@arm.com
> >  https://lore.kernel.org/r/20230913163823.7880-23-james.morse@arm.com
> >
> > v2: lets try not fat-fingering vim.
> 
> Yeah. I wondered how you managed to mangle that :)
> 
> >  arch/ia64/include/asm/cpu.h | 5 -----
> >  arch/ia64/kernel/topology.c | 2 +-
> 
> That's moot as ia64 is queued for removal :)

Okay, one less thing to worry about. Tomorrow, I'll re-spin without the
ia64 bits included.

I would really like to hear from James before we think about merging
this, as it will impact James' patch set and would add a dependency
for that. I wouldn't want this patch to become a reason to delay
James' patch set for another kernel cycle.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
