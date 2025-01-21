Return-Path: <linux-arch+bounces-9832-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67898A17533
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 01:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414747A219D
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B76BA3F;
	Tue, 21 Jan 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0IvOdGD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369379475;
	Tue, 21 Jan 2025 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737418806; cv=none; b=KidZ1hy+74pN/IiraO/LVQ9uFpxZBbi7MWRPdUMnXxOwP3lpp+BWPMry0lEAznL2bfw7QK0dN74gUYPjNiSetmbYsTviUiC93TuLRVo4o4YETa9oJn5Wb7GI2LAIp9yeUeGzU1Sn3ld/Ug9tFOw4IJFqovzVjZBOEUdSxYKcSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737418806; c=relaxed/simple;
	bh=8S+cd3S5qM1k6mnMcNcb3ZKWUBe0goIpXrzFzAWnjD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/px3KB/TOt0g4kmH7vbv9TIoKcWrmyqUdh0LmKE3bfLm/gzo8x1720jjbJJDBJ3lqp8q0mHOlXgW/IyEdqPTuq5ZhP97W6y0J6TkRqc5ihhKFzAf3XtnyWaq+VOlY59xcP7MXqjphfOzWOPkOlwV4etRcVt8HAveTU/NG5Dh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0IvOdGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2411C4CEE1;
	Tue, 21 Jan 2025 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737418805;
	bh=8S+cd3S5qM1k6mnMcNcb3ZKWUBe0goIpXrzFzAWnjD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C0IvOdGDvboKiNJIj/MhKDM040rIr7I0Rnck2Q0Bi6WHksrvH1/pg2VQPvx2D3p1h
	 y1ykZco7TswbzzfDJPJPJLtnrTP/psi6a+4ACgY4JOP4IlO7cfLDIHUFJ1f86n1K+q
	 SWhwTw4VnMw1J583jaFIMjstxUr0rUC8oVO4BtU2CidArUB9MjvETMUfBxrz20BhHo
	 OhuBDHiIGGT81q/xdGHv7ntoGHZprTzK8TqKZPmxA+yrqwowDmBlERbkfG4E7soQrf
	 ZTI2l9mIBo0b12oxZzz3vMB0+PqBu4GK8D+ITv7qYep8H6JO12XShSjrISx+8aWdFW
	 Ne+sbPTTEwFhQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-540254357c8so4736357e87.1;
        Mon, 20 Jan 2025 16:20:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDFFTdFJko4dbAmLj+VCI52TG6fERC6T76LYlZiqvv6IOUYNs8SFr9k8JdFWmagf9IkOhjmMPaaYFUN4Os@vger.kernel.org, AJvYcCXhAb5rKHN14HfEBp4SgP4tTaE9YxTEiQlASpMyLnQx91b+eJvYMTX8So8Pv+7oJ4+Rb072f50eexi9@vger.kernel.org
X-Gm-Message-State: AOJu0YyTO0hjQ7SrqUi0kkG6dz+Yy9ouG4hrQ9kRZiponsDRN7/fnauR
	kJz9x/OHTeWsMQKhD0+QzHY2SJs7gRNOwerTOuXWBHlZhv97YN3TcjnjiU1coJ7WAzH5Kr11/dn
	r3/58RveuuElET/+hw6rjOLcWevk=
X-Google-Smtp-Source: AGHT+IExSI6nlRjF4jnonhF+UkBWnNBdR9x9teS0A8O0GamOqIclItkZgI1INzVWncwio+Cvqd22qIoAFItABmwRl54=
X-Received: by 2002:ac2:5187:0:b0:53e:36c8:6e54 with SMTP id
 2adb3069b0e04-5439c280905mr4237275e87.42.1737418804392; Mon, 20 Jan 2025
 16:20:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120212839.1675696-1-arnd@kernel.org>
In-Reply-To: <20250120212839.1675696-1-arnd@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 21 Jan 2025 09:19:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNASo+wGhpCVhBi+ew1mOtLbSXgx3AiQ6D7RtXO5P=R0EfQ@mail.gmail.com>
X-Gm-Features: AbW1kvbc1aF7uSK9oa8tsDMoVxPv87eSjB_2x8-t6FWPOwW_6ttafN93A9RBgf8
Message-ID: <CAK7LNASo+wGhpCVhBi+ew1mOtLbSXgx3AiQ6D7RtXO5P=R0EfQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, regressions@lists.linux.dev, Han Shen <shenhan@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Rong Xu <xur@google.com>, 
	Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> I noticed a regression in the time it takes to fully link some randconfig
> kernels and bisected this to commit 0043ecea2399 ("vmlinux.lds.h: Adjust
> symbol ordering in text output section"), which (among other changes) mov=
es
> .text.unlikely ahead of .text.
>
> Partially reverting this makes the final link over six times faster again=
,
> back to what it was in linux-6.12:
>
>                 linux-6.12      linux-6.13
> ld.lld v20      1.2s            1.2s
> ld.bfd v2.36    3.2s            5.2s
> ld.bfd v2.39    59s             388s
>
> According to the commit description, that revert is not allowed here
> because with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, the .text.unlikely
> section name conflicts with the function-section names. On the other
> hand, the excessive link time happens both with and without that
> option, so the order could be conditional.
>
> I did not try to bisect the linker beyond trying multiple versions
> I had installed already, and it does feel like the behavior of recent
> versions (tested 2.39 and 2.42 with identical results) is broken in
> some form that earlier versions were not. According to 'perf', most
> of the time is spent in elf_link_adjust_relocs() and ext64l_r_offset().

Is this problem specific to the BFD linker from binutils?

Did you observe a link speed regression with LLVM=3D1 build?





--
Best Regards
Masahiro Yamada

