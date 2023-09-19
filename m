Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE4B7A5F6D
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 12:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjISKYw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 06:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjISKYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 06:24:51 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F70F1;
        Tue, 19 Sep 2023 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZB9BH5s6f+1vWNC2c2Ik282bpxBrIN2PmS2ywFcicC0=; b=QFgL+GrLi4spuAOmLz3KFJCeSu
        7JM8L9KKnKdJd3mizqrd7r8XOiJmeFq4ouhF6CtN3jNRYGfxLg15k+cYTBuT7BZSjFu9zVQF8U/CB
        qxcY62BX4iTdtz8TxPGyYqW8R9PtxZRdZm6Gd0YY/iva1tazgUAbLpcGUJM32rZEm45UkyONvMzWs
        Mp0U+xYRw+Re/2wd/EZgoyLCr3uesAioIu99+to9tNugowUvbsi+ux/B43lRIuE/x2tdQaVoO4Cwn
        OKzk1azVmZpkMlOWJfGw9LFPDoFDTEZ5kdmDVEPR5gKaIiaDFlSVebUav8i0+wPxIeqx4CC53O9wi
        X2T6BZ8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48024)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qiXuL-0001gT-1a;
        Tue, 19 Sep 2023 11:24:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qiXuL-0001QG-Gh; Tue, 19 Sep 2023 11:24:41 +0100
Date:   Tue, 19 Sep 2023 11:24:41 +0100
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
Subject: Re: [RFC PATCH v2 32/35] ACPI: add support to register CPUs based on
 the _STA enabled bit
Message-ID: <ZQl26YlRnQaKwCg6@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-33-james.morse@arm.com>
 <20230914171341.00006e51@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914171341.00006e51@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 05:13:41PM +0100, Jonathan Cameron wrote:
> On Wed, 13 Sep 2023 16:38:20 +0000
> James Morse <james.morse@arm.com> wrote:
> > +static int acpi_processor_make_enabled(struct acpi_processor *pr)
> > +{
> > +	unsigned long long sta;
> > +	acpi_status status;
> > +	bool present, enabled;
> > +
> > +	if (!acpi_has_method(pr->handle, "_STA"))
> > +		return arch_register_cpu(pr->id);
> > +
> > +	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> > +	if (ACPI_FAILURE(status))
> > +		return -ENODEV;
> > +
> > +	present = sta & ACPI_STA_DEVICE_PRESENT;
> > +	enabled = sta & ACPI_STA_DEVICE_ENABLED;
> > +
> > +	if (cpu_online(pr->id) && (!present || !enabled)) {
> > +		pr_err_once(FW_BUG "CPU %u is online, but described as not present or disabled!\n", pr->id);
> 
> Why once?  If this for some reason happened on multiple CPUs I think we'd want to know.
> 
> > +		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> > +	} else if (!present || !enabled) {
> > +		return -ENODEV;
> > +	}
> 
> I guess you didn't do a nested if here to avoid even longer lines.
> Could flip things around though I don't like this much either as it makes
> the normal good path exit mid way down.
> 
> 	if (present && enabled)
> 		return arch_register_cpu(pr->id);
> 
> 	if (!cpu_online(pr->id))
> 		return -ENODEV;
> 
> 	pr_err...
> 	add_taint(...
> 
> 	return arch_register_cpu(pr->id);
> 
> Ah well. Some code just has to be less than pretty.

How about:

static int acpi_processor_should_register_cpu(struct acpi_processor *pr)
{
	unsigned long long sta;
	acpi_status status;

	if (!acpi_has_method(pr->handle, "_STA"))
		return 0;

	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
	if (ACPI_FAILURE(status))
		return -ENODEV;

	if (sta & ACPI_STA_DEVICE_PRESENT && sta & ACPI_STA_DEVICE_ENABLED)
		return 0;

	if (cpu_online(pr->id)) {
		pr_err_once(FW_BUG
			    "CPU %u is online, but described as not present or disabled!\n",
			    pr->id);

		/* Register the CPU anyway */
		return 0;
	}

	return -ENODEV;
}

static int acpi_processor_make_enabled(struct acpi_processor *pr)
{
	int ret = acpi_processor_should_register_cpu(pr);

	if (ret)
		return ret;

	return arch_register_cpu(pr->id);
}

I would keep the "cpu online but !present and !disabled" as a sub-block
because it makes better reading flow, but instead break the message as
I've indicated above.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
