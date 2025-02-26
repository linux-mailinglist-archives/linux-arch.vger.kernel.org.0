Return-Path: <linux-arch+bounces-10407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD32A46F6E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7646D188D26E
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3C325F7BF;
	Wed, 26 Feb 2025 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Puut8yLr"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9236E25F795;
	Wed, 26 Feb 2025 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612483; cv=none; b=VBNlYuw0Q3NMAbY/3uwItXaaVcvOqO8Vn/AhCtrRHBzIRWAl/6gzbnE5Z2PghctCWkQ7npGPy8st+aPP4lFo2gz6pMmwdJ5DQ+drUlTMSt2JQOYsxOPrQAsHIV8qD16a7/bVCrWOBAoBs7aS0YpOv3lXK9UL1YtIeNErS72vt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612483; c=relaxed/simple;
	bh=kg31cKikw8zTiM+1cxaZ6Fp3Lf7n3oRt19kfWIUot9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYhC/4ZaZHzeJbBq5sgM1pXZcvQip4mYaX6AThiNtmQ8ImCqOf7j7Dv0zv7R+Dv8MgIxXGlWuNGzpwqAVmeVSV6rxnIv9HbrlNqjtynUQU51D4odJZ9s8vlxj5uBHfoP3lQLgKUyQreIMhy2eNv9mKCnYhLRdNG/PVh0cLfi3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Puut8yLr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id C44C9210EAD1;
	Wed, 26 Feb 2025 15:28:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C44C9210EAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740612482;
	bh=RKO/Sj02BRKu9QS9mP6LZJOiDz35IJfzkzc44G0lY1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Puut8yLraneGflDYN4kMgWO58PGttlAenmnKkqXZHmtQkYF8rirkdns9NFXOm+s6S
	 bs/Xo17KAJmoxWthHUXNkyzgvNnP1mrJvAhrL1FiuLciF/UGKBWUFruLv9rFK8m6XL
	 17jSBJvwWiJZ6dN89WkwmizimWNdFxzqv7HtA1rU=
Date: Wed, 26 Feb 2025 15:27:58 -0800
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
Subject: Re: [PATCH v5 03/10] arm64/hyperv: Add some missing functions to
 arm64
Message-ID: <Z7-jfp4E22Tp0cbk@skinsburskii.>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Feb 26, 2025 at 03:07:57PM -0800, Nuno Das Neves wrote:
> These non-nested msr and fast hypercall functions are present in x86,
> but they must be available in both architetures for the root partition
> driver code.
> 

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

