Return-Path: <linux-arch+bounces-8182-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA6C99F13F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 17:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547561F22DC1
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E281DD0FB;
	Tue, 15 Oct 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuK9DjVk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB51DD0DF;
	Tue, 15 Oct 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006285; cv=none; b=JFpXNSRGiFGeEbJhvKN9Uzl1CbwZmrmfQhSmHZJldznLIp40zTegr7GTP1PXhkkoN+b+FfB76/dM5i4mhpiCn8c8vNJ36g36nduu/F+r45R1zWxlecFLIka6QGyDTB2REK2W58QHTcJ+F+f6EOx482UN1U4KMPRg+/KnAMRJr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006285; c=relaxed/simple;
	bh=XYJf7hrcLT7Ow0dgGMK3ItjJvo1qX/WLHMjBflskpp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQ3goPXzUCyoi7KG8YZhEarDQcKguEsyyYR25mAXMqDGZigHr/1SZns1zqOV5Q1e5QIYrVC6ZjsJpGsnHnJBUJ82hWzkQ5G/IQYGWLeDxA6Lu5Y+JXFrHuDW0854vlTJGumWlSnJ6CevEb/zGGk7aD0lkmFY2huOFct0NeTH57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuK9DjVk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c83c2e967so4569645ad.1;
        Tue, 15 Oct 2024 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729006283; x=1729611083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYJf7hrcLT7Ow0dgGMK3ItjJvo1qX/WLHMjBflskpp8=;
        b=GuK9DjVk64kafU2trISty/DJmJ6dlByLrc/IqM4E4aJeI+yh2M7hN3GJcVNrIYzmDd
         zO/bBcjX2bFQxpnBoTsMTIQgBRQ3lqWDRTuqhx+BE1X2msmjFTxuF2moBAoSQKgeMifh
         71I+d94Lykl6gzxwHrvj/TL3kTA7wauv2QIdjEYCHq7iuBOoLgbw7U73e8Ia1sllAjSd
         73ZvY4xGyKnfw1RhnhfRidSNpTeC/g78TZ7/SPperExO3Yhq6SbI9qS/Q7x4R3+zwJ23
         a7O5b2HhU2iV8moc2BVwKrStd+88mztUqt8t0iu5ELdWCTJgWugTo/yOurpR80yEypl0
         Y7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729006283; x=1729611083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYJf7hrcLT7Ow0dgGMK3ItjJvo1qX/WLHMjBflskpp8=;
        b=MU4TAbvn7sHns2txCtHflhXQkvsNTRmoRYPSxiBzopNLU86SDufsa4PZh7NyyKXDEE
         nrWtNR/P8VVjBkda/4z3FAQU+yEZD4sqEH8AWBm8Cud15ygpRF+WoZ6ctfwqNpdnuDtc
         faSkRLNLsK/pst08mfEdhc+8mvwd/R5erO9B2mAAjZO5SnA/2iCtsATrWX7ROgrQ2woX
         S4kApeysAPf17/O9LP1YKdW2AJ0EqMA7sQdvvemXY3mLsJYhsVLMUIW46rozXtyCbT9/
         D2MZYstQsdJPOJ6fH1pR5Tu5+53f08Tbz5YaWF4M111FRNIbuqrenNndD+VH7isHLbBK
         qLvA==
X-Forwarded-Encrypted: i=1; AJvYcCUiq0/7u1auK6zczJ0h1/B1iEWy7HuGmDRPKfnawqWlndtkc9SJ0GZpPwyQtkSWlS+HZnsz5BS/T4c7U3PVt5I=@vger.kernel.org, AJvYcCVBQKPnJfpePCp1lEhnE1mbYy1w0q3oWhY3GNKu0OZ5KWl5SSic4IEAdjXwUpbJZGN3dyAFuHVn1mfwcx+2@vger.kernel.org, AJvYcCXCpE1Sj/4TuQ09NSHz7iAwKyavQGPOTMeVx2qi2J3d6fW/r+hFe13ey+4GS0m3pSMW5uQ0yLxiwaw3mavyBvyY0IgK@vger.kernel.org, AJvYcCXRbrPILczxCpYJ/Xza7bCX9toOsM5wYQtsPUC3WdEBcqmZwK/Y0uf+7EoqGD8tw1EmsWc6lphjc7Il@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfPfAZEngGHbbhmR06AA9GVxwkGC+cZTjVeqHFBZAYIXyHN5g
	E5eI/y/pNVPh3EnMIycgjqRXx4Qln0SsBuSfaNMvTSjL8tJn0jlnvmRBxPYG7jCPiQdZlO42+PS
	KNvp/nA3YAuDhs1ajE4hgNfBY92c=
X-Google-Smtp-Source: AGHT+IFgGW52eztBAkDuewDmtmXhOGFk9GZOZdh7DbttGzN3ZkEhOvpiLgnEe8CkavcbYb8B+mBuvtNrTixMpXJBb9s=
X-Received: by 2002:a17:902:c402:b0:20b:99cd:c27e with SMTP id
 d9443c01a7336-20ca1425487mr86305455ad.3.1729006283310; Tue, 15 Oct 2024
 08:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-tracepoint-v10-5-7fbde4d6b525@google.com>
 <202410151814.WmLlAkCq-lkp@intel.com> <CANiq72nn6zv9MOD2ifTXbWV3W1AgiXL=6zTX_-eGL5ggLj4fbw@mail.gmail.com>
 <CAH5fLghJrrq2nJu7S08bBg2sAjdibkZ4D14K9cqETafnr4CR4w@mail.gmail.com>
 <CANiq72kRiQvw3xWbMGRxcVJhHN0LMRa0RewxnkofVr=71KQvEA@mail.gmail.com> <CAH5fLgjFFmm-m8=4Qbad6X-EOjKfCytE3ncevO1u-sSn-jJF9w@mail.gmail.com>
In-Reply-To: <CAH5fLgjFFmm-m8=4Qbad6X-EOjKfCytE3ncevO1u-sSn-jJF9w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Oct 2024 17:31:11 +0200
Message-ID: <CANiq72nHnecUS1H2t8AMx1oyY8j35HcEzMxeZDTp2aqjv+qksg@mail.gmail.com>
Subject: Re: [PATCH v10 5/5] rust: add arch_static_branch
To: Alice Ryhl <aliceryhl@google.com>
Cc: kernel test robot <lkp@intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:46=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Too late! But I can do that if I send yet another version.

Yeah, I meant after the one you already sent :)

Cheers,
Miguel

