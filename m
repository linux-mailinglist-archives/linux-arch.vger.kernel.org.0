Return-Path: <linux-arch+bounces-7783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E2993641
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 20:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71A21C234F3
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC0D1D968B;
	Mon,  7 Oct 2024 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDQdnImx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395141D4348;
	Mon,  7 Oct 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326009; cv=none; b=Conp5wYF2FV5Jklaav8vvHyhrOaSB54HFkQg4cD8+ENRaAUPeeOOfgCd11RwlphQzWNMv9uIjkJokjlTdqzCQEycpViFbz60U6jHgAtj4I9pZ2PDnh575YqQW81ZM2jlsmY/y9CuwuwxiGy1atPx2BYZiCoRTyvV+Ex9tCZcmTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326009; c=relaxed/simple;
	bh=ZliK8otf4DPyN2MADeJuJzws3KQCKgf8pzmFtxSBbEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wwn3g+kcY1PxHylSq3+PTZOi25Rp3TtvT0K7xtOIx8NCHH10VS9KNQp75r+gIrWLq8ZwcpLp+mq4lEl1/MGwKNjzLURyExoukshH8fUsBWPWh1B2PQI2I9zbEfLGFSw96WlRthk7+gcV5HtOSRFyzm0ifoNjXEGlzrggB0DL6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDQdnImx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71de92fdf13so246557b3a.0;
        Mon, 07 Oct 2024 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326007; x=1728930807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4abmxiPmNVi3cKnPW7CiBWGlypLWQgwpQa1s7rzLXg=;
        b=LDQdnImxmHhegquYi6Lj742GqetJTYG9tPhEMAndaRlCrakN6O6KVp1ZM35awRfQFR
         vjuYh1hlqE8VMqUKTOkGAA1F/F3+TrAa2Yb0ZKoCNwdUfhAr1xwd+16zNH4Gyp7OYySr
         DejqvH55EfjW8+XSxHLoiLEMgMZ0f5rucCKJ1o9IRXEigtj1peqH6MyYNHGqv3u8CoXn
         FLeiYnfSaUnFwhp+h3BAvkSm2ut3G+4BDfNHi5SbOgkT7pBXYb3unpUYzMP3TSqy4MvD
         PTUIVq3jJLK/I/r7h3khg/2xeSffnmvBGo9u47LrkMZss8ANgCFlqqWyQlarf5UKeEmM
         C+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326007; x=1728930807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4abmxiPmNVi3cKnPW7CiBWGlypLWQgwpQa1s7rzLXg=;
        b=Zl7or6WK+Zo8K8lWKBi/dxFa/dB45KNcSI3fqpgf5YaGvjP5h3AqKxWr32Py96lEfS
         4QC7hDKbI9dBqUWLQZZ5M1DvbDZfDaC00d/HhdktcfKpVmgm+Ruw7Ws3aUMLHyKrdUVE
         irydzpeaSFQtszm5RsAu2L3k+LEDwB2FrL0QYWg/NbhCVIQ6ZT7LueqfdxzDWLhgZWua
         iefcflmTBbdw28ia5etEjqJyWiIKbcmyNIoY2Rx5Vu+atR1aGMUJhLtUql/4vs9GxQO8
         6OAlBxkmkn1f0cb/Yca/LNx2S444wxtNORDg88e/UHY0YJuDJ+7+45nudr5TiBixFFmV
         8kPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEJ7Go2ko4kaEtSzIrNMIeG0Y3/2cpBdIVpJmci7V9Rt0x9Y6BrMMwp7lZsEIi2ABJ6G5neFmU4Alv@vger.kernel.org, AJvYcCWLFdYspH76YYhfT14HRbRo+QfjFjcNN99w/p2MZHwmEeT2B0EFy3Pej+JC80Oa7iYtW+R3p8iDjXfAobpd@vger.kernel.org, AJvYcCX4TVpDcMTZwAzOtOAse548YLoLXDwX35aCQw/6Mk4q5u2abVJn9BBGVpQKFKlej7Gk0O8pfwXPl2EwpwnB@vger.kernel.org, AJvYcCX85gKUjJEIeosL1Lc7Hb2S4cw4gBK9P/C3N+XPLG00bJy5U5WP1hb1chuyCvmGN2LAvVcjIo5xIInC@vger.kernel.org, AJvYcCXYt3j2N2bZL9B4BDSV5Qk+3wfJZaKhOVVlnadQ89pLgdbSFVtlknD4n2jSigY44NqE0tM8gdxyla+I@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2BWjzjE6HS2Kw8yD+/zBR8qTJldTP+tLkW6wJOoC2IDQtTal
	qLdTJO8kqw9KAMx4rq3m1EU9jwtiLuyVXaRiXEThFmJIlvXsugqfupH+IoIfwe8pwUbgA7lRxrS
	O4u5biQXEimB+XumUNZ3rqCcPQBc=
X-Google-Smtp-Source: AGHT+IF+C2pJlkVmDRVo4PXcJTPJZ4U4RBrw9yaJ3O78ja9hmVpWEH3Lmebudm9Idsdk19oGIrpS46PjWjdiP2NSuEE=
X-Received: by 2002:a05:6a00:3e16:b0:71e:59d:36a3 with SMTP id
 d2e1a72fcca58-71e059d36edmr2264095b3a.5.1728326007506; Mon, 07 Oct 2024
 11:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002233409.2857999-1-xur@google.com> <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net> <202410041106.6C1BC9BDA@keescook>
 <87setapq4s.fsf@trenco.lwn.net> <CAF1bQ=S7HfvXw+hczmQrSYcBf_DHsZo2k59JSL8T_9J9HitHuQ@mail.gmail.com>
In-Reply-To: <CAF1bQ=S7HfvXw+hczmQrSYcBf_DHsZo2k59JSL8T_9J9HitHuQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Oct 2024 20:33:14 +0200
Message-ID: <CANiq72m7dkcy=0+ut=rM6Heo4tQSNyUrejBDWCvtwGQVVvLhWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
To: Rong Xu <xur@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>, 
	workflows@vger.kernel.org, x86@kernel.org, "Xin Li (Intel)" <xin@zytor.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 8:04=E2=80=AFPM Rong Xu <xur@google.com> wrote:
>
> I removed the "code-block" directives from the rst files,
> and used "::" suggested by Jonathan. The rst files themselves are now

I think it was Mike.

> (1) The text that was previously in code-block no longer indents. It alig=
ns
>       with the preceding text, regardless of how many spaces I add.

Did you try with a tab? At least in Doc/rust/ all those three ways
(i.e. `::`, `.. code-block::` and a single `:` for indented non-code)
seem to work fine, e.g. the following document uses all of them:

    https://docs.kernel.org/rust/coding-guidelines.html

I hope that helps!

Cheers,
Miguel

