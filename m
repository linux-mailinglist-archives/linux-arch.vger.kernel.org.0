Return-Path: <linux-arch+bounces-13177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE66B2921D
	for <lists+linux-arch@lfdr.de>; Sun, 17 Aug 2025 09:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C214E5C67
	for <lists+linux-arch@lfdr.de>; Sun, 17 Aug 2025 07:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28265238159;
	Sun, 17 Aug 2025 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbnT+t1/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C88B19E82A;
	Sun, 17 Aug 2025 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755417467; cv=none; b=QngyFyn0fOU9cxGVlb7hnyLK/5IVkulWJ7OgXdRN9EC7J6w7aVMCJbDYdtATYagCCEknT/egvHeppFB9nwmBdeE6gaYd8MijfpJgDSoMnAutSZQbtIWHUgcsNq1LjUQavE51wvv0nN8V+M1AbKebuz3bOqhG8I+RQNSibAIIIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755417467; c=relaxed/simple;
	bh=yQuiJ45Vh6J7gKXVGoZus8IP+oatDjgK0XKBk6cWb/4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=k+e4K6mJ4qGXICqsLN8xB9/oQarNUGCHRtTjQwBBJdYsDphHPwBt9cPKcGrv5KnflmvKAwis8dBX4YxP0mV7uYjwy6QI+0DtOu1whDRvvL9ENF5Ni5VrZZmEDJ20zCI0D3TPwKsyYBtIwWozkCTcnEyM/8OYFleFtfY+noZ9yms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbnT+t1/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3bb81a0c36aso108675f8f.3;
        Sun, 17 Aug 2025 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755417462; x=1756022262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1jkR3N9Y1QTztsNiDkJcC+i9uf2sc9OYJvJHiG79qQ=;
        b=HbnT+t1/XDEZLrU6hReGPicZAgIXdEkRfJ722FdE1yoOIrR6v5g08PBnWrAZUVoprf
         dtccwKvHtmP0yEwJ0CuLsQp0j4M3fb834i50A2qGMOkD4HFe2N5IlroDG7vf9gV4mznT
         XdrChAsy4IhzL3jScm6J8wXoWKaQPByb4xCIsi/JRBAbfVNW13SxCvCujZ/M9vGHN1Hw
         aHjbjmaYTNzNlpLECWKwDRP9OySoE8J3FmWHC/zaZPu9Rv6941FMvKDkwzW+Xgpf6CHm
         ka2Fkwy/gFNZQhexuFL70UYTUZqRHA9dhfIYzvmyZv06p71SRtWF1Dmd/9ZHfVqc/h9Q
         QeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755417462; x=1756022262;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q1jkR3N9Y1QTztsNiDkJcC+i9uf2sc9OYJvJHiG79qQ=;
        b=fgFoB/u7J3uXh37Mt1pVdDhr1T/Drx3K1zOy2xXwSmHUwurTSMTlSmX/wu+6vL78zB
         OnNY9Q2konImUDkdmNLXGq54HYtNR0ONl4L1uuXLeLqLc4fXaF54W4sEOEO8sMkziXDg
         TJ3ugBeVZkGixyR/E7MBnFYllmUgbXyrB54kyWIhG1tnQRekPiPEx82VMPx07U2yLOaB
         9MB+sDundmlMsshi8paUTraxTNxizx8sPJ8IJFfGY0Oe1XDGuKaj1Vy0+WZcSJC9HFpl
         4Ala8jRlkoohddvuSIVNLiX9sYCKjeo6aD0988rjbErlGpYgMk2V1faLGdwhiBR4ggSZ
         jPxg==
X-Forwarded-Encrypted: i=1; AJvYcCWdFdsT+SFg7kDFYgzMkAQmmQQPTBB/BLfmjK6++lfpqOFSct4OmE+skAl90PTWZ/UrCLQdqztZWuk=@vger.kernel.org, AJvYcCXvgsiL1kflx7xkctaCbdFFEnfSrqnTeATun1td03379WpO8AbBdPDf6MJk6mQVge2OWiXJrmcsMd4/KObR@vger.kernel.org
X-Gm-Message-State: AOJu0YyTg7SGwGmzzoHooYoKfYlQrFQUsC6JQFZHcBfvI3/a7dVluQ0j
	jN00KBWEnuONeZ9fF1uLu208J30faJ9rbvpqARooXuNkMXsMjS18JDf4HFjrrLUNtWv3
X-Gm-Gg: ASbGncvK4tOIJ3VCgzRF8hpV1bKUgmTjAj+nw33klv50a6h4zaN7wiilrq4sHZkLGxB
	tarQc0kqAATcDnzEUABzaibTTAV8VmwSZ6Hkr/UtFDBwA1xoJtuBkMi2hJBBpwBqoBRbit8zsts
	iNlhXVzAW+Ww8vkZsU+st21DQMoLzgBFGpvjfbV/2sqeDBQSItaMfx5nTGQX3qcu1oMsGgYTcKc
	Ldb3IhbvsrpEdgk50CDXXhMtt5INAcopmPSlpWImH0pZKfPER2HNlfkIGJgwVeVoBQQyfH+SGAX
	opnXQzDpwY3JwwaVRpoxP4IhjZBYolNkb6+wLaTusx/Y+A+SCZe+cFVD4Be1P+CH36QZ8D+EEaE
	+5ixLwx2chvGYlNcUFZJdu4JLrfdhj3tkwvh35m8cDTxVqqF3L47gb2jhVqqA
