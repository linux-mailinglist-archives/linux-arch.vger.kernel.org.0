Return-Path: <linux-arch+bounces-14437-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F98C24DC9
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C461A2366D
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 11:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34894347BC0;
	Fri, 31 Oct 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLW/68ZH"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C85347BB8
	for <linux-arch@vger.kernel.org>; Fri, 31 Oct 2025 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911585; cv=none; b=XLij7C5ncNUCpP48Kb4nAb5M9Q/gfQc3KNLE2rRDUrJaq+Xg+vWNtIASOwLCk2FNmdTslyyYXMM2XYjekKjZ0Ov6UPAlvNyBP3fl/lclcvNARedzQ5Pg5IiP/n7culqLFcDFWxsLgb0IFvWqgRxf4EwxDylZxmToZHUJ3WTcxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911585; c=relaxed/simple;
	bh=6fzFmvYYmy0FD/zsZjCIHvVy5pIl85gYKYFQYc5ntms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+2NOTwwRk6n276/vMw0LKyQZfu2hDbCCm3Iikt1PXyfsdGODnxG2B+zNKNA0pnKszDs39SsIv9dsWI57A6TMb8ceEfV5uK2p3/h7vf1wJXha5qUTSaUsrZeCRxhC6Kbju/9KtvDkS1+QDVSYDzs0fJSlFMFTTraJInzN6ZKC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLW/68ZH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761911581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTUIS93GUZsQyg4tbyddEkDWsI2/kBv/P3HZONFfij8=;
	b=VLW/68ZHSgBq5lCtIBt6zBfYUUL9IMbTYLjZAqwK/FhqjF+QAXx3GTgJuMBL3GSVIzTNtD
	LkNkGQjSvlhnngMQwMoTJIMtampraNBpsyA+MGl4E7l8zOtU4XE6QYh/GSciXnW1xubfiQ
	5jnxJTDgQ9z0DxI0INAjX7EOwrYO8QY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-088sPeUtMymjkCQ7an03VQ-1; Fri, 31 Oct 2025 07:53:00 -0400
X-MC-Unique: 088sPeUtMymjkCQ7an03VQ-1
X-Mimecast-MFC-AGG-ID: 088sPeUtMymjkCQ7an03VQ_1761911579
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42814749a6fso1856541f8f.2
        for <linux-arch@vger.kernel.org>; Fri, 31 Oct 2025 04:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911579; x=1762516379;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTUIS93GUZsQyg4tbyddEkDWsI2/kBv/P3HZONFfij8=;
        b=kAXwFSKhASKgoZbs/jfsVwuoRvQzKy6zaQXORcPFKdFoDXUfgJ2xxx1E3BmIurwNTE
         F69UXNEgxX2dKoQn9+lYcip/lmgdB98c+aQEkLI9flHvgwEF0AGIX76gMGf1nemkx6IV
         Wt4tnjuI+LCb0eZjGtXTBlgg/GxFEqVX8E70XBJtZuyLEqOtixeKXFozGrOB/xUBgKHd
         2QC0UqOfmnTes+bOSdZPoJvbjw8Mn9l7mtTW16A91EE71Nb9PYh1viK3RpTX4VXLE1uq
         ZpVtvDhPQUntISFuq/IICXZJdJgpC3wHM8xTA9LfO+cm0KcPOOlKL23lZ24xEMUlyxWn
         0wew==
X-Forwarded-Encrypted: i=1; AJvYcCV4bStWItfH+zoefB/IlLp+oV+0L20S7e1DUVwQltDUsBbjQOQH4yKw/KEj5Q8mh9iIzhHSJBGEW8Fn@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPkIHelw8T05SRNDShwlPYG+670TNKqoOBX57HhbSsIvHOSJZ
	0N/yCSQacU5Cx7lOlu+BguaT12nxFIHu/P/cGiCGjVhQjQrc7EkTkxkE9QUdVCGOOQSqZNKpaqP
	4jqw1BNqlBgM9EAZB4dFQziO349zY4sQrPLmyN7y4piGRkpDow4rp/mqVQnS2HWo=
