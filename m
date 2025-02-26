Return-Path: <linux-arch+bounces-10410-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA52A46F7B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EE4188D473
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274120E32A;
	Wed, 26 Feb 2025 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d8bNHDOi"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464BE217667;
	Wed, 26 Feb 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612770; cv=none; b=TjQe+T06zWARf3j+47YM41nclZwstu19chWU1YwWM+wUvS1gBKN9fHTG6pkvIZ8cf8vhI1ZnL1ft1WIC8JgNGiLbztfWdfCfvxq2Ajdm47se5+T72fxuzc8J8g6iL6679lwhSpejXQXvN2AX/qDlKt4w2KuWK2u1IrfViIPFrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612770; c=relaxed/simple;
	bh=bh7f0dYdsZzBaHum1wV2hy0VFCZvaqSQOizZ5NKFsHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv6AHXrdGLSSE2iQDKtow1TpFIQ529vPDMnuNnVZr6zcyjcUGF81YXxTwPn3azPV6WpOmqXukL/UvDU1YtDCZdPIOkfuu+jmvrpewbp1bj6oR9NqEYt1pBmuJI33e6jJSNvebuSsVvwWdpKlGmpExeW+qfOHv/GVh7PJnz/UkaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d8bNHDOi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 223BD210EACA;
	Wed, 26 Feb 2025 15:32:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 223BD210EACA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740612768;
	bh=UEoVyBpUX3lFNfnp2cCHlhOnrwe2QxwgEqIvC2X/3iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8bNHDOiYxdhtkrKYYPEHNFQaugrm+RMCXnNNSdB2RRQ/3V5aZ3xAM0koem6RCFog
	 XFnYZAwbK6QiyU9Vz7GUQsFS6+VK8cfImWj+EAswlp23akzSKX+WKDelQ3BKFQAL1F
	 aBaVrx3PzGTFxsRWJxIicYnnv4RjcyTmGvoHGjrw=
Date: Wed, 26 Feb 2025 15:32:45 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
	gregkh@linuxfoundation.org, vkuznets@redhat.com,
	prapal@linux.microsoft.com, muislam@microsoft.com,
	anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v5 06/10] Drivers/hv: Export some functions for use by
 root partition module
Message-ID: <Z7-knarBxqxRIqVE@skinsburskii.>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Feb 26, 2025 at 03:08:00PM -0800, Nuno Das Neves wrote:
> get_hypervisor_version, hv_call_deposit_pages, hv_call_create_vp,
> hv_call_deposit_pages, and hv_call_create_vp are all needed in module
> with CONFIG_MSHV_ROOT=m.
> 

Reviewed-by: Stanislav Kinsburskii <skinsburskii@microsoft.linux.com>

