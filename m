Return-Path: <linux-arch+bounces-8632-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCCD9B2247
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 03:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7F11F21C65
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 02:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DDA18CC1D;
	Mon, 28 Oct 2024 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lGtpDk27"
X-Original-To: linux-arch@vger.kernel.org
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70118C327;
	Mon, 28 Oct 2024 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080943; cv=pass; b=bPZo9vX3XOeUCVPXWlzLPGdxMC5l7f7szwoHn1oK+807wD6za4c63B/7WJTgyJwgZSfqL1LKlw26JSvlyiusGUNP+Wi4nqbvW6tD1DurlXorQ1+W7bvGYP8Sp/dKAfen1wWU8lNArv+YOYmwjnBhcqBCLDMcz1hOZzsOkrJNvdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080943; c=relaxed/simple;
	bh=u9dgxPjngV31fQs5HEB/z4Keu+xsVZ4WEEml2hZEcz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkhJB205Uhcy8vNMiuBQ2jO8Dpc5qlsLZescWgAlT5bccCGKKe/ScJIQpzozu+4mM1vIoRAIgys3aG5EjVNmSBo9J8KNjL1cjk1e46tIJJ+w7HxYwbO7+WwjNe98jYuWnl89aIR6RMOhx6aqiF7TNVebLlyOQIDQ+2eL50ozn3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lGtpDk27; arc=pass smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CBB2A220F4;
	Mon, 28 Oct 2024 02:02:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a284.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.103.199.17])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 57A6E21D72;
	Mon, 28 Oct 2024 02:02:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730080935; a=rsa-sha256;
	cv=none;
	b=20SbFdjEvL4Fd+Lfe/05QcpabdHDSntjB7JlDA1EAxeUBglUnKj9PulwtSUQeO5/ESfvSq
	rM+rHhJSftF6YrXP1rMYqZJNNlOeHMIvI7s9ZmXCfO0h45PRmF81jyCrCm1k5ednMR9AMO
	vK1rDBZclTjwCsSazRQPe6+rbvrPwrAh4XJtLy3/Rgrt6q1sToEOAWKBhMgJa3XC8e5Ish
	r6rocEyGbDFoyk+27Kudq772S0sa9YdU78NqWFExp/TlMli6XMyIvQIZFP/Xe/hgEzVzqq
	9qgUnWW4bv2FXTYGMip9DDTQW6ugu1Xu1rex2QkLuhVXCAzsI0mxFLYcmYNm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730080935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=u9dgxPjngV31fQs5HEB/z4Keu+xsVZ4WEEml2hZEcz8=;
	b=EG3L+gqAjS3GHycdSvdHnP3hyGr5/CY24F3xoLmBkyoCkERNXe/TVV7nVDntdRmwGFjuj8
	lGYt2bUVYEIOzx74yKMUWV7iXCfdEr0L1UdXN+zprLHKu6GOiRYWpmm0mYtW65FBCPRzb9
	zVe0uxMKy4zGwKyryYz/Hqd0rL9Vh6A+evlixF7JNuyL1bEGhYf+a6DbiHuNxrqe4cLmiH
	epphYxMwCiifYtQQqrB6/7hzUuhscMLkDnzNOCkWbgD2T9lwletu1laX7/jqyng4SEAZ7U
	vBWl8KN6/RZi5YDz8wsDGdclnBYpGG6jYe9v+S8MAQE/XjF/jdOA12AHVqXFnw==
ARC-Authentication-Results: i=1;
	rspamd-7c89d756bb-sth78;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Hysterical: 735b6a21772d744d_1730080935709_2280068382
X-MC-Loop-Signature: 1730080935709:3118448206
X-MC-Ingress-Time: 1730080935709
Received: from pdx1-sub0-mail-a284.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.199.17 (trex/7.0.2);
	Mon, 28 Oct 2024 02:02:15 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a284.dreamhost.com (Postfix) with ESMTPSA id 4XcGqB0CXNz1l;
	Sun, 27 Oct 2024 19:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1730080935;
	bh=u9dgxPjngV31fQs5HEB/z4Keu+xsVZ4WEEml2hZEcz8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=lGtpDk27ag5i/FvKyjDUqPeM+JO1oVBUL4eWE8Za1en3KJ7RkdOcReHH7mkcH+aJB
	 fWxJUY4hSHELRJOHpI9zkwUEh9lkAjxppO1xjQmie9dk7Dd8E1r/okUhFEyZdZujz1
	 6ePlrmnz3usmroo7g9aUr/oiiKJwtMh5Y6eGUI5xOR1DwEGHUu1SDBIxFKZufEwqyo
	 TkJGAXSTlXXHsnq5FnYi0lpJbIjNhbi41W/Zy547Tqi/y9tSwI71iRPQzfm6s3lC6n
	 SE5uNCF3Brj+6OSF8+eWOFWVTxIgxUWQOAcBGmtzvH29KDOxX0bHdidV19tfGkqWvB
	 +mP84MGTDol3w==
Date: Sun, 27 Oct 2024 18:59:13 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, dvhart@infradead.org, andrealmeid@igalia.com, 
	Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, malteskarupke@web.de, llong@redhat.com
Subject: Re: [PATCH 2/6] futex: Implement FUTEX2_NUMA
Message-ID: <whmqaksbwuksdobz2fomqi3pa7btf2ucjtr3i4bz3oglidz3n2@27zggp5udztd>
Mail-Followup-To: "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
	Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, dvhart@infradead.org, andrealmeid@igalia.com, 
	Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com, 
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, malteskarupke@web.de, llong@redhat.com
References: <20241025090347.244183920@infradead.org>
 <20241025093944.485691531@infradead.org>
 <dce4d83c-fb3f-3581-71e4-33dad3f91e07@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dce4d83c-fb3f-3581-71e4-33dad3f91e07@gentwo.org>
User-Agent: NeoMutt/20240425

On Fri, 25 Oct 2024, Christoph Lameter (Ampere) wrote:\n

>Would it be possible to follow the NUMA memory policy set up for a task
>when making these decisions? We may not need a separate FUTEX2_NUMA
>option. There are supportive functions in mm/mempolicy.c that will yield
>a node for the futex logic to use.

With numa-awareness, when would lookups ever want to be anywhere but
local? mempolicy is about allocations, futexes are not that.

