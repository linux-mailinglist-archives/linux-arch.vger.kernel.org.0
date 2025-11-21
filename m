Return-Path: <linux-arch+bounces-15017-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E315CC7B190
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 18:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3435B6B4
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 17:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887AB2749D2;
	Fri, 21 Nov 2025 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awpmj2IY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5vLJe8L"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8834E753
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746641; cv=none; b=pnjBBVt10PAIWX0gZem4pPflXLUOf0zKk3kfmc5YYZ9GYFWBekrH3IUL5yyg/jubDkz4gjFhf0d5y3ErhskiKc1F5ZVCap0UKnu/n9eqptPPh8Tku845D+waLJE2Paquog+/obiFs9WacMV/Nlat1uP7steIVLssCpZmvpXr0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746641; c=relaxed/simple;
	bh=R6+it4z+8J3tQq6khArTa00xBA3LI+Aiux4czwnNIBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EfzfVsJEWdZKYMddyfS7KN1fWvQtI5NB4vtOTNkiTwF9K+RSjJzyJXyhHaKqZpNAJfHCcjdXsmXYlLQOWCGZW7VO/TQqWxdBKXJv0aeXgwvTFYzS5quaKECWezzlpggiafLUVjMJjn439qPaRMMbxsrj5Cp32QQYt73rW079pWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awpmj2IY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5vLJe8L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763746639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3OE0zpMaGFe7FLO1SjE8KbYNBSyHZmUa+LcldBnwuQ=;
	b=awpmj2IY+dtg33kKKZARS0y2aVJsMFreZY8lIcORl4Ftxbq+Isg6xeTdlWwYPRSiurxIDx
	YP1mq05Mk6JOOWj8DpFwc2DEFgtS+PCDd4INBWGO1h4IuMhrPlnGAeXsIs1H030Moa7GSc
	oDP9LiunBYCzxwnIcfTp9tY+7h8q6YM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-xlnxOtu0NQe-avOb-dgBRQ-1; Fri, 21 Nov 2025 12:37:13 -0500
X-MC-Unique: xlnxOtu0NQe-avOb-dgBRQ-1
X-Mimecast-MFC-AGG-ID: xlnxOtu0NQe-avOb-dgBRQ_1763746632
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2e448bd9so1658226f8f.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 09:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763746632; x=1764351432; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3OE0zpMaGFe7FLO1SjE8KbYNBSyHZmUa+LcldBnwuQ=;
        b=U5vLJe8L0a86P8h3MUZfCtbqbvtoJav9VqBJbzGwf61gnaIKl/s1ka74ifirX2UroI
         kJ86MkvCZ8sKjWHApHl63yFVSHGPDwB5hNcY4FjCYgKmcvdqrHdIwaxoDVnW21FkmTXB
         zxQOb3rXyaOSMALSYhMxCu+bHfC2taAVRkEfirNyEcCB2HxWBVvXmaYGMmr8HLrSJFf6
         8lE5rImjmJ6jk34LfcWBkrwJTcNuDEqGuus5AgqHiT+2piOy0SPRNOq+dg+zVd435FMY
         zQgGVYaTmaqBtIzcUP6Fg2UbLesoplRxwogEJgvVkb9Dtv6kp6yHwcDsNar4mPKUmwHz
         n9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763746632; x=1764351432;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3OE0zpMaGFe7FLO1SjE8KbYNBSyHZmUa+LcldBnwuQ=;
        b=XKRxPkoTflM4cr3qjbdMj28D3K4o+Rca8O7P2ciV6an0VLqV+CinboToBparFExyK2
         lPHt39CfApheO/m0UTs9Sd2Wfh8EcVbBTuEB9zMjwfegjmjeAGXh0lui1bFk4rb8gTJt
         VL+UDHCB/+U4QJUzQXEpsAUt9HCdpwbkiGIBkAGZiULNNyiV8HfKnTNaoK4xEJGU5MxI
         QpGnjPgGWGufPjLwvg3A0IfHPUWOKpTjRWhxgmZwVw6Pfk1Qr/JKmE4+iNP0K2vkT0se
         bcMb0o/044t/jjaHVIFgtgxrVCbQ9uhlBgZrh0CdEVf8kO6TsaC9+1KR2GCgticXUYx1
         K0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXItbk326iA7wQj+GtHxi29huh/ITdO9r0c08wReCQVW8Bt7Oucw3gvQKhMnZU345hA+uLIKXMK6OcA@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFWGoomfL0T5P5yHwPoSjgi78mJ0V+ESYo35AlneGBJGa8lBU
	MxDXbyrPqaBWbndMxQZfnPgo/m+2VNZqMWCyes/1ox4KgEsGswR+h1IuAs+9w6UOqbSxtomcj5F
	6oQXBI9ePY85uww7UWCi4qZeYbv1DUdAfcIrxDfFH0oECTfq4R1jnOQMxOYo0PDM=
