Return-Path: <linux-arch+bounces-1234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D076821E5C
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 16:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9264283B8F
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6B413FFE;
	Tue,  2 Jan 2024 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGcEb+FB"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B34134DD
	for <linux-arch@vger.kernel.org>; Tue,  2 Jan 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704208179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyAp2a63bNUdMnRsj/hhIizx1kpY/IpGl6RFLf7olc0=;
	b=EGcEb+FBf1SCon9Px0Ou9S1QT3PeXhaZdnve0OngsZuwDvTCRtt1qt2nv9HqHcWBcb9H08
	XLIDyZCxmmZyNfSnUnCIlOIlOe9fVz02EneNVqiIGBjfDQWzt+sj3e3Ma5rsB39db5d+1f
	yBUzpFwKGsXkgly/uSlCOl71G3pY0C8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-z1ZxpOPtM265DghDSnS3MA-1; Tue, 02 Jan 2024 10:09:38 -0500
X-MC-Unique: z1ZxpOPtM265DghDSnS3MA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33677bbd570so7156880f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 02 Jan 2024 07:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704208177; x=1704812977;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyAp2a63bNUdMnRsj/hhIizx1kpY/IpGl6RFLf7olc0=;
        b=LJIRb0KOhht72Et7IcrDD3gRIG4uZUkJVGIn2t911L3nGL0xvDEo9351VlrxQ35WrM
         o7tj/MfHxwA04UxaTzsPUNw63EXyA//JyOefzlwe7UwLLWza+0jCS+fc5X+PBKMIrhYM
         AjbM05dJUHkLkfZPuFG0SiSfmpDd+zwk+wi78wdQXrSsrnhOJ24JrvAdL8ZA3M3rc6+I
         IBiyyJpGV42evwJv+pe3k8mqEXA8HBUius4gfQFJ4atXhAn5hIRFR96Su9+1BVvIo4Gz
         dIWJe9j0d+XvfABlncN4F+hjM1z4KagZgtyY3QAEdFh7RaBncOWHwwzGKzzcbHpYN9No
         Zhbg==
X-Gm-Message-State: AOJu0YwXrKTZCFHag64dfbXZl+zX7lwOxXwMmBxXXzjfB2+UlmPC2wum
	g4JAZDomtBzRLdbfAGpeQwN0B69/WpNttKladbjLinZ3CnmxfX5h3tq7ozPqwyqdcqaRVq4iMhF
	u7tfYwXVxrh5vjKJF3wZmbL/875czxQ==
X-Received: by 2002:a5d:6744:0:b0:336:45cd:6d87 with SMTP id l4-20020a5d6744000000b0033645cd6d87mr10953354wrw.60.1704208177488;
        Tue, 02 Jan 2024 07:09:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyuXnWxFGu6P2UDRmOMW7+D+oRJwWgKCt7eNeNUUfLIpD6sU5j5lSo6bU7jHHxrb0gagtbQQ==
X-Received: by 2002:a5d:6744:0:b0:336:45cd:6d87 with SMTP id l4-20020a5d6744000000b0033645cd6d87mr10953332wrw.60.1704208177153;
        Tue, 02 Jan 2024 07:09:37 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id a1-20020adfed01000000b0033748f5600csm1610410wro.108.2024.01.02.07.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:09:36 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
 <ardb@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand
 <david@redhat.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
 Michael Kelley <mikelley@microsoft.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>
Subject: Re: [PATCH 5/5] x86/tsc: Make __use_tsc __ro_after_init
In-Reply-To: <20231204182043.GB7299@noisy.programming.kicks-ass.net>
References: <20231120105528.760306-1-vschneid@redhat.com>
 <20231120105528.760306-6-vschneid@redhat.com>
 <20231120120553.GU8262@noisy.programming.kicks-ass.net>
 <xhsmhcyvlc3mi.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20231204182043.GB7299@noisy.programming.kicks-ass.net>
Date: Tue, 02 Jan 2024 16:09:35 +0100
Message-ID: <xhsmhmstnkc0g.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 04/12/23 19:20, Peter Zijlstra wrote:
> On Mon, Dec 04, 2023 at 05:51:49PM +0100, Valentin Schneider wrote:
>> On 20/11/23 13:05, Peter Zijlstra wrote:
>> > On Mon, Nov 20, 2023 at 11:55:28AM +0100, Valentin Schneider wrote:
>> >> __use_tsc is only ever enabled in __init tsc_enable_sched_clock(), so mark
>> >> it as __ro_after_init.
>> >>
>> >> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> >> ---
>> >>  arch/x86/kernel/tsc.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>> >> index 15f97c0abc9d0..f19b42ea40573 100644
>> >> --- a/arch/x86/kernel/tsc.c
>> >> +++ b/arch/x86/kernel/tsc.c
>> >> @@ -44,7 +44,7 @@ EXPORT_SYMBOL(tsc_khz);
>> >>  static int __read_mostly tsc_unstable;
>> >>  static unsigned int __initdata tsc_early_khz;
>> >>
>> >> -static DEFINE_STATIC_KEY_FALSE(__use_tsc);
>> >> +static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
>> >
>> > So sure, we can absolutely do that, but do we want to take this one
>> > further perhaps? "notsc" on x86_64 makes no sense what so ever. Lets
>> > drag things into this millennium.
>> >
>>
>> Just to make sure I follow: currently, for the static key to be enabled, we
>> (mostly) need:
>> o X86_FEATURE_TSC is in CPUID
>> o determine_cpu_tsc_frequencies()->pit_hpet_ptimer_calibrate_cpu() passes
>>
>> IIUC all X86_64 systems have a TSC, so the CPUID feature should be a given.
>>
>> AFAICT pit_hpt_ptimer_calibrate_cpu() relies on having either HPET or the
>> ACPI PM timer, the latter should be widely available, though X86_PM_TIMER
>> can be disabled via EXPERT - is that a fringe case we don't care about, or
>> did I miss something? I don't really know this stuff, and I'm trying to
>> write a changelog...
>
> Ah, I was mostly just going by the fact that all of x86_64 have TSC and
> disabling it makes no sense.
>
> TSC calibration is always 'fun', but I don't know of a system where its
> failure causes us to not use TSC, Thomas?

Having another look at this, it looks like the actual requirements for the
TSC being used are either of:
o CPUID accepting 0x16 as eax input (cf. cpu_khz_from_cpuid())
o MSR_FSB_FREQ being available (cf. cpu_khz_from_msr())
o pit_hpet_ptimer_calibrate_cpu() doesn't mess up

I couldn't find any guarantees for x86_64 on having the processor frequency
information CPUID leaf, nor for the FSB_FREQ MSR (both tsc_msr_cpu_ids and
the SDM seem to point at only a handful of models).

Also for x86_64 there is this "apicpmtimer" cmdline arg which currently
disables the TSC. The commit that introduced it [1] suggests there are x86_64
systems out there with calibration issues, so now I'm not sure whether we
can kill the static key for x86_64 :(

[1]: 0c3749c41f5e ("[PATCH] x86_64: Calibrate APIC timer using PM timer")
followed by: 7fd67843b96f ("[PATCH] x86_64: Disable tsc when apicpmtimer is active")


