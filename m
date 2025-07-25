Return-Path: <linux-arch+bounces-12948-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C7CB1197D
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C67F3AAC54
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 08:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F3528A41E;
	Fri, 25 Jul 2025 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxBPOFeK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B314A4DB;
	Fri, 25 Jul 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430735; cv=none; b=D7TwhBGP8DjtVz0DOVS4SXq7k16Fs8l6PCBYk3RQIDJTc2xfNUVwgDIqmo8LVdrwujdFrpGveiETRWbemQggyE4g/h31DeKZImM0pY6WPv6JKD8sWAAP17emU45Vyw8q4ZX5Wwshgl6zWeuOdIpoOnokiM2EkOSPYIKuDOzbYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430735; c=relaxed/simple;
	bh=ajTcppa1gSdeqNwkcD1rjRYogNHde5NOslHrwv9fGRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXkWqV//DWgr2nortyqrqK88P82nkJmd+lKMucVpJxeiGQXGy/ahDLfbZPrcTCFyROMG0luM0MgZP20gdEN77tfNtzb8zaguf+2A5swb5IbEGDhlUmce0FQyA9xE7NokjwMNxhK4oNCA+BnBQHplNIoFQkRAEdkSPcc6UU0IOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxBPOFeK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso1511117a91.2;
        Fri, 25 Jul 2025 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753430733; x=1754035533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajTcppa1gSdeqNwkcD1rjRYogNHde5NOslHrwv9fGRY=;
        b=SxBPOFeKxBijipwtaKgpueVbuzBpnQJanJ7BCF2HtbOErvEM5LdgIWEPSfIDE9UE9O
         4D8YebHw7lkVmqbJHuGMRTKtQMmS9WPUuqy16U6rpKdoJA4rS7P6M2xTnFgHI4Rskyc5
         fSDgKfysQwnyrzPIIDQbw9pdX9afQcCd8DRF6EiyftFynwfVflbLrX2nCQwhiB8utTki
         FjrVEiFaiW62Kn0EuIe/H220KrhMitBg8gJbzPI0gE1n6GDRM1bIBGsBuKAZPqahHahA
         jRCUD/eJhWCN4JSENXc58/UGZpiayX4oHC4rml8fYtTvO9YjHECAqZZ6j/ZP9Yxk/WyK
         uc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753430733; x=1754035533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajTcppa1gSdeqNwkcD1rjRYogNHde5NOslHrwv9fGRY=;
        b=XDtWY2x8RHX+CFPe/SHU5wHjLym4wcgR26NvGq1OoFjaKLNXY53JdxbkAnKoTHjFb6
         C0GcRC9sgN94bzHWwOCKFDqxiO6q64i4frf1LjBFG98/+IsLypOV0VvGg0uvK24a4Zm/
         hP5IOqliUqVn+Uc41688Xk7LmF1m1hk6tSncMqc1UEXI3p+3+8lHuoCWaciUoECWupso
         G/WDKMmVvVO/EsqTICvWh9r+79dCjaRXNFTHNn3uHxTJPtog8kxKeizRnqdy7ud9wJCq
         CI28u12+aQGf1ghSUloUVAkkD6iEvZD9UtTyQBLmH03lErhYb1EBKoDLvMnNvvTKhLI+
         iKpw==
X-Forwarded-Encrypted: i=1; AJvYcCU1oSFm6K2mPPSNxEXwflbM2mbyhX5NjKPh6TLhGjt57wxOuyBb+EdX6sGQxddXPxsPs3sfIi3x3Aee@vger.kernel.org, AJvYcCUCxsIcTKEqydQoUXDVKkSrTc5/utwxPAmJ3QddvbS4xTt5ygtpTcV9wrfjXrJZE58bhRZAQTfYEOstRffy@vger.kernel.org, AJvYcCUNZmbyNDYs4sA+jJdhFJ2L4xxvbG/zc0YyWp9vjkS9dtBT+4cUaaab3NEzOvCw7oD7V3LPioctrVKxcT1m@vger.kernel.org, AJvYcCUk/z0hBKM3YAhxJmLYJXGqmqriD2P+1KuhyX/wxLTG4c4mJdXLDfxdca548Sa8V0P5kmhWsA0HPLRP@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNsPjEzwD598XoZSKSkqom/GQMzGx0Ar5bzU3U/ZnHn7vFHbJ
	U8rpp9KyhgowG46rYk+++A1zqe2jd/YQfr1H+Gc6Gdyp5Vt37tWiLk78oVE1T0edI2yDpyYzgLm
	m2r21U4I5N5Ox++x+XUn0YSUM5TQl1FY=
X-Gm-Gg: ASbGncvaHBBH9q7ibqBLl8eev1F9bnUrR9FMiru85r6qa7gt/1xDka2n3d+iqjXJjl1
	fOYjxbFm83VMzAWONx45eGdGxMFzkqSmYaVt+OCyahfh6HrC1+BE/YhQZrdPrEVvk/mg8D/YNLf
	f5EXcshOSF6oCzoSCR2EewE/Lva3YkW086WR4iNfT+JwiTuwgLV5Pu9LtmCejF5YFa7rKPNmc5s
	TWs
X-Google-Smtp-Source: AGHT+IH0N7juE1ML00NeiySrFmenoxzcFgUIXMma1ZSmVk4GmnlWp8/mq5UTyMmh53UW0+vZkWi5ZEkkBePcY/NEHCk=
X-Received: by 2002:a17:90b:2809:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-31e77a1a3b7mr1399394a91.35.1753430733203; Fri, 25 Jul 2025
 01:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714221545.5615-1-romank@linux.microsoft.com> <20250714221545.5615-5-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-5-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 25 Jul 2025 16:04:57 +0800
X-Gm-Features: Ac12FXyG2VF4VdQLGnMHOU54EmL0I-F5ODIYDs9CDmGbYwFuca8sVz3NIDMA2oI
Message-ID: <CAMvTesCjbsG_Uw_Bttw7vL6C6QDCzx-pxAi1FBGAAS_54LcqFw@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v4 04/16] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
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
> hv_set_non_nested_msr() has special handling for SINT MSRs
> when a paravisor is present. In addition to updating the MSR on the
> host, the mirror MSR in the paravisor is updated, including with the
> proxy bit. But with Confidential VMBus, the proxy bit must not be
> used, so add a special case to skip it.
>
> Update the hv_set_non_nested_msr() function as well as
> vmbus_signal_eom() to trap on access for some synthetic MSRs.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

