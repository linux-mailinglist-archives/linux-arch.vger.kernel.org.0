Return-Path: <linux-arch+bounces-11127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB14A70BC3
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 21:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E09188CADA
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 20:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480F1E1E05;
	Tue, 25 Mar 2025 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y+IFlN3e"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DE42A82
	for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935788; cv=none; b=Rbs8vcLTnMX5BLgupHucy+POXfVAX0VWR++KCG22BUGzLoGKSh+qN/IxL/nkyoZUIPW1voT5xZ1A1rV6/yQGEwRp7d0gWfIdgBMXr2tiV7I/W3k3wOVEHhJABmpqGhOfUFA9c7nYCKR6rxHSi307kx8D02uZLpKu8g40BQkFX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935788; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/gh5ta+HPTQYVvBXK+f7D4p0qxVa6dXR2Qr4bIRxOrfOIQsxPaiSk57jQA7IQe2dOK3NEAynvDud959lgQi+unXjxqQoRcg+kN70Dhi6sWq6Y4X5FSCnpCZsHq8roRomOILd8P0HkjrKI1hEhJ0t1qDYhWKht9k5fcZaT7BZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y+IFlN3e; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso58946681fa.3
        for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 13:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935785; x=1743540585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=Y+IFlN3eSGJxU1WvipgKlPavpcuNROkcYcLEDyZFNqU6ijsdghIibExtZ1t68ycnp0
         pNb0XkOukWfCP0s/K6AI5tzZOc8/tf7LEgqZ8KkwKG7bvqy1Lub9uPWdS/tsGcxTL+Ly
         Z5kl+nYQt5u8rNoPAThkqkPsBkSg2cfN+6NpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935785; x=1743540585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=E7KgKyhloe3wjqKpGWn51iN9K/O/cSXZMWp4kUhRWNrLicDIhk3RgKUTsdYSgaTbn/
         X60lT80CpHP8BzQfvx1I7zsDreiepBOtOR79wbthwcYz15Mc+BGeJUi2m8lVPUjR87L+
         R4dg/7c+qM+zsZ85CqkkBozEQvzAmrFGp+1gNqFJn9nw7rYLXQwLgwtB6stlmP+RcuXw
         xN4nC/x7qKZmMM37MZcN8fUiK0sJ84N28lCasm5IiyXTEisRON5DaNd0ybkOO4lcF3UM
         O1sNBN9tULGo2kdjqoW/IsNGcGaUWkbuTdnSFW/WoIZ/8maRQDIfBcz8/HaR49rNajWB
         N2fw==
X-Forwarded-Encrypted: i=1; AJvYcCXWGVhJkm5reCOQgTKwRCROOmmYiB2qWAfBRNzh7lmCiuQ6qElyIey5LUiZGYlFwDrV7kzWucIQpcYW@vger.kernel.org
X-Gm-Message-State: AOJu0YySM4RToZEphAmJ8hKs9zDwKqN2hT9C6cxoLWk79jawJwHW12Z4
	mlZIbRYla6pTavtZru/zNW5AoEPN1oELb99j4PjCcSOoUQtT7pfhayFdu7x5jNNl2f1Oi/KqDJi
	LS0VQtw==
X-Gm-Gg: ASbGncsJ7nvDnZVKoEn6gdh4q6TfPgXOI9fwEID5sgmC1X39a7k2L/iYCbz6Q9+suXT
	lnqTW0uOrYlu0c8t5Wo5IzcRQLX04U1kCe+vpmFbJ1KGY48u63sY5YBnq+tyDWifw7eSvpi2nq/
	IwzNN4PKjDpBfQmRB3+kg9vQVJl26hZxHCtggIbQzYdFxAr1VyXBnkoSE+0kOZKZDI9QxC/EfVc
	Qph4xw5rU6PsUGjbXG8mMsDdUa0jcN6ngQrxU3W0kVBI7/zxX+LkD0eqzLCtcaA5SA/vxWm8bzK
	lHplT4J3j3pt9EIOsyYjpFhPf45hgWIB0uZQNgKuTHAjCbve8eXWl/HrzNUiUxiFP1aoyUhiozq
	Ic+db6lpkwmic+ezBA7o=
X-Google-Smtp-Source: AGHT+IFK31lsDo+dTWIJg+KqDv+42S9Q3oZ54eIqi8BCJ+Lia7/0YyB2AWgeVyYf9oIFnAGEabj0DA==
X-Received: by 2002:a05:651c:504:b0:30b:c83e:720a with SMTP id 38308e7fff4ca-30d7e206a07mr59819251fa.1.1742935784623;
        Tue, 25 Mar 2025 13:49:44 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7c1ab2sm18916071fa.11.2025.03.25.13.49.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:49:44 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54996d30bfbso5660108e87.2
        for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 13:49:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPa5t6K8sjISwUoxv6jZeobuyZXBfrPDzIJ3P7F2uNxzDPEybX2AcIamSkeCUov2G+n9TvEqjwlonQ@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus

