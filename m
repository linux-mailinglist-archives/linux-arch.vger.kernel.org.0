Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D857D12D4
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 17:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377727AbjJTPca (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 11:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377723AbjJTPca (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 11:32:30 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F30D78;
        Fri, 20 Oct 2023 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oeGZC/GFFZBHPdyj3JvOUApGMDrwTjGZ7XC00CXwh5Q=; b=EoNYPhJ6ubRySWuuhtVBiIyqDD
        Zbsgv90x3JwfNxoehfPQaO6I+KGkUNZSC7RsTD9YG3dPGEgVlBJBfyQekKs/F9QoRNwGxVI9niq+t
        4EwPvXp0Xlxh4Nz+MDrYoFyWSOlaRzLrjC3UQfxkQrXF/G8dElJu0zei7KTU02SrThLMwLxChW8jo
        9WTeoxMqRvv4l594/V8RM0UnYFESz4aaQkJbPNc5HjQWXBSAb58kGhSaJtqrkbsCnq8Sf6kUbRJPB
        Vue1W8Z9Q67PVPGUVdza6LfZNSP8Q3soDQTcfwzRHdETs0/rtO7CD4oHLq90sMIrPRZPBwEoQvgAH
        CD3ZYC/A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41310)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qtrU4-0000b5-0E;
        Fri, 20 Oct 2023 16:32:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qtrU1-0001e6-HL; Fri, 20 Oct 2023 16:32:17 +0100
Date:   Fri, 20 Oct 2023 16:32:17 +0100
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
Subject: Re: [RFC PATCH v2 14/35] ACPI: Only enumerate enabled (or
 functional) devices
Message-ID: <ZTKdgUu/wubKfdef@shell.armlinux.org.uk>
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-15-james.morse@arm.com>
 <20230914132732.00006908@Huawei.com>
 <20230914140940.00001417@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914140940.00001417@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 02:09:40PM +0100, Jonathan Cameron wrote:
> On Thu, 14 Sep 2023 13:27:32 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Wed, 13 Sep 2023 16:38:02 +0000
> > James Morse <james.morse@arm.com> wrote:
> > 
> > > Today the ACPI enumeration code 'visits' all devices that are present.
> > > 
> > > This is a problem for arm64, where CPUs are always present, but not
> > > always enabled. When a device-check occurs because the firmware-policy
> > > has changed and a CPU is now enabled, the following error occurs:
> > > | acpi ACPI0007:48: Enumeration failure
> > > 
> > > This is ultimately because acpi_dev_ready_for_enumeration() returns
> > > true for a device that is not enabled. The ACPI Processor driver
> > > will not register such CPUs as they are not 'decoding their resources'.
> > > 
> > > Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
> > > ACPI allows a device to be functional instead of maintaining the
> > > present and enabled bit. Make this behaviour an explicit check with
> > > a reference to the spec, and then check the present and enabled bits.  
> > 
> > "and the" only applies if the functional route hasn't been followed
> > "if not this case check the present and enabled bits."
> > 
> > > This is needed to avoid enumerating present && functional devices that
> > > are not enabled.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > ---
> > > If this change causes problems on deployed hardware, I suggest an
> > > arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> > > acpi_dev_ready_for_enumeration() to only check the present bit.
> > > ---
> > >  drivers/acpi/device_pm.c    |  2 +-
> > >  drivers/acpi/device_sysfs.c |  2 +-
> > >  drivers/acpi/internal.h     |  1 -
> > >  drivers/acpi/property.c     |  2 +-
> > >  drivers/acpi/scan.c         | 23 +++++++++++++----------
> > >  5 files changed, 16 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> > > index f007116a8427..76c38478a502 100644
> > > --- a/drivers/acpi/device_pm.c
> > > +++ b/drivers/acpi/device_pm.c
> > > @@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
> > >  		return -EINVAL;
> > >  
> > >  	device->power.state = ACPI_STATE_UNKNOWN;
> > > -	if (!acpi_device_is_present(device)) {
> > > +	if (!acpi_dev_ready_for_enumeration(device)) {
> > >  		device->flags.initialized = false;
> > >  		return -ENXIO;
> > >  	}
> > > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > > index b9bbf0746199..16e586d74aa2 100644
> > > --- a/drivers/acpi/device_sysfs.c
> > > +++ b/drivers/acpi/device_sysfs.c
> > > @@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
> > >  	struct acpi_hardware_id *id;
> > >  
> > >  	/* Avoid unnecessarily loading modules for non present devices. */
> > > -	if (!acpi_device_is_present(acpi_dev))
> > > +	if (!acpi_dev_ready_for_enumeration(acpi_dev))
> > >  		return 0;
> > >  
> > >  	/*
> > > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > > index 866c7c4ed233..a1b45e345bcc 100644
> > > --- a/drivers/acpi/internal.h
> > > +++ b/drivers/acpi/internal.h
> > > @@ -107,7 +107,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
> > >  void acpi_device_remove_files(struct acpi_device *dev);
> > >  void acpi_device_add_finalize(struct acpi_device *device);
> > >  void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> > > -bool acpi_device_is_present(const struct acpi_device *adev);
> > >  bool acpi_device_is_battery(struct acpi_device *adev);
> > >  bool acpi_device_is_first_physical_node(struct acpi_device *adev,
> > >  					const struct device *dev);
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 413e4fcadcaf..e03f00b98701 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -1418,7 +1418,7 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
> > >  	if (!is_acpi_device_node(fwnode))
> > >  		return false;
> > >  
> > > -	return acpi_device_is_present(to_acpi_device_node(fwnode));
> > > +	return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
> > >  }
> > >  
> > >  static const void *
> > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > index 17ab875a7d4e..f898591ce05f 100644
> > > --- a/drivers/acpi/scan.c
> > > +++ b/drivers/acpi/scan.c
> > > @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
> > >  	int error;
> > >  
> > >  	acpi_bus_get_status(adev);
> > > -	if (acpi_device_is_present(adev)) {
> > > +	if (acpi_dev_ready_for_enumeration(adev)) {
> > >  		/*
> > >  		 * This function is only called for device objects for which
> > >  		 * matching scan handlers exist.  The only situation in which
> > > @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
> > >  	int error;
> > >  
> > >  	acpi_bus_get_status(adev);
> > > -	if (!acpi_device_is_present(adev)) {
> > > +	if (!acpi_dev_ready_for_enumeration(adev)) {
> > >  		acpi_scan_device_not_enumerated(adev);
> > >  		return 0;
> > >  	}
> > > @@ -1908,11 +1908,6 @@ static bool acpi_device_should_be_hidden(acpi_handle handle)
> > >  	return true;
> > >  }
> > >  
> > > -bool acpi_device_is_present(const struct acpi_device *adev)
> > > -{
> > > -	return adev->status.present || adev->status.functional;
> > > -}
> > > -
> > >  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
> > >  				       const char *idstr,
> > >  				       const struct acpi_device_id **matchid)
> > > @@ -2375,16 +2370,24 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
> > >   * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready for enumeration
> > >   * @device: Pointer to the &struct acpi_device to check
> > >   *
> > > - * Check if the device is present and has no unmet dependencies.
> > > + * Check if the device is functional or enabled and has no unmet dependencies.
> > >   *
> > > - * Return true if the device is ready for enumeratino. Otherwise, return false.
> > > + * Return true if the device is ready for enumeration. Otherwise, return false.
> > >   */
> > >  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
> > >  {
> > >  	if (device->flags.honor_deps && device->dep_unmet)
> > >  		return false;
> > >  
> > > -	return acpi_device_is_present(device);
> > > +	/*
> > > +	 * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
> > > +	 * (!present && functional) for certain types of devices that should be
> > > +	 * enumerated.  
> > 
> > I'd call out the fact that enumeration isn't same as "device driver should be loaded"
> > which is the thing that functional is supposed to indicate should not happen.
> > 
> > > +	 */
> > > +	if (!device->status.present && !device->status.enabled)  
> > 
> > In theory no need to check !enabled if !present
> > "If bit [0] is cleared, then bit 1 must also be cleared (in other words, a device that is not present cannot be enabled)."
> > We could report an ACPI bug if that's seen.  If that bug case is ignored this code can
> > become the simpler.
> > 
> > 	if (device->status.present)
> > 		return device->status_enabled;
> > 	else
> > 		return device->status.functional;
> > 
> > Or the following also valid here (as functional should be set for enabled present devices
> > unless they failed diagnostics).
> > 
> > 	if (dev->status.functional)
> > 		return true;
> > 	return device->status.present && device->status.enabled;
> > 
> > On assumption we want to enumerate dead devices for debug purposes...
> Actually ignore this.  Could have weird race with present, functional true,
> but enabled not quite set - despite the device being there and self
> tests having passed.

Are you suggesting to ignore you're entire suggestion or just this
suggestion and go with the first one?

So, the code was originally effectively:

	return adev->status.present || adev->status.functional;

So it has the truth table:

present	functional	result
false	false		false
false	true		true
true	don't care	true

James' replacement code makes this:

	if (!device->status.present && !device->status.enabled)
		return device->status.functional;

	return device->status.present && device->status.enabled;

giving:

present	enabled	functional	result
false	false	false		false
false	false	true		true
false	true	don't care	false	<== invalid according to spec
true	false	don't care	false
true	true	don't care	true

So, I think what you're getting at is that we want the logic to be
according to the above table, but simplified, not caring about the
invalid state too much?

In which case, I would suggest going with your first suggestion, in
other words:

	if (device->status.present)
		return device->status.enabled;
	else
		return device->status.functional;

Yes?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
