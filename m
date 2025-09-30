Return-Path: <linux-arch+bounces-13813-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E3CBAED30
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 02:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E734A6A13
	for <lists+linux-arch@lfdr.de>; Tue, 30 Sep 2025 23:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38282D29C3;
	Tue, 30 Sep 2025 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+g1Qz7P"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A342D24B8;
	Tue, 30 Sep 2025 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276783; cv=none; b=HUSxo90LXFButQvPSZnQB13zvx1PYkEKVmHInrt5lXiRqzmZMVNkUifEb2nchW/07fNbwvoYU8hRx7y2Lc2OsIYgn25DT00LgCQSYRXhKuy3bjAJIW2lfzBdsBTad2RvbMhZX72KGBGBj8T23T8a0ymfVWByqb3vTWGInMggT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276783; c=relaxed/simple;
	bh=ncijZpP6NU5604g2nU8DsF54hN8uk7Tn6UIiPJv0nGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij1DDP46y1K0RBIGppBFF1RA3YTPmS0Zua5WKh9QabeL6hVIxKHWPd/avetGnGYebaahjy0G+uHlHf7ZHKH7nODKe/aCmAVRB4nugPpmatnLg7zUD4gBF5/sm00/W+xu6wpla4ddSRfrPu/uPTEFNPD44oCW12RAQ7vENJqtd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+g1Qz7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9A6C4CEF0;
	Tue, 30 Sep 2025 23:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276783;
	bh=ncijZpP6NU5604g2nU8DsF54hN8uk7Tn6UIiPJv0nGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+g1Qz7P57iqfb9/sZsBZpoVbhp3zwCW7O6TcmR8FGI8vHYuEHInrxXfnriCTJT2/
	 r/0XSYB8SzQVNPh29PYuyw67q6Mo9OEkrVN8muHkObhmO+wTDmq1MqJcnMV+4qMZUB
	 lIKuTrrrk78y0zkfs+FzvtmIwMd+amqP0+24APxK9PCG9YrB5zO2cRVu759VDC5hsT
	 V4vLnPmkJXcYh917OU09Ddgg7PeCFDePwp3MZwkFGj0okV0XlJ/IbJ9UpyW9zFjgBW
	 VuH6ndwDWAg8G2dSMWEn6aYtuReHETdPZ0Qd0ir8do4vqTlL5Xf4gNQWbZUbsGoaa6
	 mJvlMfGcsqyMA==
Date: Tue, 30 Sep 2025 23:59:41 +0000
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
Message-ID: <aNxu7R6fDWb7Ugh2@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250906010952.2145389-1-mrathor@linux.microsoft.com>
 <aNxuU6VI3dQVPYF7@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNxuU6VI3dQVPYF7@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>

On Tue, Sep 30, 2025 at 11:57:07PM +0000, Wei Liu wrote:
> On Fri, Sep 05, 2025 at 06:09:50PM -0700, Mukesh Rathor wrote:
> > At present, drivers/Makefile will subst =m to =y for CONFIG_HYPERV
> > for hv subdir. Also, drivers/hv/Makefile replaces =m to =y to build in
> > hv_common.c that is needed for the drivers. Moreover, vmbus driver is
> > built if CONFIG_HYPER is set, either loadable or builtin.
> > 
> > This is not a good approach. CONFIG_HYPERV is really an umbrella
> > config that encompasses builtin code and various other things and not
> > a dedicated config option for VMBus. VMBus should really have a config
> > option just like CONFIG_HYPERV_BALLOON etc. This small series introduces
> > CONFIG_HYPERV_VMBUS to build VMBus driver and make that distinction
> > explicit. With that CONFIG_HYPERV could be changed to bool.
> > 
> > For now, hv_common.c is left as is to reduce conflicts for upcoming
> > patches, but once merges are mostly done, that and some others should
> > be moved to virt/hyperv directory.
> > 
> > V1:
> >  o Change subject from hyper-v to "Drivers: hv:"
> >  o Rewrite commit messages paying attention to VMBus and not vmbus
> >  o Change some wordings in Kconfig
> >  o Make new VMBUS config option default to HYPERV option for a smoother
> >    transition
> > 
> > Mukesh Rathor (2):
> >   Driver: hv: Add CONFIG_HYPERV_VMBUS option
> >   Drivers: hv: Make CONFIG_HYPERV bool
> > 
> 
> Applied. Thanks.

I meant to apply v2 of this series. This is sent to the wrong version.
Please ignore.

