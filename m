Return-Path: <linux-arch+bounces-9801-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8D6A14C5F
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 10:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BB9167D55
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2025 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512851FCD08;
	Fri, 17 Jan 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHBRYnQc"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA531FBCBA
	for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107280; cv=none; b=NGjIQmZbez3UbqEa2GW/Wyc2BwaLh/782vqBHQ4zJTxRFvtobqbi7Tf4KLwKeEE/9KA3g4thgoRtvnN6cowvnXJ0xr8GVSsRgB8IA4atYgXe9ZvQ8ZsyxbhDzIG1TJtGL23t+P03Hp6hSnKV9IKL8FtuW5PFEvthI2AQ+9+LnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107280; c=relaxed/simple;
	bh=F2gqeuB0aLhR/bzKUvYunwZ5S0liP9KO05qoNp3Tqo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L3F6FuEeV5fRXQrDPcrTP3rWCR9WJtCwyDe3+zgBPPXKj9TQQS8sOcJX6vHX4OmstVefOD5zjXanF7OpxJr7ZAJffyVk1mGROHfH15FZR2E2NNfd+tsU34+KUbl12x0q2Zloe63MYRg/1V7gj+1cPz7SeItQtEMYVKAcQYGtdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHBRYnQc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737107277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvR9KfuLK5jT/0k1YGBwcApH+9cF5PsvBxGMV+DYi4c=;
	b=DHBRYnQclWBz29AczmtdH2psrHQWNAp2LDJjwl32uDPBUSGvi1VCdiDO7Zu95RYG4y3OpB
	9Tebjf3WoGAbLJ64WOQ9vzSA4BycUOWy/bKAHOHksNptStG7BmNFug3JbEo5RGgIFyw1yE
	ZQ5x15X5d61OUrj/+AN5FwVAZ+jtRyE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-hiWIqb_JNBypSvqVmdijAw-1; Fri, 17 Jan 2025 04:47:55 -0500
X-MC-Unique: hiWIqb_JNBypSvqVmdijAw-1
X-Mimecast-MFC-AGG-ID: hiWIqb_JNBypSvqVmdijAw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436328fcfeeso13404415e9.1
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2025 01:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107274; x=1737712074;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvR9KfuLK5jT/0k1YGBwcApH+9cF5PsvBxGMV+DYi4c=;
        b=MZcO/Ur0tlzYtHEasU7hYsMD3EYxz94C+Sh+hj++j6pFCdagRwd0Ux+EOuQOIzFWGw
         BHe1ahN9N187DaTPZzVm4O5lfBXZveGxW+AfGjWitSG1y+4HD4UUEC10p4JoI8vao+PE
         pDuDUJQDIEttksdvb5ANqdNXuMxIF9xwaCwFmm5PEVWxBAP3rouMvWUOVwzC6nSAGoNh
         R2VIWId3oKgQLA/5qYk400YX/KS0uOwdQHk1VdD+KJ9RYxpcoCQwFZhXpx/GySts3Fud
         qwbajzlqIUnxofEkthjq8Eb+vEXwTXAmK5GnL+7WxxBgch2oPTCyNdWpwy51/JzlCfRZ
         3HUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAj8clKMJ+23jAK4JcecQKfejvxNmFY8DwGfaj4PpWtc/Wm0tGumu901yn/7g6jhu79N5V9gQRYW0L@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzceuX4hdxkOMfhFZSX5sjV3bVjn2y0MDG5lSG9gMl/6QJ5SP
	thpmrHe7tjs4n7DR/zmB4wKxpPdFNLmrTgGxzehUT6yEZ/fl32hrMmQuB9RINJJpl03Uydrxpp+
	+sSSJeUgIfUzwPJVFxCO2z4zX6Cal+d4LMAVp3pQKhViKz3bbtBM9GUS/EEM=
X-Gm-Gg: ASbGncuxPrcXr8UPa4t80jP9jo5j7oq6bM5O1LIWovA+1Mf780DPJUh77cEiWCbHV82
	pr6KrC/o1wgc39Cw2vQedimoe0e52QIhy2Q6u0Gg+AKrJ1KsYvLEoSuu8Qo9QAhbcFdCdNlspbL
	6gZ1SU7vItt+fr9Wi24GS9lWOF2zjVDopUy5oFX/bcox/RuRqBnQSiGnmTqrNY7yjgclJnfJB2n
	lOro3iFLYNBR32YHpPMCQbXEUr/fk/ksT2De7lubEYC7kXhz1sUK0/hnIlY0o19W0PB3ct5vLUj
	ne7XE9Sw6nKjOL8ZVGRgmnPlnKf1cSNpp+fwHMoZVw==
