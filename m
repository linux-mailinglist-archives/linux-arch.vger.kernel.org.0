Return-Path: <linux-arch+bounces-15897-lists+linux-arch=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-arch@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJH5C0i6b2kOMQAAu9opvQ
	(envelope-from <linux-arch+bounces-15897-lists+linux-arch=lfdr.de@vger.kernel.org>)
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 18:24:24 +0100
X-Original-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C75344881C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 18:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 530B35CC23A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF54779B9;
	Tue, 20 Jan 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="F5fTmeb0"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7531078B;
	Tue, 20 Jan 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925638; cv=none; b=ga1yeDA+zxsFMKfTnvLENEgki4M2CTSVERnrc6Gbvw5qDG6Bwm0DT6jYn/XGvkY7hHue916rL3kQXZ2oiRHpWEPS1cHvoCEDPX7eh6DWBy75i+r9OGdNMgJ6E0oY8KVq64ds8cXN7le2Kuf1mwgOplgULha5L45MWojuWm3eZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925638; c=relaxed/simple;
	bh=xsjjUWsrEHOLFWe2BoC5SLfeDNDK/qtujNgUgM+Xs9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXP8DYDnUscuJFwX0e1klAd62oiBui3bJ0iV3SOHLnW2nI357KCkgrX6DXEGa3QLK+arIsLKkxD4zKfPA2G8EzRnyu/ggMJT+SZNJgAt84590beQa4aNkZ6FMBf5J1rt5RkdJBE7ENS2GQ8iQ+6BS0lPN/W2R3pVGH7YFK/lSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=F5fTmeb0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id D96D220B716A;
	Tue, 20 Jan 2026 08:13:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D96D220B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768925636;
	bh=/Swnp5UxzGM1E07wXoCWuTUm5dNDFNjqw04IYItUiZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5fTmeb0PykDmukATKeznivsbr5F+tiwHrBIXbSukB7u/I8XQMQr07lyn7T8HB+DC
	 0Yu6Td8AvHMQu5KoktaRBGfu3OEDheGEkU1Sw9HqaN9f/pkYRdAt2lb4gKNw70hudj
	 Z1+JJSU7NLIBgTC0La4WehEREThNXf/D1ERTikfY=
Date: Tue, 20 Jan 2026 08:13:55 -0800
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
Subject: Re: [PATCH v0 07/15] mshv: Add ioctl support for MSHV-VFIO bridge
 device
