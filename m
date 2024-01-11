Return-Path: <linux-arch+bounces-1334-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA0682A858
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 08:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C45D283AC5
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jan 2024 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A54D28F;
	Thu, 11 Jan 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj2GJVKu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3413D271;
	Thu, 11 Jan 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbe1560c5b0so553695276.0;
        Wed, 10 Jan 2024 23:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704958265; x=1705563065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4T5oinj6i4RtpTG4VL9LZbm5pLTPQsWr68EJIfiHeE0=;
        b=gj2GJVKu3oRFYgsgTlbcc+ZYy8RJbcKnlqQolsg7ox8TDv5Vn1/TfXmZdMVquG1iO0
         Hm/86EFyQv6YIe8YE5mTHenFTP8jhH8ESmvKIvoYjaNJuLlVToSf2X8cIhCJwSf7phDh
         Grf+ffalQfFrJRD1S22cXmzIbpK1kMDIYH8D3gW0F4cGviwh8tqvLghRLbiYK4+0XHje
         x0cOf5snxjHAGbTuO3QRnPvzSeDi5y4CnSUs8qFmwyKponMJKrEZsQbQrOiT9PdfRzHR
         jCeE9n/w7IQAVQIwHQydVZJUDzP26EQfqEpg3XpWTq5iGMWhbvvzbpM6EaXNVnre3e1v
         HKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704958265; x=1705563065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T5oinj6i4RtpTG4VL9LZbm5pLTPQsWr68EJIfiHeE0=;
        b=fwwG1aoKIMz6Ss3oNQeiWGTeq50QBnYoDgJAS7BPqyAO2xLSWzPfkogAmGS2osZEl1
         klHZacaOu+q51SBkkVZsz24NrPqak0h/nswp0YG+fKg/fZw07cCpF/0/KuxSSKxA604H
         6nmqdhSiAvjXfnM1TVRDzIq9KJ4RmfU1+T3/FNKSt1B0Ve+pxLaG6h7iLMU1t76ch2K8
         AcdS3MkXX46NCe1+ckvolVFOaJZfgBmtL4BBTZsSnZ2uNLAIdaBF5oz2rWglz4i9O6NI
         bgzQPuiimDRZP/6L7AYnTRip27Em0IWQHfGuHMylByN1/Sqgdxw9mXLpJ1lmQqpqqWUB
         YCxQ==
X-Gm-Message-State: AOJu0Yx60h19VX4lUsApi100ZoB9WkZmiJV6R8Kde3zh9fOecHuD76Ns
	8Ahj7xv4y221NfJ6H/XRccgyYt03n5E=
X-Google-Smtp-Source: AGHT+IHFyUhcUtqRSzpWm/gnjXz+qEZoFool0wFoHozXJQggC1lFv7etZ+nxppAw9wp+cAbX01nF8w==
X-Received: by 2002:a81:ae43:0:b0:5f0:7272:c243 with SMTP id g3-20020a81ae43000000b005f07272c243mr1249913ywk.5.1704958264821;
        Wed, 10 Jan 2024 23:31:04 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id g189-20020a0df6c6000000b005a4da74b869sm200083ywf.139.2024.01.10.23.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:31:04 -0800 (PST)
Date: Wed, 10 Jan 2024 23:31:00 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, Andy Lutomirski <luto@kernel.org>,
	tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Nhat Pham <nphamcs@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
	Kees Cook <keescook@chromium.org>,
	Alexey Gladkov <legion@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] posix-timers: add multi_clock_gettime system call
Message-ID: <ZZ-ZNHgDsZwg9CaW@hoboy.vegasvil.org>
References: <20231228122411.3189-1-maimon.sagi@gmail.com>
 <f254c189-463e-43a3-bc09-9a8869ebf819@app.fastmail.com>
 <CAMuE1bF0Hho4VwO6w3f+9z3j5TtscYzuAjj10MFt2mZXG2P8dQ@mail.gmail.com>
 <84d8e9d7-09ce-4781-8dfa-a74bb0955ae8@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d8e9d7-09ce-4781-8dfa-a74bb0955ae8@app.fastmail.com>

On Tue, Jan 02, 2024 at 12:29:59PM +0100, Arnd Bergmann wrote:

> I think Andy's suggestion of exposing time offsets instead
> of absolute times would actually achieve that: If the
> interface is changed to return the offset against
> CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW or CLOCK_BOOTTIME
> (not sure what is best here), then the new syscall can use
> getcrosststamp() where supported for the best results or
> fall back to gettimex64() or gettime64() otherwise to
> provide a consistent user interface.

Yes, it makes more sense to provide the offset, since that is what the
user needs in the end.

Can we change the name of the system call to "clock compare"?

int clock_compare(clockid_t a, clockid_t b,
		  int64_t *offset, int64_t *error);

returns: zero or error code,
 offset = a - b
 error  = maximum error due to asymmetry

If clocks a and b are both System-V clocks, then *error=0 and *offset
can be returned directly from the kernel's time keeping state.

If getcrosststamp() is supported on a or b, then invoke it.

otherwise do this:

   t1 = gettime(a)
   t2 = gettime(b)
   t3 - gettime(c)

   *offset = (t1 + t3)/2 - t2
   *error  = (t3 - t1)/2

There is no need for repeated measurement, since user space can call
again when `error` is unacceptable.

Thanks,
Richard




