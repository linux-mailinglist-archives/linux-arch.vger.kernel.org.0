Return-Path: <linux-arch+bounces-2988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C8087B725
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 05:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003C62829E8
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 04:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362A1C15B;
	Thu, 14 Mar 2024 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gHN4thFU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD65C129;
	Thu, 14 Mar 2024 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710390802; cv=none; b=SzKtJjsaMJwcfyvLe1xplHIwFuCSb5yTtXBXhskNXgIWgiuk4ecxC6skr189ztoeEilSX4mGpBt1s3iqSg0oygVflHhv0s/4iUE6AOyzATrpbM5RpityzcZoJZPbew2RfcFA2tqEWR5maWgjYjCqXxoEpwE0P8r+aScsH+XWs24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710390802; c=relaxed/simple;
	bh=oaR7INPBXWbSndCIuCySYwa55FMJJjVsfijagh6nNO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3Rxy0Fyaz+f2CNHVeaxaJzxiyeiAN5793lecFGarwi2uiq9p7hL2z+YvRXGSQel8tl7CY047nmvedbQs8FJuZXNf0KfFpSGI8VOehHqhBGnGF44R43rBHdkFiaFP4Y41YwsDh6n+drrX3RtvBYwPCeTHxuqurb20BGex4x/iNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=gHN4thFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BC9C433F1;
	Thu, 14 Mar 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gHN4thFU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1710390798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uV2XXkDShWDvaG98HlCCrocvexYDgtOSoGWgOn6b02g=;
	b=gHN4thFU9HFH+GIAfzpzN2G8K1hJuE5oxAJlQoR+TMEnkRDQF4v5jNNCofTfRZZmcLYF5h
	UZDEG+UbdFEURWqC+ERgqc1KzWxDPGHAQIESVlBwHiedrS9rt2Z4SF4DN5POuVagsdbbsI
	GFiN25pkSyj/IVXpw0U+JQBS3gpPeHM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 89e2a725 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Mar 2024 04:33:18 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed0710c74so392052276.1;
        Wed, 13 Mar 2024 21:33:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWe9UiyCWqCWMrKNFabicRSe6O4kEiHc9KONqQgUz7aMIxK2LIo6mpAjxd3nyoeW4OYlIDJ1RMoC3Nqxh/M+XL+q3rIszoGCoFxGa192aqvDuhIUQgkBak0QkG9IakYFpAeTwbq36Zank7sZCJdRFuhLXb/X9n4A+cOvIJ8ZpoWsx3sF0beeA==
X-Gm-Message-State: AOJu0YwtjC3WRUTxMKsVg8uvS1HbRssYiILIDd2cW+9GTNz7ZU0sbKQz
	pmoEc2FMCoUhuPVmw3ZoWPrXAa7IFGg9xbhyV8tgOYmTx15bYbcOD9M6Bt1DxAymCrF4rFjz8/j
	emRgEcAv7SK0fQ1OE1JzN821S/zo=
X-Google-Smtp-Source: AGHT+IEbDCuzyIkgt/bRae8iwtfrGkhwWdENFBM+2A7+3pyYs6glLpv88gPCloiCTTyM1eEaZfK3iffRsHmBK/1Xsho=
X-Received: by 2002:a25:c846:0:b0:dcc:96db:fc0d with SMTP id
 y67-20020a25c846000000b00dcc96dbfc0dmr596737ybf.25.1710390797306; Wed, 13 Mar
 2024 21:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307184820.70589-1-mhklinux@outlook.com> <ZfI3owmQOKc4Ta_X@zx2c4.com>
 <SN6PR02MB41576DD458EB3C72F3784EDBD4292@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZfJpk94mtwzRaJzv@zx2c4.com> <BN7PR02MB4148FA0075DCB43F1971485BD4292@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To: <BN7PR02MB4148FA0075DCB43F1971485BD4292@BN7PR02MB4148.namprd02.prod.outlook.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 13 Mar 2024 22:33:05 -0600
X-Gmail-Original-Message-ID: <CAHmME9rGm++fA+1=_MkPfdPEsKmDk_P8j_XnUoGC4rED7OYcgw@mail.gmail.com>
Message-ID: <CAHmME9rGm++fA+1=_MkPfdPEsKmDk_P8j_XnUoGC4rED7OYcgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
To: Michael Kelley <mhklinux@outlook.com>
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"arnd@arndb.de" <arnd@arndb.de>, "tytso@mit.edu" <tytso@mit.edu>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, Mar 13, 2024 at 10:30=E2=80=AFPM Michael Kelley <mhklinux@outlook.c=
om> wrote:
> By default, Linux doesn't verify checksums when accessing ACPI tables
> during early boot, though you can add "acpi_force_table_verification"
> to the kernel boot line.  The default is shown in dmesg like this:
>
> [    0.004419] ACPI: Early table checksum verification disabled
>
> The checksum of all tables is checked slightly later in boot, though
> it's after my entropy code has run.  Without the checksum fixup,
> this error is output:
>
> [    0.053752] ACPI BIOS Warning (bug): Incorrect checksum in table
>                 [OEM0] - 0x8B, should be 0x82 (20230628/utcksum-58)
>
> At this point, the checksum error doesn't really matter, but I
> don't want the warning showing up.  I need to experiment a
> bit, but probably the best approach is to set the data length to
> zero (and adjust the checksum) while leaving the rest of the ACPI
> table header intact.  It will be more difficult to make the table
> disappear entirely as it appears in a global list of ACPI tables.

That makes sense. If the length is getting set to zero and the data
itself zeroed, I would assume that the checksum evaluates to some
constant value (0? ~0? dunno how it's computed), so that should ease
things a bit.

Jason

