Return-Path: <linux-arch+bounces-13814-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CF7BAED61
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB1C1944206
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 00:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7F1DFFC;
	Wed,  1 Oct 2025 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksftohVl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE013FFD;
	Wed,  1 Oct 2025 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276919; cv=none; b=Sbx/1SU7bfbYt+FsrWdigQVFB4FbSc/bAsKFos7vIvPG+htAGRzuoMZ6FWbBuetVjrmY6stW8NB24oegcL6LVCrT80fpejKi5YvcPlfXa8XYHaMbL65gUYUFNGlzGqVQoSIZj4tS4zIvdJNQyXzyJQEgwfHXglaLHX+4vbaACOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276919; c=relaxed/simple;
	bh=3y68Tqy6cDtlcmDOr/T5Y/n7dmVkzFZcMAywC6/1zAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaBGHTp7aQTCowQILQrKUthgKsb+dZq0RdRYGHcEXJ75xsenpVtp82yFcM3Hi6abzCwdLxoqCciIThj6v6zRFn4fRVQsKQjX6Hjd2V7IeuND7jvlAa6x7JSXShrmCyTveslUX0mehI9ISF6IVg2VXoARRc8xdBD3aUsEj9O4B1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksftohVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD063C113D0;
	Wed,  1 Oct 2025 00:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276919;
	bh=3y68Tqy6cDtlcmDOr/T5Y/n7dmVkzFZcMAywC6/1zAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ksftohVl2Qo0dLrp1wRNv9/74o1Fs7lEIRefjQh7LKdfvCLUMg9xMh1ELfqzluFRi
	 qsENQ2370Fzn0agVtBXxyPDE3Zb0sknD/K0DnzraIyszsT6PwomnKkQVAFjZB4RAbG
	 f0WWr3hw8EZlihgHXFMr0EcrJSfUQrxCKSLiFBM50iwiryha4eDBX7cC0c0u4Smb+M
	 g2mg5N2i+VED0wcsKCG+/wkoMwOSkZQjyWXNVov94eNZKaWnpLYE8vrXVaoWH1SYZW
	 HqweboEtW61q7LNtIDeEt4mfkkga0AiDYtNv35UcHtsD6HOfCp7xR5t4D4klBB4W7W
	 2DaB5l93yFmFw==
Date: Wed, 1 Oct 2025 00:01:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-arch@vger.kernel.org, virtualization@lists.linux.dev,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	jikos@kernel.org, bentiss@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	dmitry.torokhov@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bhelgaas@google.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	gregkh@linuxfoundation.org, deller@gmx.de, arnd@arndb.de,
	sgarzare@redhat.com, horms@kernel.org
Subject: Re: [PATCH v2 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Message-ID: <aNxvde1KTtLeZEKy@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250915234604.3256611-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915234604.3256611-1-mrathor@linux.microsoft.com>

On Mon, Sep 15, 2025 at 04:46:02PM -0700, Mukesh Rathor wrote:
> At present, drivers/Makefile will subst =m to =y for CONFIG_HYPERV
> for hv subdir. Also, drivers/hv/Makefile replaces =m to =y to build in
> hv_common.c that is needed for the drivers. Moreover, vmbus driver is
> built if CONFIG_HYPER is set, either loadable or builtin.
> 
> This is not a good approach. CONFIG_HYPERV is really an umbrella
> config that encompasses builtin code and various other things and not
> a dedicated config option for VMBus. VMBus should really have a config
> option just like CONFIG_HYPERV_BALLOON etc. This small series introduces
> CONFIG_HYPERV_VMBUS to build VMBus driver and make that distinction
> explicit. With that CONFIG_HYPERV could be changed to bool.
> 
> For now, hv_common.c is left as is to reduce conflicts for upcoming
> patches, but once merges are mostly done, that and some others should
> be moved to virt/hyperv directory.
> 
> V2:
>  o rebased on hyper-next: commit 553d825fb2f0 
>         ("x86/hyperv: Switch to msi_create_parent_irq_domain()")
> 
> V1:
>  o Change subject from hyper-v to "Drivers: hv:"
>  o Rewrite commit messages paying attention to VMBus and not vmbus
>  o Change some wordings in Kconfig
>  o Make new VMBUS config option default to HYPERV option for a smoother
>    transition
> 
> Mukesh Rathor (2):
>   Driver: hv: Add CONFIG_HYPERV_VMBUS option

I changed Driver to Drivers and applied both patches. Thanks.

