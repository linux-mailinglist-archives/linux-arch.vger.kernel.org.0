Return-Path: <linux-arch+bounces-7614-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F198CA24
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 02:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E57C1C21C36
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 00:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B711392;
	Wed,  2 Oct 2024 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="gED2UN9B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD22138E;
	Wed,  2 Oct 2024 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727830681; cv=none; b=B7lQP0Y6nXVQMTxSUTe3HhIFfZQt8SQHZqjkDURRmxK6/5he/AjK2JZHPRkhFn71cJx/BhqCN5L7nhfcuT9PNHeFinhmxF6LRqqW6Gl9BUfu3N7kDcTqRVC3kFGJ0ReNtmxHU0ffAJtDcWlTh45XfN6LUvuuv/Equh1zLEr/wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727830681; c=relaxed/simple;
	bh=YM4Ik/++skhu5+1aPGoe6mNpuU96S415oYDsns6XXx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhu/uWqbdvIGESZXJfDjjx2JwlsFmzLOWVzwKf+rvihkQfjQhALZ2+M18uw5V0hNRVBSs+2f0YJW2VAtiyV18V1u0EJZ+8+C8JgiPKRemGFsl+eVLSL8Rc8SsePjm+YUdd7ElbcMbrpmDef+AYXR1eKfh3awEwEgz6ShMHfbU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=gED2UN9B; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727830669; x=1728435469; i=deller@gmx.de;
	bh=YM4Ik/++skhu5+1aPGoe6mNpuU96S415oYDsns6XXx0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gED2UN9BR/UgJ6k+cTtmp7r7gvchXAilWE4Hl+B8knsSZBJPciuWgVMmZA6pNZlW
	 laihyRAfIRyGD2Nbowu5UZ1xBztPKTwcTvzO1+K+jfRBff0eb2BVoEeoF2voUVc08
	 FuRraIa7RsAA6vWQ9c2SAKtS4TXxDo3a9GsjrZylP2IkAO7g6j9HZlzYv4m2Rjff0
	 qhAaPBE1Yb0A3AI2c6a3HZ8ZJxQVY90wHTPHMHnPJ71+mauxbefB//5t69OcPAAhN
	 DCbgHMXO11VqStlHdiR7Jfy1qWpSgi8ByVdTR3TBcoFGQKoD59pSrFhLbiNov1yaG
	 OTVjEacz6+7HjMSt0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1st2nK3aIw-000OE8; Wed, 02
 Oct 2024 02:57:48 +0200
Message-ID: <9e7fa2c6-ae0b-458a-a4ae-a216a3b11a77@gmx.de>
Date: Wed, 2 Oct 2024 02:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] parisc: get rid of private asm/unaligned.h
To: Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>
References: <20241001195107.GA4017910@ZenIV> <20241001195158.GA4135693@ZenIV>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20241001195158.GA4135693@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nqzp/cA84bRl/eFMJ6RrdgYoh3MbQi5dYx4KbfZLxvkV1b9Knl0
 g+HM8akaIMOrEljIqaH7gi31aj4D8unh2zhUbT6ZfWyF1qU/ApPNAoC4870W1Rn+OCCYvMN
 qrHWJaq6VtNJBXri3ZeY2a4L5aLMgxM3Be53HN4HwDRi7qtx9xBs2CpyyOqNbo1uKiReYwA
 Ws/13v6DJvCX7YfL251/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+KMFQLB8iUw=;pdulnsSUsLBi5xMMBOagSKhkJ4i
 QOiPiQRgqF2G+T46hr1N+G3ZPgvo9zgmyvWYrnvmDDjHxLDJ7irAtsdKtaO6ZMvNNZUZtk11d
 2nPU6fo7IN8BjXH6K6KGaqp/SFNBOH0/uC2uhf0L5SpKiP2g21iKNwcAg1q683nm+YCescI8I
 3JU9epiJ7BCp2cRqj6YhZ/Tu9/7ClPUjT/kXrWnREt6EzN5bsjWKyCxJLAg7jKM65GPbypnPr
 pqoAQ4ETfTnLNT7xQdPnBVv4ub+hPJLqAH/eprfxRRIJg4qxmNtvvBdO62falF3PqX7D0dWeM
 8lbWu8Y/DiAGG/bJ1mAHlDcrjrKiOLMrTGTYFFL259b28EpU/QUgmMLrU+CCPMFrE9hVDX8og
 xconl8NWlAF4QLiMfZR46sbqFl3sG6uQC4gPFQOqkKUhq5QK4s9mUZYf4+769JuuOrnL5SABo
 8LJazLoUkippyYPJ8xG4MFjx7OUe4QLIf23xoNRafBMdXGdKJG0ZMxt/O9/rMzhrwoez9N/RF
 Lvcc1Tv+czaFaLPXcy8akag2cfWgTs2cagZR/XkwQxX4xSWmeFT7CtBLeu6FB/1O7dfz6PGZh
 lqlpaiUEGd83TlENKYtrLQZdul5KGVNF70CIasCuP/B+Jicf2joT/egAWN2mofVmIkojfRUwp
 rKMkErhnpZoqoU1G12ij04J3II1t1ktLPYiL8yGetEvSs0xwkR8lSRzjDdQy+CENE+5y0GWIi
 3D99kSiW86wuyRt0GAH3rzPn56/UjywrPeSowmtCXogMTXGDHTQz+QE7mFf8pu7dpaVJ26jT6
 J48Nk2R8CMJfuU9So4VodKbA==

On 10/1/24 21:51, Al Viro wrote:
> Declarations local to arch/*/kernel/*.c are better off *not* in a public
> header - arch/parisc/kernel/unaligned.h is just fine for those
> bits.
>
> With that done parisc asm/unaligned.h is reduced to include
> of asm-generic/unaligned.h and can be removed - unaligned.h is in
> mandatory-y in include/asm-generic/Kbuild.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Helge Deller <deller@gmx.de>

Al, I prefer if you could take it through your "for-next"
tree, as you offered in your header mail.

Thanks!
Helge

