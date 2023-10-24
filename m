Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498257D5B73
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbjJXT3D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 15:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXT3C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 15:29:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC0710D3;
        Tue, 24 Oct 2023 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4y6l7G1s0Dqeh+0zp9FkvmwtEOSFGk+0AxUmVITMGPU=; b=DtkWRF3bmONSx32KVn6ChvxqI2
        u16XWvdfg/5pScH/5dNy7MZzEuQM6lSUzqd632z1Ah6E0EXL0ZDVxeNrjefPodzVuHe8LE30ZUOxc
        ynQdnLV6CRnNzRke0MCL1Dsm3nCLqUX500XhUr0pRHQsjzRcIJS6tPIGxJfePtgxo5h6+HqithRzO
        ME7uEgNuCsnLh/16YcmBRUCb1HSbefoNKFgjh9sok9tyCuiBOmle2d/zkCDTk438cLD03S2yBO8bL
        sGnAoFnOhJr91vckXF5qi2Q/jfyomzUMGuw1rIWP6pD1VltxAlpxOTCoiIQYP90MMgcgDaVNQtEqe
        b/akFbdA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48356)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qvN5B-0004q9-0c;
        Tue, 24 Oct 2023 20:28:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qvN58-0006FV-Kl; Tue, 24 Oct 2023 20:28:50 +0100
Date:   Tue, 24 Oct 2023 20:28:50 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH v3 00/39] ACPI/arm64: add support for virtual
 cpuhotplug
Message-ID: <ZTga8sDSJ+Tg80Fs@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <CAJZ5v0j-73_+9U3ngDAf9w1ADDhBTKctJdWboqUk-okH2TQGyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j-73_+9U3ngDAf9w1ADDhBTKctJdWboqUk-okH2TQGyg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 24, 2023 at 08:26:58PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 24, 2023 at 5:15 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > Hi,
> >
> > I'm posting James' patch set updated with most of the review comments
> > from his RFC v2 series back in September. Individual patches have a
> > changelog attached at the bottom of the commit message. Those which
> > I have finished updating have my S-o-b on them, those which still have
> > outstanding review comments from RFC v2 do not. In some of these cases
> > I've asked questions and am waiting for responses.
> >
> > I'm posting this as RFC v3 because there's still some unaddressed
> > comments and it's clearly not ready for merging. Even if it was ready
> > to be merged, it is too late in this development cycle to be taking
> > this change in, so there would be little point posting it non-RFC.
> > Also James stated that he's waiting for confirmation from the
> > Kubernetes/Kata folk - I have no idea what the status is there.
> >
> > I will be sending each patch individually to a wider audience
> > appropriate for that patch - apologies to those missing out on this
> > cover message. I have added more mailing lists to the series with the
> > exception of the acpica list in a hope of this cover message also
> > reaching those folk.
> >
> > The changes that aren't included are:
> >
> > 1. Updates for my patch that was merged via Thomas (thanks!):
> >    c4dd854f740c cpu-hotplug: Provide prototypes for arch CPU registration
> >    rather than having this change spread through James' patches.
> >
> > 2. New patch - simplification of PA-RISC's smp_prepare_boot_cpu()
> >
> > 3. Moved "ACPI: Use the acpi_device_is_present() helper in more places"
> >    and "ACPI: Rename acpi_scan_device_not_present() to be about
> >    enumeration" to the beginning of the series - these two patches are
> >    already queued up for merging into 6.7.
> >
> > 4. Moved "arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into
> >    a helper" to the beginning of the series, which has been submitted,
> >    but as yet the fate of that posting isn't known.
> >
> > The first four patches in this series are provided for completness only.
> >
> > There is an additional patch in James' git tree that isn't in the set
> > of patches that James posted: "ACPI: processor: Only call
> > arch_unregister_cpu() if HOTPLUG_CPU is selected" which looks to me to
> > be a workaround for arch_unregister_cpu() being under the ifdef. I've
> > commented on this on the RFC v2 posting making a suggestion, but as yet
> > haven't had any response.
> >
> > I've included almost all of James' original covering body below the
> > diffstat.
> >
> > The reason that I'm doing this is to help move this code forward so
> > hopefully it can be merged - which is why I have been keen to dig out
> > from James' patches anything that can be merged and submit it
> > separately, since this is a feature for which some users have a
> > definite need for.
> 
> I've gone through the series and there is at least one thing in it
> that concerns me a lot and some others that at least appear to be
> really questionable.
> 
> I need more time to send comments which I'm not going to do before the
> 6.7 merge window (sorry), but from what I can say right now, this is
> not looking good.

Thanks for having a look - there was the feeling that this was ready
for merging based on the review comments from the previous series sent
by James.

However, when I sent this series, I did notice that some mailing lists
were missing, so I guess that's could be why you haven't commented
before, and we find out now that there are major concerns.

My interest in it is because my employer wants to be able to hotplug
CPUs in a virtual machine, and this saga with aarch64 has been running
for years with different approaches ending up dead in the water. I
hope your concerns do not result in this approach being entirely
scrapped, and there can be some solution found.

I think James Morse will need to be involved in addressing your
concerns since he has the detailed background about the history of
this series. However, James seemed to fall totally silent after the
last posting back in September, so whether that is possible is
currently unknown.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
