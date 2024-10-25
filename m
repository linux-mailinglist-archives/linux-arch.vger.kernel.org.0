Return-Path: <linux-arch+bounces-8551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC51C9B0D64
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 20:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606AB2859C7
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338A1C07FC;
	Fri, 25 Oct 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Vsk/NPxE"
X-Original-To: linux-arch@vger.kernel.org
Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB61534E9;
	Fri, 25 Oct 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881211; cv=pass; b=ljLMA9Gh5kBKPrs7IwiyTDswaeyplawVzo3aeeyQGP/9nBzMMPSDQDXZOvTEum7IgVN4qyl84oOKPDY+IJWufmXyi2XRUwat456nisabDnH7DvHBY6S5OalcLlUZuFOyE/U0icj3dMqIFFZY1yMA7VTsOssqwH4gebDzjp0uDaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881211; c=relaxed/simple;
	bh=dwVze2IoN4lNX6/VE+wDa6/jdnBd4wpGu126gCkhqsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS/wR5jUXSEu3U2IpVXRlJH5XhW+w3CgJ+Msh+UcP1Dsc29kMChRwhU2yZVfoEgD/Sql/tk9Op7TBmUvVJoHAzjnu6ZLSDRKiSSjcNfRmSW/AlLxYfWBf1lRNlN9pl7jBqcwyuAGUaPhjYpx9wcSPf37m5gsgw0DwPC8KuDMu6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Vsk/NPxE; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0AFF32C1B84;
	Fri, 25 Oct 2024 18:33:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (trex-13.trex.outbound.svc.cluster.local [100.102.223.228])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6B0102C37D4;
	Fri, 25 Oct 2024 18:33:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729881200; a=rsa-sha256;
	cv=none;
	b=j5P5Z6nwn7aUtQdqVV7veKxoLLw7vBdLodEdHWQdp1LHoWolNUAlXqqrctcTwvZhHFHXiw
	TkgquVIsGBgDuKxUuiLvGKpl2XUuhUYnWi0YTTvFzMLOHucI/V/l4rCWtJbcha+BqRz6Z2
	t0/uikYaCtc/CJFjIe8gi+8a6q5oJRpHVWbiWXnfQH+5njbFy9ajA0mPbgveqpc9+mJ5EY
	v5Y3mxrChNoiplMMLt6uher97meKD+p5/ikXlchwz+yNezS/ciJT3UlmHr4neCMidepgNd
	KY7dJotH7L+XHldYRchMPS9Snlq1WLwIc4iECQjS8zQV4lh+FKHFgZQccDF61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729881200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CT4I2WNs8+lv4enGsXMLmXV5yqvMUhh47eXWE7/RKS4=;
	b=6DCSBlT2DFrC8tksm9jKSdTODKtWHI374gECEVPYRRl+2wAQvL+SxplT4unaTdgZ1TXOBk
	7R55ocCqK//NFlFWJECZAirZt3peZo0pB0gb2dB2TeubXw2oipuy+WFPZ9roOx6Qa1WyGm
	ygvd7VsZlRaQwWh11lRjm5IksaEPjGMYbXqyR2nPRIoJHcr2OKkOdNLXX+N7NfA0Q/VK99
	qOQ/8AdUNKKG2Mw7AGxkXygIJJ3yOfoBhfGSS2fM8y4hwVhcmQkX978x02DIO9raR4cUW/
	8TY4zmTo7D+4LFUvqWX6KyB56Db81DUptNqKKfS+pB2wVqYa8S7aWDHIl5jM1Q==
ARC-Authentication-Results: i=1;
	rspamd-cdbbc7585-hgvf8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Reign: 7245a16350dd8199_1729881200793_2943900534
X-MC-Loop-Signature: 1729881200793:2559233038
X-MC-Ingress-Time: 1729881200792
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.223.228 (trex/7.0.2);
	Fri, 25 Oct 2024 18:33:20 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4XZry72Y0xz9p;
	Fri, 25 Oct 2024 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729881200;
	bh=CT4I2WNs8+lv4enGsXMLmXV5yqvMUhh47eXWE7/RKS4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Vsk/NPxEuhRtgVp5TlB3DwcWvnMqm9mythIDgEulakohCN5GOnlLxeEj2sBHVMjBf
	 yG9Bu7FazgHrrluyfbxugoCb9rr3UvgdX4LlVPfGjXWTWHmNm6RefJ9mqv8bpA8tDc
	 PqLrL7jRRiGN7Uqqujeyoq50jPKnOnq8TQLgodb1+fMrIEyojUzChIc9q4Eh2qC60Y
	 Fh4a7snuTbazI0oXvixGNjBhKecifSz4wqaixS6K2FueL3Ycx6SZh4ISUbip8YsMzC
	 vrJBA2HPdby+MLKD0onAqWL/uJRi9eMAIG/mT089ImWGi2y/gXVBdSjtOYwdjToBX8
	 RWmnThY43TYow==
Date: Fri, 25 Oct 2024 11:30:26 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	dvhart@infradead.org, andrealmeid@igalia.com, 
	Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, malteskarupke@web.de, cl@linux.com, llong@redhat.com
Subject: Re: [PATCH 2/6] futex: Implement FUTEX2_NUMA
Message-ID: <i4ljhfndmqrdg5zevd4gf2chmzesfieflxvfj2io2qfhfj4vb7@nicvpjmcdtyu>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>, 
	tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	dvhart@infradead.org, andrealmeid@igalia.com, 
	Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, malteskarupke@web.de, cl@linux.com, llong@redhat.com
References: <20241025090347.244183920@infradead.org>
 <20241025093944.485691531@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241025093944.485691531@infradead.org>
User-Agent: NeoMutt/20240425

On Fri, 25 Oct 2024, Peter Zijlstra wrote:\n

> static int __init futex_init(void)
> {
>-	unsigned int futex_shift;
>-	unsigned long i;
>+	unsigned int order, n;
>+	unsigned long size, i;
>
> #ifdef CONFIG_BASE_SMALL
> 	futex_hashsize = 16;
> #else
>-	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
>+	futex_hashsize = 256 * num_possible_cpus();
>+	futex_hashsize /= num_possible_nodes();
>+	futex_hashsize = roundup_pow_of_two(futex_hashsize);
> #endif
>+	futex_hashshift = ilog2(futex_hashsize);
>+	size = sizeof(struct futex_hash_bucket) * futex_hashsize;
>+	order = get_order(size);
>+
>+	for_each_node(n) {

Probably want to skip nodes that don't have CPUs, those will never
have the remote for .node value.


