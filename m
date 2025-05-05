Return-Path: <linux-arch+bounces-11846-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFF3AA95DA
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD75218848BF
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A1D25B692;
	Mon,  5 May 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FAEmofIC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D325B66A
	for <linux-arch@vger.kernel.org>; Mon,  5 May 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455283; cv=none; b=jU4qIF3rFhDESzgIa7xXxysPagLwBnBThtSsa3fOmlFJAmk7s/O6YP5N9n106RT2DcqvbP05xCqnmJGRkGui6owkpEG3q+kptdIuXXyShY7f+nSObl1gOtuJ/J5aMw7l4DUD8JwG5FJjFWV+bs4j65M6LRf/1qejpWYMWZY3+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455283; c=relaxed/simple;
	bh=8bG+q9cvIxNRKMt+IdST9BOBQGsJ4SSG4cIoMmhVp70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJwjckHW/jxscnYQ0qK/Rv5zge4qhS36oJxsig0bYnQyHJkZ1D9yw+N+zF6QZALZ7athMMALgXchkDigweWbI7fAm9t8A433jSrMaYOzEN71cHI/vyZGbFvOIZ7Mf3jRFTGA1qc4CkdmmAEsB/3uB7kpvI2Lcn0C2x/L2tmKbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FAEmofIC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso8325531a12.3
        for <linux-arch@vger.kernel.org>; Mon, 05 May 2025 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746455278; x=1747060078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBzMpH2jBdczGJAGi07riCizg5SErgbDrt1biXSYE6I=;
        b=FAEmofIC0oMM+HqGX1QdwjAskqxFoWHqsDymqlRLBS/KhXeZxE+mwWfJq29JUleahh
         vKT2odpe77T24da5PV0EMgZ19hC2eRe4ZrMkJVRQRz0eIKE20NtNaupb7t2dlnTladb6
         4mHbjKw5IN4P2WzraDyaCPW1q3P+ecfzDwBrl6jMs7w3fpy/jYI+5rBEE66Agxn9GF77
         g4Y8NWq5b6bnb9NlFU8Pc/my94E230XqMhM79g5fUvX3TSlwsiVK2ibWES8kafcBxZG4
         tnLTBER/EMzZktt84zMYVCpiHMTBHreMBiFItt1ZWyOn+8aGousocxWBWePautMA2OGz
         bc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746455278; x=1747060078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBzMpH2jBdczGJAGi07riCizg5SErgbDrt1biXSYE6I=;
        b=olO4/9n+OWv+GVznrfSF1+kIVKq+KboKBbJEcrqjmL9d/RNkmSJ62ylTRBcxr+8x8L
         J5EyYJz6IFcQ9vfw+wTwUq5/8n0HbahfxVa4Hl5grSrm82N1dtFe1nW/4AvL8CjCOAs5
         /CZSogyLpzkvpuYHaJ0T+S7/nQ4o6a5icq2bG4ntwI5tRh8+6SJ58cXql4lbuRTM2ki0
         pNrkwz510AjCbSP2uE7JVlLppO6EPnSZAQB3zM9i5K2rYtTXu2mWW2CHBLENFP2Av8Na
         h9kf9wnrcbrvCnebMLqmBMZlBosEEwYV33QN174VphoQExiJM9wYuFMD2+orxLVjw+2G
         /C8A==
X-Forwarded-Encrypted: i=1; AJvYcCXuMdjG8HSKJ66YA5MAG5g4Fee4GchpNIWdHvr+bi3nSL/O/9Y1ZwI7cTipMdImaaVwUFieWEbO81/T@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBe2BYrMWWsbLdQe+fk8K5lrTWftEhgUdxFIY3E38eGca3AZt
	XKMz26aYm/2P6BzKfFrAKbJz9nRRaW827bdOkKlZd3nM9mT3bqoMilRoYSuqQvw=
X-Gm-Gg: ASbGncsLBKKSigBxqBM6We7gOsLE10LX9Utbkwuc7ZCc6RfX4xg9k6I3I5CvD93G9f5
	9nUOfYKSPOQDitq5HgeYbKqyrI1rDHusBCBZP84xwzx7yVYI2EYuBidiSo1eaqOcv29yEkIuDns
	IAzkkKPFlTRxeVWfwE3oFmqf6p6YdRl1K56HbiCjC62eJCBQ0DiEcRwLDntDC2DkV/lpyS8mDOj
	o31+vz7ErRX348eDtcvuDPWmRJVip8ux6pOROVrybzzGBTWg0BQieiXJyubLhgtBBX1EkbHqM4f
	VuND4jb7J7jCBtQ9kwwXa1PMfTJcU4gaTy/eFOGdXE9j0246H5+utg==
X-Google-Smtp-Source: AGHT+IExfE0hcX78gw0nn1iPLAnLmMN0HdxWQnnSN8VNB89rL2yQ8NHWy4t+WCuJ1B8DNVSnVHuwAg==
X-Received: by 2002:a17:906:c115:b0:ad0:c6ae:c0c9 with SMTP id a640c23a62f3a-ad1a4ab7f0dmr731420066b.40.1746455277537;
        Mon, 05 May 2025 07:27:57 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a1f2dsm498974566b.40.2025.05.05.07.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 07:27:57 -0700 (PDT)
Message-ID: <68e762ec-d320-4077-b321-63eefefe6d7d@suse.com>
Date: Mon, 5 May 2025 16:27:54 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/25] module: Remove outdated comment about text_size
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yair Podemsky <ypodemsk@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Nicolas Saenz Julienne <nsaenz@amazon.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Naveen N Rao <naveen@kernel.org>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>, Rong Xu <xur@google.com>,
 Rafael Aquini <aquini@redhat.com>, Song Liu <song@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Brian Gerst <brgerst@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Randy Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20250429113242.998312-1-vschneid@redhat.com>
 <20250429113242.998312-23-vschneid@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250429113242.998312-23-vschneid@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 13:32, Valentin Schneider wrote:
> The text_size bit referred to by the comment has been removed as of commit
> 
>   ac3b43283923 ("module: replace module_layout with module_memory")
> 
> and is thus no longer relevant. Remove it and comment about the contents of
> the masks array instead.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

This comment cleanup is independent of the rest of the series. I've
picked it separately on modules-next.

-- 
Thanks,
Petr

