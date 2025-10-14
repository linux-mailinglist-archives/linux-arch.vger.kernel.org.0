Return-Path: <linux-arch+bounces-14097-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7176BDA688
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 17:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829E13A46D1
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D119313E2A;
	Tue, 14 Oct 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izCA0mcu"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE301313E27
	for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455576; cv=none; b=Z7l4Rtpj2e4mtEEKeD5U4b8mdRen7wW1LtWj4Lo5Z11y0m92ovkbsrGNwyo8EnYty78RQhPwRoSlWmQWixA4w86EngdKSbKrVHDNosEfWrgm3eCDRq6l2h24pl7VAMRkwfv8e7bnZ5tB5wc3kWapiNKZ+65cp29BFwCYfeFazOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455576; c=relaxed/simple;
	bh=zb6o9BBzMA6ybYP4rPtrVGFRzAZAk6RHKlRdzBd4wb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHntaxGjDgA1gcw2HWK0ItuVQNEl+hKcfe0LBOhWXFoG3B+6M7AZijMQlWdNCjru2Q42CteJKtSeT7BReHoyfQW0NeFhE/dtGEy4/wor72eF55l3R9bBVlDzsIMb2FJOfMAW7DCWlkpjO7tKqksmaCd3iLbHZpW3gNcCcYf2WbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izCA0mcu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760455572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPklb6K1+lkU1jV8UO4c/obMd20v1vJ9fV4tt0H1zPw=;
	b=izCA0mcuzSgsFxS0mRkE8tqGWS0sJhUrHRKJwPnARutstN+l6SAXr89HS90jtvL5Wmb7nh
	slGHQ6yfaAUJ9xt9vhTveHpnya158LcNacuvCZM9kmVIyHIjxaFY47qhuQyBmW88AqTjc+
	w77cMLLpQRdP+FHhP8cZK9VzUgamaUs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-3T-QCgKHPe6aQOHbZb0aBQ-1; Tue, 14 Oct 2025 11:26:08 -0400
X-MC-Unique: 3T-QCgKHPe6aQOHbZb0aBQ-1
X-Mimecast-MFC-AGG-ID: 3T-QCgKHPe6aQOHbZb0aBQ_1760455567
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e7a2c3773so28335185e9.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 08:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760455567; x=1761060367;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPklb6K1+lkU1jV8UO4c/obMd20v1vJ9fV4tt0H1zPw=;
        b=GPMrOLmMubVPECDNoWU8It7bKwww/Pp7vyao71aFWtLxFIuNOMrSdaUJibes6DHqzg
         8mIdLHFRHO5/Cm2xhkUCiHwc7xXFra0tCVv9CH/8keWUB7nKdi0M7a1ltdmjS9YSiJs2
         3sC5aOEXLB6xfhFLWV19jBIF4W5eqg4rjOVamoiLpHxRkLwHSmM8awZsVgsfIXL6axkk
         ozWyJ/2aYRBjkRJ3DCkV/lfAnfoKXJTGW1+pRZr84vUL7xO+iI85r1sELN/75XMNbFlm
         d7VuDlpO+u04s8wsljYR1jtvgY/ycbzowu1XWhM9syqP7vA5PP3L354GwjLxTVRjo6Ku
         8e8w==
X-Forwarded-Encrypted: i=1; AJvYcCUr5v+CtDp63/PXVPDvjJxI2C+SrZqIeU5JmgmEe09yeITA4YgWg/6+Y4WDMCC42bdWmtM4Ck3MJv5H@vger.kernel.org
X-Gm-Message-State: AOJu0YzFE6n1neT8NprGH5z0XPox43wYp+JrksAmsVMBys14SKfmgpOM
	6SIDNEYxU5PRbqKUJZ9Mb6aroNnALWUQzbbRzg4VAQ7WNGycLea3x7k7LkMiXo3QLAry2H40IOs
	Pp6KTG+Fq8a6mv1wAuc/pJ7b2Ajk2cWMcdWLSgtkZDpETInzNg7LCQr8C0upO2gs=
X-Gm-Gg: ASbGncu/PbgQRYjYynSw6e7D6Z7O2WPDKwDj8lCP+a5leoWF66TU1UdraJkj0DC5hB+
	UEQEfNT+bBToCQLccJ+O4kDdSPiZSf1csJ6tgK9/t7ss1N4QR1WyklHuxVsRte9rfVJHOKmLh0s
	N7GHnWwxSo93Rzclig0giKrHfP9lYWDH4YPiH8pB+V3X8oKBD3fTKwY0vvQWwcPrVjLeD+BF/FA
	HXgs/w1sVx80VY967hQNf0CVZwouVi0vfd24trGbYz9EHsal01D3sfw6k5QMuEcCVQF5n7HwMw/
	5IJEb+3txJQam2BksrHevKTdopiUx1ropz58m1qHnIfKdZ1EMUhBAqEsoILgIFy1NErCtY/aKAE
	GNoH5CUzepzSVToPy2+LVLQWBzQ==
X-Received: by 2002:a05:600c:8115:b0:46e:711c:efe9 with SMTP id 5b1f17b1804b1-46fa9ec7556mr181899025e9.13.1760455566802;
        Tue, 14 Oct 2025 08:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW593XOgtaLpqw6H4D31qH5lmbNbujonLfE4h+J4hQ9AwSFy0g3uK3ztnKvCXj4YJKI0uSVg==
X-Received: by 2002:a05:600c:8115:b0:46e:711c:efe9 with SMTP id 5b1f17b1804b1-46fa9ec7556mr181898575e9.13.1760455566403;
        Tue, 14 Oct 2025 08:26:06 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3b9sm24483884f8f.11.2025.10.14.08.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:26:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Clark
 Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
Date: Tue, 14 Oct 2025 17:26:04 +0200
Message-ID: <xhsmhzf9tld2r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/10/25 14:58, Juri Lelli wrote:
>> Noise
>> +++++
>>
>> Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
>> RHEL10 userspace.
>>
>> Workload is using rteval (kernel compilation + hackbench) on housekeeping CPUs
>> and a dummy stay-in-userspace loop on the isolated CPUs. The main invocation is:
>>
>> $ trace-cmd record -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}" \
>>                 -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
>>                 rteval --onlyload --loads-cpulist=$HK_CPUS \
>>                 --hackbench-runlowmem=True --duration=$DURATION
>>
>> This only records IPIs sent to isolated CPUs, so any event there is interference
>> (with a bit of fuzz at the start/end of the workload when spawning the
>> processes). All tests were done with a duration of 6 hours.
>>
>> v6.17
>> o ~5400 IPIs received, so about ~200 interfering IPI per isolated CPU
>> o About one interfering IPI just shy of every 2 minutes
>>
>> v6.17 + patches
>> o Zilch!
>
> Nice. :)
>
> About performance, can we assume housekeeping CPUs are not affected by
> the change (they don't seem to use the trick anyway) or do we want/need
> to collect some numbers on them as well just in case (maybe more
> throughput oriented)?
>

So for the text_poke IPI yes, because this is all done through
context_tracking which doesn't imply housekeeping CPUs.

For the TLB flush faff the HK CPUs get two extra writes per kernel entry
cycle (one at entry and one at exit, for that stupid signal) which I expect
to be noticeable but small-ish. I can definitely go and measure that.

> Thanks,
> Juri


