Return-Path: <linux-arch+bounces-1420-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E32836D8D
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B082C281C8B
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ADD3D57F;
	Mon, 22 Jan 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9xIMG19"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED33FB32;
	Mon, 22 Jan 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941630; cv=none; b=CLyMsKzDiSKdW7QKsk1Dy8x/g0eFmkRZ8avMJfiAzcdoJI7dC9755lLjXO+6BJYa9zeLXgRHwBhdHq71RNyIL4WLqKsv5+GFBYPH/yp3llxHEis9I1v2py/TrbKbrN0Pbr27ifPMgeX9adYS0Uwm57RITi8KH/TXDAyyhyFHOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941630; c=relaxed/simple;
	bh=3xYHurgaAQEqFo/p7TdpON2MWNbsijqrFa22/vlH68A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYewvy2b/9Q+87xafRA0YYM+kdgzzHE1qOtnC5GW2gQLyorGjaO8NXeIflo1nw4nSM8UvpltJ1Udl8oTb7FC1R1dXJj8NO2dcRan+9jiOzteiYWxdexnENx3VTZ5uNGSrKjAKTaRYCemJDyiSAmntG9nLljSdDLMplxy+IEs0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9xIMG19; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d70a986c4aso11869625ad.2;
        Mon, 22 Jan 2024 08:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705941628; x=1706546428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFXUPIGtXHy0u88aXaZUxzjzqMNiU8mnTcB9U06vRXQ=;
        b=W9xIMG19UILaW2lkNzCza6Hy/mzX8M5gQNwbTmRTiMm9Al8ll+4grn/Qvp8yTXe5e5
         VV790UtPWhS4VckFK14nSJygowaF4TrwDyeerLtEJ9DJljquQqM07kOtXF2+JXhi5aYr
         caOQ4C2HDWDyRGJTaHMDX1ZC6GN78/TjPhlY61+Em0IXJjRacTqi0xr+3XCnbRZbu9xI
         +fZbN2J+MQwIjRXegNFuAdntWN68uMVa+9TktXlRW2LIhQCj9d2q6t/XInnk8AziWeHP
         P7czk8Pf4AndPe6rs/TdQ1bPsYI+o3OsRFi8dSVOSXj75Rj9nFORXAqielYYwJZ/OEhr
         Xl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705941628; x=1706546428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFXUPIGtXHy0u88aXaZUxzjzqMNiU8mnTcB9U06vRXQ=;
        b=dcks+eC9PEzHOj5r9u/6pZZTS1y4Hrt6WKVT7dKOeIdp5oIRiLF0WNWh0ADLYyZ+7w
         1S58aYcccRWsSdKN5vYNfvnH4gY0DoPdTq2fnS8M8g4lzOx/lzsO32ZkuX2hc1LX6TZX
         JFvrqbmQKPjMTB8pvP4ij6SljOQVTBOuyiJgxHexdLMwa/gZmgTYQHIUuREz+m+MiA+R
         VNJ6YmlPWtoptzH6vItDlqhvwplxj4PDOYlrrA0pyLLeK1GPVsq2DS1P1AWBvbxLwpkf
         G3xsevNxEXARpbMRl7Bt+jU/7FqOzbXDAVH+SoKa/kbd6mZv3uN7a5suks+iFbRbJZrB
         9tkg==
X-Gm-Message-State: AOJu0YzJv65bFlnP5Fn0nFi5N1flZjSN8LyPJzcCr7JSSqmgEprPh5EO
	9hpCSvNbya80arHP7m1R9cqn7bZj9Q6bXTjxpG6N48muDaJzaU3L
X-Google-Smtp-Source: AGHT+IE14W6lGJOfsRlhYN6PdnAYVB+1RuPNpPAkweQS2ExEHuVOV7aGlwLBsCqZlWLnei3zJiIEtg==
X-Received: by 2002:a17:902:b788:b0:1d7:297b:854f with SMTP id e8-20020a170902b78800b001d7297b854fmr2168214pls.54.1705941627649;
        Mon, 22 Jan 2024 08:40:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ks5-20020a056a004b8500b006db3358a0bdsm9868297pfb.193.2024.01.22.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:40:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 22 Jan 2024 08:40:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	David Laight <David.Laight@aculab.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Evan Green <evan@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and
 ip_fast_csum
Message-ID: <2c8e98b6-336e-4bc7-81ba-5a4d35ac868a@roeck-us.net>
References: <20240108-optimize_checksum-v15-0-1c50de5f2167@rivosinc.com>
 <20240108-optimize_checksum-v15-5-1c50de5f2167@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-optimize_checksum-v15-5-1c50de5f2167@rivosinc.com>

Hi,

On Mon, Jan 08, 2024 at 03:57:06PM -0800, Charlie Jenkins wrote:
> Supplement existing checksum tests with tests for csum_ipv6_magic and
> ip_fast_csum.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---

With this patch in the tree, the arm:mps2-an385 qemu emulation gets a bad hiccup.

[    1.839556] Unhandled exception: IPSR = 00000006 LR = fffffff1
[    1.839804] CPU: 0 PID: 164 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc1 #1
[    1.839948] Hardware name: Generic DT based system
[    1.840062] PC is at __csum_ipv6_magic+0x8/0xb4
[    1.840408] LR is at test_csum_ipv6_magic+0x3d/0xa4
[    1.840493] pc : [<21212f34>]    lr : [<21117fd5>]    psr: 0100020b
[    1.840586] sp : 2180bebc  ip : 46c7f0d2  fp : 21275b38
[    1.840664] r10: 21276b60  r9 : 21275b28  r8 : 21465cfc
[    1.840751] r7 : 00003085  r6 : 21275b4e  r5 : 2138702c  r4 : 00000001
[    1.840847] r3 : 2c000000  r2 : 1ac7f0d2  r1 : 21275b39  r0 : 21275b29
[    1.840942] xPSR: 0100020b

This translates to:

PC is at __csum_ipv6_magic (arch/arm/lib/csumipv6.S:15)
LR is at test_csum_ipv6_magic (./arch/arm/include/asm/checksum.h:60 ./arch/arm/include/asm/checksum.h:163 lib/checksum_kunit.c:617)

Obviously I can not say if this is a problem with qemu or a problem with
the Linux kernel. Given that, and the presumably low interest in
running mps2-an385 with Linux, I'll simply disable that test. Just take
it as a heads up that there _may_ be a problem with this on arm
nommu systems.

Thanks,
Guenter

