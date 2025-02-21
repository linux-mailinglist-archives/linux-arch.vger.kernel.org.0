Return-Path: <linux-arch+bounces-10322-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3FA401CE
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 22:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A44319C5B5E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 21:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E968253B7D;
	Fri, 21 Feb 2025 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bba0KgUc"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5061FA859;
	Fri, 21 Feb 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172195; cv=none; b=QpNeCxZxK212AznMNrLUIFhulSMZxJtjOWLe3M82G+QTzqWXKBFizxapqufuz6fku5YVc2Zq+HeVxBFdNxqfE3NZ7uJ9WZ0pCQjgcF4q6bFs1hIAjid+wdPDNqCfmfVfpPmNLyruuV0IWXyNEoncj5GsDfImhTAKjHl03dVGnCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172195; c=relaxed/simple;
	bh=ZVSmgE59ppn9x6L0CpDAmCYQrosi9JW1l8txIIYCfMU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZcZWBUUreD6pLHXzHQW5PBewbSKr/OzXlEIKaGUwj5SuxxFL5Hln/gpQKhXZXxbKEeYoY0ERkMa3Vx2iYJVYw0iBZKA7UiLlpN2neHAWJxM1SyYiQRUu9CRSdLguZ+Cd+cqBwnVRNTC3P2W/1jLkqqW5f4WeaLqLOuKlawotRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bba0KgUc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.50] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 45654205367B;
	Fri, 21 Feb 2025 13:09:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45654205367B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740172194;
	bh=1Sv95soUBk9f1iq3csiKP86fpBD4wT9Wf9FIWGLF+BA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Bba0KgUcYGfQfDwvZ62M2/uTWl0oR1665JK7ognoirmrcpNPC0S9yj19kQxmMgamv
	 YOqV7hX7lQvmmvM70CPnek6ETCXuZ7rU7eeL9rwz6gGxO1dTYX1/XOkdOIlDRvU1DC
	 FbBE5mxascNAW6umvXY7gcKvR3p2ZWvm21bNUrjg=
Message-ID: <0e010ef1-c29e-4d33-9bec-61679e1d7a3c@linux.microsoft.com>
Date: Fri, 21 Feb 2025 13:09:52 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, mhklinux@outlook.com, mukeshrathor@microsoft.com,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] Introduce CONFIG_MSHV_ROOT for root partition code
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740167795-13296-1-git-send-email-nunodasneves@linux.microsoft.com>
 <991e7df9-d814-48a9-9469-a0b2f72acabb@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <991e7df9-d814-48a9-9469-a0b2f72acabb@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/2025 12:01 PM, Nuno Das Neves wrote:
> The subject line says v2 but this is actually v3!
> 
> Nuno

For the series,

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

