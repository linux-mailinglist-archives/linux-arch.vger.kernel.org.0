Return-Path: <linux-arch+bounces-14096-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E1BD97AE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 14:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41D654E28D4
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A20313540;
	Tue, 14 Oct 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F25wjcbo"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9718D313530
	for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446691; cv=none; b=VVqfUnkilXAMAOQZsBPf6qVoAIWsdpRYzAjb8+am7mXvAAM17S0ZLGMBlwPjXigO3lYWLgYb6WaVbI+NUu4KEihW/BQY88C/nPoM1dJMm2cUaMOtbKZUcqIUCbZUlfNa7OqTalolr4r5xOFbKBZq6NKPSy07F8oxZ92dbgNUAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446691; c=relaxed/simple;
	bh=K2g5fcbeoiLEypmxm4zdDfAPkL/Zn3ngXE1+qFzQ0Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5uX6awmFMRb/06+9eifWaAFv6Ulc1t+G9Vq2aRdIRztpMgSWblcqlrvSKDRfvJvWtn8X2RDr6cb+CJorUu5LypVYnXKnG+ajAXogpFmJjkmqCO8+mrZanlLBOPeu7qwq9X3/HIB2XqGKNIWsDt7/kF72zSMmUKY+JuJxuS9Kwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F25wjcbo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760446688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+P2Dsj3XLhA6fMrQYgh8OLSwYB2MUOQP3SbJkXqJVA=;
	b=F25wjcbomtI84IuH63y3uCwMe59HV5IiwauKpiD0sHsUdXIpr1gs8FLbLTlt7g7NNTucDn
	pxXrgcizjcEAVg5AzEb65bkVPcHPq0tEww1Mu2shf//a/rTUEZQSXBZS3zxgeS0OdkZFag
	2sqexAC7GHWcCfQQUcgenQ5DS7xbtiM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-nmPFQP55O3SU6bDlaSlo6w-1; Tue, 14 Oct 2025 08:58:07 -0400
X-MC-Unique: nmPFQP55O3SU6bDlaSlo6w-1
X-Mimecast-MFC-AGG-ID: nmPFQP55O3SU6bDlaSlo6w_1760446686
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426d314d0deso2275269f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 05:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760446686; x=1761051486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+P2Dsj3XLhA6fMrQYgh8OLSwYB2MUOQP3SbJkXqJVA=;
        b=WuGG84IqHAizdD6Nky+m+apj+fuG78AJioEIDTD6PYVq5CRy64q7E7xeHXGP6/AbAV
         Cap6d3Ill8vQlqwvQjJPzj0HUS9IG+9PtNg+G8WaEe93PIP63q+9Vxwp+Kx3w14GYEd7
         TqJNGSP6pZO2q6RZCqgzlD0kHFgZTbPIUeoFMcl6htCcKQrsnmljyYJ8oKUUmNv7gQUA
         cN1nQn4My6XW/8XuNoyT9K8B7OPRsIniYqf/n2qmwVaY4l0/njPwyR1XmNV5jM11cOal
         gnKYVLPZQvgIEkC594m6yLVqqTPtDYGELMSUIvhxfn57wyR//bUsSAazTiK080EwNBDI
         rhRw==
X-Forwarded-Encrypted: i=1; AJvYcCVaXH+3ocUaT1Gptwm450W8Jty4kYGSIfseiDMsrDDm9hMqs4Ymr0feYZQRpQjaRYhnUDMZtCo2yids@vger.kernel.org
X-Gm-Message-State: AOJu0YyU99JEw8DisIpXZ4TBLYYWgeslGtBLoRqxFXdtcX91Jf+4Wuar
	79oAz89Bf/G16fQ8LH7UipQIAoHpeTcJS5OXuH9fm6ExaKnCPfDTLpCD5Ng8m2DBhxrs/MMl5kY
	mKhHhBq3KKdaQsMlQRcjGpukh+LFVPm6oNuZzf5nyWOKT090J6XAM2GMnCnWUHfw=
