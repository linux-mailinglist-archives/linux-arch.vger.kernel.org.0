Return-Path: <linux-arch+bounces-7462-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6C3987AB4
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 23:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5392C28447F
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 21:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860118871A;
	Thu, 26 Sep 2024 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntYvYQ3V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CC418870F;
	Thu, 26 Sep 2024 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727386525; cv=none; b=goQJBRrRmkqgtyjkuhqlNcfmLj145m638QfMynP66R43xq6hJqSxjzhA8mNlnbjBMWTuMILU4IVk3/QPtjSrXfnqFiq2HMebgSRVsQUs3mGhHBrNS4jgvbvo/xy4oBf2W2O2Td1+LceQFE4HnFVUeN2lwoBYmSqXToaT/Dy9xvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727386525; c=relaxed/simple;
	bh=1/AF0ye1aEDqbRIMOiqu2UP5rEYyIqLBgduhnkT/Gq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBJfh/5Z7VEQxAgZ34fM/Fcum9KV9uRA4YIPjdwVhv1SKHj5FlBKtaFrY9UklpOXb6tj9a24Ppj0UNskaOvLs1phEpW4M0T3GA05X3E3GzoES+ZHys+EPON/W5TX4FRw1SnZ4EYkHV1ZwW9wX5nfulw3klh0rZgUbhtG3nAQFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntYvYQ3V; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e0b467da03so91493a91.2;
        Thu, 26 Sep 2024 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727386523; x=1727991323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN3ZIl0AHdW2Pc3ccHhFRbQ1ihSm5IEdT9WChsNSY6k=;
        b=ntYvYQ3VzjrPQRjO0RTjOTbXP7/4NP5rjwPgNkr9vH/XeTJuyjkJQ6j8P1Q5+uxnST
         F3wPdxptRRuXH4IYlyP+1oLBMPEpsloYKCpFimcgj0k4lN/GD1KdZTGRrH/xAwUoC1V3
         rJPs6Qhurc32eEX7Nw6W0yg9ypx4H8Kn2SL2FF0rDnTsbAewQk6cqpJ0OzCNZ9fG7s2K
         jkChH3VAIV2ScpQ7p6vD/ekIMTj99jeg/1W8R/4uC1LACZ3XKgZEkEjh99yXfdBqpnAL
         uIKAImU9QAzLmdcHL1trZc/BPKjgl7Z0W/ek20wLJnfUeFDbJ/kOre9Cpwh2jgN/OLHt
         egVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727386523; x=1727991323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YN3ZIl0AHdW2Pc3ccHhFRbQ1ihSm5IEdT9WChsNSY6k=;
        b=nnmJKkgcACozVDSpFBzUMkQb5Y3qgChkkOHFmpcaO+WyoEmG2yQ/DJaaT+0E6OKhbL
         4edl7pBfS0KSuCN4J17TXsxaCijX0wFOl1McewxcYnkjHlppDaDtIlmk7BeLqo9spMzd
         GvQfWJWmckzL3ysFqmQAywMzd6OfMCvStz6XrMLPgqsx9qF7zAWvuUCxyMl7I4LO5asF
         tY2iqMCX1KyOtyQXSAx70zzQ3QgQ3QFPJnt3mvVfTYp7DTTgIKuR5JjAdUGM1vIhG5rn
         wAdcVhSIglqIO2ATJ+gekoA6j5ux3+Xp6qrTXWyeWX5Hr9kk6/60rCGS1ehKqpiZANFI
         G0JA==
X-Forwarded-Encrypted: i=1; AJvYcCUDJ8RvVdvqtHN3lX1txbKSEmzjS+sQLqz6QZbKSBcpkEsBUAeUwf4nTqbN03vw4GXyiD9iQZArXil9IuPBiXw=@vger.kernel.org, AJvYcCUh1EnD+hD2C3vzqWv60QHnERNsPDZPvtTXZIO5sRiraXir9igXESaPEYdxkZd9i9XAYroDQMEZrC9cLvE6@vger.kernel.org, AJvYcCUidN0lHrF9iOqSPJ8IctwwAfwAs07OQfJTDdO/ZULHyFNBpvg0hyVrQCV6KMoggxOswxI=@vger.kernel.org, AJvYcCV5D5TsQSXjcHuycgk/6XXYltPQlUyoOj0RhDcW5nuV2PC/tj/Q2JUE4o2CUQJvBvD97N7k7sFVZCk9WEHGDPyghQ==@vger.kernel.org, AJvYcCVOLC6+65mOqcNjHRp1+tV/XssjpTX8h+9F4YBiY8/h9aWXzBKFdg2eK7772upIEAdFSiQJEmnzVgkk6g==@vger.kernel.org, AJvYcCVsqpEA1X34JgSSy+zWUs7+fSAIlED2wx+FoF0zXBxfBa0ReVabMdfI1p7J84be8lizTJ6y/uqbQToD@vger.kernel.org, AJvYcCVyOHlVKllui6A90Q42IfKbLrvLtdZnjC+4kVdVZSOG4aRB5tquRkPsdIouUdZ5cjLcKniIJa85fW8=@vger.kernel.org, AJvYcCWIeHXSn79E1pba2uaZgabrN6egSq3hKQJvvQyqA0ncZ3poR1endScJFmYMlQD9tOmBDQRNsnt7bGe0@vger.kernel.org, AJvYcCXTmNdlSb1QBFTlgk2/mbOW9A2NT3p8kXvs3x58YZP4/N+DnfQhUq/gJiG6xW7mj8KHqe8jHlQq55VTo3hn@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTZ3zsxEiGOsdmhyvylg0pTMM/FgSGOmCyMfxDfM9CSVwTjhW
	AAPO1FdxgZ+AUbsMCKMSJLJBPk64IXPEa9Zxwq805/7NayLOfWOsl5gSodJeflPB/OilgtRCS/O
	Gj38jwHBTYzU7aYb/AVVUkzDXAIw=
X-Google-Smtp-Source: AGHT+IFP+qclc+DwNk0VcbiLZGtyseD1sfEmeyqBVla3e/ZDfuly9waYm3g7wRqfrKuy03nGqriwsOXLp8FvWSa4ibk=
X-Received: by 2002:a17:90b:3698:b0:2db:60b:eee with SMTP id
 98e67ed59e1d1-2e0b8ed348emr498104a91.9.1727386523117; Thu, 26 Sep 2024
 14:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-32-ardb+git@google.com>
In-Reply-To: <20240925150059.3955569-32-ardb+git@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 23:35:10 +0200
Message-ID: <CANiq72=z6A=50QO3V0S3Kgx6XQT93GxbB_LN6PFAQCmNgy370A@mail.gmail.com>
Subject: Re: [RFC PATCH 02/28] Documentation: Bump minimum GCC version to 8.1
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:10=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
>  Documentation/admin-guide/README.rst | 2 +-
>  Documentation/process/changes.rst    | 2 +-

This should update scripts/min-tool-version.sh too. With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

As Arnd says, the cleanups can be done afterwards.

Cheers,
Miguel

