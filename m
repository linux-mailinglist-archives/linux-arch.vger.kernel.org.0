Return-Path: <linux-arch+bounces-643-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99871803ADF
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5187F281041
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1242C18D;
	Mon,  4 Dec 2023 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uey4/O6p"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D88C6
	for <linux-arch@vger.kernel.org>; Mon,  4 Dec 2023 08:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701708715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SapyimUGQGe0EmDwo46jv79iRuNiKKAe6T4mJuTcQno=;
	b=Uey4/O6pzWk/pWvtR5cTvjvEZE8wyTgWWTxCguXDRrwZ8AnyZ8rNt+896aTKyCREEKX5z1
	8pWch5UGJKVyz3cM3o2bMlOrnk/ThbIghD7zeabx3/Bvxxa5bBJhKF9LbnhKrvVed2WhnB
	QObiyiYQwSdyCK9PZaBBCGxKXCIHypA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-Ja0EZSAuMEm2xugFNN_gkg-1; Mon, 04 Dec 2023 11:51:53 -0500
X-MC-Unique: Ja0EZSAuMEm2xugFNN_gkg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4083717431eso33191675e9.1
        for <linux-arch@vger.kernel.org>; Mon, 04 Dec 2023 08:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708712; x=1702313512;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SapyimUGQGe0EmDwo46jv79iRuNiKKAe6T4mJuTcQno=;
        b=W0Q00iQCW0JlQRATZGg+FZaKJyTYru3EM9O3Hc5dDDN37Ts4zStmb/HtxRzsnSrhsU
         UKyXw9IUrlh583D7N4CCdYriokUVV93JbTmCieVU7zBl/Hr5vfbMUrNruQzsEU0lW5JO
         CtcLegFZyGy9ZB+XelAJ+sTbNwTi6Yo/O3+0+TbIuMdsDomvTqFtqmqbctY9F1EdkOgd
         qHDzLuI6lGr/Td9CqCWiG3Fw9gbmL/5R3FTOzOkimWz9Xt6Xbg58vWxFvaMoefxqdphG
         Seem5nE5G2MdPHbZW+viO1Y8MdeQTGNEQSz0WotowpntbuoiLRyWiUSTpMLqzJu2lyEH
         dJqQ==
X-Gm-Message-State: AOJu0YyH6UVMB8Ncp7Zk39kkO/OIIb40D8bN2OoavEcNFSNDeosSH0YC
	aQ6kinOrB7PopZHnyfZTGhacqws2fDkk4zUzwILYLD08N65S10cxomRvqo7kK6Zxb2Enlxak+V0
	RBTn+PAGilSawEU9lxV+ryQ==
X-Received: by 2002:a05:600c:4f94:b0:40b:5e22:97e with SMTP id n20-20020a05600c4f9400b0040b5e22097emr3262130wmq.109.1701708712620;
        Mon, 04 Dec 2023 08:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh+TMH3imf5AUgkN8K1YnumS25NnssEHJszx6xAz27K36WgGTXX/q2RDadA1i84yY8uwaxOA==
X-Received: by 2002:a05:600c:4f94:b0:40b:5e22:97e with SMTP id n20-20020a05600c4f9400b0040b5e22097emr3262113wmq.109.1701708712303;
        Mon, 04 Dec 2023 08:51:52 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id bg36-20020a05600c3ca400b003fe1fe56202sm15897195wmb.33.2023.12.04.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:51:51 -0800 (PST)
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
In-Reply-To: <20231120120553.GU8262@noisy.programming.kicks-ass.net>
References: <20231120105528.760306-1-vschneid@redhat.com>
 <20231120105528.760306-6-vschneid@redhat.com>
 <20231120120553.GU8262@noisy.programming.kicks-ass.net>
Date: Mon, 04 Dec 2023 17:51:49 +0100
Message-ID: <xhsmhcyvlc3mi.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 20/11/23 13:05, Peter Zijlstra wrote:
> On Mon, Nov 20, 2023 at 11:55:28AM +0100, Valentin Schneider wrote:
>> __use_tsc is only ever enabled in __init tsc_enable_sched_clock(), so mark
>> it as __ro_after_init.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  arch/x86/kernel/tsc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>> index 15f97c0abc9d0..f19b42ea40573 100644
>> --- a/arch/x86/kernel/tsc.c
>> +++ b/arch/x86/kernel/tsc.c
>> @@ -44,7 +44,7 @@ EXPORT_SYMBOL(tsc_khz);
>>  static int __read_mostly tsc_unstable;
>>  static unsigned int __initdata tsc_early_khz;
>>
>> -static DEFINE_STATIC_KEY_FALSE(__use_tsc);
>> +static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
>
> So sure, we can absolutely do that, but do we want to take this one
> further perhaps? "notsc" on x86_64 makes no sense what so ever. Lets
> drag things into this millennium.
>

Just to make sure I follow: currently, for the static key to be enabled, we
(mostly) need:
o X86_FEATURE_TSC is in CPUID
o determine_cpu_tsc_frequencies()->pit_hpet_ptimer_calibrate_cpu() passes

IIUC all X86_64 systems have a TSC, so the CPUID feature should be a given.

AFAICT pit_hpt_ptimer_calibrate_cpu() relies on having either HPET or the
ACPI PM timer, the latter should be widely available, though X86_PM_TIMER
can be disabled via EXPERT - is that a fringe case we don't care about, or
did I miss something? I don't really know this stuff, and I'm trying to
write a changelog...


