Return-Path: <linux-arch+bounces-9916-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04FA1D52B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 12:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3041718871F8
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 11:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AFC1FE46D;
	Mon, 27 Jan 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COsELM3d"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E525A62A
	for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2025 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737976632; cv=none; b=c+7Myrbb+mZtkHCAEg/h/Wu2Rk2AdqY5rXN4p++JTL7np8sj80PHMOyxjFnp9m3E1I+4Ym1BUiXOCZHiuZ7D19H6dORYmlbbGRsqTLtfww8bLKqp/U2ukhA7x5QJ8uH/68RrKZ8/NnZfovzN1KFUYpKN0NCOx7msypQ6eSg03uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737976632; c=relaxed/simple;
	bh=4dbZjQGSiQ3Uvilz1uWGVxI7SQKdAeYkXY6x+87P1EE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y6S5swD6DnHsjigdNo9GN0NZj7DhXa5VWHILxJiQQM8e57uvlEkbqGDp9zAmq6r7o27I7h/4m2Kb4ffpJa7H3X2SlG0BTQhtHh+8i+/y6XDryBn0KdJQ39b874bQgkk0T9MoWj1Y2jBukYg3Jj63mocTdITZaRswcH56LfHVF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COsELM3d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737976629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0llw80E8nAjg6kMfEOzoPei4nanpbue7YefsY9gW++w=;
	b=COsELM3dgMzqvxES3yiE/1iCKTW6mckRJV7B8/AVvEmfEs3SAt58Asoo0IgFILoNYu5k29
	fBFSTjEQXJS4MWwknSPRBkiv8c2Xy/Cc+zdBfzbAHLOzoyM7Z/f6FRWzeb8BFXztoPRlie
	qe9GX2oHEkEnaCuf0iM8NV5Gi4TtJI8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-VrWWIDjFMseXzD_glsUedA-1; Mon, 27 Jan 2025 06:17:08 -0500
X-MC-Unique: VrWWIDjFMseXzD_glsUedA-1
X-Mimecast-MFC-AGG-ID: VrWWIDjFMseXzD_glsUedA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385ed79291eso2297438f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2025 03:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737976627; x=1738581427;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0llw80E8nAjg6kMfEOzoPei4nanpbue7YefsY9gW++w=;
        b=stGfV5cv7LgXAtGKGPTZOOmwqn7bZKRTngOz1hvgLtT3uo6vPUPVLzivdJNrGood0e
         EqwADL0xvNTLgICuM2+UfSDVFXUcvYDNVeUqMmpeR9SGc5JFl/GXj1HRkO9d2qe+sKsq
         XtZfNJLAk2RhQuLNlB6k6vIFXX98kr6W17z4jyXYK51mXWCeByf/PC3gLlgYqcgoS20i
         ZwD7R4IV6Sn6RtkCBKxAoufHmpAk7K8U4iDNvMv7jVAXRpzppWhW5SPmiTNAaD0dv/qG
         BmQwjDg33FakI+4I1TT5ZlkVHEGH4sKJYxopTya3p7OGT1mOCNi8z/LSJ1yArbEGdb+b
         3+zA==
X-Forwarded-Encrypted: i=1; AJvYcCWy1zyDm3EYqpfbuyQotOOhyeULGOcsDMb4mK6AqRgm5DSCPCgTDr+W/AItp4FMmk9GYbdxz5Ipg2HL@vger.kernel.org
X-Gm-Message-State: AOJu0YxlyeRwqUiCYe5vqf5c1vFQ5loKTkkDXXkQ2vtaqtCBcYH5xdTs
	Y1RgYZqSwKbFh16+a6KjGDvcLCD4h8hVNgLV4fHk4ShCXfwIGNqtmOakTiq/4Hgq5XrCqE+m0rP
	QiWvkR98ep4GAXhdvZP3EDbPfN55rbuYhEoz0sl/AM2cuUveSqnKDIaxnljU=