X-Gm-Gg: ASbGncuDq9xQs1wBPb+V7rgXY488i4VC5Uh4Ug3rx8Ww3T/Jv2qXmu0eu9H692gT0Rz
	fcJcZtRh0J7p6R1J80/UYO5wut6nnhlZp4NlcbUVUtme++p3sIS4l9nM+bicGmQYT3SsP5hgp1Q
	upsva7icvhtxSP1+BnGIYbTKREhzrMVDK09MpiQuVnsbRlQTOh9Vbr8eTOAgg8dyOiQwZw1PL0o
	QKfQvzQmoWqN92/os8QpUI5hgFv+Bs/kj4j6X7AKy2/3NQ8w3VbrNB4cZDtf4ZKYsGLMwTFTIsF
	lcgURMlU+dsr4UOPaH0fnWA706IHNmUSNKM3L1UWUOQpw9NOy7vmbXCieATbNYzTiR4tBAN60j6
	d3n/T5DdfDMvRoi4joixmqHt6i7IOW0peeoaXJ9Tr86pmfkpUIkTD9FTtcjE4
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr2912808f8f.10.1761911579309;
        Fri, 31 Oct 2025 04:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1wuetlLZ34asXy13r1bfmujThSOSUu3cZmMHhgfxqrER8G1YsbbHDsXHGv7ziQ36i83pqkg==
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr2912761f8f.10.1761911578857;
        Fri, 31 Oct 2025 04:52:58 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1142e7dsm3186896f8f.17.2025.10.31.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:52:58 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S.
 Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn
 <jannh@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, Oleg
 Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Clark
 Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v6 06/29] static_call: Add read-only-after-init static
 calls
In-Reply-To: <20251030112251.5afcf9ed@mordecai>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-7-vschneid@redhat.com>
 <20251030112251.5afcf9ed@mordecai>
Date: Fri, 31 Oct 2025 12:52:56 +0100
Message-ID: <xhsmhqzujp9t3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 30/10/25 11:25, Petr Tesarik wrote:
> On Fri, 10 Oct 2025 17:38:16 +0200
> Valentin Schneider <vschneid@redhat.com> wrote:
>
>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>>
>> Deferring a code patching IPI is unsafe if the patched code is in a
>> noinstr region.  In that case the text poke code must trigger an
>> immediate IPI to all CPUs, which can rudely interrupt an isolated NO_HZ
>> CPU running in userspace.
>>
>> If a noinstr static call only needs to be patched during boot, its key
>> can be made ro-after-init to ensure it will never be patched at runtime.
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>> ---
>>  include/linux/static_call.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
>> index 78a77a4ae0ea8..ea6ca57e2a829 100644
>> --- a/include/linux/static_call.h
>> +++ b/include/linux/static_call.h
>> @@ -192,6 +192,14 @@ extern long __static_call_return0(void);
>>      };								\
>>      ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
>>
>> +#define DEFINE_STATIC_CALL_RO(name, _func)				\
>> +	DECLARE_STATIC_CALL(name, _func);				\
>> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
>> +		.func = _func,						\
>> +		.type = 1,						\
>> +	};								\
>> +	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
>> +
>>  #define DEFINE_STATIC_CALL_NULL(name, _func)				\
>>      DECLARE_STATIC_CALL(name, _func);				\
>>      struct static_call_key STATIC_CALL_KEY(name) = {		\
>> @@ -200,6 +208,14 @@ extern long __static_call_return0(void);
>>      };								\
>>      ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
>>
>> +#define DEFINE_STATIC_CALL_NULL_RO(name, _func)				\
>> +	DECLARE_STATIC_CALL(name, _func);				\
>> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
>> +		.func = NULL,						\
>> +		.type = 1,						\
>> +	};								\
>> +	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
>> +
>
> I think it would be a good idea to add a comment describing when these
> macros are supposed to be used, similar to the explanation you wrote for
> the _NOINSTR variants. Just to provide a clue for people adding a new
> static key in the future, because the commit message may become a bit
> hard to find if there are a few cleanup patches on top.
>

I was about to write such a comment but I had another take; The _NOINSTR
static key helpers are special and only relevant to IPI deferral; whereas
the _RO helpers actually change the backing storage for the keys and as a
bonus are used by the IPI deferral instrumentation.

IMO it's the same here for the static calls, it makes sense to mark the
relevant ones as _RO regardless of IPI deferral.

I could however add a comment to ANNOTATE_NOINSTR_ALLOWED() itself,
something like:

```
/*
 * This is used to tell objtool that a given static key is safe to be used
 * within .noinstr code, and it doesn't need to generate a warning about it.
 *
 * For more information, see tools/objtool/Documentation/objtool.txt,
 * "non-RO static key usage in noinstr code"
 */
#define ANNOTATE_NOINSTR_ALLOWED(key) __ANNOTATE_NOINSTR_ALLOWED(key)
```

> Just my two cents,
> Petr T


