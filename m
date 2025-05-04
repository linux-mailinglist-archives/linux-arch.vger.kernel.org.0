Return-Path: <linux-arch+bounces-11842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E6FAA8908
	for <lists+linux-arch@lfdr.de>; Sun,  4 May 2025 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2BE1758A7
	for <lists+linux-arch@lfdr.de>; Sun,  4 May 2025 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1324E1A83F4;
	Sun,  4 May 2025 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="V2uOYIaN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF303B1AB;
	Sun,  4 May 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746384810; cv=none; b=O90DSIlNtMZXm+r8wSw9ss0aFPqOagk4IMn5ARVKgKwoqkj+g7ojR/s9u+CCiFqi8OJEvdV2lK5Yk+v5B5g+jlFXsGuAkO1CUYQUhDeAPLaxE6pAgVpY7qEc5WFS/RDYP5F0emJcr2yFKwLV40zon0KWQ0QVgn1fgmCJrSf09HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746384810; c=relaxed/simple;
	bh=c8gn67RTaTfVkf/G6RLVDN0hANTXayEs/dFQv313mkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lY9t7LQ3n1laF9bOjXFbXlpMXPCqnncq03i3fgCpYu0uxyoKaKcmKyg1DXaR7v9WnRI78tefSoY9Z9R8FyWCpPL71u0U9M7YQc8aZA2WlQyziclNOoTee0LNLm7x1dK9ELXrq9NeHcMI6PnkvFV4AvT5G6DJQcYXpqu0XBK6qi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=V2uOYIaN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746384805; x=1746989605; i=deller@gmx.de;
	bh=a0d70L27/A4FU4ASfwuTvg1jiiQflgT+z1e5/sMqb+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V2uOYIaNn3CAQQ3l0oOAaEMCMl2P9sVG9nrN0/CtUGgmLCUN7QhfEJvgANuK3Arp
	 P10P1gBPez7GPqAsZBI+0KDQXO53cl0aao87ILL1UMQDEAsnG8HOvnX1UFJC8hSC2
	 DYmM2frWCXQzeFchurGciCtBGVM3rn8CddLArtPUfDoFjZ6AHzOfcuAjzZTx4DXf+
	 cclFQvluAnkybo1zErGHsqaurJhDKLImzV4yz3WvWnYcDo7QANqk2Or8D2uHvqcSy
	 OMQq+AfmfdUQTe++Q7Lg13YbhhBX5G/jEOD+mQg74RBuH9tajfwWLKVYXmfuWA+gS
	 yH4C8mTK7Pr5wEHb/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1vBQ7O1q8t-00sjHR; Sun, 04
 May 2025 20:53:25 +0200
Message-ID: <fbd000fd-63e5-4a7b-99fb-268fcc8d6f78@gmx.de>
Date: Sun, 4 May 2025 20:53:19 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/41] parisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-25-thuth@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250314071013.1575167-25-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c/v1ahHtfBLO88kSOfnFhmnkKlIKspudXjfs5tz7hy4775npUEY
 PcxFF5wdmHrjQSLfE4HWoOQEHR/f4SpvOZ84ForQdx6z0TXeHYjcB8VGWoAewCKjky1hbaA
 97BRcDYsgOzqzfetEvhca+q5qYH62kyqc9ZyIJ6eLQfOA1QzYtEy9e+QOaRb9lpb9MPERbu
 KzDf0xL2MdUjFaHiwgSRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U/Eau3I6N+Q=;e+J7izErBL52yWeUNJMO62fXbd4
 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

On 3/14/25 08:09, Thomas Huth wrote:
> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
> this is not really useful for uapi headers (unless the userspace
> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
> gets set automatically by the compiler when compiling assembly
> code.
>=20
> This is almost a completely mechanical patch (done with a simple
> "sed -i" statement), except for a manual change in the file
> arch/parisc/include/uapi/asm/signal.h (where a comment was missing
> some underscores).
>=20
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/parisc/include/uapi/asm/pdc.h    | 4 ++--
>   arch/parisc/include/uapi/asm/signal.h | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

applied to the parisc git tree.

Thanks!
Helge

