Return-Path: <linux-arch+bounces-5287-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FA1928D37
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40732846AB
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA8116B386;
	Fri,  5 Jul 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y2a3vqQK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54116A930
	for <linux-arch@vger.kernel.org>; Fri,  5 Jul 2024 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202331; cv=none; b=T67gZI+e6pEPMkiYpmmD0D3ozwkR6MwQ+Z5Hq/KD9G3CJovQKYXSEb8riVbfDYySt+O4nVeFZLGVoZ6dQ8U6qjLvlLkAY9fIhpFh/P/QcOo0gpXCBojI7LbzdaD4rQWsyuNCVK9qEraNU3D2Ev7d7kP3wqxrm4Sxs4lCDEtIrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202331; c=relaxed/simple;
	bh=U4Q9iUsIHozn979/PFNpyG7JLQXeBFWhmeQepI8slGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQ3Y2uvfXNpXBhLvBMmAbAmb5E73Zg6iJbFIUJpgo3zDGniWOeoG+uPXJXL41SUqoYGzO+nAZN+qKIba//qAU/WM7BCV4OPNHhtQGRK4//M8pVfu4R23ko78TKCt3dQx5PmTgvPRXIBHzoMyc8dWbE2WssdjqZUq2zxOKiI9KsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y2a3vqQK; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-810173a1d0bso590185241.1
        for <linux-arch@vger.kernel.org>; Fri, 05 Jul 2024 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720202328; x=1720807128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6rchAFSlYahM896I1I/OZo7qd5XWpA7Aq79k25WOCCE=;
        b=Y2a3vqQKEhE/SBQ49X4OUCp3yYb/Kvf4B/DqjqbYLrTr1qB03MoxdwSZgMNVZFPnYO
         hn6sss7nUP54OG+RHRhvibE2BF9S4LKxzAxSJUtI6mLCVswSc4fzvzt1cyQ3fsS/uSp/
         iWoLqAnRbuaL3dAUMapCHzByTDa5v+a7gNj5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720202328; x=1720807128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rchAFSlYahM896I1I/OZo7qd5XWpA7Aq79k25WOCCE=;
        b=cqYYkE8DRD5LSZ4mv2pQcPwRBEmy7AgVAC2md1RDWVLdHr+P6kElnMvMTSjunchfKo
         oNmDgcytkT2Z5suBKccZULmZWhMrQRFBUX3F6HcCoFyTJcQt7HO1OSCLa/AOrVwjn1Oj
         KOe7OmjoXkCmqoENUDcH9zmb3mNxGAeJJ3W2foCNyDc0E37h1bceYnKVmlypkaLGjBnI
         CY6S8959sqbXTVcl07uoi9YJobgn0lWSBZTXH8IwXF2oFYYqgrImW5ddnwoiMIDI9EmU
         bjtlPvhAQ+/ECTOSlBsrLik1E+lsFHx6aWvSTwndsrrntpxKVd+73nk3WRNIE34sDj2v
         +mKA==
X-Forwarded-Encrypted: i=1; AJvYcCXumgWpWp19MCjaM6RViu8HDa1h3YM66qBeI77X5arVf7FYsk6DBwSy1nDGDVGJs/ql/UM8L3x13OnZnzL1SBvqlh5s80cxUXBYFg==
X-Gm-Message-State: AOJu0Yw1RLngT5Adxoo35Qdn1RZKZ9WTbhWlI7wbqFwlUsDPfvK3tqBF
	1ymiI6+l5zQilyJsLrwQQW5wbryBGZvJBdV3uzQHTKr4p4g1zhD9IOLS7iYu1j0Stz9RbgaYTaF
	tSsWk0g==
X-Google-Smtp-Source: AGHT+IGbt5tGoW9Rhx3pUhmK2w2lslezx9ZqzId95PImkw92KZ3xuLymryNA2lYK4s6NZvl6+tuU5w==
X-Received: by 2002:a05:6102:364d:b0:48f:9dea:bec6 with SMTP id ada2fe7eead31-48fee678416mr5877616137.18.1720202328535;
        Fri, 05 Jul 2024 10:58:48 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48f9b2a4617sm3081012137.28.2024.07.05.10.58.47
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 10:58:47 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8100df48323so517852241.2
        for <linux-arch@vger.kernel.org>; Fri, 05 Jul 2024 10:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUy0S5WCYy9u3EUbK3pQXs3bLpoLQeYXzMlp0qrA4e+tRiao1Oa7siAkHupbh0vCdDIHmJBpxOnYvUQJ3CKq8MMnOjwN8sLIlN7jA==
X-Received: by 2002:a67:b902:0:b0:48f:b577:e02d with SMTP id
 ada2fe7eead31-48fee7dbfaemr5668127137.25.1720202327405; Fri, 05 Jul 2024
 10:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625040500.1788-1-jszhang@kernel.org> <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
 <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
 <CAHk-=wiv=9zGSwsu+=tKNgDg8oBUJn_25OEy_0wqO+rvz7p8wg@mail.gmail.com> <20240705112502.GC9231@willie-the-truck>
In-Reply-To: <20240705112502.GC9231@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jul 2024 10:58:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRgDy8_=uZPZr4LRyF7BiN1nDNzUx7iRzrD0g8O+bh3A@mail.gmail.com>
Message-ID: <CAHk-=wgRgDy8_=uZPZr4LRyF7BiN1nDNzUx7iRzrD0g8O+bh3A@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
To: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 04:25, Will Deacon <will@kernel.org> wrote:
>
> we'd probably want to use an address that lives between the two TTBRs
> (i.e. in the "guard region" you mentioned above), just in case somebody
> has fscked around with /proc/sys/vm/mmap_min_addr.

Yes, I don't want to use a NULL pointer and rely on mmap_min_addr.

For x86-64, we have two "guard regions" that can be used to generate
an address that is guaranteed to fault:

 - the kernel always lives in the "top bit set" part of the address
space (and any address tagging bits don't touch that part), and does
not map the highest virtual address because that's used for error
pointers, so the "all bits set" address always faults

 - the region between valid user addresses and kernel addresses is
also always going to fault, and we don't have them adjacent to each
other (unlike, for example, 32-bit i386, where the kernel address
space is directly adjacent to the top of user addresses)

So on x86-64, the simple solution is to just say "we know if the top
bit is clear, it cannot ever touch kernel code, and if the top bit is
set we have to make the address fault". So just duplicating the top
bit (with an arithmetic shift) and or'ing it with the low bits, we get
exactly what we want.

But my knowledge of arm64 is weak enough that while I am reading
assembly language and I know that instead of the top bit, it's bit55,
I don't know what the actual rules for the translation table registers
are.

If the all-bits-set address is guaranteed to always trap, then arm64
could just use the same thing x86 does (just duplicating bit 55
instead of the sign bit)?

               Linus

