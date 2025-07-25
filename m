Return-Path: <linux-arch+bounces-12949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24EB119B5
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 10:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82368189C4DD
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 08:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2CA29E0F8;
	Fri, 25 Jul 2025 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC7PL9v2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A41E5213;
	Fri, 25 Jul 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431566; cv=none; b=UGkRZwiBP8zL9tItsXzMe4gLWIGFDsILJzPkTrBHH/fhqyuwr89ofZY8oIjc5q3a49fPB6Kt+BHc/VbWlcNGVy0JlMDx/1PoFdYmwGGqlPr4SDTRR+Js0Ts5JnafgVkBCSlFqnD+lZpJIXuQQaxsWC0e74vNeDHLHRe1AxSEq6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431566; c=relaxed/simple;
	bh=sy2xJtdA/SBfuji7K5FsjuGqNTI6m2xV98GTAoHdlaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+eApKyP3qp/gRWrVB0/1V4DnWFBq/8duR0cka4t+WoJ/NvvWt/sDm2AqEnXTJGbdoRGBiEoL7jXGtJARVWhR0sxjWlb+uWBBD5JsErh5hCVRFixW+bo5hMWMy3XgewKXwA/SmN1dSxyzsfCwNciIfx6tFvSowsNs8SWu2nSLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC7PL9v2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso1662350a91.3;
        Fri, 25 Jul 2025 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753431564; x=1754036364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy2xJtdA/SBfuji7K5FsjuGqNTI6m2xV98GTAoHdlaU=;
        b=JC7PL9v2BO4H6H2Ia2dGG9tm1ZsF17idiHBAyeyYMdOGMC+c20bYCjPGuBvsBFtShg
         J9gACchtOfwkoAYQefQNTo5oaZ3s9JpRkZKaqbcu0gyrtZdaZw7LgJpYrVK1m2ctZhAF
         pAvNfnJsAd3L6tOIeccFTwvmEdQBQ1W4AMIGeuMNkDeTmmKpt4Z3s80+Thmpm/wvdiX6
         Q70/eFsFJuMmuSJ4+f7ahyRBUgQwpgWccyu1FdJMCV5rPf6901SQhWVruBzpkzE7up19
         2mzeaSZIleuoCRu/b4EBXlFFiU4pNI3jV17KMGzp+cydNg59uP//tez2mVKNdwIP3GFG
         6QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431564; x=1754036364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy2xJtdA/SBfuji7K5FsjuGqNTI6m2xV98GTAoHdlaU=;
        b=ItRnqU3YLjPPvxOHTZBgPg3xobuzy/2KaAoYpMVCCAGuV9H/SfZxfM84SGqBhof0ay
         C9UJD0PBU7rtxOx0ztamXHUFEgxAoV/wudQ48rQ5oFh4Bm3xUT60ga/fHR8Sqvl14q5u
         QWrGYg0CMWl4lYTmrANdKf7Jh5T3g2b0osODNXbqoRXtXWNo4Qa30/7yYyvOLaDBQWB6
         Y3ZOJdbmaFWzGWud6RmqXzrKhfbbjZMzLPME6Ko6qizXPn/7PLnNnH5cYR71VrL/IDUr
         i6wAWg/AWrRAwJPf1ZrobEXFitunNJknhVz3bBLMcQDBbsotJIYPWTdm4hd3hbcDUVsK
         Chug==
X-Forwarded-Encrypted: i=1; AJvYcCVbMIkQcXsNidtwjXpJUECkafWDBvBRlMiqWbCojQWTk/+BO8BdYOy6giZmoVuSwb/fW9zSVK8wjRuh9ig7@vger.kernel.org, AJvYcCW358Q1NXjMUkJV7s1QXuoWvwLJNk0fy5Bq7K65l9ghVMvE+3UwbujvL7UGP9cUK4GIjTlc+eS2807k@vger.kernel.org, AJvYcCWMq8d8V6qewO4VPLY8l5iuG8jvn9JWOWStVT2WI83N443Fc/nN2ZsnSQOD9A8xl4ZVhsGngX4zfZRR@vger.kernel.org, AJvYcCXLqbcMtSzioN6BmILSFKx8ZMIloB9TzE+gN5xdNwSPRjAG8zg5w2ekvCnW5srU2RG1PUN5X8r9xp7EUFEu@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYKp44QfcwPIhNuGa2srmtdIOMp0x42VrHHRDYG3Cl7SCEOYO
	JQTLAhboLiRvY+q+QXIxxumpgSer0Vmy00WVgdZ5EZN2wgDJkrVPTrl1QXDt3JuMUF3p1DJBke2
	0AFLB6S1hzQtfKEsRw6jOm2E3X5ONnk4=
X-Gm-Gg: ASbGncs47+l7QeBy5nScAf5kWLiGN6BxwujjDnu2Ws/ymzH6Hg5YWPzLcR4vpqgQUk6
	bSIPE1Z13yNKFN7S5tDnN+TWPjH1ssI1d9yk6/cnG2wRnc/uBWbPaZ4Jm87JhnnKFtPLbZ6+JlJ
	+6Yv+pcC2qCKDl/4AKZ2wL2wSJcJterjrdw9E7dda/+CiUetp1iEU3/bbOyzVbv6gi0f6mMVfhD
	jLeATAQ9DFy/Zk=
X-Google-Smtp-Source: AGHT+IGgzNGe1EcM8WMPC7m9XVu+3funoe1AvSjNFRR6i7PeY6XfKo0eBJhjkZ/bHAe5BjkPVXOCBAznAQXufu35cdE=
X-Received: by 2002:a17:90b:2e8f:b0:31c:ad57:b97a with SMTP id
 98e67ed59e1d1-31e7785830amr1445568a91.13.1753431564324; Fri, 25 Jul 2025
 01:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714221545.5615-1-romank@linux.microsoft.com> <20250714221545.5615-6-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-6-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 25 Jul 2025 16:18:48 +0800
X-Gm-Features: Ac12FXwAvdyBnWojo-UU5PSyFhAlYyp43g5iKOGXsvpn4ryJU_iDi-VuMF_onos
Message-ID: <CAMvTesDdCCH5HxaX8yoA0E3OFAQ-bJSJ_LrQezM6pDXx2CTO1A@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v4 05/16] Drivers: hv: Rename fields for SynIC
 message and event pages
To: Roman Kisel <romank@linux.microsoft.com>
Cc: alok.a.tiwari@oracle.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, 
	dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com, 
	hpa@zytor.com, kys@microsoft.com, mhklinux@outlook.com, mingo@redhat.com, 
	rdunlap@infradead.org, tglx@linutronix.de, Tianyu.Lan@microsoft.com, 
	wei.liu@kernel.org, linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com, 
	benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:18=E2=80=AFAM Roman Kisel <romank@linux.microsoft=
.com> wrote:
>
> Confidential VMBus requires interacting with two SynICs -- one
> provided by the host hypervisor, and one provided by the paravisor.
> Each SynIC requires its own message and event pages.
>
> Rename the existing host-accessible SynIC message and event pages
> with the "hyp_" prefix to clearly distinguish them from the paravisor
> ones. The field name is also changed in mshv_root.* for consistency.
>
> No functional changes.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