X-Received: by 2002:a05:600c:9a3:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4389191b819mr16314365e9.13.1737107273785;
        Fri, 17 Jan 2025 01:47:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHToHDxXT5KMOIEW1byUZUSn/LchRidR5pJg2ZFHbUxu07B2Q/njknWrWkjTXhDYHkp8NfwWQ==
X-Received: by 2002:a05:600c:9a3:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4389191b819mr16313255e9.13.1737107273291;
        Fri, 17 Jan 2025 01:47:53 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904131f5sm27135155e9.11.2025.01.17.01.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:47:52 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra
 <peterz@infradead.org>, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
 Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Kees Cook <kees@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Shuah
 Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland
 <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 25/30] context_tracking,x86: Defer kernel text
 patching IPIs
In-Reply-To: <Z4bTlZkqihaAyGb4@google.com>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-26-vschneid@redhat.com>
 <Z4bTlZkqihaAyGb4@google.com>
Date: Fri, 17 Jan 2025 10:47:49 +0100
Message-ID: <xhsmhed11hiuy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 14/01/25 13:13, Sean Christopherson wrote:
> On Tue, Jan 14, 2025, Valentin Schneider wrote:
>> text_poke_bp_batch() sends IPIs to all online CPUs to synchronize
>> them vs the newly patched instruction. CPUs that are executing in userspace
>> do not need this synchronization to happen immediately, and this is
>> actually harmful interference for NOHZ_FULL CPUs.
>
> ...
>
>> This leaves us with static keys and static calls.
>
> ...
>
>> @@ -2317,11 +2334,20 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>>       * First step: add a int3 trap to the address that will be patched.
>>       */
>>      for (i = 0; i < nr_entries; i++) {
>> -		tp[i].old = *(u8 *)text_poke_addr(&tp[i]);
>> -		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
>> +		void *addr = text_poke_addr(&tp[i]);
>> +
>> +		/*
>> +		 * There's no safe way to defer IPIs for patching text in
>> +		 * .noinstr, record whether there is at least one such poke.
>> +		 */
>> +		if (is_kernel_noinstr_text((unsigned long)addr))
>> +			cond = NULL;
>
> Maybe pre-check "cond", especially if multiple ranges need to be checked?  I.e.
>
>               if (cond && is_kernel_noinstr_text(...))
>> +
>> +		tp[i].old = *((u8 *)addr);
>> +		text_poke(addr, &int3, INT3_INSN_SIZE);
>>      }
>>
>> -	text_poke_sync();
>> +	__text_poke_sync(cond);
>>
>>      /*
>>       * Second step: update all but the first byte of the patched range.
>
> ...
>
>> +/**
>> + * is_kernel_noinstr_text - checks if the pointer address is located in the
>> + *                    .noinstr section
>> + *
>> + * @addr: address to check
>> + *
>> + * Returns: true if the address is located in .noinstr, false otherwise.
>> + */
>> +static inline bool is_kernel_noinstr_text(unsigned long addr)
>> +{
>> +	return addr >= (unsigned long)__noinstr_text_start &&
>> +	       addr < (unsigned long)__noinstr_text_end;
>> +}
>
> This doesn't do the right thing for modules, which matters because KVM can be
> built as a module on x86, and because context tracking understands transitions
> to GUEST mode, i.e. CPUs that are running in a KVM guest will be treated as not
> being in the kernel, and thus will have IPIs deferred.  If KVM uses a static key
> or branch between guest_state_enter_irqoff() and guest_state_exit_irqoff(), the
> patching code won't wait for CPUs to exit guest mode, i.e. KVM could theoretically
> use the wrong static path.
>

AFAICT guest_state_{enter,exit}_irqoff() are only used in noinstr functions
and thus such a static key usage should at the very least be caught and
warned about by objtool - when this isn't built as a module.

I never really thought about noinstr sections for modules; I can get
objtool to warn about a non-noinstr allowed key being used in
e.g. vmx_vcpu_enter_exit() just by feeding it the vmx.o:

arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_enter_exit.isra.0+0x0: dummykey: non-RO static key usage in noinstr

...but that requires removing a lot of code first because objtool stops
earlier in its noinstr checks as it hits functions it doesn't have full
information on, e.g.

arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_enter_exit+0x21c: call to __ct_user_enter() leaves .noinstr.text section

__ct_user_enter() *is* noinstr, but you don't get that from just the header prototype.

> I don't expect this to ever cause problems in practice, because patching code in
> KVM's VM-Enter/VM-Exit path that has *functional* implications, while CPUs are
> actively running guest code, would be all kinds of crazy.  But I do think we
> should plug the hole.
>
> If this issue is unique to KVM, i.e. is not a generic problem for all modules (I
> assume module code generally isn't allowed in the entry path, even via NMI?), one
> idea would be to let KVM register its noinstr section for text poking.


