Return-Path: <linux-arch+bounces-13155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5756B248B4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 13:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423011AA4F85
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056F62F83B7;
	Wed, 13 Aug 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyRGq9k2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FD2F83A4;
	Wed, 13 Aug 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085487; cv=none; b=epYriWq8WCcOlgGJSjTKrsmykltj+M1c9ovhh6sKi85bH6PjQ8zI3Hm+dvxMUyCkFw5+idL/ZjVU/39aOIny3NuYqMptGepZrDBm8OKXl7SQiHAcOBIp41a+IabQkAAcfY0NAtk94ZKQFNLLllVFWWuiRyoQp2DQKgXM5i+O7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085487; c=relaxed/simple;
	bh=LtXMBSZ41T9S1VXli4K642aHlTPu7kIv4WO+OfZj4h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSUU1Dx/dbCwh9cRBs2yDceb6Hxqgcxyyx+M22mXkNAHaPHq02aIFDbVszjyCNF80JpI3HMN0MDgoAwOUj8Ip0+xCfGRJRmmtBCP7LR/+ivj3hNaELehP729qfZ9+Mdxr4Bkumrfv5pFKlRr0lYX4uLmmquaqPg0MAqFTFvUcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyRGq9k2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b46f9bb92edso1361423a12.1;
        Wed, 13 Aug 2025 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755085486; x=1755690286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wxzRyPeeBw0qg9nt85647b7kMZo1J0UshALu1jRYAw=;
        b=QyRGq9k2Jv0Wj06xPiPHfKFnpv9rm46+hpraLoyBQOYGxGQjYZMKQoMD3SQl+0REwO
         PlR+Q50+bKeKV5DSsj2wbHvyiRqm3DTH7e92cwCwZeVacMkLsJ9XadoA0TZa7KOHv6NY
         SHqJF1/m1trwYf7X4w792qIVs6xxSGqzv/JzQVY3AkmWD8TD8VKcmmo9MTmBVtumRsR5
         ZCopxZVf927c7qUAGkpQUxTzcziu+LLqT0fSPWZ0E1zVHkTD8/npLTb3JQ0lGPeWeBvH
         qC1hT47FolUXttHElQHiwfgPGxWojiRyPgbQTAnnx5jbLqmcm1h0Tbykajiq0DRdznRl
         vC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755085486; x=1755690286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wxzRyPeeBw0qg9nt85647b7kMZo1J0UshALu1jRYAw=;
        b=s9PSOVVbNeVrQAyXHA0O6PhqxC89fiiUCX4z/vsrhgKq885i/WY+pseE6wnn/ySCbf
         c30RSKxuuLSNtrrTtXPnGhjbS32Is/FMvvmGUuf5JZySsz/8YovtK14XCRDYNTu2TpII
         lXr+ERJtTF7L7HJiOZ/KpRs1wq2liDSqAR6o1VDzgVh/ogxk1Tz6a2kfWdemN/2KjjC3
         qgOqGb8tSt8Bkz2iM/yepUYZPyOpXZKeExUA6WM0eaXYF4stVctN6Bp1MZ9GV9bLoBkj
         XzE/rZ9cwyVCMjX8wOYwfyfZzVHZPvRPvwhWwiufXWNyfIhH8r0ozmRE3Za2Puo8u2AL
         CVRg==
X-Forwarded-Encrypted: i=1; AJvYcCW47C3xtu+7LYXYuC/9QlDjilB0BTpt9QNmaWmWhZ/T9/YKJFCq382otWy5kcKoRmEEXZlzo05na7zkxSzj@vger.kernel.org, AJvYcCWJrwqF94oAlGjpQA5xQ0QWIVDHRtMxFYXgEyAbTnE5NbEs974AOJ/Ne+K0YaxDI8g9Wr+aZ/SfPHYA@vger.kernel.org, AJvYcCXuw3S9s5novV2fJK+cvBTt8ico0/bG6EnOBmmt8GLOWRdBQlIRan4AESUdbdyF0K4JtrqzlNFm1k/4KU0k@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfd70b9mJV2ot6g7XPW2UpvWlz+fjEizL3+OY1mbO8z+z3ldc
	kxXTCTB++NaGh4ULMhmT6iW+f7NUD8h5J0KM4TQK2Xw3NyNOgzjoqCpd6Whba9qh8K+ogBQ1ASk
	RdHc2b64pVDO08zidjC7hvPGnPh4UdSg=
X-Gm-Gg: ASbGnct0vwRxZ9t7MbeuD5Bn69WZBZFwANflErpqei89SRgjNCQYPyqNldVHdsv6ihu
	oRCot/FBvMHzH0bd6jPZnyAxPuGPcypkYKYpc64Wqmj68zeu461O3jjUL8VSjsz6dArVHIbUnW6
	YNp3Ae0U6Ac8NewlnfFAjERWWh7DcrCpVXIE/DXM1DVM5HRNVAeB+hJ3zxDmFpPez8IIsYh6btS
	Vuv
X-Google-Smtp-Source: AGHT+IGuxNtcpsKZPZQV35zoLWRRYjfUgSkRCs0DxN58aZFHCBEYcyzmSka5hB1Ze02FYYsyXgGZtyau4+NCq4+i+Mo=
X-Received: by 2002:a17:902:ce83:b0:242:9d61:2b60 with SMTP id
 d9443c01a7336-2430d0b049cmr37705165ad.6.1755085485715; Wed, 13 Aug 2025
 04:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806121855.442103-1-ltykernel@gmail.com> <aJvSfmmArKeEsD01@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <aJvSfmmArKeEsD01@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 13 Aug 2025 19:44:09 +0800
X-Gm-Features: Ac12FXykXIMnCfmy1bhLAle0eywha9M-Mzq73T6QPkVvPbKWrQiEWKLdB6MR78I
Message-ID: <CAMvTesBngjSrvd1Zuto94NzZ-RztnAs3q9LMJohC4OepnoQRhA@mail.gmail.com>
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
            This patchset depends on the AMD Secure AVIC patchset. If we ju=
st
add hv_enable_coco_interrupt() as a dummy function.  If It's acceptable,
I may send out  a new version for merge.
--=20
Thanks
Tianyu Lan

