Return-Path: <linux-arch+bounces-7620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3625498CD47
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 08:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B234A1F2472F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F38A132121;
	Wed,  2 Oct 2024 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="JKraihz3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3012DD90
	for <linux-arch@vger.kernel.org>; Wed,  2 Oct 2024 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851390; cv=none; b=l8teImKyQIqU8kKwWlU4KFRT9aUNgA1lywrdk7nfOewhOASOWLJoxzdghMsUj2rtA0kaHivUbLH5evaZ+vuw7CP1VL7pRM6hqutwSZ8SBRsXrvTV12mYbOSpHzehs83RYB8F+R9TQSgmsfQYPCRkhxGiHKlB/TiipC7nn3DcKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851390; c=relaxed/simple;
	bh=/u7ndM9PjegOZvGmdKHJOiXuqepu5JOIg5M63tk3noI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CrYs2dySbtCAtzZKOZN++wcCkAxQPFhHoiVP+rL8G5HbXwlkZ6OdNVMnVb8fXFUTC5fv6lNJ0B1TOfbikV/W/ajBN8wqzZjM+b+Q8Idfl60i0DEb+B6nDEALMiOzE6aUCqI1kWpuAjOCovveuUliQZzXKQzL9a24a/qGRBdiCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=JKraihz3; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-6cb2aaf4a73so63135636d6.2
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 23:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1727851387; x=1728456187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u7ndM9PjegOZvGmdKHJOiXuqepu5JOIg5M63tk3noI=;
        b=JKraihz301UgOSpZutsGx90b/pNGY8Fj04xgD0SRW5bjY+io2p19hDaXrjENH4ORwg
         UxySXvmuCTaIWG7YePez2eEdUWwLaOjblTSX4XQNbX7Me51QFDnDrKRwGyMg1Wnpj1vY
         NjhkIHLPAegFlg+iwSwIyvILzrhlzuE/S8kSce+Vow6JFAhVyeJroGxlGWG0AHzVMIvo
         Yb3Kz56spRjZmjAdK6i5Nv+09oaYKxlCkzcXTkGmdMEqCGryT3zpgJHbQRLUutRwzhtl
         lqwUuUfY0wtcXEkDc2acgTzyhE2Y/HPtAA8VJII5KY1RfY1ajSdF9U/TRQGeI0z5UPRt
         sxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727851387; x=1728456187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u7ndM9PjegOZvGmdKHJOiXuqepu5JOIg5M63tk3noI=;
        b=B7mFcTaavlyCK56zhz3eiWHEbhUILm8EehyS9DITS1dgvIRxKOkcKFIhLVMbCuVvSE
         Om3ii08y7qhd/xiNkya+KydMVOgvshkyVwmmSIB85IUUqs+vccGoXlVT11LL0/hYVLOh
         /qMaNyOR0BZgkgDBUh9EE7kaRYqbpondJvIKpD4+QsPwv8GRfyrckIb+C0nVylYCXcKt
         l5aeHdFOb5B9ia+IhMMLZ2KPOmSEhn2co4AdHOui4HT8uSs4s1NXiuLVudO2zBgF4KCM
         aAL8EBULv8j+hCLGaWCuiuPdcwPaRoewLEBBtcup2NzPXgfpDZFd2HRIeC79E+lOpBaX
         1/ew==
X-Forwarded-Encrypted: i=1; AJvYcCWHcZq/WxZgJL+8id9a7JDJqtMkIkYsdIBqDeYsYF8PB62wqP5fc5TlK07+lxlOSWnRWUl6RXJ1Z3sp@vger.kernel.org
X-Gm-Message-State: AOJu0YymrFbb3PJUDvJkl+/VXP35e2PsHQFv9S1rtydqbtlFkCm/X7NT
	5WGdz2Vawx8T7azypLsmNztRk6ZaTOzpQaMw7w5chLNJe2osT+WU+WWTaQE+OQ==
