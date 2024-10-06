Return-Path: <linux-arch+bounces-7722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E35991D14
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 10:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA9CB21997
	for <lists+linux-arch@lfdr.de>; Sun,  6 Oct 2024 08:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1461662E8;
	Sun,  6 Oct 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADQyojO1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FA4C8C;
	Sun,  6 Oct 2024 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728202004; cv=none; b=F0RcWYE4WpfjAZbqKYYSPcZguu4KWCQ7As+10KtGWGebvg36cN0FLuHaieD17QLXgQ6he9uo8s3YGzq41INtDrxk37T8DBrl3ZZJuu+8aMqqWSsOr+EhlfSWiXtOA9tkOv5f16fuPmfRyIseoQAajmrzESXmP4MFW/1RJ6hLEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728202004; c=relaxed/simple;
	bh=puHS7d7azwqNXLt828Ye1D2ZDeZMXjrh1xk6a66e+BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roNF5bDbsvuUWU10g48JuYfh+U9ITXISe9Wx/I3XdXJxserno76LiARLxwkHk1xHXSEXL9o3i9BB6/+dHmSdEHDjkrMdrSRxKUznvCMZgOQDWky9kd9/rsOWi7YCAnBz8WolHpcpa3nN4EMixDGsT59rPYHsNDP/jptAcAfoL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADQyojO1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fac60ab585so35853791fa.0;
        Sun, 06 Oct 2024 01:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728202001; x=1728806801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puHS7d7azwqNXLt828Ye1D2ZDeZMXjrh1xk6a66e+BY=;
        b=ADQyojO1oVFojpQ/OG07teh+doGSlmlCOI1svEsXZuCE4Pp3VxQ59FFZBFhXa9VncC
         jbcCoTvmwV4jgS7xpikpA/Vo1es4yEwEJpZgHQ/YXxFwhcYCNbeEQNm7LIbM0BxNNc7g
         S4Eve/4A1OefjTgzCmQUHDFMqiVjRHI0GSKQzBe5i+zvzsWj2MYydbKm3G0SZ285awrN
         V0Fm88fhRq8KTL3vc8UydwbhWTw3PTSjOD+aD5Ceeq16kD+X0FCHD722t2XZpy+691Jt
         l0AnEpr9Lu6QJNsBRJauh/i3MzLPhzXWzs3OQEp0m1vTM9E0t3+WLKwLt7VyklpDHNfW
         FT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728202001; x=1728806801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puHS7d7azwqNXLt828Ye1D2ZDeZMXjrh1xk6a66e+BY=;
        b=IEoPEpSWp3B0Gem0y7RwFGyMQ3q/fe6rncF5S/MfFvwo4R3ELRQP9oEDt+ZpXyYAfa
         t8L4u6hnXkoaD+BVAY/Cl718hC9Tic+GQJkhaTQh3VZ9YE62j5p3/Xdu8ZTUopiVVbZf
         PtCgsaiZG8msFtoNqmU/FgEUwHpU6hS2ChFQGY55AR2O3y5kScblMLZqh0gyLwLC/OMy
         8kwlaXOu9clqIH4d/8lfXojCq3efSYNMy6GVNbKNg4IoBq23oTZhXlJvrK70km/4GVYr
         b56ROMfqN5g89p0lFkTsjfvgtZDVbsJ/badF/Ew/BGKhV/W+j0M0rUwIhotteLQwE3Dy
         leLg==
