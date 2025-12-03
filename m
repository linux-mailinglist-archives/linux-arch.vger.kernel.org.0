Return-Path: <linux-arch+bounces-15129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B4BC9FFB2
	for <lists+linux-arch@lfdr.de>; Wed, 03 Dec 2025 17:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F62E302283A
	for <lists+linux-arch@lfdr.de>; Wed,  3 Dec 2025 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20436CDFF;
	Wed,  3 Dec 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="LfKpCL7+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD636CDE8
	for <linux-arch@vger.kernel.org>; Wed,  3 Dec 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779528; cv=none; b=SLeN6ktihIMCAmiHyQN3e6hd+GDGXKwLwcHUFjMKEQfdR8IDvT2wreUlhojXJ818YiKb2RkE1LSMJTBMtciZjVD4CrWV6UxQsg09gg7HoEtMUdtykBLrtPofIrhmvT5Q5FSACkgoHz3t0hypL+NEIcqfKAa8zlMlMfsKtqQacM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779528; c=relaxed/simple;
	bh=l0gnY/UzSbFUAuDU1KntIMiLjASuWWo0nEVW8bui9Tk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VPCe091ZKEQ0rFoSsd1kPGXozfNS9zyux9WNjlNptnIxKNK/xQSiN02qLuuWCuK5R5LTZIHBROpPwh2GVFSOjResTJUtsT+GWG1xJPBtwJClPiGIVxAgBcpWWjw3oCEP5hUjTPoq31lpXgUHK/d/wBksO6fZSPMAP7lTwa3I+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=LfKpCL7+; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D00BA401CB
	for <linux-arch@vger.kernel.org>; Wed,  3 Dec 2025 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764779481;
	bh=l0gnY/UzSbFUAuDU1KntIMiLjASuWWo0nEVW8bui9Tk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type;
	b=LfKpCL7+25t4im+WZBhwtm3MrnKvZMoLboDIobzfE+5DQSwU/ycnrf4VAuwEG+xrj
	 pH7T/d9JsRvoO6NeF13bjzqJzjkUsx7MWn4M7V/46C3EoSKx5UFSu+IbAzc8lqvOPr
	 VpOgQJtuOv/DPtehpfOZ6XHDkiQY04VIbTqianUFUApQl2BiOCdBJzTaWMMybvciJg
	 1iv32KsBU4x8BlsLh8HaJ3MKD+lvaGI8PPgQsBMODQfh/+Cj2DjnvA7jQWH4zjku3R
	 cy3Fv65LXdET1tuX6us3ReTG2G9Vl12rCTgT7JNhQBu8p1XDnH7C9q9PP9Ijx+CZJ6
	 gvOMrZMKvz0+znJy4EfqmVd4RFA+OepLPoLBRnXOFeN0bTuI2kYlywIT9jhTGl/miC
	 QgTJnyAALIlXeDz7ttJwM8aOGWgmpHcASdqCsJIg9GXNspj2aFak+rVjdlkuwPiJyy
	 rxoigdoJGtON7k3OJoPUlC9Dd0oa4ZlrDv32U9pKzxcyGTg79vQ1OOFaXM2cfRlLHC
	 qLDEkpf/wh8kh3M4S3U1OwLiLFTdiMKb38FPQl52a6rQ2ELmnjUvQUKKNfWwJmGt3N
	 kAtaLy9tVXAugha8SiaprkJbQDlJTXcYykDJMIt/H+/RuX2ZB3JrLS2RPpKazAvOd5
	 hOtmiW67sPWNeehLXak+epIU=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4788112ec09so40010645e9.3
        for <linux-arch@vger.kernel.org>; Wed, 03 Dec 2025 08:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779476; x=1765384276;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0gnY/UzSbFUAuDU1KntIMiLjASuWWo0nEVW8bui9Tk=;
        b=CDyF/DJUBix3YzCReDQJBQBPyWwRBCC+Nj7LW0ezLoY3oEXSMkXA8TkLQrW36VgGJN
         z6lI2kinsdwuk/4y/FAT5xrG06AwpYga+OJ+9XV2of65Rg7vEhrJbuhORoIDD7AvMUWW
         HHsxKa09UXS7e6O+2pv8OOVnVv6fyq4NUoDQ3df0+IKkFObpx3Ws1EHuVJMDfoJDGpcF
         TBszFQ6N948ZKTRAhTkvpEscDCVWSGgqOQDh0YLhCNi6AtZ7k99UZkaC8DRUdu/F7ujZ
         4WReZkRForKmqitqeHOwm+TlAhr41f3UTJkYiSmfbL2jMfaimxRbcSW93NTyiVeXcFUF
         iu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUevugEO63sIzemIZCsvDjpPtyOO5X7ypCdYagw6a7AXAxgqJHeSpt9Tl/STKGFK2wX22aNuPFr3Z8b@vger.kernel.org
