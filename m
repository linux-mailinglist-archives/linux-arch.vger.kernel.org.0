Return-Path: <linux-arch+bounces-8055-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04CB99AD0C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 21:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8A51C2147A
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 19:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061C1D0E18;
	Fri, 11 Oct 2024 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lV4yCNxs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285181D0796
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675964; cv=none; b=KxZXrN0iFeYCmH2P1FzYywJ0CBS1+RjTII2xDNGljKDvSX6ubs4WRLgXU8j30pT7QP2XBywwVJoe2855fwCITOQZIxAbBrFBCidBVQU2Jjyk7wNszyZf+VzV0WEl5Asl4goPm8dGvrDaE2zDxLA0nN7uprCRQVxvVNZvWYVtH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675964; c=relaxed/simple;
	bh=t7P/KEncHEjcXdz1K3PihQemKIQQ61oPnVKnhfUk5n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3F5wF4d65JqZlNlK9k7+mD8ISdW6ssFatyZHJxza8bNmHjl0ZOB7ARiaAJPEUZy6uZJQ2uEuIkpHkvl6ZaAgYjCnxdvzBrVpXuJKfDemSLwe9KBrOsw1xLOSDFJ58KjRu8I8XvlQ7cVAl6c7SDCw1wHx07id7939GaDdRef/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lV4yCNxs; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e9fd82f1a5so1606792a12.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728675961; x=1729280761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=exLsQV8+AgRTzSgIuh9REhlgyhIFFL6ykktOdGZoGFg=;
        b=lV4yCNxsWdv45991ghfe2wns7l+/s/d+YLcrIZFmoS3x3hGwHVNM/lLDoTb1S148g/
         wjCNMuU7ASe99vAOixL04qe3q/lGax6rpPyt1lm67ppD2F21CTYZGTN8/X4wycTxHsxL
         P/A2LCQBZjkSqlvCJI7zm+qY8vwkdXglEPn3QADdA2zYO8iZeXVHbU9BZJLzXkn6beFT
         ts9isgOszzowJr6cetdaSLt8ipo3Z6+Aey5qB1O+raze27joEJIvyv4Hklm3/FhjSfT8
         jaZi6Qz7N48YVKso4KxssvtnXgxeSllxs48Rq9PKybtpTBlB++fwin5ip7uz97JKL8LE
         BytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675961; x=1729280761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exLsQV8+AgRTzSgIuh9REhlgyhIFFL6ykktOdGZoGFg=;
        b=iHfrv8IZKQ+8xGl3QLOeFaS/ob6DE6xCIzbwdnvaJy7AVLJI4NMQkNxgfuH11Zkpf5
         Hdz0ua+hx+acdMn3doOxrulmQv3C66D+XGX35cFZpWg/E1aOB/NEbgV7XTTixFyAJfZf
         NWb9G3ApOiFWlWOHRKdHEAjX1dzCDQfHt13mKJz5oweDJicG2T2lD1Y73+d9/V78mvlw
         lWlMks+ffPe5X9/o6pQ0zN+CyG5QbDMHxsymZxqkkQzEJP5drPJPz1XTKtoPOqWXX98d
         U3dPHphP7nP9ZnS1bORFoK5qUSN2IjeWO61NZej+o8TcSf1UlPSH9Yf+cFdXx6KmXW8M
         RtoA==
X-Forwarded-Encrypted: i=1; AJvYcCUOJ+bhMyWFnWTxRvFwHHis25lfbEeM56hyiyiqqtSW3SC0GNTmbZmxpNk779BwJ7j3XfFHJOtZrmBW@vger.kernel.org
X-Gm-Message-State: AOJu0YxIK3xiHZRHYv7TQ4is5WP2Hx4sP+t+11ISK4qDSj/K/9mpcBvM
	+bDGA49w2tUyDCce7hFCsNzccHgMhZCmRNAiWi8pisn6Dsw2qQiESZyxDS6GCMo=
