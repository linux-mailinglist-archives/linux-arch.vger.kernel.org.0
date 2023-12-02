Return-Path: <linux-arch+bounces-615-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DC1801DC2
	for <lists+linux-arch@lfdr.de>; Sat,  2 Dec 2023 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A0228148A
	for <lists+linux-arch@lfdr.de>; Sat,  2 Dec 2023 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C24407;
	Sat,  2 Dec 2023 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dk4OWgcB"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912FC102
	for <linux-arch@vger.kernel.org>; Sat,  2 Dec 2023 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701534970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yt4yCDhbgJbVqEjZGY+0zrwL/gtoQ/Q8nFWZ1u+3nY8=;
	b=Dk4OWgcBkXHlGbLgD3073nO1h0DSvwLvHkAutTW4Wh7ZZ+jO+8TS3MTp5MHe+ORU8oIdRE
	Fi67cXjLGrZbYv3nzGKTSkiJ3VIx9FNGzRW18+g+Z13lufXdELaQ3GfxiFswly2WWshoDj
	MV0Z0k52dSmi0D1FIogV83X0MyIy0to=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322--H2iPbkXMLaDNaXihhi51w-1; Sat, 02 Dec 2023 11:36:09 -0500
X-MC-Unique: -H2iPbkXMLaDNaXihhi51w-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5d0c4ba7081so56434107b3.0
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2023 08:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701534968; x=1702139768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt4yCDhbgJbVqEjZGY+0zrwL/gtoQ/Q8nFWZ1u+3nY8=;
        b=T8BuTHUiA00npIMfMJaXdJ417Qmx1qjwlkPjIaGR897EyJFe1rRu8QX1OJ2OCkHdyO
         MPaDiPD545+Xe+Oa+D6M/djDAdR3Ik9RknFMzpME5Z4EbkdQbCv52HqbBeO7x7p6YZi1
         oHQFHRNc7M8M2MTn6E9rcuqmZF4Ie8h1BhHoj9xo++Wo7cx265cZyB+KcAvh0VK+y9Ow
         uWXP5Qebf1WoVP3C6APNPZh+Oxsw8cQT9uTQPc/nGPvyLBCqgjIrazoM+RQpJrq56p5i
         8i9za3uli8So4EpCv/621b8wPmCQo/qYTTZF5xP/go2w47u/C4Up7OfdnxrzTm3+Mu8d
         4pHg==
X-Gm-Message-State: AOJu0YytiMP+KiJEaJkfQM7LZSJMq7Hhfk4O/vXOQuhzShkLQFDlmdzg
	UoU0cXpHa0fZDKq2xcUblA6SFvVSrEVKt5+cm8/xo3jfcKM2Tpyh0g9TREVN7q54zxfaw3la0vd
	qYOJr0jcxDtF3ANTlOIwVcw==
X-Received: by 2002:a25:ae8c:0:b0:db7:dacf:59e4 with SMTP id b12-20020a25ae8c000000b00db7dacf59e4mr769300ybj.88.1701534968785;
        Sat, 02 Dec 2023 08:36:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEftyDWBBv+mMnPECb2rVK9oTYatxunIoB2W4Ql4AbzgDHuw14U6JLB0Zeu8QENlNaWlUxpXw==
X-Received: by 2002:a25:ae8c:0:b0:db7:dacf:59e4 with SMTP id b12-20020a25ae8c000000b00db7dacf59e4mr769287ybj.88.1701534968536;
        Sat, 02 Dec 2023 08:36:08 -0800 (PST)
Received: from treble (fixed-187-191-47-119.totalplay.net. [187.191.47.119])
        by smtp.gmail.com with ESMTPSA id b25-20020a67e999000000b0046450681113sm698807vso.9.2023.12.02.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 08:36:08 -0800 (PST)
Date: Sat, 2 Dec 2023 10:36:05 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	Michael Kelley <mikelley@microsoft.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH 0/5] jump_label: Fix __ro_after_init keys for modules &
 annotate some keys
Message-ID: <20231201204400.wckmtoe3kroiyv4s@treble>
References: <20231120105528.760306-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231120105528.760306-1-vschneid@redhat.com>

On Mon, Nov 20, 2023 at 11:55:23AM +0100, Valentin Schneider wrote:
> Hi folks,
> 
> After chatting about deferring IPIs [1] at LPC I had another look at my patches
> and realized a handful of them could already be sent as-is.
> 
> This series contains the __ro_after_init static_key bits, which fixes
> __ro_after_init keys used in modules (courtesy of PeterZ) and flags more keys as
> __ro_after_init.
> 
> [1]: https://lore.kernel.org/lkml/20230720163056.2564824-1-vschneid@redhat.com/

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh


