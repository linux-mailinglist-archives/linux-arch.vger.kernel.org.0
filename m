Return-Path: <linux-arch+bounces-12957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66591B12508
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 22:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285AA3A672B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AEA24A055;
	Fri, 25 Jul 2025 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoEYZZJM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70EB244186;
	Fri, 25 Jul 2025 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473669; cv=none; b=U6iq5LeE9m1JHjffL1ToCdcgJWa4zBNziQMX31hFxWnlej5AhaopM7GnophVoYRHJVl+KAtIKhM4fpCeWw4Nc2je/74ush15UH01Dway7720S0Y6GJIAVZ9gJQg66XkHsATEvFVQLtzZOmA38yjuqev88k5QrUm2TONNTH8PUGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473669; c=relaxed/simple;
	bh=ol6Aln6sPy+kAwGJe4rTTxfilnbaZwSyHEG8m9t1FlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwPpncNkbntmdcGA9PLuAhrOqoNHeWOzcPy5UBLXgLnfupD5et5Y+BGzYz7gW+flkRUdReDkfWKlChlpAy1EBb2FTTgWi0YbT0KDTEQjetBlSb98rrMvUHJpBj/gS1gA7yfnfX/Dd+ssw5xc2tUj3Cf5RoebQEloWbAl7/m/7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoEYZZJM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3220c39cffso2652571a12.0;
        Fri, 25 Jul 2025 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753473667; x=1754078467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol6Aln6sPy+kAwGJe4rTTxfilnbaZwSyHEG8m9t1FlQ=;
        b=RoEYZZJMnDM3xH595InXDkN2SK6jQDUMuycv6wbt9lOP7ad5pfXcMBdpmFkJ0ifVsq
         SWKF1y2DYPcP+dru/4iGvTNS92kBqDuW4X4zHdD+WiUAQQYlUvh/8j6PamhvOwAnmKIY
         8lmAy/0TPzncBHuOXe9i4tQN4qLQtvVRkwN9zdHW0lREs2CfC7Xx2Xer8MtcySo06AOr
         9rAK6jCxnloIC4OPtmnb+dJActG//u5APW8uGKpM56zErXE6o4Y5JGURxZyBpZO8+N7c
         h8boKfhWt+vmhEtgh+yDo728kgBS8kGv/tC4DcZIjoWvGZbDJBSlrM8F7tYWS9Kxv34y
         NebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753473667; x=1754078467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol6Aln6sPy+kAwGJe4rTTxfilnbaZwSyHEG8m9t1FlQ=;
        b=IyR0RbhOnsxkW5yeKICmlk/yCyu+hyFcrS7l0VGCrIhyfFzcEEf1N1ALFFuVBn9FEz
         yy9B7d3dNVKxFf3VHYuH2fTIgUwVMTumw9TvoPjHJbWInSliNM9XwBOkLuVW7fIq8w22
         KqXfnhgmxZQS0CvoOFdqAR6g62tpCLxaMImGO5ZrNJsmLKRIX0go2pRuhZ5zkhflW1mY
         C63qYyhWYq/BCf4OH8TJNXQp/jeD0QWMdUqsbTstvLsFZ8WFoQXNy7sc/miqNFvgteId
         OjJEEn0B4AHgnMT+tDrWOTRheJCtVBVCz67SAgm7ky+fJCuIOSVInOZTmhrkJcIOxtVt
         5gRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcb3WnP1cdccoYGqkn+ZMTIslAzW4nQx/cmWKzOGTyzl9x2uQ+oq6O4WifV6ERPr0eHG86KuKdw3rN@vger.kernel.org, AJvYcCVQh+ZJHRKro6oZ1T/q0e0DZe5T3hYIzRB352cCPscoW3s3coqwrz21PdkzUcvVdsdjSxAIQFD7BT58LjUE@vger.kernel.org, AJvYcCVqlUCKIEfs2yQMiD7yPStkuTA67Fvo18NzlSxXlmVZtCEVQA6TasKHUFHrTJsWxnR95I9CqtswauwqAfJ/@vger.kernel.org
X-Gm-Message-State: AOJu0Yybz1xGNGVz236J9ue8XqCOhLT86jsfzM51ke1sGE6lPErccP7a
	JOH3Lie3uiRQ9RrEUYDdnkKnacKY8T/0qlCzwXA6ReQnLSOUz/BLAocCUQqKgFpzFg/sT4K/Thf
	z43ygn/TkAJrvagjUjTY62CjgOd3vAuo=
X-Gm-Gg: ASbGnctWaMIKlsZQJbMvnbg9O7IQrWcnktTPg29RViGmrQXnSvH3ytOmaV+Abc89eKh
	BnwXUfHPFYFijA8dfyKoiX8DNsDGwCEnUV+j3rXHOyrLOT+dxDRxgV5OzLXlayBAnuoUBXxDX2z
	Nd4UlZyPoybHkIJrt6bPE+WIkJixU57cxeSjsY9IcWd9zcag2V8VOEsINCIR3R3gbjU/lxwIpLv
	bI8
X-Google-Smtp-Source: AGHT+IGgf6UNH8/6LQ2YpbpEndLagE29FGRi2lKwLM9/Nr+0IXSnTlujsbHfiuEYsT8TptDOhFK0agCussre67Z7Zic=
X-Received: by 2002:a17:90b:134e:b0:31c:23f2:d2ae with SMTP id
 98e67ed59e1d1-31e77a59e53mr4258525a91.15.1753473666054; Fri, 25 Jul 2025
 13:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723190308.5945-1-ltykernel@gmail.com> <20250723190308.5945-2-ltykernel@gmail.com>
 <SN6PR02MB41570FB8F17994FC7DB369E5D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41570FB8F17994FC7DB369E5D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Sat, 26 Jul 2025 04:00:24 +0800
X-Gm-Features: Ac12FXzIsBEO9Jw8OGvtKrgAZbq2XjSoQremtakgA-d_7CZk53d_oep4niRDZLI
Message-ID: <CAMvTesAZVNyqaXG4i8u3VZOq+ubhFBXPmyJ1Dh+ZbHoe3hz=-A@mail.gmail.com>
Subject: Re: [RFC PATCH V3 1/4] x86/Hyper-V: Not use hv apic driver when
 Secure AVIC is available
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, 
	"Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>, "kvijayab@amd.com" <kvijayab@amd.com>, 
	Tianyu Lan <tiala@microsoft.com>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 7:33=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, July 23, 2025 12:=
03 PM
> >
> > When Secure AVIC is available, AMD x2apic Secure
> > AVIC driver should be selected and return directly
> > in the hv_apic_init().
>
> For the "RFC Patch v2" version of this patch, I had provided some comment=
s
> on the wording for the patch "Subject:" and for the commit message. [1] I=
t
> doesn't look like those comments were picked up. The comments
> improve the use of English without changing any substantive information,
> so I think they should be adopted.
>
> [1] https://lore.kernel.org/linux-hyperv/CAMvTesAscN2MyqJXpcbwcXWC-6-en6U=
_c03M+2=3DzcMF0bLv4iw@mail.gmail.com/T/#m893e8cac0314e73ee4626d736c623e640b=
46ef5d
>

Thanks for the reminder. Will update in the next version.

Thanks.

