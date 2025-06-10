Return-Path: <linux-arch+bounces-12313-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0DCAD3C2F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 17:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA346188E7EB
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16F238C2F;
	Tue, 10 Jun 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwzpjPGZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8513212A;
	Tue, 10 Jun 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567792; cv=none; b=M5nQl3X9JPrYub7i2FJiQCDNp5a11ihrdQicIuzseNc089Annz5xpzvijQfRK4v+RubO4KPGsbNprCQ7Vtj+fqMpCfjrobgIRyEG16A4Jc2AvKxtCNlF5zx4KG7KYUJrMKw6OdcN0DEgylnUoOFxhiUx9Tji3AZmVg3PBvGoYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567792; c=relaxed/simple;
	bh=2r6EAgL0ntBRPdNwAtuZKgExnP4Jg07L6tI4c6g3urk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3fuBKqCV9gAiWXvor9bnZ8ybJR70GQJDLFl3rx3tDyEmjMvJglff5w1iuXZpdq8FU0zIwB2NpMiUhj/FEV2dAC+SaUqZ8/AzoWHwLkmj80qHoX6s6Fuai7q9BC57hFMoZ92rICabkqmQt3IiIYCCDrZeYwiI052GFNUL1EM2BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwzpjPGZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso5308598a12.0;
        Tue, 10 Jun 2025 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567789; x=1750172589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDC9yplPkoPW2UltO3ycsW0uGRdrvTKeooKsDUH271I=;
        b=XwzpjPGZO3kl/MAd16Ql5ukkIKeaaWkdfKdIVYco0Sfs+DyTF1gB/dt1SDjVg3pxm2
         L35aJaMRL3si/iFRkdSV8hQ/AhwONazEHxaEVaQTDs5xFtIubbkrf1WiQ88s21q0ykjR
         vXyMmdX54ALt6y37p5F2zaid3+h+vEeqVDdRUHuPKLPe9ixnpTCqJnjSAnjpnYNUsnV3
         qXD7LBHNu7Rx3wpyT9O5Em6PWewsLT6I2nA7fZOHHgf/E8tvWKVKrzzSrr/jdrgO9jfR
         6ElucGbMf+GJK7E5nSPi7ziRavSINTIcf22+5gSbO9/sN7D3YlDsq281rY61YelhU6uZ
         b5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567789; x=1750172589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDC9yplPkoPW2UltO3ycsW0uGRdrvTKeooKsDUH271I=;
        b=U4TAphSH07dw+aWPolPVhsDAnTEPgqjUCmkNyE+a7Kzzls5rC+jhPTDGDaiALNPmkV
         aRaPJ0MVIXUa4cxqddS0JkrFmDQNXogyK+pwjZ0bp5ALg5RDDWjfoD6SLoBKlZAtZSiU
         rr/O9zO8DzUx6IkTUqZGbqH5v/lfhs6lw5Dvf8Dsy2A2DKd+ceUbFFTlWokuVHov87FI
         nghK1j1VpBkgHs7vunzl/KeCJvkDY3+5NXUe9Kx3QRHo1d3jsAePDwhn2cc5n8ngJYg/
         e3vL7ENRHxpdH9Y2qnc2KrAq4DovKkKgx45EhFsxV6XJPln/E9/Njd1AF3iX1BVrl7A9
         nG5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMSpYJtINkoboe05QvliJG7N6p6zDeewe5Z3IaxxwgNZAEmuJF6QDyhYLN+63uZUqic5K8/+aD5F8=@vger.kernel.org, AJvYcCUMr9a8LrXCKegehs9NGCCu74+Ui97VrdcRnikA+IHh3ebtiVhZ8rOJSsc7rRDLujlYTWrq930pnkvtzg==@vger.kernel.org, AJvYcCUOajZ3sWwHjxrUlSx7EbGGh/hXsQfcrIeWTuxwkxwbNI7OPEAPMbvJkvuJdRNhkg1feKfVypDWNv5rgXw1@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXY4Z/qjq2wMvLqqA57u5Z+xoN48jBkYkm6hNLE0Di03MawKV
	kAw88CaGpeb42Q1tH10K6mAq2UptwAZ4C8k369TKp0rn2GE0vx4B0Ayd
