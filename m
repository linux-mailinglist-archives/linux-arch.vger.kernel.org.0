Return-Path: <linux-arch+bounces-11971-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E74F6AB9541
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 06:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C3F1B67A9C
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 04:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F26221DA5;
	Fri, 16 May 2025 04:23:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F306046BF;
	Fri, 16 May 2025 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747369381; cv=none; b=WXR0B7/dIfDkNXq0EKXjXegPnRpxb/Q9bF1QZTBrALYErmkrRzulgAZzG+qSjmn2mRwAbjMJ7WdtqdVZIMZDhwsdbtxF69DYcnB6mzZuumwKEAqnzxYVfdHRaS+k0o65KSwfMrd4kk11yo7u3eP8iKRqJBGJJPo17ph9DYQ6C/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747369381; c=relaxed/simple;
	bh=28AvzHfFnGa8itUM2lxN/ZJugoo/wE4Mpu1yjXAFvnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7AyyDXChCXD+hMT1qttJOhNuz38tvXXFD09kZhM2XYNQRjQfoyqpKjzImWhb60hx/pfqAhnx9lkVfF8qY0EChDktptLSn1LBZWFloRRdgrIcJFqyIrIgX452xz6Tgu+Rdn1GTVOIrICrhOFYnz19TvG6ZyfTBg1lxtsFKubZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 54G4MkXD012844;
	Fri, 16 May 2025 06:22:46 +0200
Date: Fri, 16 May 2025 06:22:46 +0200
From: Willy Tarreau <w@1wt.eu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: enh <enh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Subject: Re: Metalanguage for the Linux UAPI
Message-ID: <20250516042246.GA12824@1wt.eu>
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
 <CAJgzZoqUV6gSfgCWbfe6oSH5k9qt30gpJ0epa+w78WQUgTCqNQ@mail.gmail.com>
 <e4d114e3-984a-482d-a162-03f896cd2053@zytor.com>
 <20250516034232.GA12472@1wt.eu>
 <A89533DF-E2F9-4536-A00D-4E3685565E67@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A89533DF-E2F9-4536-A00D-4E3685565E67@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, May 15, 2025 at 09:17:14PM -0700, H. Peter Anvin wrote:
> Ah yes, nolibc; basically klibc reinvented...
> <ducks and runs>

:-)

That was not the initial intent though as it started separately and outside
the kernel. Also the main difference is that klibc is compiled. Here we
only provide includes so that there's nothing to compile before using it.
We'll see when this becomes an issue, but for now it stands fine.

But I agree that both pursue very similar goals.

Willy

