Return-Path: <linux-arch+bounces-3912-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C44C8AE538
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 14:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9DD1C21804
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD628529E;
	Tue, 23 Apr 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="kKHE9Cki"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351084FD5
	for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872744; cv=none; b=gQ8mslel3xy715ytfRU8+GDKDBT0EhOA6VLMEwZU8BhG6c/A5hDzfqJHjg4XSFGaGMJNafvmsU4Rc/7JUV834uUwJZNsdfHmG5/HEisuDcsn7r1LEXYVXI/uLApXy185fCKLgUgumDOIKQHAyohsWj8vlZCB4Qz+h5IGNFxyBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872744; c=relaxed/simple;
	bh=O0Ua43dYlU3Ikmubwkdm30RvMrIaRpbJc+vhrHYu4Js=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tLA1XjI1ELlOU+JOFDNXSbf+0zjBjfZ763MJjoPDAWKD6WFcaMcGT+SRlPLrCJxIWaQUvDlul3nErMtMDM+jNMzBWXYbvV6hdHG0Lx2RYUOChnd4B48foEKHQ3D/5pXQ7FuBA1YYNBmC3ywO2uAM2psHrVt8UKAy2+SU21M4baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=kKHE9Cki; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so96548081fa.2
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2024 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713872741; x=1714477541; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0Ua43dYlU3Ikmubwkdm30RvMrIaRpbJc+vhrHYu4Js=;
        b=kKHE9CkiIkYm3NovvRSadFDbG0XsnjNGU3tHYWR4WTm6i2SSUTGFARC3L7zPiaw6EN
         g0acvT2DV1VdpKTi6BI2QS1xNJVBBC2+NvJDhwczdj2lvUzGrNHuH9qOz8Ac8YkoKOoK
         jM7B6Mxo3FYZbbNO/sr0JgFk/H0e/ck4013VWWIjJBqGwXDSermP6IuTV1tk7rfqXY1o
         sPaymHFVsKJbCIaz+fRQuXAyTtsaInTXOOeGdDsdpoCJbG7+iWA2tyKVK9H0mToXVJwh
         NxK0wCFMsewJqJkEgJ++BEqB9ceFTXF6p3kYme3Xgrwi1tXchvbmRkgMFXMhtWRp+YkT
         eeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872741; x=1714477541;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Ua43dYlU3Ikmubwkdm30RvMrIaRpbJc+vhrHYu4Js=;
        b=IQkF5x4yhLAWAtoTPBfYBeCzDZ65ivMu+W6AHTUinWh8i8+L3wkjef5mvYl+xFrUjG
         gYqzzQCQeUJcEXZLm/pRvy/tirXBcrn88z1/zoq2oIGHezKZEupbB8yaVCxCT3BZP9sP
         ytIlEr8jy1HpMskjE7n/D0BUIpSRMlZGMVaEzmaFGuGjixMzLad6YqFDMpU8t05CcKJT
         0tIT3OubwGXQ6YmJ8Cx0a3dP8HdWFlS4Z1j8mvwMXGI4ZhXzvtGSOJ3rJkSVKVLE0u/U
         kRecO7XZVKhSBUy73janJRFcxEFdK52w7JZjL3f5Ec6qWClN8YhI6hBIKmzjI/MdrNVI
         vCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX++exqihO0QMBRqoNJcXakonVzOuAzgKSWatj5g7tTLqtQZTu+Grx0oJbem4xRz0Yd25Bh737IRlQUau7zIwiN4VXgNzJ3VkdP9A==
X-Gm-Message-State: AOJu0Yyz9UfCKLPOSahtNUtnjs+axh2zFZS+FHkl7SQ01eCt49YybtKs
	znMmey5HwpyIgPZWF0vBPebdfsJkisQwgg2FtS1WX5hPKMjnVQ36DN4Ta4QEN5I=
X-Google-Smtp-Source: AGHT+IG6hD66WTu1eXwjYXPCnj4l8sUZ4QxkH2aVMHHNRvb0x1iRwoIbqOz56UcaiKLV7da4Xc1VNw==
X-Received: by 2002:a2e:a26a:0:b0:2d6:f5c6:e5a1 with SMTP id k10-20020a2ea26a000000b002d6f5c6e5a1mr9602485ljm.12.1713872740655;
        Tue, 23 Apr 2024 04:45:40 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:dd69:e1e7:9a09:9d7e])
        by smtp.gmail.com with ESMTPSA id bi10-20020a170906a24a00b00a54c12de34dsm6918479ejb.188.2024.04.23.04.45.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:45:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] bitops: Change function return types from long to int
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <e7e4ff27-ebb3-4ed6-a7cc-36c36ab90a36@app.fastmail.com>
Date: Tue, 23 Apr 2024 13:45:28 +0200
Cc: =?utf-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
 Xiao W Wang <xiao.w.wang@intel.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Youling Tang <tangyouling@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Jinyang He <hejinyang@loongson.cn>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <99B58F85-CC9C-49F6-9A34-B8A59CABE162@toblux.com>
References: <20240420223836.241472-1-thorsten.blum@toblux.com>
 <42e6a510-9000-44a4-b6bf-2bca9cf74d5e@linux.intel.com>
 <C0856D2E-53FF-45EB-B0F9-D4F836C7222C@toblux.com>
 <e7e4ff27-ebb3-4ed6-a7cc-36c36ab90a36@app.fastmail.com>
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 22. Apr 2024, at 17:55, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Apr 22, 2024, at 16:30, Thorsten Blum wrote:
>> On 22. Apr 2024, at 09:44, Amadeusz S=C5=82awi=C5=84ski=20
>> <amadeuszx.slawinski@linux.intel.com> wrote:
>>>=20
>>> I don't mind the idea, but in the past I've send some patches trying =
to align some arch specific implementations with asm-generic ones. Now =
you are changing only asm-generic implementation and leaving arch =
specific ones untouched (that's probably why you see no size change on =
some of them).
>>=20
>> I would submit architecture-specific changes in another patch set to =
keep it
>> simple and to be able to review each arch separately.
>=20
> I can generally merge such a series with architecture specific
> changes through the asm-generic tree, with the appropriate Acks
> from the maintainers.

Ok.

I would still prefer to keep this patch free from arch-specific changes, =
if
possible. The patch improves architectures that use the generic bitops
functions (e.g., arm64) and doesn't impact any arch-specific =
implementations,
unless I'm missing something.

Thanks,
Thorsten=

