Return-Path: <linux-arch+bounces-11848-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90595AA97C2
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBBB189B099
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A125DD1E;
	Mon,  5 May 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0BUGXAC"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92B101FF
	for <linux-arch@vger.kernel.org>; Mon,  5 May 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459930; cv=none; b=WFZe+AX929aECXFbrMnqe4/yUsh63pZ2PJ/lwJLxveCCo9gJTRKtGmyV2onAY2diF/h69oQZSTFEwb5NLdFmHxbs4W0aT9KqiyJ0XbzMUIq7fUhuvSS0Xf95pBW97Ii0UOvzQYMkKgkkztQwjdFCDh3yqhI7ph7LOy2lS3w56oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459930; c=relaxed/simple;
	bh=fT63Qjgxn2mmOj4nEoT8zNbpR7UCW8tfN5uQH3dFpw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G+JxTCTA9h1AWFNbYqx/N+yIrxE3nVwl4ycAvGi0ZHAwIxYaAd5GONsFO0KtnC1UphtXGOsNCoJsyv/d5XENHTvdcsdGSIEikRCvxV7r3IRiOTGZeA4dPUJE/ovxYK9Dw7a1Y2dxhpbay9w3N87aoHD7AnAsdvfD4NsdCsc75kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0BUGXAC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746459927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fT63Qjgxn2mmOj4nEoT8zNbpR7UCW8tfN5uQH3dFpw4=;
	b=A0BUGXACFv0m+cDMmFQwyFjW/ZK/NhBvbhEWwJPeEMGxAeQBnqA5m6KImPtn9gK305aVcd
	8YJhL0D45kyLu8Rxa+1t9dt4xuNJKLk5tmyjkwk08sNp5P1voQSpTLVfpoVjrghstCT6Mi
	+FR9y4NZVxPrx/r5wXLKTSL8XeYRvEk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-OJz9g29fMa6K910pIMQ1qw-1; Mon, 05 May 2025 11:45:26 -0400
X-MC-Unique: OJz9g29fMa6K910pIMQ1qw-1
X-Mimecast-MFC-AGG-ID: OJz9g29fMa6K910pIMQ1qw_1746459925
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso30501655e9.3
        for <linux-arch@vger.kernel.org>; Mon, 05 May 2025 08:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746459924; x=1747064724;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fT63Qjgxn2mmOj4nEoT8zNbpR7UCW8tfN5uQH3dFpw4=;
        b=GcXaSkeF1tNwxK7kBENbF3+jO/kgJYeNaJjc1eAux4Mne97x2KTQT7GBLaqLXiDgGy
         6ZtNyjcNx6LPvCx4eNtfwY+lP31y6VBrmGLbvN1dY12asVNCBPrW8+wPQ/IQX/O3VKKg
         JUxt+zDIBmBH1pcHW1OJPZdVUR4hZzVIYqeKYtdtsjmIO/UQtlQQjaWUh8E2OCpJqpNt
         62j0MkwSy7bd43+uc41j2joNfpDrl+h2MlPmC7HldoWhXKppo4+MWeAJu8dJFCQgGLPH
         gOomn2Djh0BSIqeM5PMWfg2Ct0LRoqHnF+axeU3lZSHbKRYq5d50JsIvjV+5IcIdE2iL
         vr4w==
X-Forwarded-Encrypted: i=1; AJvYcCUpSGD5hzLfEXwmNQz/uZXwfak/kY2LWnP+RBiNBKUJGeTWTos/TUvll/iSOoUMF4cCn5UpSHDBMH2n@vger.kernel.org
X-Gm-Message-State: AOJu0YyWH5KRJTIK7i3lHvPppPWYWMerfqRnLye+pOZ95jwFqmP4AZ7m
	/7zgRQPwZNdWHawSQO3wwG532RUQPGeauQ4OkK2t1IW+WqLlnOFv4dOF+qXK0yEVXB6fWCLB8Zd
	5V/bfCnDzUpHOPO+lT5mZIe3Cq4MWOTMbvTPebGlp1/eIJy2YchJR7DQfNKU=
