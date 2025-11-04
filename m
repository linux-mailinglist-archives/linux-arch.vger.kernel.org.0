Return-Path: <linux-arch+bounces-14502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C2C314A2
	for <lists+linux-arch@lfdr.de>; Tue, 04 Nov 2025 14:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C9A3B309A
	for <lists+linux-arch@lfdr.de>; Tue,  4 Nov 2025 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551320311;
	Tue,  4 Nov 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtxIfP8O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMHt/x+V"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C95230BD5
	for <linux-arch@vger.kernel.org>; Tue,  4 Nov 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263964; cv=none; b=s6Zp4oa/EXjxAEYHv+QRdMdnvicZaZZ4DHfM/31zWNcA8ULyNE+EFwIRzrPQxJwUEf1LdPrx9riq65Rp7Td4qj1gRfqPbbZa/9E5tBWoZs89gEU+e3k4RNQkcWyDmVVzsHqweyTQMGJHb1eiutUE0HmZEd7HKL9JXiBzAn8boco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263964; c=relaxed/simple;
	bh=6ox1zLtoIs3WHKjGHBqzO0nCO9DbDq7atxZ/hCyqdAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EstRVmdH9DHWXVOXbHK/TVr/yEEy7z2uofzUVrooLq58KdfuQKtnKPQC2C0aEZGKFR8Wwvj03EBUz5QxnRCS9kiKqsLhthjrlJtb2d9HJJr2vozsV8pmQBL7qmEc9/8+pZwEKRL0MnYqSYXzZxnLzsvUI8AsE3VUr9UiTtrNBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtxIfP8O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMHt/x+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762263962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
	b=ZtxIfP8OxR2qKPS62sHuMJsx9psPsSPwgIOqjuInzzGFIGdoOUp3a766upCpkD1jNFSTx9
	JxPug4bUSeS81NC0Xp/VZwZN8SK7liM3pgDNdS6DqAkoUuAyNOBkIryw2UzkNLEWmVj4MR
	kChaJtVrLxtdvLYf8U/le0fS0YGJdeU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-OBxK0kYBMde0ymVPnuq04Q-1; Tue, 04 Nov 2025 08:46:01 -0500
X-MC-Unique: OBxK0kYBMde0ymVPnuq04Q-1
X-Mimecast-MFC-AGG-ID: OBxK0kYBMde0ymVPnuq04Q_1762263960
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ef9218daf5so4301658f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Nov 2025 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762263960; x=1762868760; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
        b=NMHt/x+VCxgooirjQLCDYJGfq8eGEc+jKFlWyvmdixqj96mNwWuU4Omudek9PMSfdE
         tV4V1t799ZzjfSAgaIwzl4L34z3/dUL5Wb0Z3U9vifro98PyB3buEXmKMgqci9aZzBiK
         PePyAZ6mTZU1uAgenNEPT1bpOp6lYZTXrBvN58KrDF1n6vytzFIHN70Pmj5U4ESIVg8a
         94TRVqT6L4ar/Y/7euFJDAoXZxmJtLdOBdDO6xNAUng+3PjwwBCPLrUsHPWgGSFQDs1e
         WeHAUBAxR9BGWj26DV75bCuu2KGI/PYpGhbRbawb6cl9j8o2lxWtIyniVd9ntxLNVr+R
         AW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263960; x=1762868760;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBb4JYjcOHMwFtnHDJyHLJFdY3oY5dMhkeGhI5Dhsqo=;
        b=h8vxXwBqwHThqZ65pYXhf8DjLVgRVr0NrkfKKHmU+RUKdpSNd5r8S3LGb1sIpyM22T
         uVW+JETyboJNveNs72S1lBI0dDUWlpt5N99imiE4vjU8SIYmTmiYBV/7bPFlL0PVBeEi
         HaBebVl38TnC7KsEt3C67wSRi1ZtUAC0sWqDWoOnHVAUmprsi06V2YsiknSgvq3/Cvzc
         afljdaU5EtAVSW5vJt9IpUBzY69qdwaIFd0+Cs5phhah8KaxjUkiAZxf/vUOv9Z9JcYz
         D2VI8TEX1SdwgtpT90YHvVmr7Vj4L8vzGMkIH7EObTmAJxjGTyLdutd8pdZnAlXTtuzz
         j4LA==
X-Forwarded-Encrypted: i=1; AJvYcCWaJFn6nfX0O6OmpvZDajVYsgrhfBSudPNqq5k9Wz9hbXR2XmvBWtk7fHVJEBWb7h4q1SmJwZYZ8456@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkeU+C2LgdDAhAjrMtaZO46i2SoCV15xGeG+L4iPDRUIvZnNU
	tRHLgqXzqeApYvb4yEGpX/LzZEjX7Pqv1TUDGMdWTslI7S+KJnIRC890Ghqpg6gX+rsYLN2Hyf4
	t0n96FPRDhlcz+plTRhloaSyl8iyxnakXP7CK/ihtRY7SNChlerHIV3Sy+v2qsuo=