X-Google-Smtp-Source: AGHT+IHrkRLceuVqxuW80Ei9nOewPBzqZcw30/kwrIYrc0giV5pzOirc+orj5fvwWApNas7yutkn3w==
X-Received: by 2002:a05:6214:3f86:b0:6cb:7fb1:2038 with SMTP id 6a1803df08f44-6cb81cc447emr31672946d6.53.1727851386930;
        Tue, 01 Oct 2024 23:43:06 -0700 (PDT)
Received: from shizuku.. ([2620:0:e00:550a:41e8:eb4:11eb:d3ce])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b6008efsm57077246d6.15.2024.10.01.23.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 23:43:06 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: nathan@kernel.org
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	wentaoz5@illinois.edu,
	x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code Coverage and MC/DC with Clang
Date: Wed,  2 Oct 2024 01:42:52 -0500
Message-Id: <20241002064252.41999-1-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002045347.GE555609@thelio-3990X>
References: <20241002045347.GE555609@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nathan,

Thanks for all the comments!

On 2024-10-01 23:53, Nathan Chancellor wrote:
> Hi Wentao,
>
> I took this series for a spin on next-20241001 with LLVM 19.1.0 using a
> distribution configuration tailored for a local development VM using
> QEMU. You'll notice on the rebase for 6.12-rc1 but there is a small
> conflict in kernel/Makefile due to commit 0e8b67982b48 ("mm: move
> kernel/numa.c to mm/").
>
> I initially did the build on one of my test machines which has 16
> threads with 32GB of RAM and ld.lld got killed while linking vmlinux.o.
> Is your comment in the MC/DC patch "more memory is consumed if larger
> decisions are getting counted" relevant here or is that talking about
> runtime memory on the target device? I assume the latter but I figured I

Yes the build process (linking particularly) is quite memory-intensive if
the whole kernel is instrumented with source-based code coverage, no matter
it's with or without MC/DC. What you've observed is expected. (Although the
quoted message was referring to runtime overhead)

On the last slide of [8] I had some earlier data regarding full-kernel
build- and run-time overhead. In our GitHub Actions builds [9], I have
been keeping track of "/usr/bin/time -v make ..." output and the results
can be found in step => "4. Build the kernel" => "Print kernel build
resource usage". You may want to check them.

I am not aware of neat ways of alleviating this overhead fundamentally so I
would love any advice on it. And perhaps now the more recommended way of
using the proposed feature is to instrument and measure the kernel on a
per-component basis.

[8] https://lpc.events/event/18/contributions/1895/attachments/1643/3462/LPC'24%20Source%20based%20(short).pdf
[9] https://github.com/xlab-uiuc/linux-mcdc/actions

> would make sure. If not, it might be worth a comment somewhere that this
> can also require some heftier build resources possibly? If that is not

Sure.

> expected, I am happy to help look into why it is happening.
>
> I was able to successfully build that same configuration and setup with
> my primary workstation, which is much beefier. Unfortunately, the
> resulting kernel did not boot with my usual VM testing setup. I will see
> if I can narrow down a particular configuration option that causes this
> tomorrow because I did a test with defconfig +
> CONFIG_LLVM_COV_PROFILE_ALL and it booted fine. Perhaps some other
> option that is not compatible with this? I'll follow up with more
> information as I have it.

Good to hear that you've run it and thanks for reporting the booting issue.
You may send me the config if appropriate and I'll also take a look.

>
> On the integration front, I think the -mm tree, run by Andrew Morton,
> would probably be the best place to land this with Acks from the -tip
> folks for the x86 bits? Once the issue above has been understood, I
> think you can send v3 with any of the comments I made addressed and a
> potential fix for the above issue if necessary directly to him, instead
> of just on cc, so that it gets his attention. Other maintainers are free
> to argue that it should go through their trees instead but I think it
> would be good to decide on that sooner rather than later so this
> patchset is not stuck in limbo.

Yeah -mm tree sounds good to me. Let me work on v3 while we address the
booting issue and wait for others' opinions if any.

Thanks,
Wentao

>
> Cheers,
> Nathan

