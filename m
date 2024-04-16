Return-Path: <linux-arch+bounces-3723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81D8A6AC9
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 14:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7081F21928
	for <lists+linux-arch@lfdr.de>; Tue, 16 Apr 2024 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0812B177;
	Tue, 16 Apr 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PouuX8Tw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC384A5F;
	Tue, 16 Apr 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270102; cv=none; b=o1Z7Jnsz5sL8+Hq2stZzh0yssTwbrjHFjQhfBQ59oD20OwMgOR3U9R7UEKjgEJdMh5eRUxgIBQ0CV3RDQPi4N/folU94at6l4iL3NyMry1j5E40z6LuxdhTnAQqGHdUOHAUKAAshD43JW4a0REe12jlss4FCzDnS3DzX+6Hf318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270102; c=relaxed/simple;
	bh=PtVHP8X3miVG9JoGSixXlXErpWWaYrN8ODQ07uqajKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoQtEtEnHdSyAniUa/QahTgG60J5Uu1lL0UlUX264a+HcvfWfOwDhcYm+PvLg90QcjKQueh6vXP7QXFDwqaH/ZZ9QWgVZxDtYJjprQjU4pEYhJtbdhygkqYwZWUbW7qpH93jQzSRGulyL1wMyy7XrN8l9mG+nM+bpS4gB1i9LAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PouuX8Tw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2dac79e350cso6876611fa.2;
        Tue, 16 Apr 2024 05:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713270099; x=1713874899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WiGQBJDgEms2U3lclv4lJBfEDwqWDLh9wcJMdWkze0=;
        b=PouuX8TwA7NB8kQVgPlZ4ikE76tPjOLdPck6oKLsTYkmcjqDkqjRssh8+mtJnpiCb7
         M4D9zzcSmO6yD6dlFKESZD4FV2EBzAtl7Pd8oQU6gGNfrwSC7pVxL1EInTd2/jkRI6Y4
         drA+NrAvaCYSG36TaEemUxiNpUhqTBeFNv2kH3+50x2SPukHBcZN2V7o1+peifE6StUI
         boGfFgbUKeI/GcACZH+7wVjqgMS2CounNWEesbIGFBHqXzjOlKBtd+AXOeT/qygzJOuN
         kcdzGBg8NMez/SHA1TuJcB+sTlhh6GfDeX1B0gL3OF4DpieXuGFljOY1d650H80g/NUi
         uGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270099; x=1713874899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WiGQBJDgEms2U3lclv4lJBfEDwqWDLh9wcJMdWkze0=;
        b=Om17ed8kNRpEGgKb9rXmQt1oAQnmcDbegU9Q2f2PkVcy0g6KahOp3uJiIWeYDOpn2u
         ilVmPv2Hv4WT4OYRs93hNu57EhjiI0g1EPclQjOMras2q53HZAVij157wKD1AANDZq6h
         WmIMnjs2frZu3N+4co8hJfSNUvqAL8xMxO5xtt4ixFLTKQkXz0zCytTYUQkjSj7AzfnV
         zUwB0XJqVd4yqkiTkZHp38ujKy39QAiuzpM41ipsoeroCpyNHLfCL1TcRUcVcP3qFCKE
         ITiEUq3p+c3/CVqhHCqulsZGKvj02NAndenXs8I5abTO8fmXWvw3/o99hQh0P7oCPnEX
         t4Og==
X-Forwarded-Encrypted: i=1; AJvYcCVe0GErGQ0cAmQeNE/CEasTkpGKDuAwjQD3XE6h3VVPc9LwCbN44VGs5x1+92pckJ92mku3poNQag2l1eB21BKM12du6LN8JU2OI0nNKvDVmrZbapVft1SE1/SDzr3NtFaEmkak/LfAoA==
X-Gm-Message-State: AOJu0YxFq90GyPgJ+PPKxaD8m3z//ZGIodiBzLet0IDxqT53AYBxbBrk
	DnE+MchCoLmpLaR5BTJdNors1LLk0FwqNMlhSFwi9dGRUV8VMW+S
X-Google-Smtp-Source: AGHT+IFByccoJtl1DoPw9WIAY1kN4SRPI+kTQfszpLKhuPcVbfCNfL93X+Ktu0uhtrwDf8B7IC+aYw==
X-Received: by 2002:a2e:a9a6:0:b0:2d8:6054:a1bd with SMTP id x38-20020a2ea9a6000000b002d86054a1bdmr10099045ljq.40.1713270098311;
        Tue, 16 Apr 2024 05:21:38 -0700 (PDT)
Received: from gmail.com (1F2EF007.nat.pool.telekom.hu. [31.46.240.7])
        by smtp.gmail.com with ESMTPSA id s12-20020a05600c45cc00b00417e8be070csm18162091wmo.9.2024.04.16.05.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:21:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 16 Apr 2024 14:21:34 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	"levi . yun" <yeoreum.yun@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 0/2] sched: rseq mm_cid updates
Message-ID: <Zh5tTmwmWauIajeB@gmail.com>
References: <20240415152114.59122-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415152114.59122-1-mathieu.desnoyers@efficios.com>


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Hi,
> 
> This patch series consists of 2 patches. It is based on v6.9-rc4.
> 
> - A fix aiming for v6.9-rc (to be backported to stable kernels):
>   "sched: Add missing memory barrier in switch_mm_cid"
> 
> - An improvement patch aiming for v6.10:
>   "sched: Move mm_cid code from sched.h to core.c"
> 
> Thanks,
> 
> Mathieu
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: levi.yun <yeoreum.yun@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: x86@kernel.org
> 
> Mathieu Desnoyers (2):
>   sched: Add missing memory barrier in switch_mm_cid
>   sched: Move mm_cid code from sched.h to core.c

I've applied the first patch to tip:sched/urgent, and will queue up the 
code movement patch in the scheduler tree for v6.10, thanks Mathieu!

	Ingo

