Return-Path: <linux-arch+bounces-14122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FF5BDF062
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7632D19C0D61
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2228A264A76;
	Wed, 15 Oct 2025 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfbcsJpJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB32271449
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538522; cv=none; b=hOF9sUR8YizsJ86FEQeOAyiRXaGD/ZkB1HqFsn1kn56BCFjx4RdurUOF3GiyC7cxsIChHdlM7XRIUEe8qdpoZwIhjvXXsZJuX0OF7ckUb4Jv2Vws/2xtHxS8zXfB4RgQHcK8wy/9qUHNukoJOk/WW1+A54excXr92e6dTn+15Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538522; c=relaxed/simple;
	bh=nBrrzUIIz7EqduMmfNBSq6j0Y+9SBVBrG4CM+HpME4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koTzri8Um4yIF2lccmOVNBm//ICJKPSOMseALwMuJ4TpyEfOjgwAvSsVzBNIeMDQDYmE0B1elEARFzx/IE8MqqsjGTF/H5yvS5oElnvfB4N4FDcgquotNt5rr7OEbNywuqxoHNNC7YOVw6erhZT0jUnv/VNFCl3/61PBsIbFYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfbcsJpJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760538519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgeXfG5LCk279qOJi22HRVqctybfIOuy71nuUr9PHL0=;
	b=EfbcsJpJ6cnKwhLjlng/eoHGa/Nc5llZURJPOX6HITedcF7h/YL3kzq2UnWCeha0B6BFE8
	C+UqqHFD0CpGyOUgwG428ZeTyZLFol8Ay7DNW7A0qr/fASx8TnCLAs1qHPeLcpRYdowN8L
	YR+D43t+ocZYZ/StljT59xcA64NPlmk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-BltB6NQ3N_i5zwBgk1Eysw-1; Wed, 15 Oct 2025 10:28:37 -0400
X-MC-Unique: BltB6NQ3N_i5zwBgk1Eysw-1
X-Mimecast-MFC-AGG-ID: BltB6NQ3N_i5zwBgk1Eysw_1760538517
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-470fd49f185so6780735e9.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 07:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538517; x=1761143317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgeXfG5LCk279qOJi22HRVqctybfIOuy71nuUr9PHL0=;
        b=fA7u69K+wvF5ownqqlnoSYgwlmw7BUxrXaA3Q1/HexNNBM0zrJB/Q9YQboTZgSYmWn
         nbwNvy6i73qRHYv3EsF95j3ty8ZblcJ4KBkCPAusqAvg6GkjnzveN/0f08vFtyYv6pYt
         MCnz7dMje2QWNTJDpcktkiQbhEpvtp3p7BTSydzX/gdMZ6tQcW3XH6Tsf3L8CUz3XU9Q
         LXKH1NduacvQGU/AlBWvQwJfmHfUl3CFezcjxQgaBTxVLX9oxcugfLsWtQs6Z2aZgmYz
         SGk2G5uc0YKt6JxajDEr1ekcQa6E8AZzkn5ozT0+UQ1jVw9B3FvXrwtB+23sWaPT80e+
         A58g==
X-Forwarded-Encrypted: i=1; AJvYcCUX2lau+M3K0T9fCylPIuUOmW2GQ2xhCHGUYkhodKl5Ah/60vyi+9Pq7/dIqj/W8jHp0K/MNvoCQYmo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8oYU3DZocxVmPBx4XIt3+mNc0CuDBiZPcNWLbVcMMMQtrdP8
	Ovf7bk1orssaYUQZpgsMT3jf96r9S5PtYIug2hvNzFKeo1AVDj1mlOZW7WW2DB7YwiFfNysOw/b
	OK844rNUOP54uwRLvgglVzctYREgitB3/Qogq5midTTJVoFRzJjDEjEhutDRFo6o=
