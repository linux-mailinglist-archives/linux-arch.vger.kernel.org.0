Return-Path: <linux-arch+bounces-13944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E82BC0F50
	for <lists+linux-arch@lfdr.de>; Tue, 07 Oct 2025 12:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71A264F44FC
	for <lists+linux-arch@lfdr.de>; Tue,  7 Oct 2025 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E42D7DE3;
	Tue,  7 Oct 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hYTmtSyd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qNNEWXbb"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E485A13BC3F;
	Tue,  7 Oct 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831442; cv=none; b=RE4dKIb35zFBtx4r+3gaFEq+wzhoXtKbjFdkxr5z9xXeb6GPvyC7GorVah65B/9c+Ht9pWByV1mrZFemRvBWstFPrafozv9zVNFozeDbobxLB12j5Az9LOZoZj88i0XZcDneMwss85lccO98wYUtcv5c624Ti48YktqXKn4LHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831442; c=relaxed/simple;
	bh=00DXoBz5JZNAz74A9Adn+6ptz2K2oCfovcMeya5zDJM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M7N2VSNIvnHAjNgu/0lG4lgTqMJgIGKFciyFVzqVEFUIjNNgLGf/w/k0fCkPOUbX37Eb8XHPB78dv/hWOKNRbRKslJKWJwKafjh0Nq4yCOqNd3DNCe6wiYDcvRKdnVOlkg8dVhaFWFWGKOYmMlpqB9q3LZlwAElAI8B51BKdHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hYTmtSyd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qNNEWXbb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17C59140032F;
	Tue,  7 Oct 2025 06:03:59 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 06:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759831439;
	 x=1759917839; bh=tevLS1YEVLhzj9dfTyQDjMvXZjqzh6tuEAY2qUJdPv4=; b=
	hYTmtSydKG9oPRfnCYKeZMB6gO9WimOjQqYj43y6uReWlAGrTS+mIJ2O/h+qzQ+G
	7j9oWwx1RizoTZdsCfehKxRh8AoogNricEQDeIkY5996/TEu1Liv2fxHrmuL48sb
	ijyUULwC65IXGp51z04uZogXukXhBpiHDKzM8HXkqkrEg40DZCaM4DqPOvNLiy2H
	xOQLgEF4te25jxqIBncmTEXMJx1bVpYE+wcarmJvckw3cCEwaXNceTMwJGF3ANoF
	OLd1Ir5hWS7U+W1piJHKoo8Y9ZIKglrAGc9dmDypEOy47AxJqGmt9mM8+anfSJeR
	h0nj0v8i0BUvzV6jaVE5hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759831439; x=
	1759917839; bh=tevLS1YEVLhzj9dfTyQDjMvXZjqzh6tuEAY2qUJdPv4=; b=q
	NNEWXbbtvojh2EjcUveN0Pp79hPHUbwVnMY/t/eOYsQJ2RYHQhTtdUEuRW9Iai7o
	VR7Um1o6PH00eNaA2FMxKBbweFnS/YdLnO0Aj+ZoEiMxUyzh37UraoOBN72SNVZh
	19kGquRVTIgoS8xbmr2nJ31nWmfNVzS8kb+jE3EpFo39S+y3LNtIypy6NwPUYdpK
	q0PQm79soeE7wSqSrCYeyZwSSu26oS9sGrXBBgi6UaNf2KQCXkV5avInwa283yxO
	i2u0PhjOy9cNRkJHfEnvVRX4StIcgW4TaXC45K8rQ0oqGaMdn2qp0bSa7D1T19wa
	2kHohQTAa+c1/gj3aOGVQ==
