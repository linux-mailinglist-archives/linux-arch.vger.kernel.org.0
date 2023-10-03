Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405EE7B6BC3
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbjJCOfR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjJCOfR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 10:35:17 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E0AD;
        Tue,  3 Oct 2023 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XQksk7pyvzZ6898twTFuY7ew23wLu3w3rS0ARfVw3k4=; b=WlrkJSyKlNE8OwZSxon9XsxAdz
        ASx702dgd0uiF2J3NXC8vaNCH/q+u2wPNN+6oZVHo8cY5V8ZdankY0xk2rou5ypVnd8uNw0lVfgQ0
        ZnBHFMzGxJDzYFKo23XDs5VZq4WzkkYSKYCNH8u7rErL0Nj+yCGtAgeKAoAdbyWvRJAgRvKu1i4ts
        ZO+Y1/kFUR+5AfRk65vlNPA9XjR/LB37rlwNrYyDBS67mgDtOEn5IqMpRecIg0GHZej5mVDilaOpU
        OPsTIE67HUWOn2EcQWB11jsSWIqr9q/XC1tVdmPrkntyomoSbaGo9mN/l0CdlZ4t8HDoJkWt7OJGI
        9PHLc/CQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39002)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qngUG-0001rW-1u;
        Tue, 03 Oct 2023 15:35:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qngUB-0007y5-GX; Tue, 03 Oct 2023 15:34:55 +0100
Date:   Tue, 3 Oct 2023 15:34:55 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Gavin Shan <gshan@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org,
        James Morse <james.morse@arm.com>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Salil Mehta <salil.mehta@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
Message-ID: <ZRwmj/e+jAXFfvCm@shell.armlinux.org.uk>
References: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
 <dd4dee9e-4d75-e1e6-04c8-82d84b28fd35@redhat.com>
 <ZRIU/yFrbFbIR7zZ@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRIU/yFrbFbIR7zZ@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 26, 2023 at 12:17:19AM +0100, Russell King (Oracle) wrote:
> On Tue, Sep 26, 2023 at 09:04:46AM +1000, Gavin Shan wrote:
> > Hi Russell,
> > 
> > On 9/26/23 02:28, Russell King (Oracle) wrote:
> > > Provide common prototypes for arch_register_cpu() and
> > > arch_unregister_cpu(). These are called by acpi_processor.c, with
> > > weak versions, so the prototype for this is already set. It is
> > > generally not necessary for function prototypes to be conditional
> > > on preprocessor macros.
> > > 
> > > Some architectures (e.g. Loongarch) are missing the prototype for this,
> > > and rather than add it to Loongarch's asm/cpu.h, lets do the job once
> > > for everyone.
> > > 
> > > Since this covers everyone, remove the now unnecessary prototypes in
> > > asm/cpu.h, and we also need to remove the 'static' from one of ia64's
> > > arch_register_cpu() definitions.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > > Changes since RFC v2:
> > >   - drop ia64 changes, as ia64 has already been removed.
> > > 
> > >   arch/x86/include/asm/cpu.h  | 2 --
> > >   arch/x86/kernel/topology.c  | 2 +-
> > >   include/linux/cpu.h         | 2 ++
> > >   3 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > 
> > In Linux 6.6.rc3, the prototypes are still existing in arch/ia64/include/asm/cpu.h.
> 
> Correct, but I have been told that IA64 has been removed, so I removed
> those changes from my patch.
> 
> > They may have been dropped in other ia64 or x86 git repository, which this patch
> > bases on.
> 
> I have no idea which repository they have been dropped from. I only know
> what tglx told me, and despite asking the question, I never got any
> answer. So I've done the best I can with this patch. If kernel devs want
> to state things in vague terms, and then go silent when asked questions
> to elaborate, then that leads to guessing.
> 
> Maybe someone else should adapt this patch to apply to whatever tree it
> is going to end up being applied to - because I have no idea _which_
> tree it'll end up being applied to.

So, is this how the Linux community is now dysfunctional?

Someone sends a patch.
Thomas reviews, says it's a good idea and provides some feedback.
Author asks questions, gets ignored.
Author sends a patch taking in to account that previous feedback.
Someone else replies, contradicting the previous feedback.
Nothing else happens.

What a bloody sorry state of affairs.

Makes me wonder what the point of trying to contribute to the Linux
kernel outside of the areas I actually maintain anymore is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
