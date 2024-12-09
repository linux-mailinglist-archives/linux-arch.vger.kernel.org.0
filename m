Return-Path: <linux-arch+bounces-9312-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3940E9E889D
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 01:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227FF163B3B
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 00:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139A928EA;
	Mon,  9 Dec 2024 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXF9NPn9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF819A;
	Mon,  9 Dec 2024 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733702759; cv=none; b=kJoSIN6jyKo3rqmpk43AN7pXMXgkUz9ENlC8Q+/QVlLWPnqO6bkQU8NU1UrYwmbo8/wH//uu50vbOkxwzdv2hdrBE9WXh1Ju5qdy2G2w/1nOPfenLEnfUBfC/seKq11IKcgfNvKZYTk6hsSGqxnT5iTc0GEpDq3aRFt26Fa2GgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733702759; c=relaxed/simple;
	bh=KOSE2+0IJQr/pu3UWE4qE1sa7hIxtXcxZxP8jtFM2qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O44FhUi3NBsGKpbYlXx+pMb/lC4bcqmu2NkHl1E1415n925OZKLKz2PTWEa3q1W4hSb2RRPnfv0+V5w//nM+diDtFXIm4aghEC0NJMP5P66+5sd/OP+SRvSLc0cVtLTc/0IwPYroVlXijaJXbNthQEqpSFPDBWVmRxCoN+pgZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXF9NPn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F2CC4CED2;
	Mon,  9 Dec 2024 00:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733702758;
	bh=KOSE2+0IJQr/pu3UWE4qE1sa7hIxtXcxZxP8jtFM2qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXF9NPn9POFP50emVFrAtfIHqq4k8Ait3jzAckDzNP4bGmUk6T8lv6B0EIk7fxs1U
	 u7pjIv1BdHmbkxLaCyDrqJ4fAw2qD+sefOnHMs79XCU1/ccDaVEsY8F86kazyBJr6M
	 PjJunvWrVykhl/mhPfkYR2UxjUex+regGgNhtDqxdKH+urlUjGi4XqeldagYnbQSxW
	 lSxM+nTE2m+KYy1gibCaV6aXWA2i8NfGqXbAcVKwqmjgyBrs7oKccYOETeAQKZYlwH
	 3qilQ0Q/zFmyj3DBqfn5svbmu/EaZbdsza73DiOz60mE4GWluNMmHLT061A3r4GXK8
	 TI1wK055FK+iQ==
Date: Mon, 9 Dec 2024 00:05:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
	decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	sgarzare@redhat.com, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com, vkuznets@redhat.com,
	ssengar@linux.microsoft.com, apais@linux.microsoft.com,
	eahariha@linux.microsoft.com, horms@kernel.org
Subject: Re: [PATCH v3 0/5] Introduce new headers for Hyper-V
Message-ID: <Z1Y0ZB0J16oeHBbK@liuwe-devbox-debian-v2>
References: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>

On Mon, Nov 25, 2024 at 03:24:39PM -0800, Nuno Das Neves wrote:
> To support Linux as root partition[1] on Hyper-V many new definitions
> are required.
> 
> The plan going forward is to directly import definitions from
> Hyper-V code without waiting for them to land in the TLFS document.
> This is a quicker and more maintainable way to import definitions,
> and is a step toward the eventual goal of exporting the headers
> directly from Hyper-V for use in Linux.
> 
> This patch series introduces new headers (hvhdk.h, hvgdk.h, etc,
> see patch #3) derived directly from Hyper-V code. hyperv-tlfs.h is
> replaced with hvhdk.h (which includes the other new headers)
> everywhere.
> 
> No functional change is expected.
> 
> Summary:
> Patch 1-2: Minor cleanup patches
> Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
> Patch 4: Switch to the new headers
> Patch 5: Delete hyperv-tlfs.h files
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Applied to hyperv-next. Thanks.

