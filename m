Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1127D5866
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 18:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbjJXQbz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Oct 2023 12:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbjJXQby (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Oct 2023 12:31:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F3118;
        Tue, 24 Oct 2023 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mv2+9gUUjwW5p4nAhtEkX5YZZx1pxyCR6znx1hs0kpI=; b=rsZIaVku++xS3FLshJEaUmBzq+
        IZD6Cn2c0/et6Uo+JOt4WeR9dFq1Ut+rF5FrT6IV5KhIFvVMf+LLjBQLU47NDzgIwcmGbpVvhRTRU
        gCMWRDcUie6kOaY2a7dMFClZ3267XEs/FktAYAglK9oyph9oihl1JtFf48qSzAA3ywoyWzC0GfK9M
        PTB0JemBhYOU0lDTVo1ICvemFtxrnnzr1IC3EEZQvKuCtWm90ax0Ijo4QL9EWtWa0cPIQeUEmcXl+
        LV7aHQWDApKmS5tOWVE6eDqhk5hYbwHCvkYKAl3o4s/teUj9wygTZAZpbtSMTDvDNzQIg9tkuFtyu
        U9rcIOVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33572)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qvKJm-0004fl-0V;
        Tue, 24 Oct 2023 17:31:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qvKJl-00063d-WA; Tue, 24 Oct 2023 17:31:46 +0100
Date:   Tue, 24 Oct 2023 17:31:45 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH v3 00/39] ACPI/arm64: add support for virtual
 cpuhotplug
Message-ID: <ZTfxcU3EsBNOGIUm@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 24, 2023 at 04:15:28PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> I'm posting James' patch set updated with most of the review comments
> from his RFC v2 series back in September. Individual patches have a
> changelog attached at the bottom of the commit message. Those which
> I have finished updating have my S-o-b on them, those which still have
> outstanding review comments from RFC v2 do not. In some of these cases
> I've asked questions and am waiting for responses.
> 
> I'm posting this as RFC v3 because there's still some unaddressed
> comments and it's clearly not ready for merging. Even if it was ready
> to be merged, it is too late in this development cycle to be taking
> this change in, so there would be little point posting it non-RFC.
> Also James stated that he's waiting for confirmation from the
> Kubernetes/Kata folk - I have no idea what the status is there.
> 
> I will be sending each patch individually to a wider audience
> appropriate for that patch - apologies to those missing out on this
> cover message. I have added more mailing lists to the series with the
> exception of the acpica list in a hope of this cover message also
> reaching those folk.
> 
> The changes that aren't included are:
> 
> 1. Updates for my patch that was merged via Thomas (thanks!):
>    c4dd854f740c cpu-hotplug: Provide prototypes for arch CPU registration
>    rather than having this change spread through James' patches.
> 
> 2. New patch - simplification of PA-RISC's smp_prepare_boot_cpu()
> 
> 3. Moved "ACPI: Use the acpi_device_is_present() helper in more places"
>    and "ACPI: Rename acpi_scan_device_not_present() to be about
>    enumeration" to the beginning of the series - these two patches are
>    already queued up for merging into 6.7.
> 
> 4. Moved "arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into
>    a helper" to the beginning of the series, which has been submitted,
>    but as yet the fate of that posting isn't known.

Update: Catalin has just merged this patch! Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