X-Gm-Message-State: AOJu0YweTI/+sWp6XPDmIrNsnKlA0F+ucbaKvjP71AMFY8Np3tncqbvk
	Uk+WYUn+N65bSpU1m+GO7V+XQdelM3JO0AASX+MjvuSZTUmDJIBNB2ZQUY6ZVyaO1d4wK9nUclY
	DUWdn/PKRTGsP4I8EwbeRovjKQ6fvG6HqD/RDGp1ls3LqgvzBbbhF1hULuz1fHWsjDtjNoFRw2h
	pj2oI=
X-Gm-Gg: ASbGnctT+F8bOFKnkGQ/yIjEQ3RkRJJXkEDY+A5a63lXUosAk2C3f4J7pa//PRbGazA
	SsYiDBw+WvevmvAgBltqGRwE/OvXDwoSLLRKyqyxEzQKukjxGt/uSHOQYH2vOfn2Zwpr4k0/Ley
	Ifzs1Eg+DdC8rIUXiFOwCeG/6+tR9I6pMm0xahNZtbAqbLZazna7H8OPJKD+AA07xrMq69gwcGY
	WS4+YSwlJp82tQMMtgtZHSRVnEa1lR5Fr1Fog05zqkXnJyWdpHsmdU9gOTsaD8+AAaDFt7QWO4I
	Rwhgjal2hicpUwV+/EfOVx7d+r3YqJVD4WYYjEbeD0mRb3/M+o75/vtmPUqsc2kXlB1HmNUifZi
	V93cfb96tmmmnB08Q97LuRjyEgr99eVn+vY/U44hjNyFLJmVpsdVlkhKe4oHXE3B7+NA+RGv4M4
	o=
X-Received: by 2002:a05:600c:a41:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-4792af327dfmr27911485e9.17.1764779476147;
        Wed, 03 Dec 2025 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCKejq/2U+1EN5UAB8CezRHOHJDvwMZzcFVGMZ1T1ZB5XD8pg1afh59Y/Z4iwxgxyD87hFlQ==
X-Received: by 2002:a05:600c:a41:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-4792af327dfmr27910815e9.17.1764779475621;
        Wed, 03 Dec 2025 08:31:15 -0800 (PST)
Received: from [10.1.1.222] (atoulon-257-1-167-49.w83-113.abo.wanadoo.fr. [83.113.30.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30c4sm40900310f8f.9.2025.12.03.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 08:31:15 -0800 (PST)
Message-ID: <6b25515b-c364-47f1-bd75-8b7dc16e3701@canonical.com>
Date: Wed, 3 Dec 2025 17:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devnull+debug.rivosinc.com@kernel.org
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org,
 akpm@linux-foundation.org, alex.gaynor@gmail.com, alexghiti@rivosinc.com,
 aliceryhl@google.com, alistair.francis@wdc.com, andybnac@gmail.com,
 aou@eecs.berkeley.edu, arnd@arndb.de, atishp@rivosinc.com,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, bp@alien8.de,
 brauner@kernel.org, broonie@kernel.org, charlie@rivosinc.com,
 cleger@rivosinc.com, cmirabil@redhat.com, conor+dt@kernel.org,
 conor@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com,
 david@redhat.com, debug@rivosinc.com, devicetree@vger.kernel.org,
 ebiederm@xmission.com, evan@rivosinc.com, gary@garyguo.net, hpa@zytor.com,
 jannh@google.com, jim.shu@sifive.com, kees@kernel.org,
 kito.cheng@sifive.com, krzk+dt@kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 lorenzo.stoakes@oracle.com, lossin@kernel.org, mingo@redhat.com,
 ojeda@kernel.org, oleg@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, peterz@infradead.org,
 richard.henderson@linaro.org, rick.p.edgecombe@intel.com, robh@kernel.org,
 rust-for-linux@vger.kernel.org, samitolvanen@google.com, shuah@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, vbabka@suse.cz, x86@kernel.org,
 zong.li@sifive.com
References: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
Subject: Re: [PATCH v23 00/28] riscv control-flow integrity for usermode
Content-Language: en-US
From: Valentin Haudiquet <valentin.haudiquet@canonical.com>
In-Reply-To: <20251112-v5_user_cfi_series-v23-0-b55691eacf4f@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>


