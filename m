Return-Path: <linux-arch+bounces-13156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8D1B2492D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C0168752E
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019E2FE58C;
	Wed, 13 Aug 2025 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Escbfkaz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C902D542A;
	Wed, 13 Aug 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086927; cv=none; b=cdvHcvYZ81EvIBX3ZpOFpik8Kybu6Ap/8ItdUDQNKMPV3LR8hsd1mIYwMUafAVg7jujxpfphCrHMM4Mvo/JnEUNipb0mSLFUV2tyOV+5770+X8u93oWCo2wwRjcRHAiJqJYxN4LHuK6UN6U27JL/Vxv0BSAMtJMqvZQS/jHQj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086927; c=relaxed/simple;
	bh=HDj31UMnmpn+jUQQIsCYn+G/LNwtojgdTHaEeJB50+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwU9+ffxjMwgItNA5AMyTojoCdlNT1O22lpbcC0POZT5Jj9yCOXQSGn9xaC5Vm0NZh9/AiNmsgXDCP6SLqPCvCkduC3O8tMO6upTlTWMAx1MHv1xlnBaTXhYv0RsvPEfrNb8yKp4D91BXC8kjHWnmpKj4UmCd058PTdOcNtQQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Escbfkaz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32106b0930eso6795136a91.0;
        Wed, 13 Aug 2025 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755086925; x=1755691725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWGK8ZVm+zLmOeXTeLHrigp8WDDEd3OtJiB5dxz3uO8=;
        b=EscbfkazOA2OWudjz5D96dJ7LU/WKbBU4UeGMJgY+DDHehNh//iOBuvf+lFoc/GiOg
         MG9FHQ83va0cAGW3ceaE7vGIpYI43mcJAFcfJhNPDFWnH0crYx92nA9p5WeJEwa5O8pW
         YlnMcwouUmw6CRqm1Yfc+8JzoQEyIPW4L0vLoJEGs95n43T/S/Hx0+87ZpbqIyXDqfDW
         moW6WVhVp7KHIchourywCWnAAAAa4QjqumwwPmZ1KuW0buYpV7Z0Fn8TXbVkAd/zgswj
         UeL6dcCUo4DGoxJb6uCCMsQgZpG0RCh09NtSSMQS+neJ1hoAOogcY6N4mLJO5N9p0muz
         Kwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086925; x=1755691725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWGK8ZVm+zLmOeXTeLHrigp8WDDEd3OtJiB5dxz3uO8=;
        b=QwjIOHFED2/3JQmmRoWSfYlhnheinkTIeWEoPt5Ht9+d9TeA7olItq1+3kiliXTyiu
         h4oxqeN/hhqJyiVAD99QnISSbsKe/no096CjLus1MMQa1IOWvd34rO3MnKUfwok1zqW3
         ENBsnHpCWys3KXoIGCzcN//rs/LXWGPixcww7RlYoR1nozQlUrXQ4SJ68nXn5SpIhHsv
         J/dHc5yKwMFaeeEp5qJBiqb20o/ApLwEW/y+7FfYLOb2Mz1tjKV+mdia13jLbpqQoLjg
         pUh8YZH0UM3hfmfkA4sU1ullXL8TbQFFmnkivd2T4zCP3xlrehuaXfBSk/kXZ2lPn73A
         hKZg==
X-Forwarded-Encrypted: i=1; AJvYcCU6McQiqPFhQZt/F+WjOkp5NQs11w4ccML9VAYXHJ3z42DDo6q8N9NoPp+HbTvj/WK34Nw1nzDkBlfV@vger.kernel.org, AJvYcCWPNC32qrarnig0A1pJDDr3npZcG4Y8c/I+WvcVzIg8po9DpJuGs/FA1KXQAdd98OQoJUEVLEw+h4FYIarC@vger.kernel.org, AJvYcCXv4siUYgK0V/+Q5adgMlMgn7EIWWvh3buNT0hYtvHTdU+JNfjK1XfHcXbJR/AeG0qnwAhQGqgqkKZu5PtS@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwkyx6CTZxBLpJS0LC5EngYyBWASn/zjRY7AUQ6NTP1DQcn8u
	KwvRg7ERLPvvZNsV+cWCmp/d9HuGV2+gpID5pHQHk5VLt72Msj/vz6KF/54DSSknPjW+XGgE1AR
	zbgojvnLfdDKXRGqCkhZ7vumpwVMTMQk=
X-Gm-Gg: ASbGncvasNLgC/3NzH0xeNo5BFKUwfMn6o7KFHUMfMJLr7akSz6GznCnoWkc7w86xbD
	F+qNcC27k9mcBOdPmTSAZQqlqrsJjszSG2sEywfgsiXfix+zMEpnEHfvaL+d8+Rnza3X0OHrpA9
	IxkCQjZZuBtu89gUwvlHyN80uiPOwXSfZ/hnllOaEOBaVADRu/MV6uUDN4wi3U+LPtJ7F6O8TU0
	1Zt1QvQJkeNfdI=
X-Google-Smtp-Source: AGHT+IHYBG7HtSYlV/7tSd61CBVNaArOemBmZZcJHliPBDKvdLaYm3tgeApOzZgOm8dRsQoLhVMdh3JSSNoVw9ADwoY=
X-Received: by 2002:a17:90a:d44f:b0:321:2160:bf76 with SMTP id
 98e67ed59e1d1-321d0ea3936mr3036567a91.25.1755086925166; Wed, 13 Aug 2025
 05:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806121855.442103-1-ltykernel@gmail.com> <aJvSfmmArKeEsD01@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <aJvSfmmArKeEsD01@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 13 Aug 2025 20:08:08 +0800
X-Gm-Features: Ac12FXx0aKtcaxYvaGq78870E9obBGMfgQQXueqm3fgWy6WKq47Kn4PVuMXAhI0
Message-ID: <CAMvTesCWxM+VVZhT-AO7x9c=oFWpb7zCtAU23oF95AW5BZnBaw@mail.gmail.com>
Subject: Re: [RFC PATCH V6 0/4 Resend] x86/Hyper-V: Add AMD Secure AVIC for
 Hyper-V platform
To: Wei Liu <wei.liu@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, 
	Neeraj.Upadhyay@amd.com, kvijayab@amd.com, Tianyu Lan <tiala@microsoft.com>, 
	linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:47=E2=80=AFAM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Wed, Aug 06, 2025 at 08:18:51PM +0800, Tianyu Lan wrote:
> > From: Tianyu Lan <tiala@microsoft.com>
> [...]
> > Tianyu Lan (4):
> >   x86/hyperv: Don't use hv apic driver when Secure AVIC is available
> >   Drivers: hv: Allow vmbus message synic interrupt injected from Hyper-=
V
> >   x86/hyperv: Don't use auto-eoi when Secure AVIC is available
> >   x86/hyperv: Allow Hyper-V to inject STIMER0 interrupts
>
> Are they still RFC? They look like ready to be merged.
>
> Wei
Hi Wei:
        Please ignore my previous email. I always ignore something.
AMD Secure AVIC patchset is still in the RFC stage. Is it possible to
accept my patchset before AMD Secure AVIC patchset to be merged?
--=20
Thanks
Tianyu Lan

