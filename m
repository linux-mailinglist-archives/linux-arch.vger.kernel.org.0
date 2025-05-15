Return-Path: <linux-arch+bounces-11961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C58AB8ADB
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 17:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28B7A063D1
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5C8215F56;
	Thu, 15 May 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="oOFcLRQ+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16B420C026;
	Thu, 15 May 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322944; cv=none; b=rvjckK6p1jAlnT848HNQgnavdv9ojBLjhKktMdYL5Vuo594oZuf5+PORuH4tWp25ErpBhmVaKSx9mlJLUCaAF2JkJKzUmWaovLNmI39QVp5PuTnGwlp8hcCM050xyhJ5W6g1hSoAsq1zwdiDCyt7RMaILoc3WIDeV4DiNk1KqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322944; c=relaxed/simple;
	bh=N8AmQbDnBg80xLJ4bl9IoRN+LiOVImuun8i4jZm8Kms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKWkRnbS8xyRGXGXTBhmKVTHEvKoQ1NPFz1GjpiUn8xKzvGId77LEcOtVh73qcZOG2jGlpdMs87t3IrlGCmFFgshrmwtEHMifKX856eWBa6wukT7ra1GJ33pPH7CPepQIJ3dwiV36fdYzb/xZsh3pWBH1uueW4QgHEazntcKyQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=oOFcLRQ+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747322932; x=1747927732; i=deller@gmx.de;
	bh=wqHMrJ+Lxo4x9CKr+xrmfoEaqN3c4tc3hDCo/wnE2UY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oOFcLRQ+2v74Vkh/TTGotJZQgmB9HJA9WPckb8NFoajB7jj3Kb9YbgQM4hMV7onC
	 M9J1cBPI09Po0aPcL+zZxonJO55Jx1YSzGzNiwZS/Y8ntABDWYlmyMxkkotz4B4PV
	 ZMKpqKrEtxiqM+bk+aQkogYVKJvNwgB7mSLnn1KU5MTLc7pYc6tPMrezHZpINyneo
	 p1FS4vcHtsy/Sf+EhERtlfvmyuu4gLIOh08P4X46NoloONqCSFswXW3e+d+TT7DLl
	 H772e2vNiMRUAM30pOCWlrtrhfQRWDJDEcelw1OSEFfUxM7qqHQGaBzYIRBLaMCbp
	 WkS1QQJAW66XZnXSTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCKC-1uaZq3451Y-00LIQ3; Thu, 15
 May 2025 17:28:52 +0200
Message-ID: <7622c721-3335-4200-b2a4-5802c67b4b58@gmx.de>
Date: Thu, 15 May 2025 17:28:48 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] bugs/parisc: Concatenate 'cond_str' with '__FILE__'
 in __WARN_FLAGS(), to extend WARN_ON/BUG_ON output
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-14-mingo@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250515124644.2958810-14-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CXz0jss3vNV6n4o+BqrRZg83Y/UKdO4xjdHufqr4tqfUQ87z0xb
 GKjVhUow6uoBnLSxVY4TlHJCXtj6ywYXZn1w1ue1JBmLxczkZ2cZCFRNSLvbjnJT61Jkyjh
 X7kTZVRirdCRSfEpZEQu58mMnGvz4OaCI/lIJypfoOUH5QZQnvU5LxxAH0eqnOVefM0hwQv
 u6jpQeayaAIrTivNfTTdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:18cT2SIOHww=;tl6lOsKyI1DkePwv8xG6qWsIyKc
 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

On 5/15/25 14:46, Ingo Molnar wrote:
> Extend WARN_ON and BUG_ON style output from:
>=20
>    WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x=
410
>=20
> to:
>=20
>    WARNING: CPU: 0 PID: 0 at [idx < 0 && ptr] kernel/sched/core.c:8511 s=
ched_init+0x20/0x410
>=20
> Note that the output will be further reorganized later in this series.
>=20
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: <linux-arch@vger.kernel.org>
> ---
>   arch/parisc/include/asm/bug.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

