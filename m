Return-Path: <linux-arch+bounces-13812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E81B1BAECFA
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 01:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0A1942100
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 23:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09782D23BC;
	Tue, 30 Sep 2025 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djGOmCxz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857972D2397;
	Tue, 30 Sep 2025 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276629; cv=none; b=WdSmZZkEIyZx/5tyxFBKiwko48/Bi0sB9uylicM7Z1NFOtb+zRY0daf1Hw7Ya/WAjuG4rHn9uNypOPqHJc0+kAIW3F9r/vctUPQfj4JnRwEAa69Y7lRBqqXl7I8F/W7DwDbB+cL+PM/wGq13CgX1ihMY+PH6k+1Gnc8wgNYLdmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276629; c=relaxed/simple;
	bh=OBKvZVqMt11LmTPFDfHF+9VmRuyfhuvsdZDN4FvWrQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvEkdrdrBn0YQpLzMPBO3CAUxKNaIETvIcMXt21fk1mCe7RiFEWDSK27OgIan+V0U8gNASRvRMS7J/CK1Gmyz9tmZNp9yb1/aegEYBXpAe9LNNTyLRzk5VkzU8P9NL5qmQHM+8rHZBC6apz/VXgVy8xPB4Pa5SLvQRNpm6tWLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djGOmCxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7727EC4CEF0;
	Tue, 30 Sep 2025 23:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276629;
	bh=OBKvZVqMt11LmTPFDfHF+9VmRuyfhuvsdZDN4FvWrQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djGOmCxzirz8fo5frCB3tJ/H1lE0+oOt4d4vKcleLbyVtEgYgAfZHmvjx3YBqPX++
	 W1uiMUEkTmPDnNOPYvgwsalRTa11zy+I9CZPClvxnLnrbPqWqi/Gwf5ABGiY731IlC
	 Q7q8fPHynKo/dNaM9gtjvTRCpxQ2MCK6iCjOkZq68O9sAitbuUZOwNGCL9WJIT2kJ8
	 L6Tjk7L6UXYNIpNZKH4NaXDNONxpplFdJVCc5n5zIGdqh2UI0V9KDKubS3Dr8U4c/e
	 WCLc5e8hVWAAZqw5rqTNu2mz5dJukUkoK4GX7WG4Khud9IHWx2s67uBFzuGGIDoqqe
	 lQD8tIr/OLTag==
Date: Tue, 30 Sep 2025 23:57:07 +0000
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
Subject: Re: [PATCH v1 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Message-ID: <aNxuU6VI3dQVPYF7@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250906010952.2145389-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906010952.2145389-1-mrathor@linux.microsoft.com>

On Fri, Sep 05, 2025 at 06:09:50PM -0700, Mukesh Rathor wrote:
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
> V1:
>  o Change subject from hyper-v to "Drivers: hv:"
>  o Rewrite commit messages paying attention to VMBus and not vmbus
>  o Change some wordings in Kconfig
>  o Make new VMBUS config option default to HYPERV option for a smoother
>    transition
> 
> Mukesh Rathor (2):
>   Driver: hv: Add CONFIG_HYPERV_VMBUS option
>   Drivers: hv: Make CONFIG_HYPERV bool
> 

Applied. Thanks.

