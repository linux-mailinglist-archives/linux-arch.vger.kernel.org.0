Return-Path: <linux-arch+bounces-8577-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A19B1195
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C927C1F2190D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BD73C482;
	Fri, 25 Oct 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VGYK35Xj"
X-Original-To: linux-arch@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99105217F5C;
	Fri, 25 Oct 2024 21:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729891431; cv=none; b=QALDrniB4xoZrXFp1xPcpko/xwoNW32i9cvZaW1WQFkilQJvCMXvpT5uxI11X25l5RKPRug2TQxfGLluSHbkDz3DtdMXNgXaL4XWpcKKtDYB005rQQkUqRAyFYqmnaOAwzC1XUOVaTEsFRSkoPCFIkUVPGEV7NAkn+9JuRzqa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729891431; c=relaxed/simple;
	bh=MJteKabF14rmjmcWcfRJoa4ndNm58vj4dt+lQ1sgOZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iD8nHIOXiOk9SBhnOBfCb9cDgdVtGAUWyOhttkhCFpsuCBjzwlhJAYdm0bmMIaeJ3YB7Sb6ZjW2SuHDNREOMWG8ixu7ijtuT0hRyB0cvlguSx8V2B7lYOHhwoacAwfdVHNpOwW6O3DKzT5JXWJHys0UAo9Sm8+kShUz3u/I6O+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VGYK35Xj; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g/wygeGFZTjCvHlojXiuv3YCs88h6s6phKX2tMfNnIU=; b=VGYK35XjgnDbwp9myvCNunLYiZ
	ONqbtVc+b9MSgQ8Cs0BFBv4LXdEFY6rWnjnzCUnI1IJHTrFV4DBa9NCNIC+/W2Uc2U4dtrKtboDjU
	GiCdwuKUu7ezWdbzani+5BULnp7q7SV7xivaGmDlz9f/5JTG2MIVoIVvFre7D1+hcMII/vZc88NDB
	KWYXrDGUIRAAWDGuhYRaRsuBNtqJaUrtGpoPikDsdAHsBJ3d4rVAngQO5VTrj62QQzF9Sv5L1o0Hp
	dU//5DCEHJv6c+6smSKVkS1ldBuwH79lmGVqxwckHJakExJAuVMztrljCj3/lTaFSrj6xHmdXw7f8
	3FCnnnJQ==;
Received: from [189.78.222.89] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t4RmV-00FAr4-MJ; Fri, 25 Oct 2024 23:23:39 +0200
Message-ID: <4b9a5824-7cb7-4dc6-91dd-536f4dad9771@igalia.com>
Date: Fri, 25 Oct 2024 18:23:33 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] futex: Implement FUTEX2_NUMA
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, dvhart@infradead.org,
 dave@stgolabs.net, Andrew Morton <akpm@linux-foundation.org>,
 urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
 Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, malteskarupke@web.de,
 cl@linux.com, llong@redhat.com, tglx@linutronix.de
References: <20241025090347.244183920@infradead.org>
 <20241025093944.485691531@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241025093944.485691531@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Peter,

Em 25/10/2024 06:03, Peter Zijlstra escreveu:
> Extend the futex2 interface to be numa aware.
> 
> When FUTEX2_NUMA is specified for a futex, the user value is extended
> to two words (of the same size). The first is the user value we all
> know, the second one will be the node to place this futex on.
> 
>    struct futex_numa_32 {
> 	u32 val;
> 	u32 node;
>    };
> 

Maybe this should live at include/uapi/linux/futex.h.

> When node is set to ~0, WAIT will set it to the current node_id such
> that WAKE knows where to find it. If userspace corrupts the node value
> between WAIT and WAKE, the futex will not be found and no wakeup will
> happen.
> 
> When FUTEX2_NUMA is not set, the node is simply an extention of the
> hash, such that traditional futexes are still interleaved over the
> nodes.
> 
> This is done to avoid having to have a separate !numa hash-table.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Do you think some of those changes should be guarded with #ifdef 
CONFIG_NUMA? Or is fine as it is? I see that most of NUMA_ values 
defines to 1 anyway on !numa, but maybe the futex_init() and 
futex_hash() would be a bit more simplified.

[...]

>   
> +static int futex_get_value(u32 *val, u32 __user *from, unsigned int flags)
> +{
> +	switch (futex_size(flags)) {
> +	case 1: return __get_user(*val, (u8 __user *)from);
> +	case 2: return __get_user(*val, (u16 __user *)from);
> +	case 4: return __get_user(*val, (u32 __user *)from);
> +	default: BUG();
> +	}
> +}
> +
> +static int futex_put_value(u32 val, u32 __user *to, unsigned int flags)
> +{
> +	switch (futex_size(flags)) {
> +	case 1: return __put_user(val, (u8 __user *)to);
> +	case 2: return __put_user(val, (u16 __user *)to);
> +	case 4: return __put_user(val, (u32 __user *)to);
> +	default: BUG();
> +	}
> +}
> +

I found a bit confusing that this is here, shouldn't be at [PATCH 4/6] 
futex: Enable FUTEX2_{8,16}?


