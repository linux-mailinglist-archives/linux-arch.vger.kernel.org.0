Return-Path: <linux-arch+bounces-3811-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE398AA2CC
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9402B282D91
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52317BB30;
	Thu, 18 Apr 2024 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUEv9uwr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAC6A00E;
	Thu, 18 Apr 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468694; cv=none; b=RKr7x5bUBe9pOB6k/xwUvZF/XwYc7Lm8lLMrNLrc1Pe5FQ7xL1DINjI9vAyMZcknuotkgFQWC38VFnui0bvMRIDjMaCDtC4cfjjbAUqlRLL9/+mOe4GkhLbSR+kfnEGgmXQEObGuKA6/fqo41gB5awzRXKGK/RkwJlONbx2R4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468694; c=relaxed/simple;
	bh=Ps3ERSaJ3Nubf413Mgm5+5UAMdezoWO525AtmvS7hLg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kRicg1RyoXGu/ZHwAfSmhZNRzdWFDwXLr12Bj3NL4Mvi/WVdAAVTbLTtnPM/HlDfuK5tsYyuNw4yDixTfXu052lDRLWqA5WPTWr12ZgCDsng/qVKlGUAaO5lSZ597wS8N4ZSdK37oaVH1btlq+mkNfIWjgWXSD3a5IPM6rkwdSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUEv9uwr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3465921600dso1071781f8f.3;
        Thu, 18 Apr 2024 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713468691; x=1714073491; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps3ERSaJ3Nubf413Mgm5+5UAMdezoWO525AtmvS7hLg=;
        b=lUEv9uwrH2d1EIeIr6R1nj4v0AOv2obynUkrSBtRy60ku3qo7KemDH6bn7tYVlzO3a
         P5/pUB3KHASzb7TMGBP7JKc+uslQ3eJdvZY0TuPG9QuxXQ+nkKtpV+bIK6ZHs+KJ5HmM
         cjrxADU9Ke+fWIZEejQVhgV6FbazGZLgT0OsMzN014yCpa+7DZy/ywfpRS4RR3HGb4+d
         Rna2RRpJov+QfFeqYviAVwfzq7evgJsYXxwGSrwAWkPjCi4cAYvK60IO92usyBooRtqt
         zZvUCvA+V6nh95/ojlY/CvOvWGlH6Q6RRIXF7DAneqKh9WFI/iMLkXz0VL6VRe76FSIM
         7FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713468691; x=1714073491;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ps3ERSaJ3Nubf413Mgm5+5UAMdezoWO525AtmvS7hLg=;
        b=lBa95u7ACsS5NO8engccFk57GAyRzMQn/qT9Riv3mgAdPXl9ZENdogkc40erLlnWQE
         22/ZWpMIjqdEMnbnIpiMrGS31/IHjOmoPvFz3wY+So5tTH1tPX+2NsNmTgD9syJDAQNm
         InYr0639kH4kENE/K8SmwjxNfpqR6GMNGHiR/rVFChpyNbSjmVORZ34Ct7SqrsUpMb9p
         /MLwj3lqwRbAD8BroWigTa95nuWQfDMIXbmXWg89Gi8uQAZok9DbKOgZg2wc3QmhpVMI
         i0SnWwW5ZFxbyLn6S2roWdhKXQviVloSNicPPus/+Jui/GZGgf6xXz+ScOfTEllDQZhb
         hs2w==
X-Forwarded-Encrypted: i=1; AJvYcCUlHWkSgsaICGh2U7PrQXuUTnhBvu/x5CGEN7ia5U1WhO4BJIkl8N7VBVnpzaHQiJaodloWMPIHuAho+PC5tRBxugetCX0imNF+xHgnNcbnMmzm3hfZPPNVWVWFN+AjpqpIQQCTWqYbsSAtqca5xQJ1cPnK751L3dVEx1ycMwkGWR71OGksQ7+XUL2LocBIOe/L6Df6Nl9kBM3a09AcUzwgor/qs8NtcVjH4DqsiicYztbzG317zsKcRJR9BdqhK88=
X-Gm-Message-State: AOJu0YzDlr6XDccMuhEFaLfzUpD25iWbEc3we+goWzbkoNvQuZys5aAT
	19qWTgc6AIiuPWVHTbA0hwg5+7Ru/XkMZWIqg1PN/UHicX65wAxe
X-Google-Smtp-Source: AGHT+IH0u8bsjFHZqemZxrgoGwtoIHFPdCVNpm0ysNZP2RZZazFU1pUbMRvZ+DfZhHxeIo/1VeVn9Q==
X-Received: by 2002:adf:e58f:0:b0:349:eb59:c188 with SMTP id l15-20020adfe58f000000b00349eb59c188mr2213684wrm.5.1713468690932;
        Thu, 18 Apr 2024 12:31:30 -0700 (PDT)
Received: from smtpclient.apple ([132.69.239.36])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906d19a00b00a55662919c1sm1277105ejz.172.2024.04.18.12.31.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2024 12:31:30 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [RFC PATCH 3/7] module: [
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <ZiDz4YbIHEOAnpwF@kernel.org>
Date: Thu, 18 Apr 2024 22:31:16 +0300
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 Helge Deller <deller@gmx.de>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Russell King <linux@armlinux.org.uk>,
 Song Liu <song@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>,
 Will Deacon <will@kernel.org>,
 bpf <bpf@vger.kernel.org>,
 linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 linux-modules@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 the arch/x86 maintainers <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A714B340-9EFB-4F27-9CD6-CFBC1BC9139F@gmail.com>
References: <20240411160526.2093408-1-rppt@kernel.org>
 <20240411160526.2093408-4-rppt@kernel.org>
 <0C4B9C1A-97DE-4798-8256-158369AF42A4@gmail.com>
 <ZiDz4YbIHEOAnpwF@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 18 Apr 2024, at 13:20, Mike Rapoport <rppt@kernel.org> wrote:
>=20
> On Tue, Apr 16, 2024 at 12:36:08PM +0300, Nadav Amit wrote:
>>=20
>>=20
>>=20
>> I might be missing something, but it seems a bit racy.
>>=20
>> IIUC, module_finalize() calls alternatives_smp_module_add(). At this
>> point, since you don=E2=80=99t hold the text_mutex, some might do =
text_poke(),
>> e.g., by enabling/disabling static-key, and the update would be
>> overwritten. No?
>=20
> Right :(
> Even worse, for UP case alternatives_smp_unlock() will "patch" still =
empty
> area.
>=20
> So I'm thinking about calling alternatives_smp_module_add() from an
> additional callback after the execmem_update_copy().
>=20
> Does it make sense to you?

Going over the code again - I might have just been wrong: I confused the
alternatives and the jump-label mechanisms (as they do share a lot of
code and characteristics).

The jump-labels are updated when prepare_coming_module() is called, =
which
happens after post_relocation() [which means they would be updated using
text_poke() =E2=80=9Cinefficiently=E2=80=9D but should be safe].

The =E2=80=9Calternatives=E2=80=9D appear only to use text_poke() (in =
contrast for
text_poke_early()) from very specific few flows, e.g.,=20
common_cpu_up() -> alternatives_enable_smp().

Are those flows pose a problem after boot?

Anyhow, sorry for the noise.=