X-Gm-Gg: ASbGncuSv6WFF032/nnISWLOa6Poe0KeTpTzVGLtWt7Svw9bRv0COiF7/oaue/oqzyN
	JAKegbZon4fwnW3n1YvSvy71I2qb+cJoXtG0l6QEc4IXXBK1ib6v8x8t1sm1Ecz9BJHkbTDxxI0
	obPcKp+iXX3AuAjZq7eh04XEk0YDLup76ctXN47JQgbfqN3AvLupBMhgXE5IxtjAsZigYFw+c4S
	/RylZOE2eyWfmqG51ICWZtGwHec4bZGlAZv1A5hFkQsDA5/vk+xFHkcfF6u4H5F3RapermWoLC1
	Qjvfsn3R1Yr//pCRnlDEDITd8wLOB9mO/3n7wMfpHhvE1V0W+n1AUGT+4dLqXxC7pMUmdtpA
X-Received: by 2002:a05:600d:4346:b0:471:9b5:6fd3 with SMTP id 5b1f17b1804b1-47109b57585mr1427555e9.0.1760538516633;
        Wed, 15 Oct 2025 07:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzbrALSQ0Dm6MxbRBonwa/fKtFwvctLkCr56cdjw1iTmex8obFsv5mNCQ28ZCIBWNfB2voXw==
X-Received: by 2002:a05:600d:4346:b0:471:9b5:6fd3 with SMTP id 5b1f17b1804b1-47109b57585mr1426975e9.0.1760538516058;
        Wed, 15 Oct 2025 07:28:36 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101be0c5bsm48687275e9.1.2025.10.15.07.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:28:35 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:28:32 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
Message-ID: <aO-vkAAk4FCdnLZu@jlelli-thinkpadt14gen4.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
 <xhsmhzf9tld2r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xhsmhwm4wl2zm.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhwm4wl2zm.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On 15/10/25 15:16, Valentin Schneider wrote:
> On 14/10/25 17:26, Valentin Schneider wrote:
> > On 14/10/25 14:58, Juri Lelli wrote:
> >>> Noise
> >>> +++++
> >>>
> >>> Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
> >>> RHEL10 userspace.
> >>>
> >>> Workload is using rteval (kernel compilation + hackbench) on housekeeping CPUs
> >>> and a dummy stay-in-userspace loop on the isolated CPUs. The main invocation is:
> >>>
> >>> $ trace-cmd record -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}" \
> >>>                 -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
> >>>                 rteval --onlyload --loads-cpulist=$HK_CPUS \
> >>>                 --hackbench-runlowmem=True --duration=$DURATION
> >>>
> >>> This only records IPIs sent to isolated CPUs, so any event there is interference
> >>> (with a bit of fuzz at the start/end of the workload when spawning the
> >>> processes). All tests were done with a duration of 6 hours.
> >>>
> >>> v6.17
> >>> o ~5400 IPIs received, so about ~200 interfering IPI per isolated CPU
> >>> o About one interfering IPI just shy of every 2 minutes
> >>>
> >>> v6.17 + patches
> >>> o Zilch!
> >>
> >> Nice. :)
> >>
> >> About performance, can we assume housekeeping CPUs are not affected by
> >> the change (they don't seem to use the trick anyway) or do we want/need
> >> to collect some numbers on them as well just in case (maybe more
> >> throughput oriented)?
> >>
> >
> > So for the text_poke IPI yes, because this is all done through
> > context_tracking which doesn't imply housekeeping CPUs.
> >
> > For the TLB flush faff the HK CPUs get two extra writes per kernel entry
> > cycle (one at entry and one at exit, for that stupid signal) which I expect
> > to be noticeable but small-ish. I can definitely go and measure that.
> >
> 
> On that same Xeon E5-2699 system with the same tuning, the average time
> taken for 300M gettid syscalls on housekeeping CPUs is
>   v6.17:          698.64ns ± 2.35ns
>   v6.17 + series: 702.60ns ± 3.43ns
> 
> So noticeable (~.6% worse) but not horrible?

Yeah, seems reasonable.

Thanks for collecting numbers!