X-Google-Smtp-Source: AGHT+IHj8rWFWjfeD1jnOseU69L54Nubw7fuAuLENErbM2G1CFqjE5ekNxV2rf8nSVkMr8qy+VgzZQ==
X-Received: by 2002:a05:6a21:1519:b0:1cf:4d4e:532b with SMTP id adf61e73a8af0-1d8c96b986bmr675268637.43.1728675961468;
        Fri, 11 Oct 2024 12:46:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0f1dcsm2951118b3a.209.2024.10.11.12.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:46:01 -0700 (PDT)
Date: Fri, 11 Oct 2024 12:45:57 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
Cc: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v6 33/33] kselftest/riscv: kselftest for user mode cfi
Message-ID: <ZwmAdRb5BRkPLbWg@debug.ba.rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-33-60d9fe073f37@rivosinc.com>
 <CANXhq0pXVS2s-hZNusPLoQ4qPkyi1S2BTQ-FyAvcz=cDctKQng@mail.gmail.com>
 <Zwj7aZj36TBGzpZa@finisterre.sirena.org.uk>
 <CANXhq0q49k6q3ZGYqzczMeFr+_rrfa9mL7FMu62xPHeUKfvhMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0q49k6q3ZGYqzczMeFr+_rrfa9mL7FMu62xPHeUKfvhMw@mail.gmail.com>

On Fri, Oct 11, 2024 at 07:43:30PM +0800, Zong Li wrote:
>On Fri, Oct 11, 2024 at 6:18 PM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Fri, Oct 11, 2024 at 01:44:55PM +0800, Zong Li wrote:
>> > On Wed, Oct 9, 2024 at 7:46 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> > > +       if (si->si_code == SEGV_CPERR) {
>>
>> > Hi Deepak,
>> > I got some errors when building this test, I suppose they should be
>> > fixed in the next version.
>>
>> > riscv_cfi_test.c: In function 'sigsegv_handler':
>> > riscv_cfi_test.c:17:28: error: 'SEGV_CPERR' undeclared (first use in
>> > this function); did you mean 'SEGV_ACCERR'?
>> >    17 |         if (si->si_code == SEGV_CPERR) {
>> >       |                            ^~~~~~~~~~
>> >       |                            SEGV_ACCERR
>> >
>>
>> Did you run "make headers_install" prior to building kselftest to get
>> the current kernel's headers available for userspace builds?
>
>Yes, I have run "make header" and "make header_install" before
>building the kselftest. This error happens when I cross compiled it,
>perhaps I can help to check if it is missing some header files or
>header search path.

That's wierd.

It doesn't fail for me even if I do not do `make headers_install`. But I am
building kernel and selftests with toolchain which supports shadow stack and
landing pad. It's defined in `siginfo.h`. When I built toolchain, I did point
it at the latest kernel headers. May be that's the trick.

"""

$ grep -nir SEGV_CPERR /scratch/debug/linux/kbuild/usr/include/*
/scratch/debug/linux/kbuild/usr/include/asm-generic/siginfo.h:240:#define SEGV_CPERR    10      /* Control protection fault */

$ grep -nir SEGV_CPERR /scratch/debug/open_src/sifive_cfi_toolchain/INSTALL_Sept18/sysroot/usr/*
/scratch/debug/open_src/sifive_cfi_toolchain/INSTALL_Sept18/sysroot/usr/include/asm-generic/siginfo.h:240:#define SEGV_CPERR    10      /* Control protection fault */
/scratch/debug/open_src/sifive_cfi_toolchain/INSTALL_Sept18/sysroot/usr/include/bits/siginfo-consts.h:139:  SEGV_CPERR                  /* Control protection fault.  */
/scratch/debug/open_src/sifive_cfi_toolchain/INSTALL_Sept18/sysroot/usr/include/bits/siginfo-consts.h:140:#  define SEGV_CPERR  SEGV_CPERR

"""


