Return-Path: <linux-arch+bounces-11043-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10300A6CA94
	for <lists+linux-arch@lfdr.de>; Sat, 22 Mar 2025 15:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580B31B64E4F
	for <lists+linux-arch@lfdr.de>; Sat, 22 Mar 2025 14:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4CA1F429C;
	Sat, 22 Mar 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUNbwRaF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2048CFC;
	Sat, 22 Mar 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654011; cv=none; b=k8svXUYlx/M0jAig3SH6mPXdEjeOBC5daMF9Jr5vvi16dR2UTLO4QwWS6JPFspyABRP8umgcBeBirWfP3YRw6/pKMD66W6EvSge/Zl0IGayztjYRMNnaFl+gv2ZYBowjdvFZynpDPw+yWpByIc2OiPEhpHREjoj/e7zzYIeSYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654011; c=relaxed/simple;
	bh=2m3O1qTTNBZo4pOaTIjiFgTRK7QQuuRVdD7/oz+VrTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Klroxq1jNJF/YajdbnFWeAfh8qHNthS7H0qfvGJN4WkF1dRhxMRsJ7ulG9siACBcrNFnuUasSx4L2lHUDIDU+7O7xzSwT28IPjqjTHeA2bhVhAmDWVHugq4pWUr6DWqdQbJrPpw1hSXDcE0y08Pan09g1SoqebYKP5q43UuV8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUNbwRaF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2243803b776so38984755ad.0;
        Sat, 22 Mar 2025 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742654008; x=1743258808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIBZE6KgWtHZM48TAyKomWUpshgbZruN/nT+wM0z3cY=;
        b=RUNbwRaFApvN05W2SJ1g00z8UiVfL7PbL0GqJpuZWmdu3/OwaE/Iq6Afc5WAKgraMI
         ytz+jLTIsi8VBiIWRIX8tPfaNpKrPukrZqRs84oGJeD8zIwFRhv3vld1a+MvqvDahKUj
         OIBUwJ2o5nzGDeELXLAtEjxy7mFkToxN925kI+mNN70i9CGBjzRub3bO4MgyCUEFYtRG
         BVdbWSxKjos5g1ZiddLCyBuJeKRryNnKxOcJrJI3qOkYrXhSn3lKDBTIx4Ty009aGxKG
         CPD5uGNNuCthDnbzNlF5ZgLSom6sXGMDDiatWY3yInuczEkcd90MKqXrDCu99msrMl2S
         lecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742654008; x=1743258808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIBZE6KgWtHZM48TAyKomWUpshgbZruN/nT+wM0z3cY=;
        b=PpKyk5w7+qSJrY5SyaPsaR8K0/GkmJuOILQe5p5stwtZJEYRB8qgVq+Kbosl5+jxM3
         Zr5261poWnyvVE4FPINKlkoUmVTV7D8cV7boMoFTmqY35Zrw8Uum6zpGZO8cOS36CnZu
         uNgENxmwhkBphZNIHXN6xrQnlYFny6na3DjIuJwY2J7qrL/uzaW6hsymj8qpPpKge63/
         qAw7bqReUg0+YycWVNgNnPmHHijvTQDCaJflQ+gQ+tJFHlTtTdq0zZebQzDSAXDyBpFM
         ADHKuu7hxvHutNG5ccMbkSkVNP4AlZlEVkBEspOib/oBtgFo+Dmp3f9DqWT+tlWyLN+o
         nXQw==
X-Forwarded-Encrypted: i=1; AJvYcCVSI811abdv4k8bZdoP0TuswyhkqL2S3mGBY/tHYASIisHGk6dlWVvv2PWEhTgp5nTEasb0XMb0ta0wWi0t@vger.kernel.org, AJvYcCXleDMZMdD/7wYF4GVHv6OalwHvSoMnwbzxXn6GelpZP+eETNiIMdYh7GYOM/BcvFfjUoLNpR2MS9ww@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqg1dcavLDgyCglNP/SJAqYumlawZbeLfgLEWxe8oMN3DJBIFV
	Lg0BXuy4OWAbaqGV7XGqsWizU5n91ttT1FrwoBrjfMJKRfsNLOH4
X-Gm-Gg: ASbGncvap6bAQcOTREU2+9dyGDuARU4/pdEEaP84Ck6o8JLBLb9tW0CfUcgyzmYGur9
	i/xSdPbphaBZmVsD3FZfUhp5Brx8S9Y+7sZgyQyiGb8bQ3+wugc1F0XDFZb27XHBRSuhAuobJ0T
	4B5+hSGRtq19yU3yqVOH6oQ2cs0AuwuE+BDu7E7sqHclsI+XeeW5QMEqiTpG9YeURPoCXFsr2em
	TJZfrniLnuuoCwFgQ7G4UI+sjomI+mC+FwGC/iImDmN7X6QBnfOdH8OWn1FO/iHrbgwPQ5cL2lW
	pK9FBXFL80mNzO0lS4I4Q9cNu7jxfQPCMYMeSRwH2mCWZIT/HYktmN7xrPlzrF3v7qmP
