Return-Path: <linux-arch+bounces-15072-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D60C85572
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 15:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AFCB4E4B44
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D948D32471E;
	Tue, 25 Nov 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCFs1Enb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k3jbReCj"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395BC32470A
	for <linux-arch@vger.kernel.org>; Tue, 25 Nov 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080036; cv=none; b=QDcgpkljvqA6mkLiA4DAVZ97CuAYL6eR9c+c3lKoR58ugwYCnfXM0eMCh1d3XOauktAp2/kPpNod1IEjx8jGq5WnNu40nDozAKiCpqxQETZmNe1cnIkBB0ZNibwrkW8Exm+cM0FZpLgIvIQfhznjLj1HH8pDkcepE25cYP3ZCZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080036; c=relaxed/simple;
	bh=vmAxAdtBdBPAYy3/MG+wU8uP+oKefkt/UnAeEvBcakg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9x0hsOrGgNC91Xk/TGyFgu8ICrsK48ARDVTyjhJGahR0xXFlH2xV4EzcuEiUQSujWeRBcnQXXOGfJY5SRxk7Sps8+5lSXNbjOJRpLF2yca5+8S5efigD8ZPGFrHDCQn3tFKwjhDrTzjK8Qe1rkmIILPyD/oMEhrP5Va1G8QXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCFs1Enb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k3jbReCj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764080033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wOE4pVZbQk3NRzTWk4bK9iK9S5Rl6Cg6Yr2VD/4CLLg=;
	b=WCFs1EnbW0dICr2gg1LFHJox4vf8fvNZxl+Nzzhd3p2g21y8nyOWvLPzKRwF80u1AXUPxF
	PoYDGEpi/UyqplM0Qj5XipfP/S2nZ96ws7EuKlzJKxpcA+r2FH/5H40eGBC4R0rvVhoJpI
	yn2WcRZt+0AnKdKe+FU3Hu0x1ous42M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-O2-IvQiZO6O6K1D-WiGLsw-1; Tue, 25 Nov 2025 09:13:52 -0500
X-MC-Unique: O2-IvQiZO6O6K1D-WiGLsw-1
X-Mimecast-MFC-AGG-ID: O2-IvQiZO6O6K1D-WiGLsw_1764080031
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so52621385e9.1
        for <linux-arch@vger.kernel.org>; Tue, 25 Nov 2025 06:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764080031; x=1764684831; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOE4pVZbQk3NRzTWk4bK9iK9S5Rl6Cg6Yr2VD/4CLLg=;
        b=k3jbReCj9ht0ZqHrtcJVcgwM3b1d2Pt4GukpgjDN2KAN8j3gRBo78lyCoeIAinnw1n
         uikf1n0Y9lnk3ODWmSNEwIHHaUfjsrWNx4Pn4c5nMyOpTRuAMY16RPjogM1WtOCjdhOc
         0z/3X9E5syYBalrtAGYmU6G27T9alrnNOfioBPjbrkQZ2FcVe8NI6FRKk+8/NUSqms2w
         M2etWp4tUxxMNd+20cVJYKLdeloYxC7ewrADO5+5Wdgmie1M8Yj+H3kyGLOQ7tlFv1LL
         uBAib7G6gyNfg2lCYUbuSxym53/8EZ3XYdgYRp6Jd3aRz+hMrQpLilj8pof5g1h2+d7m
         wy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080031; x=1764684831;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOE4pVZbQk3NRzTWk4bK9iK9S5Rl6Cg6Yr2VD/4CLLg=;
        b=Yzow40MQx5xIC92pTNFSMlWJ4N1dK3GRHA/yHN/VDc6DnB2JX1gzK1kmdPX1Mq3spi
         zSE3NMPgX9sa5rSCTOUnbh+kCkco15wBCwZYDC38ZZIMJeMplol80uPc7kYjcS/Hv3XB
         f2pVF0lK1H+OrByj66fcCcB/mDXICxaTS1yN3Hnm0KOAHEis47JW31bOO4VQn+ox+c4k
         6tPZVGsgi12iLWsv9n5gk8dNydVFpQi+ny2cnCz2hbsfOXRbXiIvgBhz1WMrPkXWvMGw
         o/ttk9E0kAO2mxi6Za9LdhqRmCjnssAktGCIwq+cK7BMB1PUTgOREojBx61KF63eOIdi
         +u/g==
X-Forwarded-Encrypted: i=1; AJvYcCURcymYoDtOIRZhSu0qFgHlzRme0OEJHJPMBqW6IZDRu4b3JMSZSiBet8aXplrkVZEm7y7NGZhiaXGq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kGEDmAMOI330mBGBvklyMvuNOPpf3uM1Cs5Ydyi0bWOBdvZV
	vT8ykIOguSCGAsCkbiJxYBYR93H163wTM4I0QOKVc+JzUb0vysT3Yq5MqytykkuFgG4wDVH4Y2V
	5pTyupyvy1yczijmJVV8y1xNJ1GZSzqH52nb+obP332YbBh5/QaY4XcplM77E4e8=