X-Gm-Gg: ASbGnctu9SjE3+lSc8jmKQGtgOGYoU6ojduRMpNWy4NafXQ3Z5SWJs+5ZVLRWp0hBGg
	5ynNxGkaKQ53boj2xm0J8k2l30dG5jghmCnedb6qAC56+IzdOsDEi2P/OrqFWPfxNB0ZPWh5p/d
	oBwINHf0bcBo159CR7HLhU09VWLw+PCbkzS8pIfyI97KJ1CkjcBtVmHTr7bJKzCT+obkM55kmdE
	MZZdYr6+QJKwGbPtKKeLMnu5+axZMHqrjFkp6Hu6Dzm2E0SpDoiPGnhyf35/r6t1GAhDWw/4SM4
	sgyYUtZyJGGPt5JMKYx70EqMCDgfy8FQfETSszcFQqW9l/hxo0bwssIv6d4/XaxgNoNrhwAm
X-Received: by 2002:a05:6000:1888:b0:401:c52f:62de with SMTP id ffacd0b85a97d-42666ac39fdmr14487447f8f.12.1760446686268;
        Tue, 14 Oct 2025 05:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAh3YZ5oKpPdr7WASiDkPJn2IILu8/Rh+37A13TS4n2FwBRRVC0ByNWYf0Uu33Aqxt+5Ldeg==
X-Received: by 2002:a05:6000:1888:b0:401:c52f:62de with SMTP id ffacd0b85a97d-42666ac39fdmr14487377f8f.12.1760446685024;
        Tue, 14 Oct 2025 05:58:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm23624651f8f.17.2025.10.14.05.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:58:04 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:58:01 +0200
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
Message-ID: <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010153839.151763-1-vschneid@redhat.com>

Hello,

On 10/10/25 17:38, Valentin Schneider wrote:

...

> Performance
> +++++++++++
> 
> Tested by measuring the duration of 10M `syscall(SYS_getpid)` calls on
> NOHZ_FULL CPUs, with rteval (hackbench + kernel compilation) running on the
> housekeeping CPUs:
> 
> o Xeon E5-2699:   base avg 770ns,  patched avg 1340ns (74% increase)
> o Xeon E7-8890:   base avg 1040ns, patched avg 1320ns (27% increase)
> o Xeon Gold 6248: base avg 270ns,  patched avg 273ns  (.1% increase)
> 
> I don't get that last one, I did spend a ridiculous amount of time making sure
> the flush was being executed, and AFAICT yes, it was. What I take out of this is
> that it can be a pretty massive increase in the entry overhead (for NOHZ_FULL
> CPUs), and that's something I want to hear thoughts on
> 
> Noise
> +++++
> 
> Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
> RHEL10 userspace.
> 
> Workload is using rteval (kernel compilation + hackbench) on housekeeping CPUs
> and a dummy stay-in-userspace loop on the isolated CPUs. The main invocation is:
> 
> $ trace-cmd record -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}" \
> 	           -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
> 		   rteval --onlyload --loads-cpulist=$HK_CPUS \
> 		   --hackbench-runlowmem=True --duration=$DURATION
> 
> This only records IPIs sent to isolated CPUs, so any event there is interference
> (with a bit of fuzz at the start/end of the workload when spawning the
> processes). All tests were done with a duration of 6 hours.
> 
> v6.17
> o ~5400 IPIs received, so about ~200 interfering IPI per isolated CPU
> o About one interfering IPI just shy of every 2 minutes
> 
> v6.17 + patches
> o Zilch!

Nice. :)

About performance, can we assume housekeeping CPUs are not affected by
the change (they don't seem to use the trick anyway) or do we want/need
to collect some numbers on them as well just in case (maybe more
throughput oriented)?

Thanks,
Juri


