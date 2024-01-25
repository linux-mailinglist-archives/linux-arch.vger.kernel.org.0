Return-Path: <linux-arch+bounces-1693-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FD883CDC0
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2050B2555C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB870137C48;
	Thu, 25 Jan 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inllMIu8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37096137C2E
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215611; cv=none; b=Lav+dilcJ/L5puRaFCPClyVEgL0cULLngqB9c+yqTMWdvIlX0neeyYELJr3PCrt6wpIL8WjK6vtGaYUFkuw/N84WkbH77zzVcPk4K0Hl1KdJanIC6/68Tz5dhdgAVzC750TmqbPQgnAWmIkkfM2O3ay+4beiC4OD+qygH5fPOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215611; c=relaxed/simple;
	bh=ouunYuQuL5e9JirkoCcY+XKKJDTYYnL7iTYoEB+yr0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1YQP67gCtkoAmGJonqLWoSN6FXlLTxEFe1o2pywWV7rI6fP10sBQaW/RUUKnSpIF7HeAgVYIhqtvxm0/e09EP0ZUn0ax5d9sBhsRZ7OfT1wtgUZn8Jr46n0H+PmZ0ivoNPD2TkrTRYn1d2xVNV3obLeGk5+0r+AzPtEN2hkFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inllMIu8; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4bdb7f016b3so101146e0c.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 12:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706215609; x=1706820409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJCIsrO2o9NvHQxNMc03LGFVf6NoDfQO8EJsLkzfJx0=;
        b=inllMIu8HFYT4M4kiZG+LNl2W7MilGUTPVhyBU+ow3xeXd7dTkh2uttcXmpIEy7cyD
         mcuadvSBymclXJTtmT5tRMTPOBcoEqP40DyuGcHa+dvOKkYny180GeRRV+qY0mIXQWje
         MPCk2v37C33/NX8KixV4OAcurcQjwIpw/huh+qeE/C2PiFlfPXhDAXBjS9aooOp75s2N
         k6LhDW7OO1pVDVsqmvqhUvKZgw4bNHkPDQh+P7DozD+RkkGScxte7OHJg5jMHRbkp8Td
         aY1J0Vo22TfabQDytuYZnXezb0JhglIzwDR9eN+VZvHTzQ6/1t+Z7x5xzPcngdTFWirO
         O4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215609; x=1706820409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJCIsrO2o9NvHQxNMc03LGFVf6NoDfQO8EJsLkzfJx0=;
        b=Q5DD7mlFcoO5CG/XJOwvVFVuW0I9qXF8Gxk2c/OHcXEkfA3PRF3uqAnZrv0fZadnD0
         S0YQKEzhw3c6V0otawbUyHoX68QfXoR/jhGxH6LSWxdZqXK4GV5S7ACK/FEcxZYxH0Q1
         54yVLfcu9brLY3RPeEMoUUF/q51Ryd8kBg2GTmEmxBNy48jK8Puvq2dceHB6Aa3zKVrV
         0LIBfbZeiMW/nEPvqP+YMkCfIhdotsBB0eA1lFtyC5bjLbVppZgPPrBdjt1/LY5SSyDT
         dpzSHa+THVg0tq2wVeXYJidwg+gL+OTLxcdSMyps1U8xSE43u55LMllbTXy+UaF8UpxE
         VX1Q==
X-Gm-Message-State: AOJu0YwtkzcGg5xyOSpx/JPd3IU742YEV1xJx+0xEB+ZNq5FWkh0Bnct
	blcF4I4c8mah7ihW9CZkObepkLjSAUFQdBUzUHDGEDgfYM6XTmuW2jGTp0mQ20xTxZnhriaNANg
	hjYXaygOHNAmDEaOc4MMqgVJ2Z4x2IMNkpSA+
X-Google-Smtp-Source: AGHT+IHI8Q8dDZexTdG1oWiuWwKZqI7C18nLfjSkoGLgeVlXiyjEX7qqaULmDSBIhQnv0IiiZWJY1/qCHVluRpNXcEk=
X-Received: by 2002:a05:6122:58e:b0:4b6:cde4:5217 with SMTP id
 i14-20020a056122058e00b004b6cde45217mr292246vko.29.1706215608955; Thu, 25 Jan
 2024 12:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com> <20240125112818.2016733-35-ardb+git@google.com>
In-Reply-To: <20240125112818.2016733-35-ardb+git@google.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Thu, 25 Jan 2024 12:46:38 -0800
Message-ID: <CAGdbjmLEsj1cSnxoneSrDy2J2SFenjEdoYa_zoDQQhtU1nccMA@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] x86/sev: Drop inline asm LEA instructions for
 RIP-relative references
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:33=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> The SEV code that may run early is now built with -fPIC and so there is
> no longer a need for explicit RIP-relative references in inline asm,
> given that is what the compiler will emit as well.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/mm/mem_encrypt_identity.c | 37 +++-----------------
>  1 file changed, 5 insertions(+), 32 deletions(-)

snp_cpuid_get_table() in arch/x86/kernel/sev-shared.c (a helper
function to provide the same inline assembly pattern for RIP-relative
references) would also no longer be needed, as all calls to it would
now be made in position-independent code. We can therefore eliminate
the function as part of this commit.

