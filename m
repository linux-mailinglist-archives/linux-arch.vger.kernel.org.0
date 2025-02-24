Return-Path: <linux-arch+bounces-10347-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE128A4314A
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 00:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEF318849F2
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2025 23:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2BE20C470;
	Mon, 24 Feb 2025 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GUCUJCV7"
X-Original-To: linux-arch@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698020C037;
	Mon, 24 Feb 2025 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440953; cv=none; b=HWCCJjW10wFXBne5jbQj4+URk5+uWyJQj34TgvVAwA++/IqizfUgnJYL3exuD+fRN1YwAn6kL8BTPooJablIzF7PY1g0sWlC2P+YoQWc5gY+Wl8VY+dZYAvv5+1nRgm2v7/lMEnZ68dLJNeIolSUP6hc69mhiOiGghFeObE2P68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440953; c=relaxed/simple;
	bh=bSZ1BbEYc5oTKZWo6TwEiFHmEdVxTC2MtfdfcPQcJIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iFRLbrzfszfZctBWcotadjFphwtcFNHQl8ekAW9OGNRE1aVKmVsVmYzV02XeD4x2bFJShlyLJssnL3FSy13er+2hZtiJhdjJY3qDr1Z4W1B2UFB40B+MD6rIlElOkhgQPhbHDbDtIt3goWqJLrEZd9Cudqod336se2iLdVlaqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GUCUJCV7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CBF4D48EBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740440951; bh=pHGnij/eQmKrMRgKcJ0yPzwB3EItplvkoxWR3vEZS0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GUCUJCV71P0WD5pGzeQ6pnT03wD/CWTLelZENJYTf2t2PdgTk2KFIb2Ypg582Z2ne
	 Dkrv0sH6cV2iTw9w5UtDnkb3acQcUFtwTyKfMje711n0J7/2APZdWZYl0h60nKMA24
	 JNJDa38zvOpWLFOOYqBm+PVSWazh6Mi1OjlXXTvvsN1Z3ovEHLk4xwka4Gn2R8AumJ
	 7XXe5JtmG87omImTS+j3Rpm3SYTnIGW+JzXwqFg/I8l7zuozaSYc86KKftKV+Qayx0
	 B4AhEQHrwwYN92Gf939Kk8AF9xStt2YN7jkgWk3jtuejtV5ABrzCLEfXEBy9AuJyNo
	 C2+bSGF8eSZAg==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CBF4D48EBA;
	Mon, 24 Feb 2025 23:49:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, "Gustavo A. R.
 Silva" <mchehab+huawei@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bingbu
 Cao <bingbu.cao@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Kees Cook <mchehab+huawei@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Takashi Sakamoto
 <o-takashi@sakamocchi.jp>, Tianshu Qiu <tian.shu.qiu@intel.com>,
 linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 00/39] Implement kernel-doc in Python
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
Date: Mon, 24 Feb 2025 16:49:10 -0700
Message-ID: <87msea29ah.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> This changeset contains the kernel-doc.py script to replace the verable
> kernel-doc originally written in Perl. It replaces the first version and the
> second series I sent on the top of it.

I've sent minor comments on a couple of the patches.  The new version
works for me, I can't find any real problems with it.

Here's the question: what were your thoughts on when to do this?  I can
certainly take the initial fixup patches and get them out of your queue,
but at some point there will be a need to dive into the deep end.  I'm
just a bit leery of doing that as we head toward -rc5...  what do you
think of "just after the merge window"?

I'm definitely looking forward to no longer having to bash my head
against the Perl version...

Thanks,

jon

