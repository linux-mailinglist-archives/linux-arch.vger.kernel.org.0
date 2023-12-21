Return-Path: <linux-arch+bounces-1155-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB081BDA8
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679031C25C72
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC5A634F1;
	Thu, 21 Dec 2023 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kooKke3E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E133BA2F
	for <linux-arch@vger.kernel.org>; Thu, 21 Dec 2023 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso1425118e87.3
        for <linux-arch@vger.kernel.org>; Thu, 21 Dec 2023 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703181236; x=1703786036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyvnsyjEDwsUuLwMHfYUDOCjkLXxDADJ3gDmnw3h4uw=;
        b=kooKke3ExWIs55KMR0sS95C5ojaPw04G7o/Ku8rr/b0D5t6O5XVMhK3gY2AqRPZx0F
         Xi9gsDW87a+bvrFGcS9FPexLLboB+zN7feG72PZ1e80s9UhOKllBC+PWapkn9BZQZZRI
         G9TB6mH+wfDbYcAvjOqAZ5BCwyPQIlkhTHTqYj7+jClty6VvLiSzdUXtapa8xw3NUczx
         ZJEMzMmeHNygs7iaClaKfrAilgha+TTI1zMan+SyENaV9TqGnI6ktLsKKlbgroiUx6W7
         qS1taynyQhDCDm2N4gGAucoRTl7Iv4tSrWBLPbfPFiVeZ39+bOAEcpifixOMtA1BFu5U
         ELxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181236; x=1703786036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyvnsyjEDwsUuLwMHfYUDOCjkLXxDADJ3gDmnw3h4uw=;
        b=E7DmWe0dSJvnYNrGO64LovkdUD4MxaAaxsJ9WCz845GKrae+rs6ilq4RGL4zV/we1w
         2IuyiRUQivKdUByB1ZsvMCbQsdAe7qjswOTbnkRYQJQQj3fEWRbECceRsBXhyZrGF2gg
         HIDYipGkBZVU06+CE/M6jZGcoVgaPfjk/GlrUQ1aWkL8EFTsn1akwRk/y1Zm0LpQkdxh
         3mqjjuJ3M0C2tQzygRsZh+h+PmSzGncleC+QveG+FTamBhFBDkcSHqIjwDg1Rq2xMMOH
         lfPP2r/xo/hlGt+oB3JgmEHl3v1ABCtwDqoSip3TcdWbGWOaXtMLnYDwqe+M2NQN3+CO
         7MjA==
X-Gm-Message-State: AOJu0YzJU6D1SL8M1ziyTMwvXoVO1BOat4ZdMQjXKcbGlMeUQH+cPV0I
	YpzxE2V5nPkN5KitnvnhQBC9ppm1xNKDxPi6SJHjPw==
X-Google-Smtp-Source: AGHT+IE2ge4UK3B/28OyNJsYgBRrO+CoJIShGaRLGYuzONOCc/uFJ0mOz6/3Iza3du7r74b7GPBwMBxm/piGxU/FSfY=
X-Received: by 2002:a05:6512:60d:b0:50e:5e48:2282 with SMTP id
 b13-20020a056512060d00b0050e5e482282mr412065lfe.146.1703181236297; Thu, 21
 Dec 2023 09:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com> <20231220-optimize_checksum-v13-2-a73547e1cad8@rivosinc.com>
In-Reply-To: <20231220-optimize_checksum-v13-2-a73547e1cad8@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Thu, 21 Dec 2023 09:53:19 -0800
Message-ID: <CALs-HstooJ5z9T_M48jwQGbxiUdL-B8eFqqsi4-6TMrMJtz7mg@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] riscv: Add static key for misaligned accesses
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, David Laight <David.Laight@aculab.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:37=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Support static branches depending on the value of misaligned accesses.
> This will be used by a later patch in the series. All cpus must be
> considered "fast" for this static branch to be flipped.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

You didn't pick up my tag from the last spin, so here it is again:

Reviewed-by: Evan Green <evan@rivosinc.com>

