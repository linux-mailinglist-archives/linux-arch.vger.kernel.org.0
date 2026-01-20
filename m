Return-Path: <linux-arch+bounces-15896-lists+linux-arch=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-arch@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJxqNDrUb2mgMQAAu9opvQ
	(envelope-from <linux-arch+bounces-15896-lists+linux-arch=lfdr.de@vger.kernel.org>)
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 20:15:06 +0100
X-Original-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8368C4A1C8
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 20:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3101740D2B1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1006F44CF4E;
	Tue, 20 Jan 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KDJga7K0"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A0344CF54;
	Tue, 20 Jan 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925344; cv=none; b=KdsYD1IPJXRWIbv/+39L73F6m04hMAVgeb63F7q4ZVRRgjMKlHe2ugFHXHPsN2E/VZbQljeRLv9mUtNSVwKVwUDZwrVW0Tfqe+4JLunjDEpn/4JgTtn7Uwnzdfh7JA+8qkFK0Yor2m6TxaCPkn/etYJnQi3iJ3ygRzeEvHA2upI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925344; c=relaxed/simple;
	bh=0rIs6thx3jDKb/dI+dzD7t5H6DNv9t1pVMHjiruS7ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffmen9Qap//ByUkTMK+D1K2VkjsEd9DFIwb62C7OsncmCep9Zx+F+NoOIzdMevKRl0rlTH5uEamD22RwM3Cq+t1fQmDjJi3ABlcv590SYFhFqtpLN4ex3OALSa0brIGpkT4VXQrzV02L+bEKSWt6vYoPodSdyahpK2pEMMKP52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KDJga7K0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2544020B7167;
	Tue, 20 Jan 2026 08:09:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2544020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768925342;
	bh=iIZ7bzfOU+32o456dducA6V77xDpYZ8q7ZzTpg2VDtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDJga7K0N+4P68lcEAZIkzvNWr/d4a4erZoM6A9oDmUjDtDW8qpeY2QlJaVLNMMho
	 AjVJWrCGPrMN01TJa64q6v0vAEqXHMR6+xcTbpJMwqsm9W/h3tQqNtNaYNf0kDWpBb
	 Npz5ZO5vyjcIirlciM5xur4auzAEdCskgnwCgqtk=
Date: Tue, 20 Jan 2026 08:09:02 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 06/15] mshv: Implement mshv bridge device for VFIO
Message-ID: <aW-oniY3VpagQMPb@skinsburskii.localdomain>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-7-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-7-mrathor@linux.microsoft.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-15896-lists,linux-arch=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-arch@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-arch];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 8368C4A1C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 10:42:21PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> Add a new file to implement VFIO-MSHV bridge pseudo device. These
> functions are called in the VFIO framework, and credits to kvm/vfio.c
> as this file was adapted from it.
> 
> Original author: Wei Liu <wei.liu@kernel.org>
> (Slightly modified from the original version).
> 

There is a Linux standard for giving credits when code is adapted from.
This doesn't follow that standard. Please fix.

> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/Makefile    |   3 +-
>  drivers/hv/mshv_vfio.c | 210 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv_vfio.c
> 
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index a49f93c2d245..eae003c4cb8f 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -14,7 +14,8 @@ hv_vmbus-y := vmbus_drv.o \
>  hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
>  hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>  mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
> -	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
> +	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o \
> +               mshv_vfio.o
>  mshv_vtl-y := mshv_vtl_main.o
>  
>  # Code that must be built-in
> diff --git a/drivers/hv/mshv_vfio.c b/drivers/hv/mshv_vfio.c
> new file mode 100644
> index 000000000000..6ea4d99a3bd2
> --- /dev/null
> +++ b/drivers/hv/mshv_vfio.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * VFIO-MSHV bridge pseudo device
> + *
> + * Heavily inspired by the VFIO-KVM bridge pseudo device.
> + */
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/vfio.h>
> +
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +struct mshv_vfio_file {
> +	struct list_head node;
> +	struct file *file;	/* list of struct mshv_vfio_file */
> +};
> +
> +struct mshv_vfio {
> +	struct list_head file_list;
> +	struct mutex lock;
> +};
> +
> +static bool mshv_vfio_file_is_valid(struct file *file)
> +{
> +	bool (*fn)(struct file *file);
> +	bool ret;
> +
> +	fn = symbol_get(vfio_file_is_valid);
> +	if (!fn)
> +		return false;
> +
> +	ret = fn(file);
> +
> +	symbol_put(vfio_file_is_valid);
> +
> +	return ret;
> +}
> +
> +static long mshv_vfio_file_add(struct mshv_device *mshvdev, unsigned int fd)
> +{
> +	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
> +	struct mshv_vfio_file *mvf;
> +	struct file *filp;
> +	long ret = 0;
> +
> +	filp = fget(fd);
> +	if (!filp)
> +		return -EBADF;
> +
> +	/* Ensure the FD is a vfio FD. */
> +	if (!mshv_vfio_file_is_valid(filp)) {
> +		ret = -EINVAL;
> +		goto out_fput;
> +	}
> +
> +	mutex_lock(&mshv_vfio->lock);
> +
> +	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
> +		if (mvf->file == filp) {
> +			ret = -EEXIST;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	mvf = kzalloc(sizeof(*mvf), GFP_KERNEL_ACCOUNT);
> +	if (!mvf) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	mvf->file = get_file(filp);
> +	list_add_tail(&mvf->node, &mshv_vfio->file_list);
> +
> +out_unlock:
> +	mutex_unlock(&mshv_vfio->lock);
> +out_fput:
> +	fput(filp);
> +	return ret;
> +}
> +
> +static long mshv_vfio_file_del(struct mshv_device *mshvdev, unsigned int fd)
> +{
> +	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
> +	struct mshv_vfio_file *mvf;
> +	long ret;
> +
> +	CLASS(fd, f)(fd);
> +
> +	if (fd_empty(f))
> +		return -EBADF;
> +
> +	ret = -ENOENT;
> +	mutex_lock(&mshv_vfio->lock);
> +
> +	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
> +		if (mvf->file != fd_file(f))
> +			continue;
> +
> +		list_del(&mvf->node);
> +		fput(mvf->file);
> +		kfree(mvf);
> +		ret = 0;
> +		break;
> +	}
> +
> +	mutex_unlock(&mshv_vfio->lock);
> +	return ret;
> +}
> +
> +static long mshv_vfio_set_file(struct mshv_device *mshvdev, long attr,
> +			      void __user *arg)
> +{
> +	int32_t __user *argp = arg;
> +	int32_t fd;
> +
> +	switch (attr) {
> +	case MSHV_DEV_VFIO_FILE_ADD:
> +		if (get_user(fd, argp))
> +			return -EFAULT;
> +		return mshv_vfio_file_add(mshvdev, fd);
> +
> +	case MSHV_DEV_VFIO_FILE_DEL:
> +		if (get_user(fd, argp))
> +			return -EFAULT;
> +		return mshv_vfio_file_del(mshvdev, fd);
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static long mshv_vfio_set_attr(struct mshv_device *mshvdev,
> +			      struct mshv_device_attr *attr)
> +{
> +	switch (attr->group) {
> +	case MSHV_DEV_VFIO_FILE:
> +		return mshv_vfio_set_file(mshvdev, attr->attr,
> +					  u64_to_user_ptr(attr->addr));
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static long mshv_vfio_has_attr(struct mshv_device *mshvdev,
> +			      struct mshv_device_attr *attr)
> +{
> +	switch (attr->group) {
> +	case MSHV_DEV_VFIO_FILE:
> +		switch (attr->attr) {
> +		case MSHV_DEV_VFIO_FILE_ADD:
> +		case MSHV_DEV_VFIO_FILE_DEL:
> +			return 0;
> +		}
> +
> +		break;
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static long mshv_vfio_create_device(struct mshv_device *mshvdev, u32 type)
> +{
> +	struct mshv_device *tmp;
> +	struct mshv_vfio *mshv_vfio;
> +
> +	/* Only one VFIO "device" per VM */
> +	hlist_for_each_entry(tmp, &mshvdev->device_pt->pt_devices,
> +			     device_ptnode)
> +		if (tmp->device_ops == &mshv_vfio_device_ops)
> +			return -EBUSY;
> +
> +	mshv_vfio = kzalloc(sizeof(*mshv_vfio), GFP_KERNEL_ACCOUNT);
> +	if (mshv_vfio == NULL)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&mshv_vfio->file_list);
> +	mutex_init(&mshv_vfio->lock);
> +
> +	mshvdev->device_private = mshv_vfio;
> +
> +	return 0;
> +}
> +
> +/* This is called from mshv_device_fop_release() */
> +static void mshv_vfio_release_device(struct mshv_device *mshvdev)
> +{
> +	struct mshv_vfio *mv = mshvdev->device_private;
> +	struct mshv_vfio_file *mvf, *tmp;
> +
> +	list_for_each_entry_safe(mvf, tmp, &mv->file_list, node) {
> +		fput(mvf->file);

This put must be sync as device must be detached from domain before
attempting partition destruction.
This was explicitly mentioned in the patch originated this code.
Please fix, add a comment and credits to the commit message.

Thanks,
Stanislav


> +		list_del(&mvf->node);
> +		kfree(mvf);
> +	}
> +
> +	kfree(mv);
> +	kfree(mshvdev);
> +}
> +
> +struct mshv_device_ops mshv_vfio_device_ops = {
> +	.device_name = "mshv-vfio",
> +	.device_create = mshv_vfio_create_device,
> +	.device_release = mshv_vfio_release_device,
> +	.device_set_attr = mshv_vfio_set_attr,
> +	.device_has_attr = mshv_vfio_has_attr,
> +};
> -- 
> 2.51.2.vfs.0.1
> 

