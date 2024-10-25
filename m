Return-Path: <linux-arch+bounces-8548-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1EA9B0909
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 18:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3BB1C219F7
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01C70816;
	Fri, 25 Oct 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="VDIAY7g3"
X-Original-To: linux-arch@vger.kernel.org
Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C970825;
	Fri, 25 Oct 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872053; cv=pass; b=NlQCUP6pz+9GEKja/eyUfsmi5teis9MmXZp0tFgYFRy1P5seMc00Ml97A5UPrFl2ak9WGlaSOX2Q8z3bKDJPFQKL3S+UPxxX8FuPYrBw8bQD430okJ21FLaLljpOhak0v5R+1hw5Nr1tYnnMRI3MvrDVpEd4QFQYNXVVzoUOXBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872053; c=relaxed/simple;
	bh=suKnIkzHl52GQ3uUBRyZ4/13NfkZfz1GZL+ygVGh2O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz8KGEWd6sGiMkVtQganGZ5ZsshSwEP2QSimma9BimVLmBfGeuYEN7o2SWxCTZNPi67F0ofHkqWn3jmgrekmWeacIEmGnQj/5plKPI7h7Ssoo1o7NcgByuOjXGQcEG2kBxVJOp7ohNjxYuRVPelnKyGEetkTCy1j7Xze5slpFsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=VDIAY7g3; arc=pass smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5CBCBC6740;
	Fri, 25 Oct 2024 16:00:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a287.dreamhost.com (trex-13.trex.outbound.svc.cluster.local [100.102.223.228])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BC10BC6842;
	Fri, 25 Oct 2024 16:00:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729872040; a=rsa-sha256;
	cv=none;
	b=LN9t0SSJ70DJWx1oZL7Mu1n5qBApWU7NnH2YAGkoTFiDDrYpmHXRck1cDV3ekXPQnJiNTx
	ewOkWOwbuqq5kl5MwlbO+/RLPJMl+kLXcd+QsWwcqO2MCh36Low4kjqzsSiaaTczmsq3fP
	ThQFzvdqr7IwUucdAHDqSVDQSPzmu+SqPfFDU6wJ/KwiHHoWYiwICbFGSRutvI6e5Sq316
	MyIntLCQqQS7hjIpYdk26d9V4PnqFBBlaLzXPI4N4IH2q3ssM/Ui6w5NdJL0H8gmUfECWF
	v85q/VNi+orUum91DAJ3e6FGkbm97Prb5mwndU+HnzlvooRKHxibnBioaiZVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729872040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=suKnIkzHl52GQ3uUBRyZ4/13NfkZfz1GZL+ygVGh2O8=;
	b=wkNI2XsD4d1rgzvZDkAe84IJs5Z4W3sRkGfDDnushht1thyOx8S8A0aiDLXcPdoZmq4Aoq
	6QOKpwUZpOuj+PrDFcyAgpIpHdoSLhHnhT7PKwNX3SfTNKVQBBmL4GKBE9VN56Q4BLZeVp
	qBYJaxpjVth9wn2i+2GUajVEBGwKg7BIWLewmZVgp+mIZAKxt0br4hxz7/SXWIBUq6OxYC
	JMGMNGccUGsGa2+DkSfRbTTDUIhctKPthJ+0ndvR21cgOPc66TQPscJ331p8Xbv5mMNUeU
	dgeQ4+gRQmdQdM/mf7w3QCCU7QOXlsOPW7T3/IvimNtnENJSF8wFKKyAObM1Zw==
ARC-Authentication-Results: i=1;
	rspamd-78ff97654b-tkhlg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Share-Oafish: 78ba8f760e311cf0_1729872042984_934192089
X-MC-Loop-Signature: 1729872042984:564840505
X-MC-Ingress-Time: 1729872042984
Received: from pdx1-sub0-mail-a287.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.223.228 (trex/7.0.2);
	Fri, 25 Oct 2024 16:00:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a287.dreamhost.com (Postfix) with ESMTPSA id 4XZnYz4s2nzBF;
	Fri, 25 Oct 2024 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729872040;
	bh=suKnIkzHl52GQ3uUBRyZ4/13NfkZfz1GZL+ygVGh2O8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=VDIAY7g34MhrN3et69nORKt+92m9EF/j/oBrcen+OdVLK1t8CcYpzk0CrkvlXfPPT
	 Z1PgbjGDkSWQusAHf38iuUXdgojHWFrO8DMWZXyCo8erPz56WQo9Xkom89uHUCv8xt
	 Xk9jnbkkgUPlzoQ9YS+9kdONnTqKs6s2Hoas6WGUXrO2Sajksfn805dAReF70FkwlN
	 UDBm5ETwCoxTys1EjrQ2edO6gSiVk2QuPky8buVnzirX6AKkc1U1v7++QeWiA5TQjA
	 Bm/05l2wJ0b20HEpIJbpKf8R/v/LAfj1zgQBWitwesCIULwc0L3erHpXOkqP9EsaXD
	 JaLWgNxYaRC7w==
Date: Fri, 25 Oct 2024 09:00:36 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com,
	dvhart@infradead.org, andrealmeid@igalia.com,
	Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
	hch@infradead.org, lstoakes@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	malteskarupke@web.de, cl@linux.com, llong@redhat.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] mm: Add vmalloc_huge_node()
Message-ID: <20241025160036.awgzmuafq57k53yq@offworld>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	dvhart@infradead.org, andrealmeid@igalia.com,
	Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
	hch@infradead.org, lstoakes@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	malteskarupke@web.de, cl@linux.com, llong@redhat.com,
	Christoph Hellwig <hch@lst.de>
References: <20241025090347.244183920@infradead.org>
 <20241025093944.372391936@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241025093944.372391936@infradead.org>
User-Agent: NeoMutt/20220429

On Fri, 25 Oct 2024, Peter Zijlstra wrote:

>To enable node specific hash-tables.
>
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

