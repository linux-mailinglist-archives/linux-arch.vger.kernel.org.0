Return-Path: <linux-arch+bounces-7686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D1990066
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 12:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1455284642
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F871148FF5;
	Fri,  4 Oct 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNjlsAZz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3A146A72;
	Fri,  4 Oct 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036114; cv=none; b=LVvx6h1A1Y7dnQnqjZIF+G5vg/Lzcd8juilIXmmjWPy80WEUd1c4VZKbj11i/OpmdJtIdFL2cCsrlMSXw8Vvi7WWc3+3jH8MGKB8/qEnPtI6+82C0MsPGUA4OE95YG3rvr4JD9vLBvlwBuPGgME0vjqI6Pzl7W8wNrjW3lM5zrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036114; c=relaxed/simple;
	bh=nuE9Wx0dXnlPfKn5kpp9tKPB9VOjIJcG2joICPhGO2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxuDaNkUWZeLGBipsBdeCkhm6Mej4WktzAc6c+HhnzgApFvpstkfBdjGFYWORpjLDzEffawWbJCZRYBNRWCv74pTI1h5Rqt+euN4zAwby+phc3yR/CLWG7Qtx70Afr6RhBKhxBQJWvruta4wuVkbmdtE/aorvMxTZU3ee0e7v84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNjlsAZz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2faccada15bso20055361fa.3;
        Fri, 04 Oct 2024 03:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728036111; x=1728640911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cieeCIQbn3uKGp6ANoCcdjT0voB4iLaxe9sLqJZ6O1w=;
        b=UNjlsAZz7sXdg9PcAuShFuTpjC5GIO3G7ZtoMn/gCYPFhFP6szeN6CMksFj2Mz7CX9
         25E2h7rpMX8Yy7FK0nJlHpqOfNHH7OsiuX5yXdjLrS3BUNUDTsmagyFzmyayhb0/KvuM
         bXHYcRlukQ3AwkuhIt2hoOKF+IwgXkmX0A73CKaCZ2sHUApI0UffEZuwngDk9UIBElEb
         Z28/ABXaoxNiF0Pg8YwjQdTYrw4aEr/VmzBY47CwdQvVwvp5GEYM0H/TsPONY4+RZcSA
         gKWMDhlSUAOt8oP72N2S0dQPs15n3DPYf59+4hc/TD7AWGtzQDgTVCkWio0vUxK5tZWj
         t0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728036111; x=1728640911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cieeCIQbn3uKGp6ANoCcdjT0voB4iLaxe9sLqJZ6O1w=;
        b=GDf7o7thQUd4t/9w7KIlh1KmxPFRcaD6uklICZwdEnHm3/yndanZx3Sw6CQDASJIqf
         7Z/tWYi9XvQ1pPcPwdKsGePmpQMXPAJskAy0pIaO7QzY2jCvxS1lQDt9U3ZC6+Pgns35
         zBjg+kEKzUnUvyzQprtsVQXayLLjdx8HBVQrf8aVDxAx7ZaXX4pgZdBC5eN19GeUNb9y
         FicRdcNpsZnEJEUCXEZuJkQAWPM28TCJDktw3KxFzJYySBj7tBT8vquP+we/aoHNhnxz
         Bwr2+gY8+thv6rmh5RTYzDp/FRWy6E1ULpVMMEvzzbd54K9cfIC4hfTCwNXa9+Ic4ox9
         U/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU84yheG384U6F9uEf227dUGedLNtPKxD4sgwOjafNm4coPN0Vay10n5gQR2dDuY02UR+4=@vger.kernel.org, AJvYcCU8MaO+7GOuKN1euj5QwNyqnAlWjxFkdgspotEa/YpNXFgneBOA8LxcBLa5JuLr7PUafSuw+2LftcL5evfc@vger.kernel.org, AJvYcCUqAT0d+M8dC+FDiTd8RL09YjbHdGtfjkGALZPRLcAi00ATgc4fG/Vsxz5ZVPRrkht6fzsOWLfeU+o=@vger.kernel.org, AJvYcCVYedjxx8giapV3RYq3wRyoRTRyTIK/WIi9aukN/dyXpxKlsR/fKgZUYDcAyl9lPvxLssjlQexNvHAJFCHIIkc=@vger.kernel.org, AJvYcCWOi9kaT7Qj8ZkFH74IawTmk3VlIHs2choKSxkvObE30vTwMvnp8rUKU96oCkQztuH5O+tRLB+hZ9YnGFt0@vger.kernel.org, AJvYcCWQ+cGSwMhisD7ZFcXR5KHuZeAz8DXcw5QHYvaxaozvNNQhoaTNio27cKMrPKjDqsp3TJLOnbybNbv0@vger.kernel.org, AJvYcCX5hZ5Sa0eVKmquPw9TYFXfnx1MkqK75toj5gz6jTR31v0LmacNgJePNN4j4Ga5OgukOW8XrbPOY/6euYKVuHc7EQ==@vger.kernel.org, AJvYcCXoInKUyj9p/A+snT8qzUOE+x0AOGHl07pMAmUBFhJdxABlIDAOZdLAf4Eq9eFjMN0FlOZsUJwJGJQI@vger.kernel.org, AJvYcCXpqKwrQdjWjD1Pij3zUecNM9k0oYVOsRU7bieE4++E+Yjw7GkQgkSTZzwstI21foPmU8hWSadWw1F0uw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8f8ucLTA9BwO78upx78NfYlu5K7z1qJt1N7ESvd8czW9KXuNd
	TDOdMP7qL6FxQfSbBTtNH+P34Xsf/LD6fy65nBPt7yLsxcGhLSB4T72dIaRjHTGKEf6ftknGjaz
	QLSBrX/ROQ2TLf5jYRsSc3atwJCo=
