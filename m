Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A157A221C
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjIOPQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjIOPQi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 11:16:38 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C5199;
        Fri, 15 Sep 2023 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UOiyQ0tdZAGc1P6pnaM1XhDTukLQhBrH8Z/l/V1nSz0=; b=OMVJ9mkqZe3HMOFA1ea27odBxI
        cNPtMwnyBfMxgm+ny9zHU4Qk2sm5a8BKOL7j1meKXZ5iCm0fkQdsfhuz48Dakr6PY9gRXb5vnvxSb
        8jeyKQw7DRz8PgrzCL6y4TD8rDkDVj9eT1Wubi7XRIQFGx8QTiaNnhkZ35Wgo0j2tXBlQ1fz2HBf6
        1p1YVXgdzVGMXljBV3BjlvKlJLjkwOKgzoC9pHro+dtG05g+4uFO7KprAoJXLB2zeaoTD0y6Gy8kQ
        KuXLTnmhzfk8osSJY9663oTMHxzRfCgy3aR2V4muXsyVbbIbcmdHEzBGEkfW8pjCkUp4+6az4D3nh
        ZXDHjY+A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53798)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qhAYR-0005mC-26;
        Fri, 15 Sep 2023 16:16:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qhAYR-0005to-Dr; Fri, 15 Sep 2023 16:16:23 +0100
Date:   Fri, 15 Sep 2023 16:16:23 +0100
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
Message-ID: <ZQR1R+okAxfJrS0p@shell.armlinux.org.uk>
References: <20230913163823.7880-28-james.morse@arm.com>
 <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
 <20230914155459.00002dba@Huawei.com>
 <CAMj1kXFquiLGCMow3iujHUU4GBZx2t9KfKy1R9iqjBFjY+acaA@mail.gmail.com>
 <f5d9beea95e149ab89364dcdb0f8bf69@huawei.com>
 <ZQQDJT6MOaIOPmq5@shell.armlinux.org.uk>
 <CAJZ5v0jUQ+4G5ArYAtu1gvYF4356CK_QVTO4oWn0ukwdOiZaHA@mail.gmail.com>
 <80e36ff513504a0382a1cbce83e42295@huawei.com>
 <CAJZ5v0gou9Pdj_CPC=vLJ-6S-hz+0VY+GMgXcRJk=6t9mL1ykw@mail.gmail.com>
 <cec8f4ad16434c2daa0b5db7f6d60a6b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec8f4ad16434c2daa0b5db7f6d60a6b@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 15, 2023 at 02:49:41PM +0000, Salil Mehta wrote:
> I am not aware of any on x86. Maybe we can do it on ARM first and
> let other Arch pitch-in their objection later? Afterall, there is
> a legitimate use-case in case of ARM. Having mutually exclusive
> bits breaks certain use-cases and we have to do the tradeoffs. 

... but let's not use that as an argument to delay the forward
progress of getting aarch64 vCPU hotplug patches merged.

If we want to later propose that Enabled=1 Online-Capable=1 means
that the CPU can be hot-unplugged, then that's something that can
be added to the spec later, and added to the kernel later. There
is no need to go through more iterations of patch sets to add this
feature before considering that aarch64 vCPU hotplug is ready to
be merged.

Like I said in my other email, it's time to stop this "well, if we
do this, then we can do that" cycle - stop playing games with what
can be done.

Delaying merging this code means not only does the maintenance
burden keep increasing (because more and more patches accumulate
which have to be constantly forward ported) but those who *want*
this feature are deprived for what, another year? two years?
decades? before it gets merged.

So please, stop dreaming up new features. Let's get aarch64 vCPU
hotplug that is compliant with the current ACPI spec, merged into
upstream. If we _then_ want to consider additional features, that's
the time to do it.

If you're not prepared to do that, do not be surprised if someone
else (such as myself) decides to fork James' work in order to get
it merged upstream - and yes, I _will_ do that if these games
carry on. I have already started to do that by proposing a patch
that is different from what James has to at least get some of
James' desired changes upstream - and I will continue doing that
all the time that (a) I see that there's a better way to address
something in James' patch and (b) I think in the longer term it
will reduce the maintenance burden of this patch set.

People are getting sick and tired of waiting for this feature.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
