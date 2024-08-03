Return-Path: <linux-arch+bounces-5949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64E39466B3
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 03:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C27281A8E
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 01:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553DBAD32;
	Sat,  3 Aug 2024 01:21:40 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62210A14;
	Sat,  3 Aug 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722648100; cv=none; b=JR69QYIbwqu59ciR5Qg6eIMxFNKS6TyEui2xwp4oD82ShCPp+hhXuGImFrXByIKLOJrjyZleizWKi5mmUqLdeXrceZlMF5BeDFlATOHG7LX8c4MRPRbnFz1XbgF5R06giKEyZkZDQ8LnRmzaihLsOYHN4i8RRwi32dTYAqOUqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722648100; c=relaxed/simple;
	bh=KycQ3+kEGHPU98q3ZOCdV7WRyyCfkvyXQ2jrE6NF5Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS3VIkmJwZH7kfPgaSwXnyLQXsMQyo8Trdx+Y6/pktbyIwguVrvQwPcC2dXE85LJ6KmJmisYp32m+IyJQ8JT7gyvZkW8plYAb4vRn3RbeO9QhopGKUS9BU8CDCk2tizIPcpNL3+K59czFKQjGtQj3qG1zLoe0pwx6mSWuoInLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fda7fa60a9so79704145ad.3;
        Fri, 02 Aug 2024 18:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722648098; x=1723252898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuktiP0LsENIHh7HgPVSXvfcRchZYkvk1etK3Fqt9d4=;
        b=EFIeri+B64KPS8/aw10KIJmSyR8roC+0pta4eW+ADApsQrCIZB4l4CYc6H1/zcKWDu
         BFrVjZhHRjK2GLd4C/34ZnUpBs5TqpC/LkGhzhJARdXYYHalQSWuLtBFOCRC4vi7zgAm
         SdqeIH/ERdTyhBIbrQ8alR4nkfu2hwMZgcq9gSm458zRQ9nUbnC+kHZb/ibfKNOA0ER8
         ulT1r5zAcGVEYB9SG8qWmNToKKQl4QrvF4QHwy7MBtk1Fn5cOPRvDHFl+VjTG3b1Z61L
         Squ7r7juCFtkz4bRgAQ2S4TyjgE9XTXuLuIQWdQp7Zmx/03muTLAt5+1yb5jwGipTPOL
         UYOw==
X-Forwarded-Encrypted: i=1; AJvYcCXK0unSBZnd3XiipBFMlV0UzVGzoPRdXyZ/ftPuPFchknxjgP/1elg0XPmO07qHS0LGUlBbrEnHL3htzuzcrv0wqEj67qG/JaK8htBNgZ4edk6ReE7jXn+gQUEUYQm96aSa9/xRK8ormw94zN8U2A+qezIidoSMAhyJwkaGWquiaXCJpqHF/39ZqgKvGNicdvnB4P0BWweS2tzRYx9HMhaIk7y+zPd+ucV+lBhADKitTEfH+uEDzGep8Sx1lgw=
X-Gm-Message-State: AOJu0YwqIiPiprSwn0h2kWuA+gvdpjG3RF8SYjxWXJJN6Tzgm/x9dlT3
	VUlcZbWwbZHqArmUsOQmjSQoZ7JTaQXGgbz3kg7M9Rdyy+CMuRL0
X-Google-Smtp-Source: AGHT+IEpvBHceNYwsDgJw5rXz8VBN8QHc5Bdb38TsHCZWW4iGTvCAj0qQ0mUxG8+FLwU35Zuxcocgg==
X-Received: by 2002:a17:902:ec8d:b0:1f7:123e:2c6f with SMTP id d9443c01a7336-1ff57323889mr68328195ad.37.1722648097906;
        Fri, 02 Aug 2024 18:21:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905ff30sm23364635ad.156.2024.08.02.18.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 18:21:37 -0700 (PDT)
Date: Sat, 3 Aug 2024 01:21:35 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	kw@linux.com, kys@microsoft.com, lenb@kernel.org,
	lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org,
	robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 2/7] Drivers: hv: Enable VTL mode for arm64
Message-ID: <Zq2GH-tbk1SSgP7C@liuwe-devbox-debian-v2>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-3-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726225910.1912537-3-romank@linux.microsoft.com>

On Fri, Jul 26, 2024 at 03:59:05PM -0700, Roman Kisel wrote:
> Kconfig dependencies for arm64 guests on Hyper-V require that be ACPI enabled,
> and limit VTL mode to x86/x64. To enable VTL mode on arm64 as well, update the
> dependencies. Since VTL mode requires DeviceTree instead of ACPI, don’t require
> arm64 guests on Hyper-V to have ACPI.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

