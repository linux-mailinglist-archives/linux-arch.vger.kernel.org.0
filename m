Return-Path: <linux-arch+bounces-4850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5F19059C8
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 19:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A451F219B7
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D5181D06;
	Wed, 12 Jun 2024 17:23:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F83209;
	Wed, 12 Jun 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212983; cv=none; b=USKDveBxESZ3CmzrG5kxett0z16OTx5+g7N79sWP7MjDV8/rtyqYqPJssJH9Ic0e1dJdMEx2/ZuH3vJNGBUyfK/fphuOFiEfaTT6XIVZ41KYVjj68bP45errx1uwX2MiPf9CUqfpTd23JTVDh4ANCmxWAZjAzsADJQtlHwTJ4pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212983; c=relaxed/simple;
	bh=mk1V5wN1cC5VI0L1QKEMWa2idEvq9NGRGwsz5h88drU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YMh8Jvk6xE60ijP8pVH95KPhhQIvltt/kwroezveZPlq2VperrS0LIPcDuCkVYUZ/G4F6CpQ5GCmZ+bz6qZa1CMAOP7XQUkbGvAEt7c6d0tA6CxizM9jhRyY2Vf6f0njsH9OOrgrlsaLigHdEoFoB19rVOUYWaO5+w8Wb1UdDcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 80E4040B11; Wed, 12 Jun 2024 10:23:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7FB9440A8C;
	Wed, 12 Jun 2024 10:23:00 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:23:00 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Peter Zijlstra <peterz@infradead.org>
cc: tglx@linutronix.de, axboe@kernel.dk, linux-kernel@vger.kernel.org, 
    mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net, 
    andrealmeid@igalia.com, Andrew Morton <akpm@linux-foundation.org>, 
    urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
    Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
    linux-mm@kvack.org, linux-arch@vger.kernel.org, malteskarupke@web.de
Subject: Re: [PATCH v1 11/14] futex: Implement FUTEX2_NUMA
In-Reply-To: <20230721105744.434742902@infradead.org>
Message-ID: <9dc04e4c-2adc-5084-4ea1-b200d82be29f@linux.com>
References: <20230721102237.268073801@infradead.org> <20230721105744.434742902@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 21 Jul 2023, Peter Zijlstra wrote:

> Extend the futex2 interface to be numa aware.

Sorry to be chiming in that late but it seems that this is useful to 
mitigate NUMA issues also for our platform.

> When FUTEX2_NUMA is not set, the node is simply an extention of the
> hash, such that traditional futexes are still interleaved over the
> nodes.


Could we follow NUMA policies like with other metadata allocations during 
systen call processing? If there is no NUMA task policy then the futex
should be placed on the local NUMA node.

That way the placement of the futex can be controlled by the tasks memory 
policy. We could skip the FUTEX2_NUMA option.

> @@ -114,10 +137,29 @@ late_initcall(fail_futex_debugfs);
>  */
> struct futex_hash_bucket *futex_hash(union futex_key *key)
> {
> -	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
> +	u32 hash = jhash2((u32 *)key,
> +			  offsetof(typeof(*key), both.offset) / sizeof(u32),
> 			  key->both.offset);
> +	int node = key->both.node;
>
> -	return &futex_queues[hash & (futex_hashsize - 1)];
> +	if (node == -1) {

> +		/*
> +		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
> +		 * node -- this ensures regular futexes are interleaved across
> +		 * the nodes and avoids having to allocate multiple
> +		 * hash-tables.
> +		 *
> +		 * NOTE: this isn't perfectly uniform, but it is fast and
> +		 * handles sparse node masks.
> +		 */
> +		node = (hash >> futex_hashshift) % nr_node_ids;
> +		if (!node_possible(node)) {
> +			node = find_next_bit_wrap(node_possible_map.bits,
> +						  nr_node_ids, node);
> +		}

Use memory allocation policies here instead?