X-Google-Smtp-Source: AGHT+IFuGDrvHo87gSkJ3AgKg7PRhGZxToZM2+HRB79B6clNvtT7xfbYzfwMUOphtPaGeqwrjNJHSw==
X-Received: by 2002:a17:903:320e:b0:224:1294:1d24 with SMTP id d9443c01a7336-22780c51260mr108189625ad.3.1742654008346;
        Sat, 22 Mar 2025 07:33:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4c3a6sm36082255ad.92.2025.03.22.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 07:33:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 22 Mar 2025 07:33:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	Zhihang Shao <zhihang.shao.iscas@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 08/12] lib/crc_kunit.c: add KUnit test suite for CRC
 library functions
Message-ID: <389b899f-893c-4855-9e30-d8920a5d6f91@roeck-us.net>
References: <20241202012056.209768-1-ebiggers@kernel.org>
 <20241202012056.209768-9-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202012056.209768-9-ebiggers@kernel.org>

Hi,

On Sun, Dec 01, 2024 at 05:20:52PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a KUnit test suite for the crc16, crc_t10dif, crc32_le, crc32_be,
> crc32c, and crc64_be library functions.  It avoids code duplication by
> sharing most logic among all CRC variants.  The test suite includes:
> 
> - Differential fuzz test of each CRC function against a simple
>   bit-at-a-time reference implementation.
> - Test for CRC combination, when implemented by a CRC variant.
> - Optional benchmark of each CRC function with various data lengths.
> 
> This is intended as a replacement for crc32test and crc16_kunit, as well
> as a new test for CRC variants which didn't previously have a test.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
...
> +
> +		nosimd = rand32() % 8 == 0;
> +
> +		/*
> +		 * Compute the CRC, and verify that it equals the CRC computed
> +		 * by a simple bit-at-a-time reference implementation.
> +		 */
> +		expected_crc = crc_ref(v, init_crc, &test_buffer[offset], len);
> +		if (nosimd)
> +			local_irq_disable();
> +		actual_crc = v->func(init_crc, &test_buffer[offset], len);
> +		if (nosimd)
> +			local_irq_enable();

This triggers a traceback on some arm systems.

[    7.810000]     ok 2 crc16_benchmark # SKIP not enabled
[    7.810000] ------------[ cut here ]------------
[    7.810000] WARNING: CPU: 0 PID: 1145 at kernel/softirq.c:369 __local_bh_enable_ip+0x118/0x194
[    7.810000] Modules linked in:
[    7.810000] CPU: 0 UID: 0 PID: 1145 Comm: kunit_try_catch Tainted: G                 N 6.14.0-rc7-00196-g88d324e69ea9 #1
[    7.810000] Tainted: [N]=TEST
[    7.810000] Hardware name: NPCM7XX Chip family
[    7.810000] Call trace:
[    7.810000]  unwind_backtrace from show_stack+0x10/0x14
[    7.810000]  show_stack from dump_stack_lvl+0x7c/0xac
[    7.810000]  dump_stack_lvl from __warn+0x7c/0x1b8
[    7.810000]  __warn from warn_slowpath_fmt+0x19c/0x1a4
[    7.810000]  warn_slowpath_fmt from __local_bh_enable_ip+0x118/0x194
[    7.810000]  __local_bh_enable_ip from crc_t10dif_arch+0xd4/0xe8
[    7.810000]  crc_t10dif_arch from crc_t10dif_wrapper+0x14/0x1c
[    7.810000]  crc_t10dif_wrapper from crc_main_test+0x178/0x360
[    7.810000]  crc_main_test from kunit_try_run_case+0x78/0x1e0
[    7.810000]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x1c/0x34
[    7.810000]  kunit_generic_run_threadfn_adapter from kthread+0x118/0x254
[    7.810000]  kthread from ret_from_fork+0x14/0x28
[    7.810000] Exception stack(0xe3651fb0 to 0xe3651ff8)
[    7.810000] 1fa0:                                     00000000 00000000 00000000 00000000
[    7.810000] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    7.810000] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.810000] irq event stamp: 29
[    7.810000] hardirqs last  enabled at (27): [<c037875c>] __local_bh_enable_ip+0xb4/0x194
[    7.810000] hardirqs last disabled at (28): [<c0b09684>] crc_main_test+0x2e4/0x360
[    7.810000] softirqs last  enabled at (26): [<c032a3ac>] kernel_neon_end+0x0/0x1c
[    7.810000] softirqs last disabled at (29): [<c032a3c8>] kernel_neon_begin+0x0/0x70
[    7.810000] ---[ end trace 0000000000000000 ]---
[    8.050000]     # crc_t10dif_test: pass:1 fail:0 skip:0 total:1

kernel_neon_end() calls local_bh_enable() which apparently conflicts with
the local_irq_disable() in above code.

Guenter