X-Gm-Gg: ASbGncuSap6C8XknijHCKqKFkugPdNCn/9UBs/zHH0IYFLUloI6lIlDlEJzyU2t3Npv
	v8acw1aqmw4a+JrHxtCO1XkBJIBJdM/3vBRZmxiKcb/DG+rIamHUBHjd1tr22ruNDRkC7Ri9x3i
	PBZ25hjiAcdy30nEAqDMTlw5zx/RPGYarN2DvaShFM8LCBtgnCWIN6/I2Agiiht3FfVn7K8vYkt
	5z1uKhCPhC4FDGOw/d+v7QeVDsxjTvol7aD4wxOC9X6NU37ntKw6wZMTnzhl/XidYhYYIbugKRQ
	aKT3AQyb8tS3ZEBQScRNz620OYbJDvl7J3yECS5sr57F6plZ
X-Received: by 2002:a05:600c:5290:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-441c49340e5mr60613135e9.33.1746459924511;
        Mon, 05 May 2025 08:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbfW0Iv3UrCtUauOGIpvVxzFiIHYGFD4OyH1evLHyjz0zJwfLTvcXbPZ3pmzRKAXfEnCx79Q==
X-Received: by 2002:a05:600c:5290:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-441c49340e5mr60612745e9.33.1746459924071;
        Mon, 05 May 2025 08:45:24 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2001:861:43c1:5950:3e51:b684:9982:d4a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d1358sm138001675e9.10.2025.05.05.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:45:22 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, Juri Lelli
 <juri.lelli@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>, Nicolas
 Saenz Julienne <nsaenz@amazon.com>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Juergen Gross <jgross@suse.com>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Naveen N
 Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Rong Xu
 <xur@google.com>, Rafael Aquini <aquini@redhat.com>, Song Liu
 <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Brian Gerst <brgerst@gmail.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Vishal Annapurve <vannapurve@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>, Tiezhu
 Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v5 00/25] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <2c5d11cf-ad06-444c-b84a-42de7a10159d@intel.com>
References: <20250429113242.998312-1-vschneid@redhat.com>
 <fefcd1a6-f146-4f3c-b28b-f907e7346ddd@intel.com>
 <20250430132047.01d48647@gandalf.local.home>
 <019f6713-cfbd-466b-8fb5-dcd982cf8644@intel.com>
 <20250430154228.1d6306b4@gandalf.local.home>
 <a6b3a331-1ff3-4490-b300-a62b3c21578d@intel.com>
 <xhsmhr0179w1i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <34535b8c-35c8-4a7f-8363-f5a9c5a69023@intel.com>
 <xhsmho6wb9de3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <2c5d11cf-ad06-444c-b84a-42de7a10159d@intel.com>
Date: Mon, 05 May 2025 17:45:20 +0200
Message-ID: <xhsmhldrb9i3z.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 02/05/25 10:57, Dave Hansen wrote:
> gah, the cc list here is rotund...
>
> On 5/2/25 09:38, Valentin Schneider wrote:
> ...
>>> All of the paths to enter the kernel from userspace have some
>>> SWITCH_TO_KERNEL_CR3 variant. If they didn't, the userspace that they
>>> entered from could have attacked the kernel with Meltdown.
>>>
>>> I'm theorizing that if this is _just_ about avoiding TLB flush IPIs that
>>> you can get away with a single mechanism.
>>
>> So right now there would indeed be the TLB flush IPIs, but also the
>> text_poke() ones (sync_core() after patching text).
>>
>> These are the two NOHZ-breaking IPIs that show up on my HP box, and that I
>> also got reports for from folks using NOHZ_FULL + CPU isolation in
>> production, mostly on SPR "edge enhanced" type of systems.
> ...
>> While I don't expect the list to grow much, it's unfortunately not just the
>> TLB flush IPIs.
>
> Isn't text patching way easier than TLB flushes? You just need *some*
> serialization. Heck, since TLB flushes are architecturally serializing,
> you could probably even reuse the exact same mechanism: implement
> deferred text patch serialization operations as a deferred TLB flush.
>
> The hardest part is figuring out which CPUs are in the state where they
> can be deferred or not. But you have to solve that in any case, and you
> already have an algorithm to do it.

Alright, off to mess around SWITCH_TO_KERNEL_CR3 to see how shoving
deferred operations there would look then.


