Return-Path: <linux-arch+bounces-10408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFCCA46F72
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E321D188D20C
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CF126036C;
	Wed, 26 Feb 2025 23:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LmqI5Pz0"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8430260366;
	Wed, 26 Feb 2025 23:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612543; cv=none; b=J+sWi8kzjS4e0J+ArETc26/k05sYUGp/JmL2dmy9hbTs15HvqgFNpOeZ1+2xoU6KO1qfc9BV26VMV4srOGzg5sMzZcF/mUsLPgQejxvRBTaZRda6xMFyBpwgPWQMbwY9+JMMy3Im5GnT8FahIG8+2MGaXpHMPWr7AOqMh8K2hss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612543; c=relaxed/simple;
	bh=d2pYkamX+sNsVSy77Flcw37FithVlhiCUh44ftrfCWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXChtZMLHPPtj4BDcp9d9IW5faQEZRVkJtineDzu2NxLtLp2w0C8sMa55RfTBZeWlzZC4Oj28/m/PHEHxX6vC9kOWMqvPyVjjIhGaDX0M2LfhslSSmFlc7rxwxgD6DJmsvxZ27Ej4uc9uOd3IJc0tYtetiuVQh0+ngofkIqKFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LmqI5Pz0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5E4C9210EAD1;
	Wed, 26 Feb 2025 15:29:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E4C9210EAD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740612542;
	bh=Y0SsGMDsIhNDXgsDJppjL0ICttRNdOjHbSPpWqlls1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LmqI5Pz0oEMAIA12UXnqbyiy7Ln7sN8zNhFjlNh1Jd0VqKfr+zNRoK2jESW3nLrrR
	 TdYuwJe6C9jrFV5Mb/9H33kKo5TA0QSCw9d1I3u2qBBv15WghFf/at7PrXMINvnpD/
	 3UXqj/2VmIAoRa0X+9QkCRMIoECSdSGtxXoXjJR4=
Date: Wed, 26 Feb 2025 15:28:59 -0800
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
Subject: Re: [PATCH v5 04/10] hyperv: Introduce hv_recommend_using_aeoi()
Message-ID: <Z7-juyZW4q9PsQ5V@skinsburskii.>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740611284-27506-5-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Feb 26, 2025 at 03:07:58PM -0800, Nuno Das Neves wrote:
> Factor out the check for enabling auto eoi, to be reused in root
> partition code.
> 

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

