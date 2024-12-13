Return-Path: <linux-arch+bounces-9378-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D1B9F03D1
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 05:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A4418857D0
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 04:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81C31822E5;
	Fri, 13 Dec 2024 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFVs/7RZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EDE3398B;
	Fri, 13 Dec 2024 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734064145; cv=none; b=gPT//XfYJzkoevbbfQxI6wUuYBjMHHiKmuL8UJOflF45pCPznHjNEvT5p5Dtv6dJO771wwWVHg3a2dkESaYsSnVa2/HR549BHnR2CvAoucWduFBAQwh74QIFUUKTLHoCsp5yY2u+NUlNSVr/uf+/Wuk92IXIqux/LdrdfJXevQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734064145; c=relaxed/simple;
	bh=+L4rIwPf+GveKcDw4d37qzefPMQEtHgjvmRhVI9XKBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tc9RWHNCKzwbuNt0K/hERjfa7uw4nIW8bALKJtaRlazpVG4HsGRDY2yCpXcVnCUtJTJjKJJ8YFw8yi2u1iQpJic3VfawT0YChEi2+CqyeTqE+2q10w4k47IXKW6PHUZRrCxAmNhMOWoDwHi8HrIGVJXVOQE0K6KyxZ/vepuAwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFVs/7RZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30033e07ef3so14022221fa.0;
        Thu, 12 Dec 2024 20:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734064142; x=1734668942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCvQILuEqni9koGNIRPa0LCov9Nq5Mb+hDK4nC1Iwh8=;
        b=bFVs/7RZq66j1bzM53269Dqr/3hVrZZMIIlMGHIy8/tPgNco2kciSM4n2OSxxTWKX7
         HXC0xjIXfsWdq5WIsrSw/5AGXXt128/PYjOJy1HcrkMNmeE8bhKp8As26eh5Y0rIXZlc
         eDy01AOTkOSGbcJ03IvbO8UyqQnuc1PlqSGz7r8ekKI2MPAl8hq7vN/DHAni+0gMN+D7
         +znFxdt271L3w7mudY+esdonChJnMm5aDaNY1fos+4hViLtLr3rKpEg4NwZdPkcyK5YF
         YKap4mBV9joJdx9iwTgTkBr53kWwNS6lDKWMls0m93pNcDfNNKzPn9sr1kBMZ6srTliY
         TYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734064142; x=1734668942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCvQILuEqni9koGNIRPa0LCov9Nq5Mb+hDK4nC1Iwh8=;
        b=auiiqbJHSdlAs734IAVqbdpCG3RSN5CPsHwK0LVul+T5uWV20XznkNYg3xaX07rnEG
         meQUCje6GgbubYSN2wEuN8o8mGqtG9gmujhVAq7k/+IIyMG4HjuZ2czTDN+/SKZsiVHf
         nbsGQVFsKc6kGbLpqHqnpzHhAF7j+/7wt1NhnT9+LH9hKZic4IcXyKBGH6d1Pmy6GqoK
         DDUXDugpkFBDJMnO1Sz4iBplk2eL6yG/3rHu+0qn93QDZiXjnUXITM3QXX6fl4VGJO3x
         HKurmqAqtDjRW3+sADGvd4Z+5IN/vsXyplstqViIhYJjDzwNOHDXBalfFryxEGvv+79K
         p0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUy55YimgFtto+y3CNs+XVlyq93Jkk0bj3z5u0HInJlNLHfhd/nC95MFYzB6t5OCbnF3yX7ce9i@vger.kernel.org, AJvYcCWBzqjsYW6lrq5owSUlXusudar+V9vmJcOq4BUHbtg+qX2zGjQmoiV5A/o0QYaay4I5mBzgAuDRWIkIJA6ewt0=@vger.kernel.org, AJvYcCWJBgXXueseWS67A9bHZ1t7QDAZCNOmqk6zD3nB6L7WKf3Ph16MQ4PQxt0DzPhzA+8NwYwCbt/zhJEd@vger.kernel.org, AJvYcCX2gP34MKcSXHMGZuyYuMnShxVe3iyCTjXTpGTKYXWXzdPE9vg/3awspDe2r1pNt1uidtCudK9BpeCE0wSH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0pjVzFdgGyOZN5Z5RnTkwo0VH8LcYRP5VVA/Fw9qJ0HpPWF+c
	Hlqy6bfQMvIHPcxfj/EBGpfvzwfdrDNfBPFqymJI1r5XyIF8p9vlljZf0gwIYIMmoEBzjs2lXEm
	dRPWFZsQ23n6NpQeKC25hf2hDHSPTmLBO
X-Gm-Gg: ASbGncvQAiKhph8yopljBaZmOUVxLYLbIVq0lU/dhl5ZYjvQTdk1VTKX029Sp9jiqmF
	3qYQLLwfHo9tkfJp+gYZXkvzt0121k75C2j7Csw==
X-Google-Smtp-Source: AGHT+IHhIZMzrUjX6OhgTdgCbFrO6miMc56t5nTDb6E+vXxnejuRboiGgCQouuWXc64JICWARJa+c4QiTrxibRLPcbM=
X-Received: by 2002:a2e:a58e:0:b0:302:215f:94ee with SMTP id
 38308e7fff4ca-30251be6cc4mr9687611fa.4.1734064141597; Thu, 12 Dec 2024
 20:29:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208204708.3742696-1-ubizjak@gmail.com> <20241212193541.fa3dcac867421a971c38135c@linux-foundation.org>
In-Reply-To: <20241212193541.fa3dcac867421a971c38135c@linux-foundation.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 13 Dec 2024 05:28:50 +0100
Message-ID: <CAFULd4bJ71PT8-CetpF6fb7ufUQb24ZPNnStkvbjXSsuXGMqew@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Enable strict percpu address space checks
To: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org, 
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 4:35=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun,  8 Dec 2024 21:45:15 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Enable strict percpu address space checks via x86 named address space
> > qualifiers. Percpu variables are declared in __seg_gs/__seg_fs named
> > AS and kept named AS qualified until they are dereferenced via percpu
> > accessor. This approach enables various compiler checks for
> > cross-namespace variable assignments.
> >
> > Please note that current version of sparse doesn't know anything about
> > __typeof_unqual__() operator. Avoid the usage of __typeof_unqual__()
> > when sparse checking is active to prevent sparse errors with unknowing
> > keyword. The proposed patch by Dan Carpenter to implement
> > __typeof_unqual__() handling in sparse is located at:
>
> google("what the hell is typeof_unequal") failed me.

It is not "typeof_unequal", but "typeof_unqual", as in "unqualified".

Apparently, google does not like expletives, googling for "What is
typeof_unqual?" returns some very informative hits, e.g.:

https://en.cppreference.com/w/c/keyword/typeof_unqual
https://learn.microsoft.com/en-us/cpp/c-language/typeof-unqual-c?view=3Dmsv=
c-170
https://gcc.gnu.org/onlinedocs/gcc/Typeof.html
https://dev.to/pauljlucas/typeof-in-c23-55p2

> I think it would be nice to include within the changelog (and code
> comments!) an explanation-for-others of what this thing is and why
> anyone would want to use it.  Rather than assuming that all kernel
> developers are typeof() experts!

The comment above definition of TYPEOF_UNQUAL in [PATCH 2/6]
summarises the above as:

+ * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
+ * operator when available, to return unqualified type of the exp.

which is basically what the standard says in its reference document.

Thanks,
Uros.

