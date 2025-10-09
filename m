Return-Path: <linux-arch+bounces-13987-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0875EBC8BF0
	for <lists+linux-arch@lfdr.de>; Thu, 09 Oct 2025 13:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0DE14F9AFD
	for <lists+linux-arch@lfdr.de>; Thu,  9 Oct 2025 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC10D2E06E6;
	Thu,  9 Oct 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNoiJ37l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44F2D6E58
	for <linux-arch@vger.kernel.org>; Thu,  9 Oct 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008782; cv=none; b=TYGZKdS+zBQ3Q51VC8ZoIMwyClfgnOt4wVI1SNbk9KDv4bZERjClRBxy5JpZRXab68SW2Yq3ae3bIGEaeQIK3HHenpqJqF+u10Iyj5xnLgXNpVBm1NK/fvgSRilImnAERmameMeKFXKOplPP9zM0QeyKNe/OAsDcO1roildGShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008782; c=relaxed/simple;
	bh=mzeWOdj3lBj+Ke0QviDFWI2aF1kcLsskxWN0A79AnHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt+v0fp7UjlosFA26+VcZoX8VEn2AabsA1OteRt+OCkrR5fQT99//rydRsVi5LcvEV7TDjr1lCUDpkWCaslgmof8ODYPTNTsk6DgCQywxIs0Zv/+ffZTo+UoAy3EWQjf23/k0l87h4sMPdlIq3RzLN/nJhwrwEic93SLeLJ/8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNoiJ37l; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60501806so8533337b3.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Oct 2025 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760008779; x=1760613579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzeWOdj3lBj+Ke0QviDFWI2aF1kcLsskxWN0A79AnHU=;
        b=jNoiJ37lCUQ9Hrm2hMpur0n3OpmXylsTAvQFzFo0gEHLdPW1H7xLOEfZx9IMP3xJGG
         VvaFojxgSsr0dFIBvT0p9gx6C2qVKiKNUQeCfRio9yhV6GZjq9rpyyrteqxqW9Ew3dBm
         wtvaqMjirKwpcBo4MgJpiCLn7sWEkQpEyqFiwGTjc5zHrlT4QCRizWiXWVk6zMf3FYYn
         bzUTIQSKLADIffCIHWelPhf43EqQYtzVSfMGzuGbrzIwj9QJsP6FN+oluyC+bzTKhDgF
         5nZ3Uo6yeEy5h0e9DLaazODqWGp9Q080LEkzOtn2P2FcQKQiw+6Kon0LQ4PFBZDDcg2+
         Grtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760008779; x=1760613579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzeWOdj3lBj+Ke0QviDFWI2aF1kcLsskxWN0A79AnHU=;
        b=Y6+a010iqi0uAayX8cUvtlcckzHIgwFY6OZWoXNeDNtZJHMZv6r2zAzOdqK/MXyYwK
         IgP0E3splAKLfK2va0c+Pry/gwmjerW2msOZb1XMZD+N9hckUbxALt0HuqEIWlNMNNuN
         Tv0pu/IZ3Arju6/yB8c8YPIicmYwgeSzn8T7exxUAN7NyOUkae5QAIRvaOH3djVjhSDF
         JepTN+y2tUOQNWKYF1BiOLIVmURk/jwJ+lf7aD1k5m8xzZp2fsH2VuV5063FniuHEqsa
         CG95NxjC0L5LfhYTRhVwYb8fY40IfDgwmRcguvmVv8REnmH6A0dhIkpzBhKd+8waalWu
         43OA==
X-Forwarded-Encrypted: i=1; AJvYcCUqHfucUR5fqqFV7jyjd9xRPtyFdQePHZBgeE0ibY1ECJuwNf6Gob4mebdh1lA0toGFFIUZ/8GPc5wV@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPVjF6Ko/neEoHhTWcPY09K8gsVaVkUvfyj9pODWa86pWrC8L
	RbKsw6RoXIDJdxYjMMmtKHtq1MQAbbXXRjTvOvKvkbZyQmKT6WgPWMyD1q0Jtb7H5GM2GR1H/3/
	NCenvdk0jE9tgixkEDUs02SoBY6s2fFM=
X-Gm-Gg: ASbGnctZfoAQmbhZrEtTcZU1SZEwLJYnNemTz3rnomV5YuqN9YOFQx+cBSBk04tCtqH
	tMjCjO/AAv9TzXeqk9/IGVL8f7LPSusx/CbBG8aLoQMG//cP5/o9KFMCwg6wCQBNIkHBc4dO7Xm
	Wq+ru16pMAqxLyKLY8e6TqIP749ei4m21FbmDpP0drfWolD0z7QKCJ/ZZ32y/tbH6apnZ9rO/Z0
	JiILJYJQ0raPuWoqD3LLceNYscRMjQ=
X-Google-Smtp-Source: AGHT+IE5U7JyGi1AmeLjDi25hUOta+sU2hpJbVTN9Ai63ARDyOdLqRjdCN3h5Wr4u+tqZlHZJ+/pg/7Xr5jCWFq4BIc=
X-Received: by 2002:a53:d048:0:10b0:63b:8e80:c017 with SMTP id
 956f58d0204a3-63ccb672a0emr6807745d50.0.1760008779377; Thu, 09 Oct 2025
 04:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-29-safinaskar@gmail.com>
 <20250913054837.GAaMUFtd4YlaPqL2Ov@fat_crate.local> <20250913055851.GBaMUIGyF8VhpUsOZg@fat_crate.local>
In-Reply-To: <20250913055851.GBaMUIGyF8VhpUsOZg@fat_crate.local>
From: Askar Safin <safinaskar@gmail.com>
Date: Thu, 9 Oct 2025 14:19:03 +0300
X-Gm-Features: AS18NWAGN6ExXhEWeXK-ERFvGpf6JdjWShiWpIPYOnPjMCR9bXVHwIY8E_1WxIc
Message-ID: <CAPnZJGBwFqNAybORpTtRfjtGwMQiBtd+rATD=mh8ZgE3owT_ow@mail.gmail.com>
Subject: Re: [PATCH RESEND 28/62] init: alpha, arc, arm, arm64, csky, m68k,
 microblaze, mips, nios2, openrisc, parisc, powerpc, s390, sh, sparc, um, x86,
 xtensa: rename initrd_{start,end} to virt_external_initramfs_{start,end}
To: Borislav Petkov <bp@alien8.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 9:00=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
> Ooh, now I see it - you have virtual and physical initramfs address thing=
s. We
> usually call those "va" and "pa". So
>
> initramfs_{va,pa}_{start,end}

Okay, I will call external_initramfs_{va,pa}_{start,end}
(after I will remove initrd, which will happen after a year)

"external" means "bootloader-supplied" as opposed to builtin initramfs.

--=20
Askar Safin