X-Google-Smtp-Source: AGHT+IFNljN6dwZlkogrdacVOY8k+lgMnJISEE8yVKjz9PNhP8aN8ZuhCudCHYoRMsLr1EPgwfyfZf3qjEWBYLSi1O4=
X-Received: by 2002:a2e:b889:0:b0:2ef:20ae:d113 with SMTP id
 38308e7fff4ca-2faf3d8a95emr9412991fa.40.1728036110938; Fri, 04 Oct 2024
 03:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com> <20240925150059.3955569-35-ardb+git@google.com>
In-Reply-To: <20240925150059.3955569-35-ardb+git@google.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 4 Oct 2024 12:01:39 +0200
Message-ID: <CAFULd4an+aN4iJ7T0DdMQDOBWrTZPJ4Oyy9ULm6R29fLNQND9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 05/28] x86: Define the stack protector guard symbol explicitly
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
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

On Wed, Sep 25, 2024 at 5:02=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Specify the guard symbol for the stack cookie explicitly, rather than
> positioning it exactly 40 bytes into the per-CPU area. Doing so removes
> the need for the per-CPU region to be absolute rather than relative to
> the placement of the per-CPU template region in the kernel image, and
> this allows the special handling for absolute per-CPU symbols to be
> removed entirely.
>
> This is a worthwhile cleanup in itself, but it is also a prerequisite
> for PIE codegen and PIE linking, which can replace our bespoke and
> rather clunky runtime relocation handling.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/Makefile                     |  4 ++++
>  arch/x86/include/asm/init.h           |  2 +-
>  arch/x86/include/asm/processor.h      | 11 +++--------
>  arch/x86/include/asm/stackprotector.h |  4 ----
>  tools/perf/util/annotate.c            |  4 ++--
>  5 files changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 6b3fe6e2aadd..b78b7623a4a9 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -193,6 +193,10 @@ else
>          KBUILD_RUSTFLAGS +=3D -Cno-redzone=3Dy
>          KBUILD_RUSTFLAGS +=3D -Ccode-model=3Dkernel
>
> +        ifeq ($(CONFIG_STACKPROTECTOR),y)
> +                KBUILD_CFLAGS +=3D -mstack-protector-guard-symbol=3Dfixe=
d_percpu_data

Looking at:

> +        * Since the irq_stack is the object at %gs:0, the bottom 8 bytes=
 of
> +        * the irq stack are reserved for the canary.

Please note that %gs:0 can also be achieved with
-mstack-protector-guard-offset=3D0

Uros.

