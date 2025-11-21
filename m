Return-Path: <linux-arch+bounces-15008-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F394C786D8
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F93E4E92AB
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A20221F03;
	Fri, 21 Nov 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOK+FY87";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcrrlcZp"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78738190477
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719946; cv=none; b=ieV9iLe01poQuYD9hFLaZoZFOJXaSotGIdwyppEhdjdUOXG7rgwT739SHNdUcpS/UpdBGCbkkLZQlfr/8cUDVhaW3CG0OWRBmhEBZOl/CtrFq1appj2uhCCbCRMVkyGpbTqCBMgo/y1BGmOsZg0NLgjOFjeM9HnnY9me9WLu3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719946; c=relaxed/simple;
	bh=nIxOA6aOVr6gGSQiExzc8nNHFfpPye0obYzpAtlDgI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gbp+7CuJ+6u7+Kd09y9HbSAvfHwAvddTM/cyzFYc7yNoO0cAjrHpcUZbPPdJ/3klsWMl/eMTGhat/AqMjoqngBFbScbt5mwosrBfGVEGs+hlSlvvxtPgraw3DTnzt+YCRLzQWY1b4D5f1alLWVQPeL3mmmuivg/sj45vlrrHW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOK+FY87; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcrrlcZp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763719942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZIk/6eiWFE7r0Pz8jIgtNeqgPIl4m+Z/Z67QWlEwbg=;
	b=YOK+FY879Am7GnPXbNLmSgDD9+CwCE35ZTP111/C75w6L6OtMB75MILjDrXLsK9Yl7VOqd
	9vkqDFih2SuH6BKKfbDoa82R2hHE2K5NtORIUpXT2hp6wqOPmxxN81vmwMRCetrS29N8wq
	zHDfF3e3Mwkpx7biyfMKytTcPvPA2fs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-RR-agMrCMlGOPMBSYwZbdQ-1; Fri, 21 Nov 2025 05:12:20 -0500
X-MC-Unique: RR-agMrCMlGOPMBSYwZbdQ-1
X-Mimecast-MFC-AGG-ID: RR-agMrCMlGOPMBSYwZbdQ_1763719940
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso1624740f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 02:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763719939; x=1764324739; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZIk/6eiWFE7r0Pz8jIgtNeqgPIl4m+Z/Z67QWlEwbg=;
        b=VcrrlcZpFqyVhH8MmCt6P+yUSIwuWCfg120or1zJ+SviQuHZkBKw76xSxkUw070nSq
         LLIPuo3x5gF3Nz0KqAweo9rjIbTif2nSxtgkZKDDUmPFcDYe+DyeIrcK3IQP6NAB1BQs
         0dOIh4t2kIu+zu52MgQrBlenEpspUCY1vcWHLZqN2zZ5JGMSiOi6bH2A7E+o0IWTv0aR
         Xvc5DHAj3OA/t8pR9c9poGBi6RQoJl6GgyiBM9qX0BQzYoGTBAviR24tiADBKIaamHj8
         lt9q6jM10kh9K4TKEiVI/FVKqnac1TiXv28KnEV+bxJ1eTQDBqqjMoMzxKedLFZlhCND
         sZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719939; x=1764324739;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZIk/6eiWFE7r0Pz8jIgtNeqgPIl4m+Z/Z67QWlEwbg=;
        b=HHpug8mBaw3Z/k+4TQGpeotc1bErJKIWVAA9PY5KlP70oGiZGfeiHtK+v3m0GDpcVS
         4Emzr/UkpGwG2pWIshUQukvv+mrTyOtF0vYWs2a64me166Sh3JYNHU0HtPbeuymLE36U
         GVCwJZZ4zC9H5WONCzQsVB6KLqlyeByvcICCguLk42osi7P14n/8wiqa7KRJmcgrlRUz
         Nz7iqiC+jlQf1LNm+o40GuaOjrgterN6NmqbClNjRhQfBkMsfYu0ytg432AUdQOiHZYA
         bcGKgFelpPjAwCtx3OiSvRzcF3bZRhYqbIis269K5vZE3NAzDP41jhlSQ9J25fLNOcld
         yJxg==
X-Forwarded-Encrypted: i=1; AJvYcCUWm1zmBkORUQxizMdM3xEUaS0bW8u0ymZ9pItf7JeyH817OgVtTf0ZcqXvdel3g7SxjKKrxAXtFZXE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv5AOoKFrIx6BjPgJQeQYdfevuIi0LLVeCvGmT7GU86hwLZMmj
	UDAD1NBLAaYqCKayQY7Wa2WDYdeKu1kyqSU2hv1L6ZFICNOOb2vAwTdfMRUHsVF6HK0YVzfAC00
	y3Ilmkz4C1/SJIJuNobreQ4Tlnb4TVUkpr5d1RNGnyuIV059Djt9HR33AZCqoJHE=
