Return-Path: <linux-arch+bounces-10128-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C3CA31D4A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 05:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8333A6B97
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFA91DE4D5;
	Wed, 12 Feb 2025 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdsbx6vQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB30271835;
	Wed, 12 Feb 2025 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739333464; cv=none; b=OoyMxhziTpqpsq5UEhVMK2UaLU23q1liDNn5qIy1cYN1uyBjPoM2aIU/97sDcc/qReuc5Qi5meNWkoRaIChFOV12d714pHetjaPHnihUz1nXEpDfam+vL7rWtZhxnn99hUmdvWtYhICACq/mTpWWQz6Azg/YQMvwK5/0ef/vhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739333464; c=relaxed/simple;
	bh=k7vtiKJkTWMbOT4Z1lA+9eriWHA4AQxXpXh6m2Skn5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEcRnricXfSNK4tEUtdNaKt7zF4eYCKi83CnJW4zxtiG2WJTqqJ/L6GHkSE2hlikJQHIhJrmZzvrcugnD1hNLdKWZXgSufkshUWn5spVcUdDV9Zssbe2gHJc4VhKGmCOF2/xUt1tc5HRf7bEaH/KAMwB8vUoduuSLExeHQGCFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mdsbx6vQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58C7C4CEDF;
	Wed, 12 Feb 2025 04:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739333464;
	bh=k7vtiKJkTWMbOT4Z1lA+9eriWHA4AQxXpXh6m2Skn5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mdsbx6vQ5V1ATwNJsubQqPXCS8b/odPRww54GW2qBMKPnIVllZ9OjkvN8pZd+p5s9
	 ebDZ2OC+tyK7I4v/g+4CkJtWI6BApTR1y45rhZiKfyGGfl7ey65/+HWfl6MfQpLQGV
	 kuVxLqQzMQKQ4BoCLXkl8zIAcg4wCuxsnC6B9HOn+mydTAFPemrXFQrL8Bz9Y7FrXx
	 Vn2WdvuWQ04I6iWlB1K8sBftAGRuwKPWjGaOO2sLR09OOuQdzDV+6Rtl27uDgg0CoY
	 dlGM23iqM8M7WkDxb6rf76dJgr1n0na1a4kV+sQlBLTN6hxwq6jPL0PlcUoy/+Et8O
	 dHlQfCz4sNPng==
Date: Wed, 12 Feb 2025 04:11:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
	jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com
Subject: Re: [PATCH v3 2/2] hyperv: Move arch/x86/hyperv/hv_proc.c to
 drivers/hv
Message-ID: <Z6wfVl89EioBB8ou@liuwe-devbox-debian-v2>
References: <1738955002-20821-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1738955002-20821-3-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1738955002-20821-3-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Feb 07, 2025 at 11:03:22AM -0800, Nuno Das Neves wrote:
> These helpers are not specific to x86_64 and will be needed by common code.
> Remove some unnecessary #includes.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

One comment about the ordering of the tag. You should order them in
chronological order in the future, so the "Reviewed-by" should be after
your SoB.

Thanks,
Wei.

