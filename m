Return-Path: <linux-arch+bounces-9915-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA34A1D49D
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 11:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2C8164319
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974C1FE45E;
	Mon, 27 Jan 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBG60Ehs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A11FDA99;
	Mon, 27 Jan 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974223; cv=none; b=UJSvAmgV7Lh1mGfkDD4YPKdfrazrzbjhN/q33EonAVT01cLcVHoM09IVbxFVQ9V5mnZwI1LCS707MTVCJCVzOX3zXfLQyFol9TIH0arQSkgpSpSGUEf+lGTrFmvRyUHxiIrQRwtY2Iicvh/5hz0mWga6hNabjW1Sd3AOIswAGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974223; c=relaxed/simple;
	bh=jxECeMXjdkYPN8Gg6gBfLrTjeCyPn6+e948JqztZKrc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFl9rHEq+kNCgUFMQ8s6ptM0CM+eDhKwDj84bwSCqpBawBkEk7rLyd5Da7v8J6gtc8vNAgVlvXvrmW+YAnGiWBZj9V0lwRY5NRR/oappCawkQVgKoZCV9iCQwzdfYArQ8YzceOVw+HrVs+1Q/75eoMD9vxfsarMj7DU4ARCzCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBG60Ehs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-540201cfedbso4142055e87.3;
        Mon, 27 Jan 2025 02:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737974220; x=1738579020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W4QFE15tzxGQeI7M/zW2nqDheIV1bS+m/FQTTUzpTLk=;
        b=SBG60EhsV6vyJ1IDGSJKIKZienw7FUEeoTFQPU3iMW3FXZaU6I7fmM1KsRGgAHn7hV
         xp2IujVbrtpOBhfuhagLYwW3q8l9JhXsbguC8I4L0Gd/q1MWh3Pwney0FnqgVN+VZFU5
         U2JBGF2vw+yfi60jmAq5S13gFp7i5fttClRvx47xArAe4UIub6hr1PFun+l/nvLpDO3C
         ErW2tCc19Co6A4KVKwfqsMwPJcBC4c+sysy0Jjwia6vV60BoduprpwwMRKS3zyjyUN+Z
         DpvVUPtInzNzKsnkQNfwDWnIoeSHLtDOyoUw23EwemjyWG1ODG1NiRjFJ36ecUFAKCEV
         hvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737974220; x=1738579020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4QFE15tzxGQeI7M/zW2nqDheIV1bS+m/FQTTUzpTLk=;
        b=PMk2fDCAeKFtcCY/q//RJcZe4MRRi0SIIq7lF8XPIF4Mmr55NnCCBMYQo61p/iWq5i
         vstKQmPBdhvEh12FMXrCA61Rmuga4o3qKW4DP/JQKfzjMAjYCcQGmW40/LF6R8zRtZNO
         35GyYmXRwmbjGURMxoIdgamrn3KEAMZGGwiADwKzp6n28dtMbUN/SMbfIdNqhwpunFYg
         VrfXA/tga5vPKDAybWKJai0RZLLmoRm0ZOiM469WDji0rjp4neY/BgJy97wFa9HD44YA
         BRWVFHwJ5ssLhCrehUYtS/Iqx6uWHfS1yVlDmNbT9DB5pVim4AJIAtc56GmMUofYOc1h
         XyPw==
X-Forwarded-Encrypted: i=1; AJvYcCUSbQBrqmlVU+4ZjkZDv1R0JYDh7Up6QagW4bP5DB5MDPygrc+30pQ7ln5qY9XaQVWEYQNG@vger.kernel.org, AJvYcCUTMjOpy7b06hLjWlmbxRfUrQboZmGaR0dVLsIGCeUfXEQgxcUIG36A7042LKSSQTdo4I5+a8FejDW3B1+9935Q@vger.kernel.org, AJvYcCUjyPh0BEHz92YIKm7kxhKI4L4fhXLmkXiY9/0t2fWncjFaqyIeogtPawrS9HC3y0OQC62Q@vger.kernel.org, AJvYcCUlUqm4+Ebsfnny1oEJ05SIppnqsPFndHibRJhTrfrY+BFWDl2DltjOHqWBB/bjQbVb98mhfRtOtYF7PQ==@vger.kernel.org, AJvYcCVW+B3sT1AUmSZfr5O5SqMRM9CZFw/+qH778Jub4WjSuTv2td9cXC5UkNvwMpiYK0SkmxMQ9EQFAN/kjGJA@vger.kernel.org, AJvYcCWF8WgkhqAkYU4mK0hNVbXo6Xg+FK/xfMZC0ouFFUbcBG8jpzX1ON+Nh/Vm7m2NIBS6ayrml5fXWUTb1mnaM4CSxg==@vger.kernel.org, AJvYcCX2VA5zezrGPJjCAd9xs7ELQTsdN9WtKCj0T4h5Ce6L+khYsA5l17EOX1O5zozNiv0yNu9eQ5KoUAgdIsrMNMZD@vger.kernel.org, AJvYcCXpIUm1221jaXwpgC6vY18LBSSui5dhWmFBubj/vjWCsHK7hqZeWzOhXLgO7UqRyjzxP2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7Cvb1k5M3UjD2VdSDrtX4yXOYutVYVG2F/TY8iBpuwO9mMxc
	pFtWpeFBL9pQXibvyu9GpEESGS4XeAbyeyH/riL+xbAKbnJbE4wW
