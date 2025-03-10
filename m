Return-Path: <linux-arch+bounces-10606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584B6A5951D
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 13:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133B216CE0B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 12:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DE222836C;
	Mon, 10 Mar 2025 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhLDU9d6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53793227B9E;
	Mon, 10 Mar 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611060; cv=none; b=XkUU+Lg6IbCXbt0tyoOQowcjgQ4IlaOwP9236oOs0aqmPKlJXjR5/ZWwFvY1FNgFa5X5maPlGF3wWhlm1ImG4IMEvh9V9aRldFimM83s5ACZb3MMeSbHaLzSMez/X1ihHbhypYwLRwndj2LgfW7T7cDLoFyt3G8dxP0f/RengyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611060; c=relaxed/simple;
	bh=m7RpVIHY+r0sfU2i8cmIAET2MityHo7vaehhJ6cZD5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKLHYyTCKZ+fwEZh1WdzesGLNEcU8ArWThpSA9x5NW52Hw5lWsI/A/iM0C3hRx4GY4sl34oia1z6ZgjwH6vY6cHl+IwJjpXMNRGax6nHwVpxK2Qbe/R4hpdAFV7KEVDI0U88I8UpJ7d4NIKI4g7PihsEH0avFdhcQkGbG8GVuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhLDU9d6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso209033466b.1;
        Mon, 10 Mar 2025 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611056; x=1742215856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7RpVIHY+r0sfU2i8cmIAET2MityHo7vaehhJ6cZD5Q=;
        b=MhLDU9d6JMxTIliQCHLpM10w6CGvtoeDzsGFSZHJzwOcySGufaePLvVFVVeYr3zEap
         nTKVhklOSxVFf3lHBoPHGs/cM2INkWarqU7LYaRe89DaN9g1TzHbeN0c6rjHngSHPm2X
         qiMDxNPWhFaqnWQfqiwYBYYPHmFv5OTu7WdEZoQmJ6HRgaDY4KvT8rv0VME+vvArJkWR
         dfwmUjd16QgXQUq93RSJsA9L1ZQy5tvPuZIdCI0opn/M0KQRgzIC0EEclIo8r+SmpMOI
         2ln4aYYGj2an42EquunFpJuzGzB/aycwpYvXr0q4PT9ThE9Fhr0/rowCBUbfZRczvGFK
         I6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611056; x=1742215856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7RpVIHY+r0sfU2i8cmIAET2MityHo7vaehhJ6cZD5Q=;
        b=NI9J7f4hTwX74G7RUj/XpRmBCN+phaapa4N6AjFHoIkHYETyVaZXQK8lOSoU1cJi7u
         Hw09cX5N6VMQWQ+pKkYMt99VinLOatcnYMIp6DTevYpRxzAzoiDuE4Sj4tVZvniCA56V
         /xHtfi7LnZeiRDuDN6Uf86Bbx5jpcZhMk3DU6XmQqTM3EYbetR7eEgQ1xpUAOBbB7G+Z
         MIpi4LR2rL6Om3anIjMr5yd6PJg+fltcq0URXK0Pmh6mAzad0NKOKr9xpkbxLCXy4ORk
         jmb7j/xxc6ARe4vhgDSs045EvXoLVCs5xoI2iIlpiHVQ+ZMej7kDGCqTeFbZQXUlzlUh
         4MdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVngT/eGuXSkVBFvfIaxcE3PjwMqHOWPGWdfrnrgZhSmz0l4CYifEMTXqHVaQO5vffwQmiXmz+qY0iipQ==@vger.kernel.org, AJvYcCX30wDtwmzgb1asSgy0Ap/6GJn5qZeUrvxjcQrrSACJtxLGFOG6hSAWR0fNj2cCa78l4/9MzS5KUdbT@vger.kernel.org, AJvYcCXT9b0adJGTOVUeB5h5kUY9q5n3a2bXrqMHxgdRt6/Ad8zLe22SMep755/Ukmx9TfYNaPHMHbh0Cs6CAxTb@vger.kernel.org
X-Gm-Message-State: AOJu0YzbFZr3gurbwQqmBGJ8GdztkbgvcRa2mdwJqhRB9yWzGVGhBS8z
	YJiBx8GXtl8tenzaQplCU5FiFHQY/8xxDiFCNofVJN7u/PbQkm/R9CYOrWH8UN9bU2C589oq5DH
	3n+uMiwd8nCKTfJZdeBL6hfX8QAU=
X-Gm-Gg: ASbGncsjof+fWUVpqBxkB2q+BsG2tXYo3A5tRDR0dOYjHzopWC3gc3mYHSGJ00Q5Ayy
	89gFD09rSuHMCjL2yKhD643thCmP3ldXq977z/ievpDxc5eEY4ejncYTCDKeK+rW+8tQrBKwfnc
	tkA/J0WDvaMFkPxjNHM4GVqnVlNVWf10JKqwCGbJpDzls2
X-Google-Smtp-Source: AGHT+IEEhoCLJZRXY4Rijvv9tI0tLl/IUwNp5Orm1PRrbMcRZugzWXJ7hXwK/krnr0EUihHMQKx/Fjue7P0l/J3Yjb0=
X-Received: by 2002:a17:906:99c2:b0:abf:4708:863e with SMTP id
 a640c23a62f3a-ac252fb9b4emr1577886666b.39.1741611056422; Mon, 10 Mar 2025
 05:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-6-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1740611284-27506-6-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 10 Mar 2025 20:50:20 +0800
X-Gm-Features: AQ5f1JrW4lh036PUCGXkQlwffXrplxrlmEnJajhWhVG9u6jh4khODFbp1KsY5xA
Message-ID: <CAMvTesAh9hK3r81TqbSwB58c1zuXpMzhk=7=gt2cR1QvpJC35Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/10] acpi: numa: Export node_to_pxm()
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com, 
	decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org, 
	joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de, 
	jinankjain@linux.microsoft.com, muminulrussell@gmail.com, 
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com, 
	ssengar@linux.microsoft.com, apais@linux.microsoft.com, 
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com, 
	gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com, 
	muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org, 
	lenb@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 7:10=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> node_to_pxm() is used by hv_numa_node_to_pxm_info().
> That helper will be used by Hyper-V root partition module code
> when CONFIG_MSHV_ROOT=3Dm.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>


--=20
Thanks
Tianyu Lan