X-Gm-Gg: ASbGncsBaajTmF8YOYJZCMhiG84z/W9utz6YChLq1D4HYVKD2/GdlWkn9eHeyiMFWvQ
	DufYjwUUxDyktOYpWruMSsreNFri8qYM52QOcp3q2Y5iokugjqVOid3VB+sjtC5ip8IGvc0kka3
	0Z5uWQ/WgLd2khoTSth+XUD6kmj8JzWR1+Ta05WNTWgqcBQBJXSVThSy0o9LR2/1Xkgu/RWNCgx
	AV+DwmMeUpLVUD+jiDW6oMTaMa9wmXYf4IIy8uvOqi60qzHttgRsHQaTGnwOb2Ck2lQzxxB6K4x
	jUc5fvIjewsM0N+Q80921dD1gN+2QFdStThLGw1+7C959RerubvLFZZg79TwwbtcaXbuNZfk4yL
	jiG4wcEBO1iFdETgyKTneqhQJW6xhUifnQiE=
X-Received: by 2002:a05:6000:22c9:b0:429:d11b:9ec4 with SMTP id ffacd0b85a97d-429d11ba360mr6284640f8f.41.1762263959634;
        Tue, 04 Nov 2025 05:45:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRnKz3y+r5XoY3ls/nBZPt8sht5PzwdeS+jf9m1q52xASXswgB53muxrTyL7Mvrv/sZwgkKw==
X-Received: by 2002:a05:6000:22c9:b0:429:d11b:9ec4 with SMTP id ffacd0b85a97d-429d11ba360mr6284574f8f.41.1762263959010;
        Tue, 04 Nov 2025 05:45:59 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2a01:e0a:36d:2b80:e937:44f0:a96a:94f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1a8528sm4959089f8f.21.2025.11.04.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:45:58 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, "David S. Miller"
 <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman
 <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 23/29] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <dee4dc13-b187-42df-93ce-f738cfab32ea@linux.ibm.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-24-vschneid@redhat.com>
 <dee4dc13-b187-42df-93ce-f738cfab32ea@linux.ibm.com>
Date: Tue, 04 Nov 2025 14:45:56 +0100
Message-ID: <xhsmhjz05ud0r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/11/25 14:02, Shrikanth Hegde wrote:
> Hi Valentin.
>
> On 10/10/25 9:08 PM, Valentin Schneider wrote:
>> +++ b/include/linux/context_tracking_work.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CONTEXT_TRACKING_WORK_H
>> +#define _LINUX_CONTEXT_TRACKING_WORK_H
>> +
>> +#include <linux/bitops.h>
>> +
>> +enum {
>> +	CT_WORK_n_OFFSET,
>> +	CT_WORK_MAX_OFFSET
>> +};
>> +
>> +enum ct_work {
>> +	CT_WORK_n        = BIT(CT_WORK_n_OFFSET),
>> +	CT_WORK_MAX      = BIT(CT_WORK_MAX_OFFSET)
>> +};
>> +
>> +#include <asm/context_tracking_work.h>
>> +
>
> It fails to compile on powerpc (likey any arch other than x86)
>

Woops, thanks for testing!

> In file included from ./include/linux/context_tracking_state.h:8,
>                   from ./include/linux/hardirq.h:5,
>                   from ./include/linux/interrupt.h:11,
>                   from ./include/linux/kernel_stat.h:8,
>                   from ./include/linux/cgroup.h:27,
>                   from ./include/linux/memcontrol.h:13,
>                   from ./include/linux/swap.h:9,
>                   from ./include/linux/suspend.h:5,
>                   from arch/powerpc/kernel/asm-offsets.c:21:
> ./include/linux/context_tracking_work.h:17:10: fatal error:
> asm/context_tracking_work.h: No such file or directory
>     17 | #include <asm/context_tracking_work.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> Gating works for compile, but no benefit of the series.
>
> +#ifdef HAVE_CONTEXT_TRACKING_WORK
>   #include <asm/context_tracking_work.h>
> +#endif
>

Huh, looking at this I wonder why I shoved that here. That include belongs
in context_tracking.c itself; I'll fix that.

>
> I have been trying to debug/understand the issue seen with isolcpus= and
> nohz_full=. system is idle, even then it occasionally woken up to do
> some work. So I was interesting if this series can help.

Is there some ongoing thread for this particular issue or is this just
something you're experimenting with?

If you suspect stray IPIs hitting isolated CPUs I'd recommend tracing with
these events enabled:
  ipi_send_cpu
  ipi_send_cpumask


