Return-Path: <linux-arch+bounces-13396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AD9B46B84
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08D1172346
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 11:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076D2857DE;
	Sat,  6 Sep 2025 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0aS3Hmnx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411AE1F4262;
	Sat,  6 Sep 2025 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757158593; cv=none; b=qque5uN4GLkhcTtSnnFrdmA7B4w+lUfk1apkskN1UBzkicfOlsOroIFegETJCnrPF4dWZQqJtcUdXEBOkxSE+NEW2KUvQwJXQqsrfDDKCZFve9MBEhgty1RRXKmedROAdtajGYXemjxW7aFN1mhT5qxi86XNMuAi9t2MjNQj+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757158593; c=relaxed/simple;
	bh=uk14O7Fz7KUhWd0Sz/kWIAmHtwPD3Rvd0igyAAMEZO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyaWNEbUCywTiBc0slJ282jhn0JaEAqhjuHUb/pGiiKB9OEcXEo8890WsianK/SuUSh1n+mpUtnCTOqWlkngkbzYKTU3Bkx7TU5Zza3cq0HNoSz1NCmPRKwCTpS6rNtTMSR72Fev7DBgncAJPwRsDsPNZSr7qZVdapUYHPIyp1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0aS3Hmnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D48BC4CEE7;
	Sat,  6 Sep 2025 11:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757158592;
	bh=uk14O7Fz7KUhWd0Sz/kWIAmHtwPD3Rvd0igyAAMEZO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0aS3Hmnx1CryU2e8d8QkOVtY86s28a5CJwX3iD4L/zCnvZ3VRSZioBEsT1D5SGC2n
	 qlGxzX7lagXQMgx99wPQaX+CwbKjWV9JJmFzHhstRlca5J9tPne/uDFASjxrfCGThb
	 s7V98zzqhWdiq67ZCxiWvHf4MLO/UF2F4FkmihIA=
Date: Sat, 6 Sep 2025 13:36:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
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
	deller@gmx.de, arnd@arndb.de, sgarzare@redhat.com, horms@kernel.org
Subject: Re: [PATCH v1 2/2] Drivers: hv: Make CONFIG_HYPERV bool
Message-ID: <2025090621-rumble-cost-2c0d@gregkh>
References: <20250906010952.2145389-1-mrathor@linux.microsoft.com>
 <20250906010952.2145389-3-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906010952.2145389-3-mrathor@linux.microsoft.com>

On Fri, Sep 05, 2025 at 06:09:52PM -0700, Mukesh Rathor wrote:
> With CONFIG_HYPERV and CONFIG_HYPERV_VMBUS separated, change CONFIG_HYPERV
> to bool from tristate. CONFIG_HYPERV now becomes the core Hyper-V
> hypervisor support, such as hypercalls, clocks/timers, Confidential
> Computing setup, PCI passthru, etc. that doesn't involve VMBus or VMBus
> devices.

But why are you making it so that this can not be a module anymore?  You
are now forcing ALL Linux distro users to always have this code in their
system, despite not ever using the feature.  That feels like a waste to
me.

What is preventing this from staying as a module?  Why must you always
have this code loaded at all times for everyone?

thanks,

greg k-h