X-Google-Smtp-Source: AGHT+IG0TuVeq8GaU64aAuSrS/zwB4M2Cdr1TpOKqXkZ6Cyu7l4eMbbzZ6Z/mb/euW/bgJ7ibOyzdQ==
X-Received: by 2002:a5d:584d:0:b0:3a4:f912:86af with SMTP id ffacd0b85a97d-3bb6816f428mr2502294f8f.2.1755417462245;
        Sun, 17 Aug 2025 00:57:42 -0700 (PDT)
Received: from localhost (67.red-80-39-24.staticip.rima-tde.net. [80.39.24.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b1csm8361011f8f.45.2025.08.17.00.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 00:57:41 -0700 (PDT)
Message-ID: <4616546f-f10c-419b-a32f-ae1a059f15e4@gmail.com>
Date: Sun, 17 Aug 2025 09:57:40 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: Re: [PATCH] LoongArch: Increase COMMAND_LINE_SIZE to 4096
To: Ming Wang <wangming01@loongson.cn>
Cc: LINUX_ARCH-ML <linux-arch@vger.kernel.org>,
 API-ML <linux-api@vger.kernel.org>, KERNEL-ML
 <linux-kernel@vger.kernel.org>, X86-ML <x86@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ming Wang wrote:

> The default COMMAND_LINE_SIZE of 512, inherited from asm-generic, is
> too small for modern use cases. For example, kdump configurations or
> extensive debugging parameters can easily exceed this limit.
> 
> Therefore, increase the command line size to 4096 bytes, aligning
> LoongArch with the MIPS architecture. This change follows a broader
> trend among architectures to raise this limit to support modern needs;
> for instance, PowerPC increased its value for similar reasons in
> commit a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE to 2048").
> 
> Similar to the change made for RISC-V in commit 61fc1ee8be26
> ("riscv: Bump COMMAND_LINE_SIZE value to 1024"), this is considered
> a safe change. The broader kernel community has reached a consensus
> that modifying COMMAND_LINE_SIZE from UAPI headers does not
> constitute a uABI breakage, as well-behaved userspace applications
> should not rely on this macro.
> 
> Suggested-by: Huang Cun <cunhuang@tencent.com>
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> ---
>  arch/loongarch/include/uapi/asm/setup.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 arch/loongarch/include/uapi/asm/setup.h
> 
> diff --git a/arch/loongarch/include/uapi/asm/setup.h b/arch/loongarch/include/uapi/asm/setup.h
> new file mode 100644
> index 000000000000..d46363ce3e02
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/setup.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_ASM_LOONGARCH_SETUP_H
> +#define _UAPI_ASM_LOONGARCH_SETUP_H
> +
> +#define COMMAND_LINE_SIZE	4096
> +
> +#endif /* _UAPI_ASM_LOONGARCH_SETUP_H */
> -- 
> 2.43.0

A bit chaotic and arbitrary sizes:

$ git grep "define.*COMMAND_LINE_SIZE"
arch/alpha/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE	256
arch/arc/include/asm/setup.h:#define COMMAND_LINE_SIZE 256
arch/arm64/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE	2048
arch/arm/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE 1024
arch/m68k/include/asm/setup.h:#define CL_SIZE COMMAND_LINE_SIZE
arch/m68k/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE 256
arch/microblaze/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE	256
arch/mips/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE	4096
arch/mips/loongson64/reset.c:#define KEXEC_ARGV_SIZE	COMMAND_LINE_SIZE
arch/parisc/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE	1024
arch/powerpc/boot/ops.h:#define	BOOT_COMMAND_LINE_SIZE	2048
arch/powerpc/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE	2048
arch/riscv/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE	1024
arch/s390/include/asm/setup.h:#define COMMAND_LINE_SIZE CONFIG_COMMAND_LINE_SIZE
arch/s390/include/asm/setup.h:#define LEGACY_COMMAND_LINE_SIZE	896
arch/sparc/include/uapi/asm/setup.h:# define COMMAND_LINE_SIZE 2048
arch/sparc/include/uapi/asm/setup.h:# define COMMAND_LINE_SIZE 256
arch/um/include/asm/setup.h:#define COMMAND_LINE_SIZE 4096
arch/x86/include/asm/setup.h:#define COMMAND_LINE_SIZE 2048
arch/xtensa/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE	256
include/uapi/asm-generic/setup.h:#define COMMAND_LINE_SIZE	512
kernel/trace/ftrace.c:#define FTRACE_FILTER_SIZE		COMMAND_LINE_SIZE
tools/power/x86/turbostat/turbostat.c:#define COMMAND_LINE_SIZE 2048
tools/testing/selftests/kho/init.c:#define COMMAND_LINE_SIZE	2048

Maybe they should be standardized ???

And for s390 it is configurable, see 622021cd6c560