X-Gm-Gg: ASbGnctbKY7zwkt2spfIvn1g7lrZabunv8Iprk4H2ZpilVwYsJgi+M0fJwWf4kt+3QL
	S2KBDPjQA1kMY6DJWIrKbI+XpzIovaz9DzOdsU0KB3nmW5bdyS+KUbPUGgXKG0Eyo1xowMfuk+p
	Jqwak1eG40FGTLtOPJKC88ZaA6c70OSC8+7BSJkRe8ZX+S4xPfZ8g1oM8MszYPUwjDL/Ps7V9CZ
	OyjDfypdAiy5wrW8ZY5aSPhsmH01uTkY5XV7Fc2w5p9ss1qBbbmqnr9KFetB3y/JgROsaxUFZfJ
	GVHXxr5ihEKmc20XWTrVBoVgP0Daqs9anCI=
X-Google-Smtp-Source: AGHT+IEcn2mDT5d0SWT5jg0poO+BtsvQPwWj5ydN+QiFTcCpstqFwzzlc4zIAZ/gMSqSpGuiyMrqQQ==
X-Received: by 2002:a19:8c1d:0:b0:543:baa9:a48a with SMTP id 2adb3069b0e04-543baa9a4bcmr6967602e87.27.1737974219462;
        Mon, 27 Jan 2025 02:36:59 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc1956csm14103761fa.70.2025.01.27.02.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:36:58 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 Jan 2025 11:36:51 +0100
To: Valentin Schneider <vschneid@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Message-ID: <Z5dhw0Ml4KGEfaUv@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
 <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z44wSJTXknQVKWb0@pc636>
 <xhsmhr04xfow1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4_Sl-zu7GprkbaL@pc636>
 <xhsmh8qr0p784.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh8qr0p784.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Jan 24, 2025 at 04:22:19PM +0100, Valentin Schneider wrote:
> On 21/01/25 18:00, Uladzislau Rezki wrote:
> >> >
> >> > As noted before, we defer flushing for vmalloc. We have a lazy-threshold
> >> > which can be exposed(if you need it) over sysfs for tuning. So, we can add it.
> >> >
> >>
> >> In a CPU isolation / NOHZ_FULL context, isolated CPUs will be running a
> >> single userspace application that will never enter the kernel, unless
> >> forced to by some interference (e.g. IPI sent from a housekeeping CPU).
> >>
> >> Increasing the lazy threshold would unfortunately only delay the
> >> interference - housekeeping CPUs are free to run whatever, and so they will
> >> eventually cause the lazy threshold to be hit and IPI all the CPUs,
> >> including the isolated/NOHZ_FULL ones.
> >>
> > Do you have any testing results for your workload? I mean how much
> > potentially we can allocate. Again, maybe it is just enough to back
> > and once per-hour offload it.
> >
> 
> Potentially as much as you want... In our Openshift environments, you can
> get any sort of container executing on the housekeeping CPUs and they're
> free to do pretty much whatever they want. Per CPU isolation they're not
> allowed/meant to disturb isolated CPUs, however.
> 
> > Apart of that how critical IPIing CPUs affect your workloads?
> >
> 
> If I'm being pedantic, a single IPI to an isolated CPU breaks the
> isolation. If we can't quiesce IPIs to isolated CPUs, then we can't
> guarantee that whatever is running on the isolated CPUs is actually
> isolated / shielded from third party interference.
> 
I see. I thought you are fixing some issue. I do not see a straight
forward way how to remove such "distortion". Probably we can block the
range which we defer for flushing. But it also can be problematic
because of other constraints.

Thanks!

--
Uladzislau Rezki

