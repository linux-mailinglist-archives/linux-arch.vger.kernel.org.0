Return-Path: <linux-arch+bounces-14796-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D1FC5F90F
	for <lists+linux-arch@lfdr.de>; Sat, 15 Nov 2025 00:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81FB74E1BA2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 23:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A52FDC20;
	Fri, 14 Nov 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9KMTt6r"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30841298CC0;
	Fri, 14 Nov 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763161807; cv=none; b=CPy4tsfFDbL99zMRLT4vS9sfrSWMIeiKXGXAGFXBJK+Vh6QUGbamhPWBx2Z4zodIMCSMP2iGPIkGeIGqbNsfR5IIqLtweBWmZTeZxyBgECEeXYthKEQi0OzbGHpB2kDcm2LbExiB3gMWmoaZFTzlLr6+o+/KVueTzV2thfPmOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763161807; c=relaxed/simple;
	bh=Cle4/vff5SB1IWD4HNItwK0bPh/1KZ1BFPh6rOzhPmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+d9oLBJJd0pr8rwbreudiHbvNxoFjDeh50F6URKYjwjsKSHonjuzKOG1LdQ1TIiV2Y3YzzfWc8+HmVq8oZJJ7fdpYJyyzqK2gm2xoOw2zSG/uLJzUVII8CrwmjL3Clut74gtyxAX26wUhdfznFeRhNA5yyzTrfBubnQtY0S+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9KMTt6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FC2C4CEF5;
	Fri, 14 Nov 2025 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763161804;
	bh=Cle4/vff5SB1IWD4HNItwK0bPh/1KZ1BFPh6rOzhPmI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I9KMTt6rN59cZwQZpJIKV4NcU+T4pQVdUxYGYDSFDoq7S5hRKvRZDbqdzueDrp/2D
	 QnsIdVuF0CyJUp98esb2rOB3xt20JSx5c0+UvujPCDuRpfeGcXI4HLpJG9QHtg9Hha
	 kvbE3L7wMltT6S63DUUofMNuw3uQxX+UwDdNoZOH/px2oXTMrbWdSHaAhdoc/5tUux
	 m9uiBlPSPcXa5xCffROA/hh7TIjTSNpmFmGOwzAgLGNXGj1zG9v9zbpOnBca44bXoP
	 ByQEpbj+AReGYeuDeLb3RpcJj2vRBfaG0zsHCZKGPdmCjpiMthlrU5NxNtxLBPuNxp
	 AiwGco9rLD9GA==
Message-ID: <4e120357-6fa3-436a-8474-b07b473381b6@kernel.org>
Date: Fri, 14 Nov 2025 15:10:02 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] arc: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, david@redhat.com, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <6a4192f5cef3049f123f08cb04ef5cd0179c3281.1763117269.git.zhengqi.arch@bytedance.com>
 <5199c367-aabb-43e7-951e-452657dcdddc@linux.dev>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <5199c367-aabb-43e7-951e-452657dcdddc@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 03:20, Qi Zheng wrote:
> Strangely, it seems that only ARC does not define CONFIG_64BIT?
>
> Does the ARC architecture support 64-bit? Did I miss something?

ARC is 32-bit only !

-Vineet

