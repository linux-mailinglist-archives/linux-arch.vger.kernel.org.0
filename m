Return-Path: <linux-arch+bounces-11972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B006DAB9546
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 06:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A701EA017A6
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 04:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8B13790B;
	Fri, 16 May 2025 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A4xNxreE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E0635;
	Fri, 16 May 2025 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370134; cv=none; b=cIfc2one1s+wdS3DQ7ncFR98nrzzhJSnzOZEaqIPqGAFPXBThBGznaPgosqM7wOJpjDkC+UH7x+U2Co6Lih+1DcbChPXthKC79PtBWhLsK/Sk7DgQCI4aentSRNvpwfEgy7noZ3kC/48/Sz+2I4Jh+oZI+98LZBB5JZBxEZrQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370134; c=relaxed/simple;
	bh=4Qu0SXJnde/mV0+isooheXebpYpL/wmYnnV87EyzTHw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NcLYUo1yOqsQ48wGWu2hwKmzMPNxrAd2wc4YWwlYwgdIn6k8UIeiyjhI6h3JnxblhrqeeD3XQVxkesAQNRyicP8CYJ+TwebFp+1EHDvPLgHs2lWktwxoIEAK1wljTbLoy1ssE2YAITh0hve7oxHDu+FJVoLZhqWUgYQmQUuX7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=A4xNxreE; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54G4Z2sQ3939295
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 15 May 2025 21:35:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54G4Z2sQ3939295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747370103;
	bh=4Qu0SXJnde/mV0+isooheXebpYpL/wmYnnV87EyzTHw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=A4xNxreEeTm3o3i76GLEfq9j/jdCBJkMUxhz4WoOJVjte21rsD9+AtsdukrhXCs8W
	 gPrYnAoDKiDHTH/uWOUhFnX1FMlFERTNRfNxPDyiMzTLdRSPIjNbTZrrI44X4VhP7T
	 Y410R41M1ofjA1djek/yLke9jA4droUuxbJ1ybBfx9zp6urgM4NB34ZI3UkRVFEIAC
	 YMWHvPWKwz2G55qoI0KQX/VkmJMbbNaQceNFZyKNrC3nhQoIiLk7M1tpqlRctTCkzX
	 fQJ7nKl64Fhqs3x5hcgIcBhxGV5dueKcgqnJsnWUCFKk+Pi8j1FJ7QPhhlnIyUaMj8
	 TQxnpJ0zKp73A==
Date: Thu, 15 May 2025 21:35:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Willy Tarreau <w@1wt.eu>
CC: enh <enh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Subject: Re: Metalanguage for the Linux UAPI
User-Agent: K-9 Mail for Android
In-Reply-To: <20250516042246.GA12824@1wt.eu>
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com> <CAJgzZoqUV6gSfgCWbfe6oSH5k9qt30gpJ0epa+w78WQUgTCqNQ@mail.gmail.com> <e4d114e3-984a-482d-a162-03f896cd2053@zytor.com> <20250516034232.GA12472@1wt.eu> <A89533DF-E2F9-4536-A00D-4E3685565E67@zytor.com> <20250516042246.GA12824@1wt.eu>
Message-ID: <3913922D-765A-4E54-97E0-37B34F3BE86C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 15, 2025 9:22:46 PM PDT, Willy Tarreau <w@1wt=2Eeu> wrote:
>On Thu, May 15, 2025 at 09:17:14PM -0700, H=2E Peter Anvin wrote:
>> Ah yes, nolibc; basically klibc reinvented=2E=2E=2E
>> <ducks and runs>
>
>:-)
>
>That was not the initial intent though as it started separately and outsi=
de
>the kernel=2E Also the main difference is that klibc is compiled=2E Here =
we
>only provide includes so that there's nothing to compile before using it=
=2E
>We'll see when this becomes an issue, but for now it stands fine=2E
>
>But I agree that both pursue very similar goals=2E
>
>Willy

Certainly=2E I'm being snarky, but I'm not upset :)

