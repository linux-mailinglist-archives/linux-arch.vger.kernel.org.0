Return-Path: <linux-arch+bounces-14408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BFAC1B334
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 15:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F313D1A246F2
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E5317A305;
	Wed, 29 Oct 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2H5B+Ra"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47921D63E4
	for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747248; cv=none; b=fo/DelVFs4IqXUCCm3W3lWrp2QhWVRqd29uXTxoxSRTjGMkqBEk0m43jAVb5spo3K8iSzY2SjWI1hXx4t55CMlk4TBUm+cdmHoM2oqlNwGAcM2xoprb9HKGt+Vm4CtDQzD+PNVWlXlgmagVCyPpG9dQJjhhW/CF7TG8z5sU3Cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747248; c=relaxed/simple;
	bh=qHSXiqraPjnmJYVHtWW/ojXbtxwSOyBwYtqsjFFbB7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NwLRBH1Ef8i0Lr+92z336pKmDsgMUxBpx77nr3sW4bSwD9B/Fpp3T7gMSMejKmHde+KkhFalDHqgcXQBUU6XH2HOehQKX4yuCsq5aQ1wxmqsi/vc5Pxg7RIQdTuwFjTwk4P17gxWXQgs9K2IXHgYxeA1tELenD2us3aE7NQ/GKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2H5B+Ra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761747244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYXy/T5OYgT19DHuKKWwDf9vfL9WSRPLsc+nPGT92ds=;
	b=U2H5B+Raksn2ENNzszCQHAJa0BQQ8W0MyXG23Ao25C4Vyd3rZW9Ig0X4nEt+34TyN8cuYg
	lFEZQtMvF+FbZirhwMM3/ybr0u0OnC2PNRT/Yaf/8u4KNgQz6PfykvE7if0WtsAO3qQwxT
	y+ABm93UK3w4w1CWN2FMae7h7yZ+yCY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-kSt-HQqnP3OT3djX53pD3A-1; Wed, 29 Oct 2025 10:14:03 -0400
X-MC-Unique: kSt-HQqnP3OT3djX53pD3A-1
X-Mimecast-MFC-AGG-ID: kSt-HQqnP3OT3djX53pD3A_1761747242
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47717c2737bso5170945e9.2
        for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 07:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747242; x=1762352042;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYXy/T5OYgT19DHuKKWwDf9vfL9WSRPLsc+nPGT92ds=;
        b=PIGoKKzioCAVmAKM3jvJqZ9xP2K6cEgXFvHfAwO/1sQVRrb2XtUcAXZe11k4EA2nI9
         AMGu8erid13Eublkp2bOlg2/8X6FUteG8zF/gkJlBI6tWt2ogiUmWMYewrMFKFFufIjT
         bMazNqQEXhDZas+TJIXf4ABexLf3XSqWhaISla+Me45GnT3t3FYvmGUGyuZJiS9HhY3C
         9IFDBm/WXzjDF36xKsX7/9JVZ8TFrmxcAgj5h3N/vfnG/tgfcrW+SvYHXGMVU7cgnfiH
         oh3tiPVf+3uoj3Zz/hMeuXKmWNYlFmsWj0JqM7Tn5oXsCOJQpGinsa9TuSOypU9BhZu7
         oncQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6kaFMdE16d9/RvxZUYjyMbyjGUdiEiRumzUorduA9wio46tcdZqUIhKS5jpmop+iWpoC4x6wYGj+N@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oa0S9IBobiD7clrJBjlExdw+GCJC6EyyfycBk1AsoOVNRdhB
	PeuxOrZp0j6XXOzgk4nNdxjeApL3Qasajd1O2+s78788xKXVx6fV0BcJTFvfPc8IvDLAa851bJS
	oepWKFNyaG5JRb7TWF3BoGYtQO2jdTHo0jQdaiJBpzHoU/tAoS5C7v5JIpmreQpc=
