Return-Path: <linux-arch+bounces-5033-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83F914338
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2024 09:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907D11F23D6E
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2024 07:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792443A27E;
	Mon, 24 Jun 2024 07:11:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118E10A1F;
	Mon, 24 Jun 2024 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213072; cv=none; b=t9GPksa7plcrdTcde/LGzZpRGo1jU9XowfXr7EGduwIAxYmgy5HiH3UuLH2GMbTqcWFTpAzINorhKiHqNvy8FTJKaHV0of5fF6OemCFJv6NV2aeEVAs98LUq6ZXTKfK80x788BuqFsNwKvg1Sl5C8EGxNvDYH8Y4PaeSW0+ZMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213072; c=relaxed/simple;
	bh=da3yW6IGcQdP/JdAObJo6wD31YwvBnEWMZ/rCsEf4aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr5nDGtkfnSboJsuWzzfprcNIDBAslxU3HpXyIS85fL1gMg5m5d6KafrH6Te7HQTMwbNlm2aME4tKwqvDqwqZFK3j69PpNtc4L7RlfmOfQVAF7XX6QoGpFJQhpEps2Jpl8yiVuLG/cRWh4BXnDpkaW5drBl3G2pgitxfqeHKiCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b970a97e8eso2188494eaf.1;
        Mon, 24 Jun 2024 00:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719213070; x=1719817870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+m1qAHHe+u/l9Nh8Xj3tn5sz48OYqrvi4KHgsVzEBeY=;
        b=GJvi4b3BU79gETdtssaFCrBzeMhAUHeF0/16JC0+f41Jt8vmJAATDUSLrK7gBEOfsn
         l8hNcUS2klsusBCTh2NmXvG1SW52AWBen5ckB8F+Q4xQlFbY42yMhh9HSMfzSZ2cMnG6
         EqsQqRiNZu6mbAbAZjnoX1aTz8uUVkMpwMWZCt8MNryDcndYarctOntnDluqw9L27CR8
         6zZ3PDn1IkEBoxapwHPZjdhLxUtBicMj80VrjyL39uOq5DppOdNRVFGKS2glcObYfZuy
         X+H00ce3thEyZhy3uoB4IPfIggEnWfcfPWuaQN+noSFqGsxODqfu3EwMb1wVaB9flCuy
         DnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVslUogk2I6bsl9VWVNoOcGIMC1guijeJ0vsrPg610GlvFtMMEK0Vr52ctVYfAuyBTtfGHx6pRG3svtvwYEprXuDZ9Cd6WVNBgfJKnL7iqLmEzSViNiJaL/Fe9zcZlbIMX5sPSkBZbmsFxLq21FuiuOGp5t1aLMGafhC+EzefZd5TkV8hBvvblefK4eGMZ2GWUNIveuJ3CZlZCfHBMoFGlWGrVeVOnj+3/CBrArRM+Psh3nZ1tEyiOruE2yqqk=
X-Gm-Message-State: AOJu0YxPRC/0kaz/1pyyYjfNhQdxb3QHhHgKmO9nIKNobtYqHJNEsq1e
	OqS2maINKwpL9+F3ukKVs8p8BHCS3jfEuOdRYZmRotpFP4Nv9FOX
X-Google-Smtp-Source: AGHT+IGp6uemBxlBEej/6H4CeVewwQxfQEG8wLfSX9/mkoKTbXgiHx9LATxLWNYemiAMrCpQQPUaBA==
X-Received: by 2002:a05:6358:599b:b0:19f:4476:3cc0 with SMTP id e5c5f4694b2df-1a23c055a1amr572517955d.12.1719213069944;
        Mon, 24 Jun 2024 00:11:09 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb22e148sm4865999a12.85.2024.06.24.00.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 00:11:09 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:11:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, James.Bottomley@hansenpartnership.com,
	martin.petersen@oracle.com, arnd@arndb.de,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-arch@vger.kernel.org, maz@kernel.org, den@valinux.co.jp,
	jgowans@amazon.com, dawei.li@shingroup.cn
Subject: Re: [RFC 01/12] Drivers: hv: vmbus: Drop unsupported VMBus devices
 earlier
Message-ID: <ZnkcBivQwrCEmcK_@liuwe-devbox-debian-v2>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-2-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604050940.859909-2-mhklinux@outlook.com>

On Mon, Jun 03, 2024 at 10:09:29PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Because Hyper-V doesn't know ahead-of-time what operating system will be
> running in a guest VM, it may offer to Linux guests VMBus devices that are
> intended for use only in Windows guests. Currently in Linux, VMBus
> channels are created for these devices, and they are processed by
> vmbus_device_register(). While nothing further happens because no matching
> driver is found, the channel continues to exist.
> 
> To avoid having the spurious channel, drop such devices immediately in
> vmbus_onoffer(), based on identifying the device in the
> vmbus_unsupported_devs table. If Hyper-V should issue a rescind request
> for the device, no matching channel will be found and the rescind will
> also be ignored.
> 
> Since unsupported devices are dropped early, the check for unsupported
> devices in hv_get_dev_type() is redundant. Remove it.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

