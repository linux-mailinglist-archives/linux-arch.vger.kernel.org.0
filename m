Return-Path: <linux-arch+bounces-11843-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732FDAA890B
	for <lists+linux-arch@lfdr.de>; Sun,  4 May 2025 20:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66E43B19F1
	for <lists+linux-arch@lfdr.de>; Sun,  4 May 2025 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCC72475CE;
	Sun,  4 May 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="QD8Ek0px"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF20815C158;
	Sun,  4 May 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746384840; cv=none; b=V7IlzrljQ0XbupJppLFuzAdTLsWGfTLxtbZxOlRhvMMBAfQHBZCcIoXFFxdxkgWZe5tqBURpo5M4tyz20SHmbSaOrBdyBwqP9Xh/LmIfE9kw6bsGnPLVNZvnEDITrYrAswRw+o6aZRRAb1EMFgLhUD5hDEF2WAGbkasKT8JXH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746384840; c=relaxed/simple;
	bh=2hIWaNmlaC37OtaVC5SI6mLrurBqLWEYrAaIZ5e7Zlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFA0QeZUguL7akGxEUoMjOdi44ORp4Hd6TwbGA3f442gr6oSKjOAc9rjlz2pn5uVECXWUM0LEcz/NAB1P0+gt7N9qtJtpkf3FHIRK16UMpBDSUG3Gv37mhAuL/MwGRBkySoGJ5eczh8uDbhcM2ph7r/7rlyEN+KYkdo3b1XB0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=QD8Ek0px; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746384833; x=1746989633; i=deller@gmx.de;
	bh=lkhJexVslb7DfYZh51jAM1kkx3NkgOI6Ka37f26gAuc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QD8Ek0pxTNMJBJB+bR/q0muYt6TaHqhYH6JxOLdqco0X9U5GVg8EljchhQq/Y3j1
	 yxrJcE9jOTqHLLWaUlovhy0tJ93RufhEhQBJlI1CTvgL3J9fftM4f0mxLn1ukpxG0
	 65mD+tyhGOjvLhrEJi+XeOj2JJY0lbPaW2O3Mk4+e0lr/BEs3Y6u4v6HnEzxLHmxj
	 Zd7OW+bCMZ9masXbiXn0FhTBzGgqaAibggjTh2iCKTdc6lvOjSczY0YlQnTqjYoYg
	 /amDt2srMF2jN1JDnAN5QZNqWT3r8GiXy4LMDTg4Z9+t7SV41wV5lBX8B7wj+czas
	 b3f52SpuqnX6DOZn/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1uHelX2nhS-006dqA; Sun, 04
 May 2025 20:53:53 +0200
Message-ID: <4bf2981f-fbcd-46ff-8d35-9772b35263f3@gmx.de>
Date: Sun, 4 May 2025 20:53:50 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/41] parisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-26-thuth@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250314071013.1575167-26-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bdhbJqautSqLHbu+aJesTRxuyglGCjOnnMraEDXKiq+OLWfM0Ps
 6D3nu4fcOufJGmNOOrUXWKFV9Ky97fYpcr6QNdChkVTnH+qTaAlMmaA2mc2GsrBXvwEEkoT
 g72HExB/10GS7HX78MEzwezeowN8pbGQLpflQDj/UOij2xvybCmkYTABRjjueSZw2q7nums
 oyS62+TayFbdWCjKVATKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:36oS2efrMdk=;v8Yt0Rg23Ex8f29IaZn/0gkZlj5
 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

On 3/14/25 08:09, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize on
> the __ASSEMBLER__ macro that is provided by the compilers now.
>=20
> This is mostly a completely mechanical patch (done with a simple
> "sed -i" statement), except for some manual tweaks in the files
> arch/parisc/include/asm/smp.h, arch/parisc/include/asm/signal.h,
> arch/parisc/include/asm/thread_info.h and arch/parisc/include/asm/vdso.h
> that had the macro spelled in a wrong way.
>=20
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/parisc/include/asm/alternative.h    | 4 ++--
>   arch/parisc/include/asm/assembly.h       | 4 ++--
>   arch/parisc/include/asm/barrier.h        | 4 ++--
>   arch/parisc/include/asm/cache.h          | 4 ++--
>   arch/parisc/include/asm/current.h        | 4 ++--
>   arch/parisc/include/asm/dwarf.h          | 4 ++--
>   arch/parisc/include/asm/fixmap.h         | 4 ++--
>   arch/parisc/include/asm/ftrace.h         | 4 ++--
>   arch/parisc/include/asm/jump_label.h     | 4 ++--
>   arch/parisc/include/asm/kexec.h          | 4 ++--
>   arch/parisc/include/asm/kgdb.h           | 2 +-
>   arch/parisc/include/asm/linkage.h        | 4 ++--
>   arch/parisc/include/asm/page.h           | 6 +++---
>   arch/parisc/include/asm/pdc.h            | 4 ++--
>   arch/parisc/include/asm/pdcpat.h         | 4 ++--
>   arch/parisc/include/asm/pgtable.h        | 8 ++++----
>   arch/parisc/include/asm/prefetch.h       | 4 ++--
>   arch/parisc/include/asm/processor.h      | 8 ++++----
>   arch/parisc/include/asm/psw.h            | 4 ++--
>   arch/parisc/include/asm/signal.h         | 4 ++--
>   arch/parisc/include/asm/smp.h            | 4 ++--
>   arch/parisc/include/asm/spinlock_types.h | 4 ++--
>   arch/parisc/include/asm/thread_info.h    | 4 ++--
>   arch/parisc/include/asm/traps.h          | 2 +-
>   arch/parisc/include/asm/unistd.h         | 4 ++--
>   arch/parisc/include/asm/vdso.h           | 4 ++--
>   26 files changed, 55 insertions(+), 55 deletions(-)

applied to the parisc git tree.

Thanks!
Helge