X-Gm-Gg: ASbGncs+rLZznT6jWoEIYVA9O3WZBSCdq32d1tqwKH6vIS7g66b+zrPplTdlfgRCCeL
	Q1A6bnApvg0GI3OOtE1j1zpNWL9GQEHuIn9ikXIEs9EPZP44xwHvkqsjTpKT+CoqhWU2h6IuCj6
	5hBz5RPwQ+arsmQLBY9N25wUW1Nq8HyApaGDibPUhQvNhwWfBaBHXXMjuRkH6gBjTI/N3oImM/i
	QpAiFgAqidCuHqWSnIuwFxpLcK92HbSixHLrV/fPt5bHR2G/Q3Pn2vZY+nZotVXhfkGTjWILm57
	k6aEHq4nWDFEbMhOAmZff6Nb+zspk1i3ATMDp02NU79ln+UyMH8xfzUcRXCK9oaRY6djOS8vzz6
	V6eqYusF10GYEnVA+0czMGxjzAI3Tec6RykD6tlAGSk8+qwlqDCkf0l79i8lL
X-Received: by 2002:a05:600c:b85:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-4771e16e83emr30985795e9.8.1761747241975;
        Wed, 29 Oct 2025 07:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2ZXdnOISpERgBiJ9ZdxsqH+M706mFK4IVywCP8xRKb07Mt6iBAhayCrF0GEYoqONAFcNsMA==
X-Received: by 2002:a05:600c:b85:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-4771e16e83emr30985385e9.8.1761747241429;
        Wed, 29 Oct 2025 07:14:01 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47719004d79sm45516125e9.5.2025.10.29.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:14:00 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, "David S. Miller" <davem@davemloft.net>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v6 27/29] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <aQHtBudA4aw4a3gT@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
 <aQDoVAs5UZwQo-ds@localhost.localdomain>
 <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQHtBudA4aw4a3gT@localhost.localdomain>
Date: Wed, 29 Oct 2025 15:13:59 +0100
Message-ID: <xhsmhwm4dpzh4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/25 11:31, Frederic Weisbecker wrote:
> Le Wed, Oct 29, 2025 at 11:16:23AM +0100, Valentin Schneider a =C3=A9crit=
 :
>> On 28/10/25 16:59, Frederic Weisbecker wrote:
>> > Le Fri, Oct 10, 2025 at 05:38:37PM +0200, Valentin Schneider a =C3=A9c=
rit :
>> >> @@ -171,8 +172,27 @@ For 32-bit we have the following conventions - k=
ernel is built with
>> >>      andq    $(~PTI_USER_PGTABLE_AND_PCID_MASK), \reg
>> >>  .endm
>> >>
>> >> -.macro COALESCE_TLBI
>> >> +.macro COALESCE_TLBI scratch_reg:req
>> >>  #ifdef CONFIG_COALESCE_TLBI
>> >> +	/* No point in doing this for housekeeping CPUs */
>> >> +	movslq  PER_CPU_VAR(cpu_number), \scratch_reg
>> >> +	bt	\scratch_reg, tick_nohz_full_mask(%rip)
>> >> +	jnc	.Lend_tlbi_\@
>> >
>> > I assume it's not possible to have a static call/branch to
>> > take care of all this ?
>> >
>>
>> I think technically yes, but that would have to be a per-cpu patchable
>> location, which would mean something like each CPU having its own copy of
>> that text page... Unless there's some existing way to statically optimize
>>
>>   if (cpumask_test_cpu(smp_processor_id(), mask))
>>
>> where @mask is a boot-time constant (i.e. the nohz_full mask).
>
> Or just check housekeeping_overriden static key before everything. This o=
ne is
> enabled only if either nohz_full, isolcpus or cpuset isolated partition (=
well,
> it's on the way for the last one) are running, but those are all niche, w=
hich
> means you spare 99.999% kernel usecases.
>

Oh right, if NOHZ_FULL is actually in use.

Yeah that housekeeping key could do since, at least for the cmdline
approach, it's set during start_kernel(). I need to have a think about the
runtime cpuset case.

Given we have ALTERNATIVE's in there I assume something like a
boot-time-driven static key could do, but I haven't found out yet if and
how that can be shoved in an ASM file.

> Thanks.
>
>>
>> > Thanks.
>> >
>> > --
>> > Frederic Weisbecker
>> > SUSE Labs
>>
>>
>
> --
> Frederic Weisbecker
> SUSE Labs