Message-ID: <aW-pw7GlQdFv-lf5@skinsburskii.localdomain>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-8-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120064230.3602565-8-mrathor@linux.microsoft.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-15897-lists,linux-arch=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: C75344881C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 10:42:22PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> Add ioctl support for creating MSHV devices for a paritition. At
> present only VFIO device types are supported, but more could be
> added. At a high level, a partition ioctl to create device verifies
> it is of type VFIO and does some setup for bridge code in mshv_vfio.c.
> Adapted from KVM device ioctls.
> 
> Credits: Original author: Wei Liu <wei.liu@kernel.org>
> NB: Slightly modified from the original version.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c | 126 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 83c7bad269a0..27313419828d 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1551,6 +1551,129 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
>  	return ret;
>  }
>  
> +static long mshv_device_attr_ioctl(struct mshv_device *mshv_dev, int cmd,
> +				   ulong uarg)
> +{
> +	struct mshv_device_attr attr;
> +	const struct mshv_device_ops *devops = mshv_dev->device_ops;
> +
> +	if (copy_from_user(&attr, (void __user *)uarg, sizeof(attr)))
> +		return -EFAULT;
> +
> +	switch (cmd) {
> +	case MSHV_SET_DEVICE_ATTR:
> +		if (devops->device_set_attr)
> +			return devops->device_set_attr(mshv_dev, &attr);
> +		break;
> +	case MSHV_HAS_DEVICE_ATTR:
> +		if (devops->device_has_attr)
> +			return devops->device_has_attr(mshv_dev, &attr);
> +		break;
> +	}
> +
> +	return -EPERM;
> +}
> +
> +static long mshv_device_fop_ioctl(struct file *filp, unsigned int cmd,
> +				  ulong uarg)
> +{
> +	struct mshv_device *mshv_dev = filp->private_data;
> +
> +	switch (cmd) {
> +	case MSHV_SET_DEVICE_ATTR:
> +	case MSHV_HAS_DEVICE_ATTR:
> +		return mshv_device_attr_ioctl(mshv_dev, cmd, uarg);
> +	}
> +
> +	return -ENOTTY;
> +}
> +
> +static int mshv_device_fop_release(struct inode *inode, struct file *filp)
> +{
> +	struct mshv_device *mshv_dev = filp->private_data;
> +	struct mshv_partition *partition = mshv_dev->device_pt;
> +
> +	if (mshv_dev->device_ops->device_release) {
> +		mutex_lock(&partition->pt_mutex);
> +		hlist_del(&mshv_dev->device_ptnode);
> +		mshv_dev->device_ops->device_release(mshv_dev);
> +		mutex_unlock(&partition->pt_mutex);
> +	}
> +
> +	mshv_partition_put(partition);
> +	return 0;
> +}
> +
> +static const struct file_operations mshv_device_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = mshv_device_fop_ioctl,
> +	.release = mshv_device_fop_release,
> +};
> +
> +long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
> +					void __user *uarg)
> +{
> +	long rc;
> +	struct mshv_create_device devargk;
> +	struct mshv_device *mshv_dev;
> +	const struct mshv_device_ops *vfio_ops;
> +	int type;
> +
> +	if (copy_from_user(&devargk, uarg, sizeof(devargk))) {
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +
> +	/* At present, only VFIO is supported */
> +	if (devargk.type != MSHV_DEV_TYPE_VFIO) {
> +		rc = -ENODEV;
> +		goto out;
> +	}
> +
> +	if (devargk.flags & MSHV_CREATE_DEVICE_TEST) {
> +		rc = 0;
> +		goto out;
> +	}
> +
> +	mshv_dev = kzalloc(sizeof(*mshv_dev), GFP_KERNEL_ACCOUNT);
> +	if (mshv_dev == NULL) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	vfio_ops = &mshv_vfio_device_ops;
> +	mshv_dev->device_ops = vfio_ops;
> +	mshv_dev->device_pt = partition;
> +
> +	rc = vfio_ops->device_create(mshv_dev, type);
> +	if (rc < 0) {
> +		kfree(mshv_dev);
> +		goto out;
> +	}
> +
> +	hlist_add_head(&mshv_dev->device_ptnode, &partition->pt_devices);
> +
> +	mshv_partition_get(partition);
> +	rc = anon_inode_getfd(vfio_ops->device_name, &mshv_device_fops,
> +			      mshv_dev, O_RDWR | O_CLOEXEC);
> +	if (rc < 0) {
> +		mshv_partition_put(partition);
> +		hlist_del(&mshv_dev->device_ptnode);
> +		vfio_ops->device_release(mshv_dev);
> +		goto out;
> +	}
> +
> +	devargk.fd = rc;
> +	rc = 0;
> +
> +	if (copy_to_user(uarg, &devargk, sizeof(devargk))) {

Shouldn't the partition be put here?

Thanks,
Stanislav

> +		rc = -EFAULT;
> +		goto out;
> +	}
> +out:
> +	return rc;
> +}
> +
>  static long
>  mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  {
> @@ -1587,6 +1710,9 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  	case MSHV_ROOT_HVCALL:
>  		ret = mshv_ioctl_passthru_hvcall(partition, true, uarg);
>  		break;
> +	case MSHV_CREATE_DEVICE:
> +		ret = mshv_partition_ioctl_create_device(partition, uarg);
> +		break;
>  	default:
>  		ret = -ENOTTY;
>  	}
> -- 
> 2.51.2.vfs.0.1
> 

