Return-Path: <linux-arch+bounces-14095-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D76BD8F9D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE2324EB1CC
	for <lists+linux-arch@lfdr.de>; Tue, 14 Oct 2025 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCCC1DFCB;
	Tue, 14 Oct 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLtaCswH"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A851DA62E
	for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440814; cv=none; b=Vs5THYZRHfDgUEfrp1NN4EFJqBqHMq7qYxXj6xZTu1lOfmuCgKN/2PoqegKZCoVHMIMEqPRjZChwjznroYFHsxThniiUP+4udUbMVqfsrwQg6up5vF+FrFXYxUxJD4h5N5eKahcuqR+BOjYHrG2u4l5qgfOI54ulgkBdi9ki0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440814; c=relaxed/simple;
	bh=yX5dyBuNEa2OXACHjn8fnbGsDn2mXnkquyRkiu3aCD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SU3bHLnYfx6N4RvdvpfpciAtemzzW+IhhzBNxrJ6NRgWhly1h4foRnDamimE9ainEutn0gLza4J5vhae/JG9qDgK+jKApLlYajca5mRjv/vmnuF3rAruQ9MyMtdcuVDWTIJ6hxo7fkL5JJJdgEtb48dgdv2a5FTIrMDDjcWuJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLtaCswH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760440811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Imuve1iPcSxB4uVU/yFQsIzQ6zKzpq/61jJo3KbkM2Y=;
	b=JLtaCswHk/AW7ow1AFK8jpTTCTDmRdtWf4uRPQp+yJ+Cxgn9K2tK3EJ3EGx3Yxyuv5VOvW
	8MeIBKkAvdUbrmjYWsS33vur/yPGKfntdccd+N0/n4Jaz5s7kZS2eR6PLLvt3t0j3RlMxC
	JICyHnc66knRbsr4oO8lRpKs7rDX7So=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-nGXJkNrGPZiTlLOUnecWyQ-1; Tue, 14 Oct 2025 07:20:09 -0400
X-MC-Unique: nGXJkNrGPZiTlLOUnecWyQ-1
X-Mimecast-MFC-AGG-ID: nGXJkNrGPZiTlLOUnecWyQ_1760440808
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e2c11b94cso39118705e9.3
        for <linux-arch@vger.kernel.org>; Tue, 14 Oct 2025 04:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440808; x=1761045608;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imuve1iPcSxB4uVU/yFQsIzQ6zKzpq/61jJo3KbkM2Y=;
        b=eACgoVfeBmf3PYHal5fa9Gm8fpNGzDtytX6oswGBkdja5QxlyIta+I4iZdXuJt4kkQ
         AYtH3UOnpa3u441pUg/+sWje1SdWNt5/jjEyKjvgHCj5Ms9WaKOjZnMX6GfBnFED+at0
         tiur5SXmbZh+29+Wa2tmtV3EOnec77D9F7OOI5z7RFuwF+Gi2uEMAfX3wCzf6Qs5Fbbd
         nGJxYqEcZdBF57izD6bhZDjxd4XwNSX5HovCj0JW8HALNd7VBDGWAEvs2sCcUJIkv3W4
         rj+73X8bxhP/ZqnV75saNAg/F1CWRa6FD5NgHv1+bgvepryckhDEU0QPi2CWk258DnZE
         0h8g==
X-Forwarded-Encrypted: i=1; AJvYcCXjgl2PEhvyYczaLMG6DSXQazoN4ODGg1EoepA0Q9VIgZA+DOPlwB6pYABDZDNPuOZjFYf5J/2OY/pw@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3PJurdBaw/Vu1soJW6/vuNE5FE74sN8ud1ddoBSDmRHaKgpX
	LhMa4UKPnlpZA3WajSv5E8m5b22/dn3Vg/lYs30JUkOtreSXzlnShbgJRUnbJD9sF+LVjuvZaG2
	EYlEytKavAkdwhwmZoB1LgflnW9tzoNqengr5gNyOb+nSY9lAu7C0Ez5aAUxcHrU=
X-Gm-Gg: ASbGncstq97doTZ2bZVXo8gvDLFtyKvNRIvPq0E9sUmJaPLylgKF6PPezM95YPAvg7d
	VkQJFlm04CBOB31RUpuRyCi1hSuUF2Y+m0CM9gRu/fE7ubLZmasNFAUgaLo9VORkM68xeI3JpEE
	Em4CEYs53Qt6OE/eympODYKwR093n/m5jrNdaLiyljHBCQz55YZKw4HVgZluLyKnMjyrJf9iL7S
	5BUb34YX6+vp28oWJUg174mIsrtld5rJNF3TGfo/sbc9/fNzXp+kQjih+yXLYImyYqK7SFZvri4
	VdWk8pK++XKWJwtBHCqlKZbFJtpY5z4ozTCHv4TKwDWcXI4kfxMJM6mQ7H6vxcartlmKeyKjh2q
	fYb5vyX3lttQMoyIktqpSyz3Piw==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46fa9b1b18emr175576595e9.36.1760440808234;
        Tue, 14 Oct 2025 04:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPNHhJVacE21hOu+c1s40cKBm99NOdKTbqBsl6lzaW/V++U98Y1cwp6CoRkBLGlZny7BSyXQ==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46fa9b1b18emr175576075e9.36.1760440807708;
        Tue, 14 Oct 2025 04:20:07 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb492e6ddsm265506695e9.0.2025.10.14.04.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:20:07 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
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
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 16/29] KVM: VMX: Mark __kvm_is_using_evmcs static key
 as __ro_after_init
In-Reply-To: <aO2TKOY5JV9OoRUg@google.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-17-vschneid@redhat.com>
 <aO2TKOY5JV9OoRUg@google.com>
Date: Tue, 14 Oct 2025 13:20:05 +0200
Message-ID: <xhsmhtt01pw62.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 13/10/25 17:02, Sean Christopherson wrote:
> On Fri, Oct 10, 2025, Valentin Schneider wrote:
>> The static key is only ever enabled in
>>
>>   __init hv_init_evmcs()
>>
>> so mark it appropriately as __ro_after_init.
>>
>> Reported-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>
> Acked-by: Sean Christopherson <seanjc@google.com>
>
> Holler if you want me to grab this for 6.19.  I assume the plan is to try and
> take the whole series through tip?

Thanks! At the very least getting all the __ro_after_init patches in would
be good since they're standalone, I'll wait a bit to see how this goes :)