X-Gm-Gg: ASbGncv32nt/hADl4XuCJZ8h8poW5+L5FjBLfiLPYQxl/i8lnH2p0HcEmC2wgvejHbF
	y/rtwcB5dFFHr8iQc50L8AJRmum1rUdIhJjGhktj7qwdl04OvJRE8e7CZCNOkT5X+ZAj903tAxg
	FhPoX8dsMboIPRyDu2/iatlOsYykztPjvsKYpLm5GbFCV8RTcoJgQ3L+7o07fKNakQUnMoTuHBi
	L2FWDPJRahxzmT3yrddbEptUgo9+ARER6XES1s8KfIZcQvZ71KUtrajROyL37+ZsLNQiOPhhkwm
	HXXxPg3O1AEAz4FkbpYEYfQssNihNXR9LjNUx4DoIzT55GIqNanIJG9z/DQRw4Udp58EyEM+rZF
	yV314NkNZViDQBaicoi0M4OMUFI38FBfgzvcUZsqreI6SslsbpBt35IwsbgPR+wgT2yO1uBU=
X-Received: by 2002:a05:600c:3111:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-477c10deffamr169342205e9.12.1764080030969;
        Tue, 25 Nov 2025 06:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtA8JzDWqwpv+zLW5Ygo6VxUlFOBnDYO5W2Qk6szEUT54U+0BafPLKh5CrRqs4rY7IKqQsQw==
X-Received: by 2002:a05:600c:3111:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-477c10deffamr169341405e9.12.1764080030289;
        Tue, 25 Nov 2025 06:13:50 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1e86b3sm306305045e9.6.2025.11.25.06.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:13:49 -0800 (PST)
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
In-Reply-To: <2837ea3e-c0b8-46b0-b8da-bf06906d124d@intel.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-10-vschneid@redhat.com>
 <bad9eaaa-561a-498a-90d1-fe3a3ab8ba37@intel.com>
 <xhsmh5xb3thh6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <2837ea3e-c0b8-46b0-b8da-bf06906d124d@intel.com>
Date: Tue, 25 Nov 2025 15:13:47 +0100
Message-ID: <xhsmh3462td2c.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/11/25 09:50, Dave Hansen wrote:
> On 11/21/25 09:37, Valentin Schneider wrote:
>> On 19/11/25 10:31, Dave Hansen wrote:
>>> On 11/14/25 07:14, Valentin Schneider wrote:
>>>> +static bool flush_tlb_kernel_cond(int cpu, void *info)
>>>> +{
>>>> +	return housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) ||
>>>> +	       per_cpu(kernel_cr3_loaded, cpu);
>>>> +}
>>>
>>> Is it OK that 'kernel_cr3_loaded' can be be stale? Since it's not part
>>> of the instruction that actually sets CR3, there's a window between when
>>> 'kernel_cr3_loaded' is set (or cleared) and CR3 is actually written.
>>>
>>> Is that OK?
>>>
>>> It seems like it could lead to both unnecessary IPIs being sent and for
>>> IPIs to be missed.
>>>
>>
>> So the pattern is
>>
>>   SWITCH_TO_KERNEL_CR3
>>   FLUSH
>>   KERNEL_CR3_LOADED := 1
>>
>>   KERNEL_CR3_LOADED := 0
>>   SWITCH_TO_USER_CR3
>>
>>
>> The 0 -> 1 transition has a window between the unconditional flush and the
>> write to 1 where a remote flush IPI may be omitted. Given that the write is
>> immediately following the unconditional flush, that would really be just
>> two flushes racing with each other,
>
> Let me fix that for you. When you wrote "a remote flush IPI may be
> omitted" you meant to write: "there's a bug." ;)
>

Something like that :-)

> In the end, KERNEL_CR3_LOADED==0 means, "you don't need to send this CPU
> flushing IPIs because it will flush the TLB itself before touching
> memory that needs a flush".
>
>    SWITCH_TO_KERNEL_CR3
>    FLUSH
>    // On kernel CR3, *AND* not getting IPIs
>    KERNEL_CR3_LOADED := 1
>
>> but I could punt the kernel_cr3_loaded
>> write above the unconditional flush.
>
> Yes, that would eliminate the window, as long as the memory ordering is
> right. You not only need to have the KERNEL_CR3_LOADED:=1 CPU set that
> variable, you need to ensure that it has seen the page table update.
>

I assumed the page table update would be a self-synchronizing operation,
but that betrays how little I know about x86; /me goes back to reading

>> The 1 -> 0 transition is less problematic, worst case a remote flush races
>> with the CPU returning to userspace and it'll get interrupted back to
>> kernelspace.
>
> It's also not just "returning to userspace". It could well be *in*
> userspace by the point the IPI shows up. It's not the end of the world,
> and the window isn't infinitely long. But there certainly is still a
> possibility of getting spurious interrupts for the precious NOHZ_FULL
> task while it's in userspace.

IME it's okay if the application is just starting as it needs to do some
initialization anyway (mlockall & friends), i.e. it's not executing actual
useful payload from the get go.

If it's resuming from an interference, well we'd be making things worse.

I'm thinking the worst case is if this becomes a repeating pattern, but
then that means even without those deferral hacks the isolated CPUs would
be bombarded by IPIs in the first place.