X-Forwarded-Encrypted: i=1; AJvYcCU6QA2RL4oyszVN9UUX6y3Ue5LQnWVaixOmPWAweHnvqFathJsuW5eSWfRpHY21TjNfA0vSQ3TXizW2rzm1@vger.kernel.org, AJvYcCUKEH8ZY6Na8NvB4dqZRAZFf5u09HKTNhv8/rvJ67X17f/F/CM0fVVSfhbSD9ORzjNq5EU=@vger.kernel.org, AJvYcCUN77sKUAACC4XEoy6YJS+O4o3ZtmKjyyhUbe24EkocPgFyTVtnL/+PXlBfdnCTuFa8Yfl7B7sy5Mx7v86c+zGdvg==@vger.kernel.org, AJvYcCVPTjxdfLrBiEG2Z+npArJSd1y44Iu82Tf7icI/5VJQ9bboxI8rWRkZfT+bM2PQfjcZ0qrpDA8lY3QCGuKVE0c=@vger.kernel.org, AJvYcCVS41bQ6HlrLcWJlIitUx2U7oCRUqdRZrdc3mZykB+/nVZsKS5pVbJUOgPwId8FYv4kZZAd18nZits=@vger.kernel.org, AJvYcCVhV3TgrqqvwnBzq/QZXFgavknhBFfV4Dvm2JWLMZLahsuue+WoJsyn/dlmBLnHRhpICK0Qwu66A7RwYg==@vger.kernel.org, AJvYcCWD1mH5DohvmF0CxhD9LZ5E52s6txrWNsQNM6rvOOHc8NyUIjRhAzHwFy+19Lm8AnqULXu6QVKm4lbC@vger.kernel.org, AJvYcCX5X8CQWs+tFp2OREDCcerSsopvpSi1qEmC+U6+Nk8vZIxKbDlPjQ2DvDOvEl8zOKW1W2hP5aD/nmwmE/95@vger.kernel.org, AJvYcCXrM8oDH9wpZ425e7xtbvafmXMfM7mdL9C11mLw/SURft+KhmtgZZFE2K0TwOFFaV5ECT0kZKRbNqnL@vger.kernel.org, AJvYcCXw1ADMC3RR5jn61tFhVPv2
 lS9GQmJZgqTPZQxwSLPDM6Cx6Veocw7YY/cYmzRxearHkNhr9l31QJYm91Qb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0slVW+OOMz0NUGHQeWBEvjPBkM/ILY/X/cimx72O0pEGmFE9E
	ifjuDIQnJnMxiZNYxPOf4+hF7HF3KmI873g0Y/abzGV8G1Ipnc4lgPOHhN27h+i+oEJtiOLA3Sp
	Ls4cnJPLdfuq35JT1xWP5qBe/6IY=
X-Google-Smtp-Source: AGHT+IGS61n/I1TuC+MWyJZpRj63R+p8y0BprOkKwk0SOVREtUnFaMblR5HhGoJzVJpp1ktZzeiYw7JUqStdLpYUPwI=
X-Received: by 2002:a2e:bc0e:0:b0:2fa:cc50:41b with SMTP id
 38308e7fff4ca-2faf3c508ffmr41878031fa.5.1728202000783; Sun, 06 Oct 2024
 01:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <99446363-152f-43a8-8b74-26f0d883a364@zytor.com>
 <CAMj1kXG7ZELM8D7Ft3H+dD5BHqENjY9eQ9kzsq2FzTgP5+2W3A@mail.gmail.com>
 <CAHk-=wj0HG2M1JgoN-zdCwFSW=N7j5iMB0RR90aftTS3oqwKTg@mail.gmail.com>
 <CAMj1kXEU5RU0i11zqD0433_LMMyNQH2gCoSkU7GeXmaRXGF1Yw@mail.gmail.com>
 <5c7490bb-aa74-427b-849e-c28c343b7409@zytor.com> <CAFULd4Yj9LfTnWFu=c1M7Eh44+XFk0ibwL57r5H7wZjvKZ8yaA@mail.gmail.com>
 <3bbb85ae-8ba5-4777-999f-d20705c386e7@zytor.com> <CAHk-=wgkgnyW2V4gQQTDAOKXGZH0fqN=hApz1LFAE3OC3fhhrQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgkgnyW2V4gQQTDAOKXGZH0fqN=hApz1LFAE3OC3fhhrQ@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 6 Oct 2024 10:06:33 +0200
Message-ID: <CAFULd4ZZxrJvJ9gF5tC-m-tmcDMvVM3te4xc7vnbF_OFU0D2=A@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
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

On Sun, Oct 6, 2024 at 2:00=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 5 Oct 2024 at 16:37, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > Sadly, that is not correct; neither gcc nor clang uses lea:
>
> Looking around, this may be intentional. At least according to Agner,
> several cores do better at "mov immediate" compared to "lea".
>
> Eg a RIP-relative LEA on Zen 2 gets a throughput of two per cycle, but
> a "MOV r,i" gets four. That got fixed in Zen 3 and later, but
> apparently Intel had similar issues (Ivy Bridge: 1 LEA per cycle, vs 3
> "mov i,r". Haswell is 1:4).

Yes, this is the case. I just missed your reply when replying to
Peter's mail with a not so precise answer.

Uros.

