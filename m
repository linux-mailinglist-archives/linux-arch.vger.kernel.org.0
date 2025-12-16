Return-Path: <linux-arch+bounces-15454-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 926C6CC140E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 08:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D5DD3047B49
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 07:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC333BBD7;
	Tue, 16 Dec 2025 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQckP6np"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127333BBD6
	for <linux-arch@vger.kernel.org>; Tue, 16 Dec 2025 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765868693; cv=none; b=M1E45aG5y2cdXBjD2eYsy72ELy+U9hXzLQpFcrASxLODvWQvtBaZ2Pn9dO+JddYqWPMlYXvgIN+U1kXObkith/JE44ftjRB5VJi/DokhjYkUe4RQ8EP892flmQa1yw1O8+qKQxjjfoQC3m7H7QygrXHiWU7UTI5eAS0QwU5BMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765868693; c=relaxed/simple;
	bh=cTs6oU6Oo2QgwQL/Coafq9Ym3NDB+lSLyf/MAHwo5r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctcl0ehzgZ6wqcXJKjSeKi1WSMxA3VBCK0FKeaaKxH9Cj6LY2NTtlQ7OC9e1rFbD+jHc3t3H/FWOYvqPGzEGvb5xhkpWd3fz4QbL8TIZB5waZNn+5LW6juFACcKY705voOrfekQlPbC4QkZIvEyAF2Ir3qlssswhfPv/lP6uRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQckP6np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEF3C2BCAF
	for <linux-arch@vger.kernel.org>; Tue, 16 Dec 2025 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765868692;
	bh=cTs6oU6Oo2QgwQL/Coafq9Ym3NDB+lSLyf/MAHwo5r4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NQckP6npZK9/PfGYLKL2aZ9xnM51trELjK08fbM6ZNnT2JcOUdeaPaQP5f7cUSts2
	 pshEJe7LM43vdQtr6wV2LWND1tmWHFyc0iUVADogRbcpI2Nf44RYOkpKu2M1QBnVoO
	 htCz92hRouXrH0un9F2kuNd1PlVuqdF6RwfH7xsAkHe3JLEFK5U7vvZqTslSjw4jit
	 bLCNIo2+uDOs2SYzATEa/VTHNzKCezB2Ccmy0Qpe7Ta8YhDYQTqQ5/hgrbv2PTgLoN
	 5STdSI7CGFPV6yU1WcJvAbswDwzf0kt/LFkyd6c7WxNr8pYZOZnfyskkiKs0z5FDvz
	 XPj53gmEv0Ahw==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso27015615e9.1
        for <linux-arch@vger.kernel.org>; Mon, 15 Dec 2025 23:04:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqIxY3n23Fko62Do1XN30WkSrctWvEQrIrNDYWSb9rXQ62et4+bKgPQvHtPGPH86nBqr7WbzWAdTZV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jlG8oN6c0TF3T5IipW33qpVwfeEqh+BWjiGi1BBXUgdWnQW9
	Kj70QXP7jNQoj9GN5dXLOMxv1J8633qFXdGVvtn4t8UxxfEiNPTUQojR4iTM9yLilBvCEIYAzSB
	arGDWD3gLfq7SMa3KQ09yJiOsOwqoI0U=
X-Google-Smtp-Source: AGHT+IGYHo9VOhcFYKNbjTNxHIdrTnMfwbE86A/62NJHlvWxMK0rZfN8i+x5ucAfLFPqBVfq3IUbZ92ZsgWOIViCDU0=
X-Received: by 2002:a05:600c:860b:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-47a8f91d91fmr144344905e9.35.1765868691025; Mon, 15 Dec 2025
 23:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765866665.git.fthain@linux-m68k.org> <d6cd17b387fa4b4cf9f419ec586ac4756bc7aaeb.1765866665.git.fthain@linux-m68k.org>
In-Reply-To: <d6cd17b387fa4b4cf9f419ec586ac4756bc7aaeb.1765866665.git.fthain@linux-m68k.org>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 16 Dec 2025 15:04:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRH0bBO4cmoorSwPj5CqcfGp5kGj-QPxoS_AkfhjeACAA@mail.gmail.com>
X-Gm-Features: AQt7F2pnUxgY4AQsmByAYEsFwtNZoW_GQoA8q9NUaqXwqiVHOjwuLnX2v2rGnfQ
Message-ID: <CAJF2gTRH0bBO4cmoorSwPj5CqcfGp5kGj-QPxoS_AkfhjeACAA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-csky@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	linux-openrisc@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 2:38=E2=80=AFPM Finn Thain <fthain@linux-m68k.org> =
wrote:
>
> Some recent commits incorrectly assumed 4-byte alignment of locks.
> That assumption fails on Linux/m68k (and, interestingly, would have
> failed on Linux/cris also). The jump label implementation makes a
> similar alignment assumption.
>
> The expectation that atomic_t and atomic64_t variables will be naturally
> aligned seems reasonable, as indeed they are on 64-bit architectures.
> But atomic64_t isn't naturally aligned on csky, m68k, microblaze, nios2,
> openrisc and sh. Neither atomic_t nor atomic64_t are naturally aligned
> on m68k.
>
> This patch brings a little uniformity by specifying natural alignment
> for atomic types. One benefit is that atomic64_t variables do not get
> split across a page boundary. The cost is that some structs grow which
> leads to cache misses and wasted memory.
>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: linux-openrisc@vger.kernel.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Link: https://lore.kernel.org/lkml/CAFr9PX=3DMYUDGJS2kAvPMkkfvH+0-SwQB_kx=
E4ea0J_wZ_pk=3D7w@mail.gmail.com
> Link: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fx=
zr8_g58Rc1_0g@mail.gmail.com/
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> Changed since v2:
>  - Specify natural alignment for atomic64_t.
> Changed since v1:
>  - atomic64_t now gets an __aligned attribute too.
>  - The 'Fixes' tag has been dropped because Lance sent a different fix
>    for commit e711faaafbe5 ("hung_task: replace blocker_mutex with encode=
d
>    blocker") that's suitable for -stable.
> ---
>  include/asm-generic/atomic64.h | 2 +-
>  include/linux/types.h          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic6=
4.h
> index 100d24b02e52..f22ccfc0df98 100644
> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -10,7 +10,7 @@
>  #include <linux/types.h>
>
>  typedef struct {
> -       s64 counter;
> +       s64 __aligned(sizeof(s64)) counter;
This alignment is okay for all.

Acked-by: Guo Ren <guoren@kernel.org>

>  } atomic64_t;
>
>  #define ATOMIC64_INIT(i)       { (i) }
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 6dfdb8e8e4c3..a225a518c2c3 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -179,7 +179,7 @@ typedef phys_addr_t resource_size_t;
>  typedef unsigned long irq_hw_number_t;
>
>  typedef struct {
> -       int counter;
> +       int __aligned(sizeof(int)) counter;
>  } atomic_t;
>
>  #define ATOMIC_INIT(i) { (i) }
> --
> 2.49.1
>


--=20
Best Regards
 Guo Ren

