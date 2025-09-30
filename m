Return-Path: <linux-arch+bounces-13809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA81BAEA4B
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 00:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6293200E0
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F229627A469;
	Tue, 30 Sep 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6FGlfXY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD3919C540;
	Tue, 30 Sep 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759269914; cv=none; b=bOUtRcNKzC5j/wuFBfD76/jI1dZMKUIYFIxIjLQy2O3SCZ5OJmUB4X6WxhqPz9Em/LwRqCXEu0CWIzsKGGIg4PfdpHOstjrv1hy97PbLUqj6zczZRo0f7fUYVAUweboKBB8TABm/tHFodWdFA91hfgESIb9ZrS/lzLBrJSMEll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759269914; c=relaxed/simple;
	bh=CR+oDBlxH+wJG2IaTz6xx9ORxqdao+j6vCNUPR5fcqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1MA9QyARRgjg9mLjAqlEU+sD4HmsIDd9622u1XQ/oHrc/6CXcoLXgm2eLic/Rdig1On1wEMsVKLLu71Nj9oUa1QP7DPH7HCjgYhSA+7qIy+9+9FQn181F2yTdHyA3UTG9BGSDhp03BJuOc6aBKwxMoG3yfEwqAY3KLEjNRT1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6FGlfXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77F9C4CEF0;
	Tue, 30 Sep 2025 22:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759269914;
	bh=CR+oDBlxH+wJG2IaTz6xx9ORxqdao+j6vCNUPR5fcqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6FGlfXYVPrw+RIVXIQV2hF66+/z8rW9HJJQ7jXRju3ek7X4ydhic/wFCE2Zc+hbX
	 Kvd4jWlup0zuTMibWUdcl4Utmypg5Ppr6nW+rengren7rUOB9pJBPxNjND0otGxQ8a
	 51fKSZyEQjhPrQDxkuI6RGiyL8MA5cLfzecAj/Q5flYt49dAwUEewUE0PTGbUiQq9w
	 iFEVhsyvWkU81EimfpkRXPk1OmfXekxoYuX/xZdOP1xxu97OrmQ/vf7wBZkT746aNF
	 uelHffQGkf2aCeCG5obUOkR9925uv3IxbG8wLO4If25xCjLLtPKyKg/o7jY0od3wUo
	 H5vvqlknYfAfw==
Date: Tue, 30 Sep 2025 22:05:12 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, dmitry.torokhov@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bhelgaas@google.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	deller@gmx.de, arnd@arndb.de, sgarzare@redhat.com, horms@kernel.org
Subject: Re: [PATCH v1 2/2] Drivers: hv: Make CONFIG_HYPERV bool
Message-ID: <aNxUGNmRyPCzyUCb@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250906010952.2145389-1-mrathor@linux.microsoft.com>
 <20250906010952.2145389-3-mrathor@linux.microsoft.com>
 <2025090621-rumble-cost-2c0d@gregkh>
 <d7d7b23f-eaea-2dbc-9c9d-4bee082f6fe7@linux.microsoft.com>
 <2025091253-overwrite-carol-b197@gregkh>
 <a8c8305c-b518-c840-fc64-50bcba302725@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c8305c-b518-c840-fc64-50bcba302725@linux.microsoft.com>

On Fri, Sep 12, 2025 at 11:10:00AM -0700, Mukesh R wrote:
[...]
> > What was it made against?
> > 
> 
> Sorry to hear that. It was built against hyper-next, but perhaps I 
> accidentally used our internal mirror. Let me rebase and send V2
> right away.

Sorry for the late reply -- I was away for two weeks. I can pick this
series up.

Greg, feel free to ignore this series.

Wei

> 
> Thanks,
> -Mukesh
> 
> 
> 