X-Gm-Gg: ASbGncuuiK6z+WsbtTqMlmx+2Y2nh5nZ81o5PJWJbGikyPmLzCA2GNRSXVDfSuP+onm
	yCkfU+TeeSqu7XibRa9FxVNG2YEKgTbLAXZ7M+62VjVHcCBpsStuIkQcUvmX6sTb7bTzyXum87Q
	aSJpXBv16sE1jv04obzy5PtqMY1HWEhEz6bq0OTkLpCK6HhcxhzqknZPF1YtIv1TEt5UoAqukH2
	Vfb9pXpS4OsIIP4BAth5VynnQMhEGPoTQIkB3QHTOVHzX06Sei8y4yLyewFC3OBKpk86PUWNQbA
	ygqgEhm1U3+aCyM0/8ZT16mTFw6ilXwGxJYNHr8QsfibfrCEoI5Lq3l5pZUQ6H0wbEEkVuD/9Er
	Cpl5BehGYDidK26tbtbyHQdyJ+96qEUe83o3rX8CqwYAJFlLf8509KT8ok5mr1HVJTuDKaGQ=
X-Received: by 2002:a05:6000:2282:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42cc1cbd0dcmr3334282f8f.20.1763746631991;
        Fri, 21 Nov 2025 09:37:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwrptJrvQrMlATO+zOU3GD53XUKYoEIwVBRtwZMVM9uxcxDwDk+rU+CpbkpyNs1Ksl4qe7Bg==
X-Received: by 2002:a05:6000:2282:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42cc1cbd0dcmr3334227f8f.20.1763746631366;
        Fri, 21 Nov 2025 09:37:11 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cc231dc6esm4094867f8f.7.2025.11.21.09.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:37:10 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
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
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC PATCH v7 30/31] x86/mm, mm/vmalloc: Defer kernel TLB flush
 IPIs under CONFIG_COALESCE_TLBI=y
In-Reply-To: <bad9eaaa-561a-498a-90d1-fe3a3ab8ba37@intel.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-10-vschneid@redhat.com>
 <bad9eaaa-561a-498a-90d1-fe3a3ab8ba37@intel.com>
Date: Fri, 21 Nov 2025 18:37:09 +0100
Message-ID: <xhsmh5xb3thh6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/11/25 10:31, Dave Hansen wrote:
> On 11/14/25 07:14, Valentin Schneider wrote:
>> +static bool flush_tlb_kernel_cond(int cpu, void *info)
>> +{
>> +	return housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) ||
>> +	       per_cpu(kernel_cr3_loaded, cpu);
>> +}
>
> Is it OK that 'kernel_cr3_loaded' can be be stale? Since it's not part
> of the instruction that actually sets CR3, there's a window between when
> 'kernel_cr3_loaded' is set (or cleared) and CR3 is actually written.
>
> Is that OK?
>
> It seems like it could lead to both unnecessary IPIs being sent and for
> IPIs to be missed.
>

So the pattern is

  SWITCH_TO_KERNEL_CR3
  FLUSH
  KERNEL_CR3_LOADED := 1

  KERNEL_CR3_LOADED := 0
  SWITCH_TO_USER_CR3


The 0 -> 1 transition has a window between the unconditional flush and the
write to 1 where a remote flush IPI may be omitted. Given that the write is
immediately following the unconditional flush, that would really be just
two flushes racing with each other, but I could punt the kernel_cr3_loaded
write above the unconditional flush.

The 1 -> 0 transition is less problematic, worst case a remote flush races
with the CPU returning to userspace and it'll get interrupted back to
kernelspace.


