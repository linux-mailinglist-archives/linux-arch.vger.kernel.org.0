Return-Path: <linux-arch+bounces-12950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD14B119BF
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 10:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AE71C213A9
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3612BEC2F;
	Fri, 25 Jul 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQqM6M1V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA6192D97;
	Fri, 25 Jul 2025 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431838; cv=none; b=PmsGwoN7p4gNtlKjDZHCg4JVrKE+kcO+mqN/tVKmDgsYUFB8u07qG6uW+q7Jb882z5w066+tDb8lyDBzdxyhCd+D74ocTMMgf3z/KUA/9gylFBS0mWgY8oEkJ9CF4nQcazvLEOyZypFJVTGgEXi/j39v7oNmBE19Pj/pYea/sGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431838; c=relaxed/simple;
	bh=skfHYZImCEPR8PWUsCYUavnSxBKsiLEfsDiV0RFHlDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mceGFhGEN0+nnI+Hi3lJ3EFLTT3AAKzl40ipP9x3ukkYCwln7+Stp7i8Gwt8yqKent3S1K5/5AL3t9fA/RDNIuILf2atubTvRbjXDKvPZ4VWgmD5IfucOajgxNS77eiGBhMRkq6oqtii9UFA7I5JiXI8alBTfSKOvCaOIQ63NDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQqM6M1V; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so1678477a12.1;
        Fri, 25 Jul 2025 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753431837; x=1754036637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skfHYZImCEPR8PWUsCYUavnSxBKsiLEfsDiV0RFHlDg=;
        b=DQqM6M1VcaexTSad1urXL4BZ4qTjFpw/Lmz8EfipJg9eStshpHltLDARKUIDPeGnkt
         3KMRXUGddGO3U9Tm6vWnTlQV/iPaoWc0SO+Gfgo0bM0SsiwYrNff4ya+LBtcf0GNDc7r
         STr10fyUXZG8qigQmHpWPOA05HcFqqCZbz58cJkrZTBH2tQ4WfSpHM7KNugf0uGNOdT/
         1ulU9LFcgcciQmd1zLNyg6tz6fsH6yDUBnCQbJqccLKjzXjB+RVTUNg4Fm0hjsj4SOBu
         /vIlcRfUJOkx1RsJCYgRWKFinqAZFzac6jDtp+rRAyVJlSbb0GmRk67tcerjbzuMUyuw
         t73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431837; x=1754036637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skfHYZImCEPR8PWUsCYUavnSxBKsiLEfsDiV0RFHlDg=;
        b=eP3kVeJMZx+qMBxOXNSPcJfqZQ4h2Xoe+vTEMaj8EwM/Twsjkx9I1L5HrowMWnxBfN
         0hklDiU+vuClZ3Zu63y26EU/smWSEYDOf52thyxYXdedbiFJU9yEMH1xPHAgPYrJxIOV
         7orC07MMNOTfCvc7ONNmpw0G+MTgXreo1q30Bvn98Vn+RjStq5eVJC+kygW+Ao72PdkH
         HbJHaJcXhu4xxUt3OyGJUQcHwz/K65ESW4h5whzUbLQBVlZbg5ucfq072D2jKsQpW0iX
         1467IEZIiuS81QbV9vOSpiK8PNRYdO3KLPA+/C58U1bs5oRu9mhQz9fBw5PutygZyaJe
         R5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU7i0zzqpHlRiWjpevoi7uvDyAz1Id1plJ1lSOVcDFBDc/Afx8nr05tCWV2+FNL6XLJY8eAf2a7c30Jo6IY@vger.kernel.org, AJvYcCUNhhmTccaJwNRuCZoszl1henq+xOCUEZjcbhbq/NOCqN2REBVHWdveaSxzQBsC5hYgNo9CFBZeVOZS@vger.kernel.org, AJvYcCVgfnIYh5NlGe09f15M2xnyfeei1I+wrRqwR9BaFyY5Yp4lxaSnYAN1QNawbhd9MFXP1s3uckFKq89H1kiW@vger.kernel.org, AJvYcCXsGiCceqIX5689M+VDHLc2+/hJgUrXQVFAhVk+ANzxnBmLGphLkriKScEEp6hUfOUBp8SP9RIZP4Ky@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbBqRz02LPYSudm46VNlasj3g+JqPV3Wr49WMihjbKEyOqAyT
	VWaEwhmdkznMoZw8fRa9mx67kc3QUe5eJ6Lita+HNdhPdu6zoD9NxJvzFbTO9+jgG18FPhyy873
	o2ttFEdvoN6/BZcLzLWjXe8ITMPfZ5Z46X4cn
X-Gm-Gg: ASbGncvwom2mImxYRQ1vmRLbv77dyhbGAYKonOeKXFpm5f9G2U/MgF6Dio0CKDgAtPr
	DpBuajB+XdAbDkA0fSlUP0RN9h4ebX+3ImnQk7V8FS4vk4DKxPds7Fd1uHKbMN9x+Ks42tMBgD8
	YC/aqoWJhCScw9nQcCm4Hhqs+swb9tmmgBN6WfXh8I1gpGfqMiaOnGods59N3HWVyB5Aje2KF2C
	gxi
X-Google-Smtp-Source: AGHT+IF0DLuHKttF43YAHz7O6tHgoNvhE3+8geOKGjB8lYzDiT+qyeGy5nWc+F46EyDWofuUnDxfhsVhLCEV1F6KMlM=
X-Received: by 2002:a17:90b:2751:b0:31c:39c2:b027 with SMTP id
 98e67ed59e1d1-31e765d03efmr1975273a91.7.1753431836653; Fri, 25 Jul 2025
 01:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714221545.5615-1-romank@linux.microsoft.com> <20250714221545.5615-7-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-7-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 25 Jul 2025 16:23:20 +0800
X-Gm-Features: Ac12FXxL4ULjVNsTL2CjM89TDvywnTWNYgT1ZW-E5i-5hFeFE92-4wgkSmYxtro
Message-ID: <CAMvTesBMgo_u50C5_FwfdqhGy-1k1GhrMP27BL87DTuZ-ZuV+A@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v4 06/16] Drivers: hv: Allocate the paravisor
 SynIC pages when required
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

On Tue, Jul 15, 2025 at 6:16=E2=80=AFAM Roman Kisel <romank@linux.microsoft=
.com> wrote:
>
> Confidential VMBus requires interacting with two SynICs -- one
> provided by the host hypervisor, and one provided by the paravisor.
> Each SynIC requires its own message and event pages.
>
> Refactor and extend the existing code to add allocating and freeing
> the message and event pages for the paravisor SynIC when it is
> present.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

