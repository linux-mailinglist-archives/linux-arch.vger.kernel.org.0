Return-Path: <linux-arch+bounces-11605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7A2A9DBCB
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303251BA6965
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45925CC54;
	Sat, 26 Apr 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GFfa5EIf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79ACA31
	for <linux-arch@vger.kernel.org>; Sat, 26 Apr 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680676; cv=none; b=qSXe5hMYsXeGqq5RKsvuYOO4naYiIYIXFgEBXomTowQeAhWDghd/ZCVQSSOnxHlMs1bNdKn2lHoi5zjO1RpB7QlxAAcvXF8t9ghZCXXRhoNg/M7tTkfy2kX2eK+F3k+hpUgD1oVur0K9DDckB8SVs2IrEJiPZVdhDranr3eYPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680676; c=relaxed/simple;
	bh=lwUT3Iv8t9p6mwjxLMSSqUxpKJyupbTKnPyyqPO3ZNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca0fXqlqU05m/R15N613opIBTHG7YhgIqkZVT1Oz7Gq/ovByhvbLdDEgwVrbw+k9cSyYx+KDBMT07n037CSRRV4TZQ3LCluy7zL4M4ptING6EMIHih/tUkpTHiwMPj4iAaAK0ZfrECPEReHFKHEriG15yKtDobxc63Gsf9dwMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GFfa5EIf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac3b12e8518so567629866b.0
        for <linux-arch@vger.kernel.org>; Sat, 26 Apr 2025 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745680672; x=1746285472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNlY1Kyobnrt/7plmlszUhTRPyZa/aNAr5+UYAUEWpg=;
        b=GFfa5EIf2St03hFCcTCErav4/8fHMSzg55cjpzu3/ZspmEy+9eVcq35NWPidR5F+Nr
         VIsnUMp+Y4v1efVipXvyOyex6WrKfCgyN2QI9OpQegIjcVDtkfpi6M3ssHBKhYJNRMfi
         SRZVMg7aXPANkyWImpE8OzEUYf64QvhEbdsIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745680672; x=1746285472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNlY1Kyobnrt/7plmlszUhTRPyZa/aNAr5+UYAUEWpg=;
        b=Rs+vxeDehf7b3PE3iqgwYLiipGyQB0vprWB3zdmEHPboidZyWZUMtBXguvdQU+A00C
         r+chwPtOFO45lYWpXev+NaXVx0gXGOg9HOVIgVYcLgDI+43IrH+GPD1qX6CCzM976h7T
         dJe1jgBWB6GgSKsx6xpxOvmSOMXsXD7tlhTDMfTnpnSoNJu72I9NWrDIYk6e5vITSglx
         EvNieCGRBhJwZIbyczblyB1gFRiUYzQIWyD+AiFFMsR120G4yHe8WSug03fiFiqrM2YV
         lOQiJItomR8rxta+YrsFZhpQrCy8IaUxqVVzFmndmLPjkp+mVeJH8cDSwYcyseiglJTR
         qfwA==
X-Forwarded-Encrypted: i=1; AJvYcCU0pxpu81TeIcHvYq1o0WRgxG8MpS416wm8Q0ffn02gJBBTHkOlRGacAB8QB8z+T+4psk/5hpM85oww@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9m47P4ng/CTF97H+whP4HEf0W5KYGQ2ChY/+uU/++WrFnGXF4
	z6tKoU5/ZYT1zaZ03OeotGCQKLQ/wRVeyMLECaHOz9ie2dIETKnaZxRQ5/xlNoVjQ5deY24+kBe
	pd/s=
X-Gm-Gg: ASbGncvgPrWVQydtVSQ2intXNl4ODNe46qIcp7wUjN3dy3R2l7+wxDl46UZ0P8m17qa
	S+CXDE7uxSJJOZOkzRVJBB0rXyTWH+lVDwKP+sjb0D5srzoWBdjfBdo5R/jpj6ieNw2Hz1rDhF+
	H4AzRIFgiU4h+Lxg7Sv1sXPZchRFjp1wLfLANzbkKfqft7bmzpdEG4swZyLJFPJrXe12wcwcqeL
	+BI6e6wD4AsfJDn1VdQKdAZ56xx7QComZbgnp4oRHCHM3CH80YisV10TP4SZmKRki7sHT+qq5nl
	gedHK9Z5M7rvYGK2831+uQ9aBsHJY07VPsFXWFuI/8CdthfgKR/X51xkQ/Ohk6S+MJBCIJmwd12
	QHmgOsmvHryhTqg0=
X-Google-Smtp-Source: AGHT+IGtJvhKlig99n9H5kXoGxfM8i1Yxk8G6fem7AbWiIdWajTMnoWtGRDHdA2j6BJgNyWGYxTS6g==
X-Received: by 2002:a17:907:94c2:b0:acb:5f9a:72f4 with SMTP id a640c23a62f3a-ace8493aed9mr261449566b.30.1745680671871;
        Sat, 26 Apr 2025 08:17:51 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecfa347sm307563466b.91.2025.04.26.08.17.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 08:17:51 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so5851554a12.2
        for <linux-arch@vger.kernel.org>; Sat, 26 Apr 2025 08:17:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVCma1qSCz1g4q0i8kXuThIu/zShcNDJaDssSXapZLQb8B5TcqyCCALWcqtVPslmxYA40b05ZvIXVX@vger.kernel.org
X-Received: by 2002:a17:907:7e95:b0:ac3:8895:2776 with SMTP id
 a640c23a62f3a-ace848c0439mr259814066b.5.1745680670908; Sat, 26 Apr 2025
 08:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426065041.1551914-1-ebiggers@kernel.org>
In-Reply-To: <20250426065041.1551914-1-ebiggers@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Apr 2025 08:17:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_ArMFL9E9SehR2Z3pfV5QPut0XwbJs9mYWkRvcZcSRw@mail.gmail.com>
X-Gm-Features: ATxdqUFbLPq86s-2TFMi3kWckNkp7TWtoBPlYGSlRtiuXxSXCOJQKui7bzYM-j0
Message-ID: <CAHk-=wg_ArMFL9E9SehR2Z3pfV5QPut0XwbJs9mYWkRvcZcSRw@mail.gmail.com>
Subject: Re: [PATCH 00/13] Architecture-optimized SHA-256 library API
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org, 
	linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 23:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Following the example of several other algorithms (e.g. CRC32, ChaCha,
> Poly1305, BLAKE2s), this series refactors the kernel's existing
> architecture-optimized SHA-256 code to be available via the library API,
> instead of just via the crypto_shash API as it was before.  It also
> reimplements the SHA-256 crypto_shash API on top of the library API.

Well, this certainly looks a lot simpler, and avoids the duplicated
crypto glue setup for each architecture.

So this very much seems to be the RightThing(tm) to do.

               Linus