X-Gm-Gg: ASbGnctPfp5/znFHC/h2JQH4fusCWLU3dfyoxhHm0u64DuwF7oWQkoHnp2/ofzGwMGj
	opWlEnZS2slc67xtiq/ioASY4derUXlU393j31d3UwaRfXSy/1WwXhqtyCTN0B08V35vrpf9buR
	kfYkCbkflwGfgYRN3KAU26AXjUCkU7o/rl+Op8C4Kx5/cqxxLVM9qCOtmib+4eSmgeyR9bbekwo
	I8ooCsnwhfNWtHMsxB4l73ye3ZhU7WKOi62j8Tjd16Zqvdk00xAj+nbVCWOQr9OWyLDXM1JO6l9
	G/pdE2fg2mvUymHwwvmxVebH5Hk5e9qs9cArfQo8+nfcG+jIzYd7lUdUusUlcC7xgV/QIX+1Gxb
	+AwcKevOUqd9su3pI0Io3EjKz19nSaYXV
X-Google-Smtp-Source: AGHT+IExlHW6J/JO614E8U398K85uzXlylL1u+bp5hpmTla2vYCO+oDTvmf4xA+H2Z2h6vgzqSc3pg==
X-Received: by 2002:a17:907:720c:b0:ad5:749b:a735 with SMTP id a640c23a62f3a-ade7ac7bd0amr294841766b.27.1749567789056;
        Tue, 10 Jun 2025 08:03:09 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:c2f:a34:6718:ee1d? ([2620:10d:c092:500::7:b9b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d754669sm733541266b.33.2025.06.10.08.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 08:03:08 -0700 (PDT)
Message-ID: <f8db6b39-f11a-4378-8976-4169f4674e85@gmail.com>
Date: Tue, 10 Jun 2025 16:03:07 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] proposed mctl() API
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
 <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/05/2025 14:10, Lorenzo Stoakes wrote:
> On Thu, May 29, 2025 at 06:21:55PM +0100, Usama Arif wrote:
>>
>>
>> My knowledge is security is limited, so please bare with me, but I actually
>> didn't understand the security issue and the need for CAP_SYS_ADMIN for
>> doing VM_(NO)HUGEPAGE.
>>
>> A process can already madvise its own VMAs, and this is just doing that
>> for the entire process. And VM_INIT_DEF_MASK is already set to VM_NOHUGEPAGE
>> so it will be inherited by the parent. Just adding VM_HUGEPAGE shouldnt be
>> a issue? Inheriting MMF_VM_HUGEPAGE will mean that khugepaged would enter
>> for that process as well, which again doesnt seem like a security issue
>> to me.
> 
> W.R.T. the current process, the Issue is one Jann raised, in relation to
> propagation of behaviour to privileged (e.g. setuid) processes.
> 

But what is the actual security issue of having hugepages (or not having them) when
the process is running with setuid?

I know the cgroup proposal has been shot down, but lets imagine if this was a cgroup
setting, similar to the other memory controls we have, for e.g. memory.swap.{max,high,peak}.

We can chown the cgroup so that the property is set by unprivileged process. 

Having the process swap with setuid when the unprivileged process has swap disabled
in the cgroup is not the right behaviour. What currently happens is that the process
after obtaining the higher privilege level doesn't swap as well.

Similarly for hugepages, if it was a cgroup level setting, having the process give
hugepages always with setuid when the unprivileged user had it disabled it or vice versa
would not be the right behaviour.

Another example is PR_SET_MEMORY_MERGE, setuid does not change how it works as far as
I can tell.

So madlibs I dont see what the security issue is and why we would need to elevate privileges
to do this.

> W.R.T. remote processes, obviously we want to make sure we are permitted to do
> so.
> 

I know that this needs to be future proof. But I don't actually know of a real world
usecase where we want to do any of these things for remote processes.
Whether its the existing per process changes like PR_SET_MEMORY_MERGE for KSM and
PR_SET_THP_DISABLE for THP or the newer proposals of PR_DEFAULT_MADV_(NO)HUGEPAGE
or Barrys proposal.
All of them are for the process itself (and its children by fork+exec) and not for
remote processes. As we try to make our changes usecase driven, I think we should
not add support for remote processes (which is another reason why I think this might
sit better in prctl).

