Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438DD7D2D1B
	for <lists+linux-arch@lfdr.de>; Mon, 23 Oct 2023 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjJWIsP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWIsO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 04:48:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED77F110;
        Mon, 23 Oct 2023 01:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LLAJ1nq21ZTnhrh8ZIS+thX2+YPOAC3uh7BNx3S3/K4=; b=RJf6lAwrPgbn53kZMA321NVbtj
        0Ks3SzBk30AugMzXMIwVHw9EiW2Pp6YnEDkow/Gr0/Oj5gpxeciu5pm9cxAMjFhJDinr7ueEHesEJ
        JHjDcWS8EscOrdST4BZAealHDBBTWdFWrgDA9wP2Voq3z4amaH0+I8EIjOcAzUjproiVcMEJGAReF
        IEftgvyWAiiy65PziiJt27kRV43C29OqPuDLOUKERo9CjbNtxsXoimqywk09n0NUFB7J9AG6rQcdV
        uzUt9Kn9Vq6E21W0GVhayz+8tdqlx1MuTvuZy/1M8Y82WkOaS/SopzbKr4q9bxBEW/+QCCj78pkDD
        3cBRvZTA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42934)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1quqbY-0002gh-0i;
        Mon, 23 Oct 2023 09:48:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1quqbZ-0004g9-3N; Mon, 23 Oct 2023 09:48:09 +0100
Date:   Mon, 23 Oct 2023 09:48:09 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: Re: [RFC PATCH v2 25/35] LoongArch: Use the __weak version of
 arch_unregister_cpu()
Message-ID: <ZTYzSQw0iLlAKNCn@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-26-james.morse@arm.com>
 <20230914154111.0000189d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914154111.0000189d@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 03:41:11PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:38:13 +0000
> James Morse <james.morse@arm.com> wrote:
> 
> > LoongArch provides its own arch_unregister_cpu(). This clears the
> > hotpluggable flag, then unregisters the CPU.
> > 
> > It isn't necessary to clear the hotpluggable flag when unregistering
> > a cpu. unregister_cpu() writes NULL to the percpu cpu_sys_devices
> > pointer, meaning cpu_is_hotpluggable() will return false, as
> > get_cpu_device() has returned NULL.
> 
> Thought that looked odd earlier but didn't care enough to dig.
> Seem unlikely state would persist for an unregistered cpu.
> Great to see confirmation.

Would it make sense to move this immedaitely after "LoongArch: Switch
over to GENERIC_CPU_DEVICES" ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