X-Gm-Gg: ASbGncv+39AZ1ZrImYhIQivTEWxmaL9JHGpIVklEST+TA8zNMByYCBkbkDXRN+bZnOh
	fgZWE1HYOQLEZJ3yBQyUe7I2+q9zGeH3w4nkwFPgTUufKIWHlUAX6UJbgO1YHKwdSqQNaJbsUAW
	186Y9P1bSdF9D1K6NkTGf36tVzEuKj/K3NeUhQvhGuCNp3ISAAVE8qCrwbPotK07n1h2sPhC1HB
	YNwC1CRZLExWXuhMf4OfvRo/06Ryci2CZqyhVxCo8jjqWoFc8HbUXs02opdXJ3b6H55E42cv3UL
	AccJFqOLbYf34x1lMrBigkk1NwCRGLTX8PHCovoa8bzCdSuhVASlhTN0gdA9z49GmiQ3uDDn3Vm
	JSy74Y80zB3jMZ2u0EqAR5pwp7TKGj6r4LM9Lhz2q9lRg/CzsXllWJecz2CjbMOgmAqOSJEo=
X-Received: by 2002:a05:6000:1888:b0:42b:3ace:63c6 with SMTP id ffacd0b85a97d-42cc1cbcdfcmr1795892f8f.16.1763719939483;
        Fri, 21 Nov 2025 02:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQwvNnN1+6xkIr+bJK+olrvC0Z5OYdiF1L0OBTcrYbQMUdl7o+C2/hye3fKlSOf/cE5aQ8Qw==
X-Received: by 2002:a05:6000:1888:b0:42b:3ace:63c6 with SMTP id ffacd0b85a97d-42cc1cbcdfcmr1795834f8f.16.1763719938945;
        Fri, 21 Nov 2025 02:12:18 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e432sm9799426f8f.9.2025.11.21.02.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:12:18 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, rcu@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, "David S. Miller"
 <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman
 <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC PATCH v7 29/31] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <91702ceb-afba-450e-819b-52d482d7bd11@app.fastmail.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-9-vschneid@redhat.com>
 <65ae9404-5d7d-42a3-969e-7e2ceb56c433@app.fastmail.com>
 <xhsmhecpukowa.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <91702ceb-afba-450e-819b-52d482d7bd11@app.fastmail.com>
Date: Fri, 21 Nov 2025 11:12:16 +0100
Message-ID: <xhsmh8qfzu22n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/11/25 09:31, Andy Lutomirski wrote:
> Let's consider what we're worried about:
>
> 1. Architectural access to a kernel virtual address that has been unmapped, in asm or early C.  If it hasn't been remapped, then we oops anyway.  If it has, then that means we're accessing a pointer where either the pointer has changed or the pointee has been remapped while we're in user mode, and that's a very strange thing to do for anything that the asm points to or that early C points to, unless RCU is involved.  But RCU is already disallowed in the entry paths that might be in extended quiescent states, so I think this is mostly a nonissue.
>
> 2. Non-speculative access via GDT access, etc.  We can't control this at all, but we're not avoid to move the GDT, IDT, LDT etc of a running task while that task is in user mode.  We do move the LDT, but that's quite thoroughly synchronized via IPI.  (Should probably be double checked.  I wrote that code, but that doesn't mean I remember it exactly.)
>
> 3. Speculative TLB fills.  We can't control this at all.  We have had actual machine checks, on AMD IIRC, due to messing this up.  This is why we can't defer a flush after freeing a page table.
>
> 4. Speculative or other nonarchitectural loads.  One would hope that these are not dangerous.  For example, an early version of TDX would machine check if we did a speculative load from TDX memory, but that was fixed.  I don't see why this would be materially different between actual userspace execution (without LASS, anyway), kernel asm, and kernel C.
>
> 5. Writes to page table dirty bits.  I don't think we use these.
>
> In any case, the current implementation in your series is really, really,
> utterly horrifically slow.

Quite so :-)

> It's probably fine for a task that genuinely sits in usermode forever,
> but I don't think it's likely to be something that we'd be willing to
> enable for normal kernels and normal tasks.  And it would be really nice
> for the don't-interrupt-user-code still to move toward being always
> available rather than further from it.
>

Well following Frederic's suggestion of using the "is NOHZ_FULL actually in
use" static key in the ASM bits, none of the ugly bits get involved unless
you do have 'nohz_full=' on the cmdline - not perfect, but it's something.

RHEL kernels ship with NO_HZ_FULL=y [1], so we do care about that not impacting
performance too much if it's just compiled-in and not actually used.

[1]: https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/blob/main/redhat/configs/common/generic/CONFIG_NO_HZ_FULL
>
> I admit that I'm kind of with dhansen: Zen 3+ can use INVLPGB and doesn't
> need any of this.  Some Intel CPUs support RAR and will eventually be
> able to use RAR, possibly even for sync_core().

Yeah that INVLPGB thing looks really nice, and AFAICT arm64 is similarly
covered with TLBI VMALLE1IS.

My goal here is to poke around and find out what's the minimal amount of
ugly we can get away with to suppress those IPIs on existing fleets, but
there's still too much ugly :/


