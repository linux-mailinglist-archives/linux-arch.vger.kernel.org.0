Return-Path: <linux-arch+bounces-1040-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCBF813890
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A555D1C20ED4
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E0B65ED5;
	Thu, 14 Dec 2023 17:32:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3FA0;
	Thu, 14 Dec 2023 09:32:45 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrfWp0gHJz67mnJ;
	Fri, 15 Dec 2023 01:30:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C9211400CA;
	Fri, 15 Dec 2023 01:32:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 17:32:42 +0000
Date: Thu, 14 Dec 2023 17:32:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or
 functional) devices
Message-ID: <20231214173241.0000260f@Huawei.com>
In-Reply-To: <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Dec 2023 12:49:16 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> Today the ACPI enumeration code 'visits' all devices that are present.
> 
> This is a problem for arm64, where CPUs are always present, but not
> always enabled. When a device-check occurs because the firmware-policy
> has changed and a CPU is now enabled, the following error occurs:
> | acpi ACPI0007:48: Enumeration failure
> 
> This is ultimately because acpi_dev_ready_for_enumeration() returns
> true for a device that is not enabled. The ACPI Processor driver
> will not register such CPUs as they are not 'decoding their resources'.
> 
> Change acpi_dev_ready_for_enumeration() to also check the enabled bit.
> ACPI allows a device to be functional instead of maintaining the
> present and enabled bit. Make this behaviour an explicit check with
> a reference to the spec, and then check the present and enabled bits.
> This is needed to avoid enumerating present && functional devices that
> are not enabled.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> If this change causes problems on deployed hardware, I suggest an
> arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> acpi_dev_ready_for_enumeration() to only check the present bit.

My gut feeling (having made ACPI 'fixes' in the past that ran into
horribly broken firmware and had to be reverted) is reduce the blast
radius preemptively from the start. I'd love to live in a world were
that wasn't necessary but I don't trust all the generators of ACPI tables.
I'll leave it to Rafael and other ACPI experts suggest how narrow we should
make it though - arch opt in might be narrow enough.

> 
> Changes since RFC v2:
>  * Incorporate comment suggestion by Gavin Shan.
> Other review comments from Jonathan Cameron not yet addressed.

Looking back, I think this was mainly a suggestion for a minor
possible optimization by ignoring the case of !present && enabled
when designing the logic because that's not allowed by the spec.

You made that change in v3.

Otherwise, comments were trivial comment clarifications that I'm not
that worried about.

One comment typo inline.

With assumption others will comment on when this change should be
chicken bit'd out.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/acpi/device_pm.c    |  2 +-
>  drivers/acpi/device_sysfs.c |  2 +-
>  drivers/acpi/internal.h     |  1 -
>  drivers/acpi/property.c     |  2 +-
>  drivers/acpi/scan.c         | 24 ++++++++++++++----------
>  5 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 3b4d048c4941..e3c80f3b3b57 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -313,7 +313,7 @@ int acpi_bus_init_power(struct acpi_device *device)
>  		return -EINVAL;
>  
>  	device->power.state = ACPI_STATE_UNKNOWN;
> -	if (!acpi_device_is_present(device)) {
> +	if (!acpi_dev_ready_for_enumeration(device)) {
>  		device->flags.initialized = false;
>  		return -ENXIO;
>  	}
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 23373faa35ec..a0256d2493a7 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -141,7 +141,7 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
>  	struct acpi_hardware_id *id;
>  
>  	/* Avoid unnecessarily loading modules for non present devices. */
> -	if (!acpi_device_is_present(acpi_dev))
> +	if (!acpi_dev_ready_for_enumeration(acpi_dev))
>  		return 0;
>  
>  	/*
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 866c7c4ed233..a1b45e345bcc 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -107,7 +107,6 @@ int acpi_device_setup_files(struct acpi_device *dev);
>  void acpi_device_remove_files(struct acpi_device *dev);
>  void acpi_device_add_finalize(struct acpi_device *device);
>  void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
> -bool acpi_device_is_present(const struct acpi_device *adev);
>  bool acpi_device_is_battery(struct acpi_device *adev);
>  bool acpi_device_is_first_physical_node(struct acpi_device *adev,
>  					const struct device *dev);
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 6979a3f9f90a..14d6948fd88a 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1420,7 +1420,7 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
>  	if (!is_acpi_device_node(fwnode))
>  		return false;
>  
> -	return acpi_device_is_present(to_acpi_device_node(fwnode));
> +	return acpi_dev_ready_for_enumeration(to_acpi_device_node(fwnode));
>  }
>  
>  static const void *
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 02bb2cce423f..728649a2a251 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
>  	int error;
>  
>  	acpi_bus_get_status(adev);
> -	if (acpi_device_is_present(adev)) {
> +	if (acpi_dev_ready_for_enumeration(adev)) {
>  		/*
>  		 * This function is only called for device objects for which
>  		 * matching scan handlers exist.  The only situation in which
> @@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
>  	int error;
>  
>  	acpi_bus_get_status(adev);
> -	if (!acpi_device_is_present(adev)) {
> +	if (!acpi_dev_ready_for_enumeration(adev)) {
>  		acpi_scan_device_not_enumerated(adev);
>  		return 0;
>  	}
> @@ -1913,11 +1913,6 @@ static bool acpi_device_should_be_hidden(acpi_handle handle)
>  	return true;
>  }
>  
> -bool acpi_device_is_present(const struct acpi_device *adev)
> -{
> -	return adev->status.present || adev->status.functional;
> -}
> -
>  static bool acpi_scan_handler_matching(struct acpi_scan_handler *handler,
>  				       const char *idstr,
>  				       const struct acpi_device_id **matchid)
> @@ -2381,16 +2376,25 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
>   * acpi_dev_ready_for_enumeration - Check if the ACPI device is ready for enumeration
>   * @device: Pointer to the &struct acpi_device to check
>   *
> - * Check if the device is present and has no unmet dependencies.
> + * Check if the device is functional or enabled and has no unmet dependencies.
>   *
> - * Return true if the device is ready for enumeratino. Otherwise, return false.
> + * Return true if the device is ready for enumeration. Otherwise, return false.
>   */
>  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device)
>  {
>  	if (device->flags.honor_deps && device->dep_unmet)
>  		return false;
>  
> -	return acpi_device_is_present(device);
> +	/*
> +	 * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to return
> +	 * (!present && functional) for certain types of devices that should be
> +	 * enumerated. Note that the enabled bit can't be sert until the present

set until

> +	 * bit is set.
> +	 */
> +	if (device->status.present)
> +		return device->status.enabled;
> +	else
> +		return device->status.functional;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_ready_for_enumeration);
>  


