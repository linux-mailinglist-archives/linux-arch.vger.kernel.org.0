Return-Path: <linux-arch+bounces-13164-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17963B25687
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 00:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40703A4248
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 22:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C520302757;
	Wed, 13 Aug 2025 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fL0LUDuk"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F139E302754;
	Wed, 13 Aug 2025 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123646; cv=none; b=NUfb+wfsdLriDM0B3JDnXFwxWxgrN+s9aBQ8r1vrzNDnxLpedTJfeKwmn7zHQ1tXqTDofiZkInFnI+rZ1EN5QPMu6MJIITrugcsPe6QxHvlumPURjCaIdT63dwX71NfGbB2pKx5zTFTpisFniS76tnMnpDGibYyiaO7zvTwE3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123646; c=relaxed/simple;
	bh=qlGnq/rCepwhQr34eD2F7PHOad/LDS/SRna+9hjGm5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3uNuf95fiWatQfoJTxRi7TDXhIqj8m6rdP3rRRU6i0ZGubWYU1JOLozDVoGhZNWT1WJzDrQBzwIeFphaCZ7ldrIXZF4ZpV0ZoCD2JyHj98gKeppom5eGhLLcM7k3094Hl92D+cl8Cgn0fzw4KKjhQ8BFBz9gPuQqo8Hx8QI9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fL0LUDuk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.210] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id E05442015E5B;
	Wed, 13 Aug 2025 15:20:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E05442015E5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755123644;
	bh=G//HTfFerFTsStS2M8GQ6ImUYqRelSJupH7lhv28YZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fL0LUDuk5y7E6+SAFMtAG+clu339wJHE1fZIla2IHvc6yvzkfuo1Z9kLUcXwJY5dS
	 t9hmf5s7JdWM7lPI/hWjFNazqwEOxoCnLYZ8GNE3jGDv3LID0PgZzUVXtnDTjyuPKH
	 UDCjPhxJuwESgb9fZI560y7O7yXoc1Bj08exlVtM=
Message-ID: <367fa213-8b92-49fa-bde9-380deb7fdde0@linux.microsoft.com>
Date: Wed, 13 Aug 2025 15:20:43 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] Drivers: hv: Replace hyperv_pcpu_input/output_arg
 with hyperv_pcpu_arg
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <20250718045545.517620-8-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250718045545.517620-8-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/2025 11:55 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> All open coded uses of hyperv_pcpu_input_arg and hyperv_pcpu_ouput_arg
> have been replaced by hv_setup_*() functions. So combine
> hyperv_pcpu_input_arg and hyperv_pcpu_output_arg in a single
> hyperv_pcpu_arg. Remove logic for managing a separate output arg. Fixup
> comment references to the old variable names.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/hyperv/hv_init.c      |  6 ++--
>  drivers/hv/hv.c                |  2 +-
>  drivers/hv/hv_common.c         | 55 ++++++++++------------------------
>  drivers/hv/hyperv_vmbus.h      |  2 +-
>  include/asm-generic/mshyperv.h |  6 +---
>  5 files changed, 22 insertions(+), 49 deletions(-)
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

