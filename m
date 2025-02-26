Return-Path: <linux-arch+bounces-10406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94597A46F67
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C08F3AD453
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1FB25DAFF;
	Wed, 26 Feb 2025 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cbI0KQsE"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629A92702A5;
	Wed, 26 Feb 2025 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740612425; cv=none; b=ujwEuV1pQvS/SkwgE9iWhFcEX3FZug9V4BhXSlPtISbSuWRjlrnDlcBn+qaDEmeb4gCxsTIfngibFTySdYrwtK/hrtzZR0IceQLaH8h1UgghelP9I0i0tUfHQiA1+Kb7fRSCWLeu3AX2qxUJNhGMQ6BZ+mzPwc6ykiUniJzNqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740612425; c=relaxed/simple;
	bh=z+ZM1dM9yW1d6s6hW0zeKaV9BbhLpXCJUNu9m7kJndo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSYsDNTO2tq46oFmT0ryH7RuDxAxNAjeQ6zEMiQoMSyO4uuQUhYXnJ5+pe04IIYbrn62jzcxoRB+fTsuAMtlrxXA2X3cvsRFg6L4er285k1flG0Cwh4Zy4gcHOIjrYiA7lvPE8PdEUqr2t5bLO3x3sHd9JtUqzsBtgQ5HuT9mzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cbI0KQsE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC33C210EACD;
	Wed, 26 Feb 2025 15:27:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC33C210EACD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740612424;
	bh=7lHMws1Z1gT8osFbNr/ifk0g3X6AfrrHIOGRFkPcVcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbI0KQsELJKepq9/o/2xxN8OIDClMvCwA1i5LbFoimxlZ2tF92fgjUX30efR9NQWD
	 /TWf9hUkilLCn2PdeUwnWr7zE9I9Cc4gU50NkfKdXo9dbrAku841jUkwRWmZ8qbgCy
	 YrK4NjKN4l6/h+fvv0o4Gwb6vJwMp8BYsu9kw8MY=
Date: Wed, 26 Feb 2025 15:27:01 -0800
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
Subject: Re: [PATCH v5 02/10] x86/mshyperv: Add support for extended Hyper-V
 features
Message-ID: <Z7-jRek8DsTY-hCk@skinsburskii.>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Feb 26, 2025 at 03:07:56PM -0800, Nuno Das Neves wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
> Extend the "ms_hyperv_info" structure to include a new field,
> "ext_features", for capturing extended Hyper-V features.
> Update the "ms_hyperv_init_platform" function to retrieve these features
> using the cpuid instruction and include them in the informational output.
> 

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