X-Gm-Gg: ASbGncslyDggz23mq6M9ksHJpNWr8rCd+tjY1VIlepNB63kemL/W5w8AdhEfxiH+sfz
	borgQGhZZ/H+T8WslBRCObEwBkukMZg9yF7VSUTSbAH2ikutwANQO4LkMTMiCmf0u8TZ42kGf3Z
	QZwZV8lTEyOL6lLoaRa2lRPjmua7W+r7vCj5V7km2Pv/VOTw3btchXVDPkAs8s0681RjRVwcjPq
	M0gq6zV/WGEI8R/47H1+LPQOidnZyoSTdD4jImlEIQ4WgoTK3NHlp3qEqSq3tVoEijoyTH7s46V
	pn7MeZnLErIJaJkU+xLbx2g+Jze9cF90ac9Bn44ZUaYR94KNYu7tKcb8Es+SHEpsew==
X-Received: by 2002:a05:600c:6d46:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-438bcfd440dmr101052995e9.0.1737976626872;
        Mon, 27 Jan 2025 03:17:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5ZBkhc7Mo57S55YqkWjUaKcE0DvJ7v1EsH72AA8CbL1E0vvN/eQHzrpNG4sI4i71C/vJTUQ==
X-Received: by 2002:a05:600c:6d46:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-438bcfd440dmr101052395e9.0.1737976626396;
        Mon, 27 Jan 2025 03:17:06 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48a145sm128093025e9.16.2025.01.27.03.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 03:17:05 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 22/30] context_tracking: Exit CT_STATE_IDLE upon
 irq/nmi entry
In-Reply-To: <Z5A6NPqVGoZ32YsN@pavilion.home>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-23-vschneid@redhat.com>
 <Z5A6NPqVGoZ32YsN@pavilion.home>
Date: Mon, 27 Jan 2025 12:17:03 +0100
Message-ID: <xhsmh5xm0pkuo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/01/25 01:22, Frederic Weisbecker wrote:
> Le Tue, Jan 14, 2025 at 06:51:35PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> ct_nmi_{enter, exit}() only touches the RCU watching counter and doesn't
>> modify the actual CT state part context_tracking.state. This means that
>> upon receiving an IRQ when idle, the CT_STATE_IDLE->CT_STATE_KERNEL
>> transition only happens in ct_idle_exit().
>>
>> One can note that ct_nmi_enter() can only ever be entered with the CT st=
ate
>> as either CT_STATE_KERNEL or CT_STATE_IDLE, as an IRQ/NMI happenning in =
the
>> CT_STATE_USER or CT_STATE_GUEST states will be routed down to ct_user_ex=
it().
>
> Are you sure? An NMI can fire between guest_state_enter_irqoff() and
> __svm_vcpu_run().

Urgh, you're quite right.

> And NMIs interrupting userspace don't call
> enter_from_user_mode(). In fact they don't call irqentry_enter_from_user_=
mode()
> like regular IRQs but irqentry_nmi_enter() instead. Well that's for archs
> implementing common entry code, I can't speak for the others.
>

That I didn't realize, so thank you for pointing it out. Having another
look now, I mistook DEFINE_IDTENTRY_RAW(exc_int3) for the general case
when it really isn't :(

> Unifying the behaviour between user and idle such that the IRQs/NMIs exit=
 the
> CT_STATE can be interesting but I fear this may not come for free. You wo=
uld
> need to save the old state on IRQ/NMI entry and restore it on exit.
>

That's what I tried to avoid, but it sounds like there's no nice way around=
 it.

> Do we really need it?
>

Well, my problem with not doing IDLE->KERNEL transitions on IRQ/NMI is that
this leads the IPI deferral logic to observe a technically-out-of-sync sate
for remote CPUs. Consider:

  CPUx            CPUy
                    state :=3D CT_STATE_IDLE
                    ...
                    ~>IRQ
                    ...
                    ct_nmi_enter()
                    [in the kernel proper by now]

  text_poke_bp_batch()
    ct_set_cpu_work(CPUy, CT_WORK_SYNC)
      READ CPUy ct->state
      `-> CT_IDLE_STATE
      `-> defer IPI


I thought this meant I would need to throw out the "defer IPIs if CPU is
idle" part, but AIUI this also affects CT_STATE_USER and CT_STATE_GUEST,
which is a bummer :(