X-ME-Sender: <xms:juXkaNQl2VChS8VgVUTbmeeVE5BlNC1PTPwJg_G9IFbLI0VEsgsGvQ>
    <xme:juXkaBlncBfMe1EM9l3okV5oKPT6AkbX_6RBrIfzX6JNyAMWtBiojsDH7f9Ug9bQh
    rER_IIUaNL6oVQglgr0EEGnp1ZrgeOs2dwftz0Uiwyakqeqy8PU3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeifsedufihtrdgvuhdprhgtphhtthhopegtrghtrghlihhnrdhmrg
    hrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhk
    vghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlih
    hnuhigqdgrphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:juXkaJLBAfaTsVP6DfGIWR2H62aKN9OhGgV5wW9B-hbApI7DCXDM3Q>
    <xmx:juXkaNRoP4zWrJXpVT1uZiXbEvnFfqEVeL3u05oyBHdxJBbZON8wsw>
    <xmx:juXkaBMoN_Q1MqQMlkzQsY8yV9rWK70KtSXO8uCiI9zbeQwZuDPXfA>
    <xmx:juXkaKWga0e4oEQke5h0TnUxuDmN8uDXPcPX_qIMdLb3zMX-DFmQdw>
    <xmx:j-XkaHDaLY0T-iizkHCf0y8cj5SyWzawl5k0QvFI6iADNpvFlmPlf6r4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A19B0700063; Tue,  7 Oct 2025 06:03:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQeYErt0RC5c
Date: Tue, 07 Oct 2025 12:03:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Willy Tarreau" <w@1wt.eu>, "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, shuah <shuah@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-api@vger.kernel.org
Message-Id: <b554958d-1f38-4d61-8378-ce784c2bb188@app.fastmail.com>
In-Reply-To: <a5b8344e-8214-4946-8344-f34e969d30b2@t-8ch.de>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
 <20250821-nolibc-enosys-v1-1-4b63f2caaa89@weissschuh.net>
 <cec27d94-c99d-4c57-9a12-275ea663dda8@app.fastmail.com>
 <a5b8344e-8214-4946-8344-f34e969d30b2@t-8ch.de>
Subject: Re: [PATCH 1/7] tools/nolibc: remove __nolibc_enosys() fallback from
 time64-related functions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025, at 22:14, Thomas Wei=C3=9Fschuh wrote:
> On 2025-10-01 09:43:37+0200, Arnd Bergmann wrote:
>> On Thu, Aug 21, 2025, at 17:40, Thomas Wei=C3=9Fschuh wrote:
>>  - the old types are often too short, both for the y2038
>>    overflow and for the file system types.
>
> So far this was not something we actively tried to support,
> especially with the restriction mentioned below.
>
>> I suspect the problem is that the kernel's uapi/linux/time.h
>> still defines the old types as the default, and nolibc
>> historically just picks it up from there.
>
> So far we have tried to keep nolibc compatible with the kernel UAPI wh=
en
> included in any order. This forced us to use 'struct timespec' from
> uapi/linux/time.h. With the upcoming implementation of signals in noli=
bc
> this guideline is relaxed a bit, so we should be able to use our own
> always-64-bit 'struct timespec'.

You can probably either "#define timespec __kernel_timespec" or
"#define __kernel_timespec timespec" before including
linux/time_types.h.

Note that there is no time64 variant of "struct timeval", so
any syscall that needs this has to be implemented in userspace
as a wrapper around the timespec based one, e.g. gettimeofday()
needs to call clock_gettime() on all 32-bit systems.

>> We should also consider drop the
>> legacy type definitions from uapi/linux/time.h and
>> require each libc to define their own.
>
> Can we even just drop them? Or should they also get some backwards
> compat guards?

This is the big question, and we kind of left this one open
to be decided later when we finished the actual binary interface.

I think simply dropping the old definition is one of several
options we have, because that does not change the ABI in an
incompatible way and just requires the few user space sources
that use this to either require old kernel headers or make
simple source-level changes that they should have done for
portability anyway.

I see multiple decisions we have to make in that option space
once we decide to do anything:

- do we change the headers for both 32-bit and 64-bit userspace
  for consistency, or only for 32-bit userspace to limit
  the impact to those users that care about 32-bit?

- do we remove only the type definitions (timespec, timeval,
  itimerspec, itimerval, timex) or also the syscall macros
  for the time32 syscalls using them?

- What method (if any) would be used to choose between the
  time32 definitions, the time64 definitions or none of them
  when including the kernel headers?

      Arnd

