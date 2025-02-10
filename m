Return-Path: <linux-arch+bounces-10077-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D131CA2F568
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 18:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CBE37A1E96
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FC9255E53;
	Mon, 10 Feb 2025 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNVef/C9"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5402500DA
	for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208991; cv=none; b=JKJb9nMkp320gH0KpvW27uhR5+xydXjwyQGHKB6pKAAjxjbEZeZdzicYx1o57Oh+FHgakWF5rplyFhaaWOuMV1+5tCD14sLgQIlnAn+lGJJLnCTmKmpC1GgXxlaiWVjhlIIMhF7JCe4My6TKtvsZB8kCdT8v1QqhfzJhX8JgZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208991; c=relaxed/simple;
	bh=u+xBAfgGtWSjK+lShNplBj7ifal6E7BNbQMyEHGnBJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=boQB6klf3HjtLQvndd3ALZ8IQsCP5SkIsd8RRMY+t/gNSnroApBmIbqzuVvnhCn6lyeH+j75Iq0vZpG9vDAJk/nmDnHxMVg5ElLfPADV8+Q/bBYmhlbbIXa8Ms0fuAT8UxaOnFGbB6UTK1YM8PP3nCZryZ1ndvU8QcuqiUjrpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNVef/C9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739208988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmeQoovG0+h8NkGt8mJ7mUN4l2oR44byLjbsSTWDllc=;
	b=TNVef/C9tVl7GrjDDWrrk4hKqiVtvBdY+TNx20ou+2MVywJjBiuRS+LAdusTTRCqabnRrS
	2SiqpNifaNfl25SlyrgBFL3GpF+iEYwRuIyGr0R8M3DIJp2CSXAawX3L6JXmi/qYw5Lo2e
	q6z9McKvrk7zmUsoFCctS6WLdDv4p8Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-Bx-aS0_HMB2L3RckBgmDsA-1; Mon, 10 Feb 2025 12:36:26 -0500
X-MC-Unique: Bx-aS0_HMB2L3RckBgmDsA-1
X-Mimecast-MFC-AGG-ID: Bx-aS0_HMB2L3RckBgmDsA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dcd8ddc5eso2143211f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 09:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208985; x=1739813785;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmeQoovG0+h8NkGt8mJ7mUN4l2oR44byLjbsSTWDllc=;
        b=vLy8uAD5BbrKM5u21hNrTKJvN7ca8XgrDQy1wFT1rxUx7BIeG33WQG8CQZG3pXdH9I
         n+FkDFaWUWdI6YXODAxC891Dm2sR/igKAUZxNlKzL4lxSiMmbPSG9cjJEffjoLUCYr2q
         AHEOpALwvdvGnBB2lr9YIH6bsH2RfNUd1cphKxXBqTv22TrmL44EfXI2G/9q5R3WpHKe
         M412+T9Z5DwQHvDtxSEgkZvXq0sdE/5Srllaa+S300O4hg3t5h/0aQgvSVlOLvQ7GPhj
         41//m7ZTseFrGep02MutOgXwFXOEatftw515mAJV3BfYiiNKR6BuvpfhkyZYcOgzpsE4
         koKw==
X-Forwarded-Encrypted: i=1; AJvYcCXbSNfGLXsuLphiCV0Z4lkoNAYlsZ8IERGjMT9cRyAr6hLDHiKAQ6vnYgIXIs1AaoMToCODmLDlMAyu@vger.kernel.org
X-Gm-Message-State: AOJu0YxtA41kOIzXSCkN0CwRvTcfHW9axeepX01di9YfCVy5skRgpILS
	HInj99QdyK0niJZO/tNz8SWX1WRoWLj5rLmIKtbF3lNViQDArTbmX+VNnKy/SxU563w+ruscOkf
	ttJ2iOqUfcggRzi+fdBTmjjUHpiZVJe4rq76xX4Ks+bmtKVJkNuu2EDKeloQ=
X-Gm-Gg: ASbGncvvYRzZ7Zopw9us96tvW3M2Xcye5+HjRiKw1lCF1dUkPayeWUSzSY5p4AYZmO+
	awZ+bkvnao6l42Eru5hLPid3z7t6i/L/je8K/bRZq/6cT5TdrY6OlIOVsuoeDQn9jQl01m1mqkK
	tTfRADsiScmFfDUIQbBhALIpRjYOG9iOvvUZrAPth04Pp0cFHw/W+vgKteGDhisUhH+UJ77w9Ir
	p2iU0YjSQJC0tdBb3ttSINoCpS0v5mDi0xONcAj5d0EYQqsMClf1xoKYfh26xNK6djGLv8gwvYB
	zQeHMDFJy1iefbRVM66FbNg/9eh5UE0d5zQnHw/2S+ZuNF6Tc5euDYd2PqKD7ckTGw==
X-Received: by 2002:a5d:598f:0:b0:38d:e250:d953 with SMTP id ffacd0b85a97d-38de250dbabmr3058662f8f.35.1739208985404;
        Mon, 10 Feb 2025 09:36:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxfTkrMg3Ut4KvVNhGVu91A0XAdGHvAD9T0QbpHzfP2OmSPgOw5f7LxHQ3fWHxL8NqTxJ5mQ==
X-Received: by 2002:a5d:598f:0:b0:38d:e250:d953 with SMTP id ffacd0b85a97d-38de250dbabmr3058583f8f.35.1739208984820;
        Mon, 10 Feb 2025 09:36:24 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf2ed900sm12687106f8f.53.2025.02.10.09.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:36:24 -0800 (PST)
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
In-Reply-To: <Z6ZTBXUiEOLVcSKp@pavilion.home>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-23-vschneid@redhat.com>
 <Z5A6NPqVGoZ32YsN@pavilion.home>
 <xhsmh5xm0pkuo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xhsmhbjvdk7kq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z6ZTBXUiEOLVcSKp@pavilion.home>
Date: Mon, 10 Feb 2025 18:36:20 +0100
Message-ID: <xhsmh8qqdk8h7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/02/25 19:37, Frederic Weisbecker wrote:
> Le Fri, Feb 07, 2025 at 06:06:45PM +0100, Valentin Schneider a =C3=A9crit=
 :
>>
>> Soooo I've been thinking...
>>
>> Isn't
>>
>>   (context_tracking.state & CT_RCU_WATCHING)
>>
>> pretty much a proxy for knowing whether a CPU is executing in kernelspac=
e,
>> including NMIs?
>
> You got it!
>

Yay!

>>
>> NMI interrupts userspace/VM/idle -> ct_nmi_enter()   -> it becomes true
>> IRQ interrupts idle              -> ct_irq_enter()   -> it becomes true
>> IRQ interrupts userspace         -> __ct_user_exit() -> it becomes true
>> IRQ interrupts VM                -> __ct_user_exit() -> it becomes true
>>
>> IOW, if I gate setting deferred work by checking for this instead of
>> explicitely CT_STATE_KERNEL, "it should work" and prevent the
>> aforementioned issue? Or should I be out drinking instead? :-)
>
> Exactly it should work! Now that doesn't mean you can't go out
> for a drink :-)
>

Well, drinks were had very shortly after sending this email :D

> Thanks.


