Return-Path: <linux-arch+bounces-11870-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C2AAE8DF
	for <lists+linux-arch@lfdr.de>; Wed,  7 May 2025 20:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D091BA32E4
	for <lists+linux-arch@lfdr.de>; Wed,  7 May 2025 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADDD28DF43;
	Wed,  7 May 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbRtG7Q2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211687263D;
	Wed,  7 May 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641916; cv=none; b=XE6QTurLnqTY6GQ6mXZ7m4QTvmvGCa4O3/pw5S/xTPWicyPoi1jBkQTO5mjNtVhH9SQZeCDNu5sG6IVO8mlHa3btRNHG/V1ubolfFYCLafoHDDITaMmbLvtBfN/eThClzMmoW4UCCoQSij1Et25sDwdYyn+eSTV1i5dT4RVCnuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641916; c=relaxed/simple;
	bh=KMYWzqgC8ALedbSK7njrAUiFbyvgeOiiKXcBjlb8zD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwis+/xyQVsiowmf7PuFKjHYJP1vY3WlRMwPRuLsM3ixc1kAyqnLX8/ULqqp1JZ7O6JarNRXm8ScULc7lQ7uEftznCTYCsdI6aiHBnjYdkqMPqaM2oA64uepcdYZVc9Cp2JZJMOyDKlKKftFvkzEZV90Yvo7x2sPahMrR6NvWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbRtG7Q2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736aaeed234so245732b3a.0;
        Wed, 07 May 2025 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746641914; x=1747246714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/b9kLOJyNOOgXTAvMvRZx+q9I+LG3sxWJKTuz4qb4Y=;
        b=fbRtG7Q2oQIcCWGOsk6hf1VvLVp80Pr+FHl6vZkUII44UghULt2O2i6HsZpLrxsEV9
         O6cgtTSqtPmkPconeVYr3i+nw1JKZBErZye82IEdxHpMinUTpt0Tc2WD0Okm5G1wyDKX
         d/aJM2oJkT3thODK6OcWzpIPvUk3xLFEdOzJfZJTEkCnirBFEqR1ytCOQdgmcZRU0ucY
         UxQpr/CpCEdMFKjGY2tTzlkWu3nhaiRZmbRT2noUHvxKXIWcG5UVlLhShLXF3HXrG6id
         bK8JpmVydqu1+mIW69nres1W2Kv/aKOdwdotEbtpKC5rZqNd0RiAnLy9+MSl6KuIh+mM
         8nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746641914; x=1747246714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/b9kLOJyNOOgXTAvMvRZx+q9I+LG3sxWJKTuz4qb4Y=;
        b=p9GWRRI3onIailsiXd5djRXxZIZr0+lM3R1lnoeQ6JBYBQNxKsG+FnEf9r+1ybh7q1
         ut5RNR6kd+3kzn14cSb6WE6g6nfxBnHrfwqvTslCa1AslWCcTvwn8UHUMx/l5vqdQkOJ
         N5YazeiJ/h0YY0cM+uhUx6AJoh4+hhyk2f9gV0Uxn8JF11KwkbIxBVn0vds6rXwJ/Z5p
         UNVveYn2oGsWqGWSxxLxu4+XDQsr3uNQRlu62zDojvHEak9nVYA/WxRhDefcq/A4nZLl
         6J57KPxscF+BmKfgeN0vAdjsjb83uNELaAZfIo3ESiF2M/P/g4uUwnpk3D1iR0KkmOZh
         gh9A==
X-Forwarded-Encrypted: i=1; AJvYcCUTo+Z1+zh2pvqCxrEc3DgYBzd9MbFmhItUR4UsexFLTW/bueeFrdwh9ZAl5jsc6QWjkJ8=@vger.kernel.org, AJvYcCV9Db6OvNaWKr4P53xUDcwtUpWhE649cj/eYy1pWyb4yfGWIeNmj/FgE12dEB33G3doPbqPA4x8lYeFb7K4mliq@vger.kernel.org, AJvYcCWK3ejLdzjd8G3a1qsIab5rRqIZvNIDdDBuHEDx4QRxltxEDrKHOalnV7FWzY2P+LvTm7RYzQxjspFKpg==@vger.kernel.org, AJvYcCWYYRPOmzi4lzYEVYaPP+Kn7afE1ZyPiMiq/o81mvOd07Nssdt3NnP2kj3ePe36gn7Q7Zr+J9ErxxOhcbgK@vger.kernel.org
X-Gm-Message-State: AOJu0YztFnW6QWM6NjOkmJowxeSAmtvN1SWz2pOTO1wWIYiJmIhePH6c
	jtCGLsXvkDhqE2mUBurAYPY2uxRyj23ZFuNUkN2+G/mqkMbL+irydlaPQhtGptBA6+F3vTEQZyE
	OUZPDwIHWdbvCd6xvQLpsOog0bKE=
X-Gm-Gg: ASbGncvMyWe9ofj7unepjYOmwibk+dptpSuYga+w7AaHUgt+WHuOqlqJHy/RnF8LLVn
	fE5fodTXYvHCBvEhNNEADY2Y92xJyfedrQORKSRvS6Qz2fs0Cv6zM26zaf5wOWu0HRIeDIW3Xvb
	bbq89lLjVN8I6qmTtEHAdvBYvXTOQ3MvE5p+ZSzxYkykGSjuRY
X-Google-Smtp-Source: AGHT+IErQi2Er7r17YhBc/+o6xGPrWkIlSLUIKchIAzkOkxgoMQkvfSEziYBzRgcNHcxELm+ZTC0AxHxR340ziV44Pc=
X-Received: by 2002:a05:6a20:c706:b0:1f5:87a0:60ed with SMTP id
 adf61e73a8af0-2159af9c759mr321957637.19.1746641914136; Wed, 07 May 2025
 11:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
 <20250505-vmlinux-mmap-v3-2-5d53afa060e8@isovalent.com> <CAEf4BzboH-au2bNCWYk1nYbQ61kGbUXuvTxftDPAEGF1Pc=TLw@mail.gmail.com>
 <CAN+4W8gcquJRkZw+Knt=vqwR4YM8w5RbRNO-XyfE+DAyiEWANw@mail.gmail.com>
In-Reply-To: <CAN+4W8gcquJRkZw+Knt=vqwR4YM8w5RbRNO-XyfE+DAyiEWANw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 May 2025 11:18:20 -0700
X-Gm-Features: ATxdqUHkJPgp2jd7mdL1fCg-FDYV5M7we5uV-H2O4mH6XB9PR-oIz2Kv8LBAT2o
Message-ID: <CAEf4BzZ85DyEj2ey7y46tRHd=kP4xvqn5z8H3NO3bRTXZ2Mbaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests: bpf: add a test for mmapable
 vmlinux BTF
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:14=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wro=
te:
>
> On Tue, May 6, 2025 at 10:39=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>
> > > +       raw_data =3D mmap(NULL, end, PROT_READ, MAP_PRIVATE, fd, 0);
> > > +       if (!ASSERT_NEQ(raw_data, MAP_FAILED, "mmap_btf"))
> >
> > ASSERT_OK_PTR()?
>
> Don't think that mmap follows libbpf_get_error conventions? I'd keep
> it as it is.

ASSERT_OK_PTR() isn't libbpf specific (and libbpf is actually
returning a NULL or valid pointer for all public APIs, since libbpf
1.0). But if you look at the implementation, "an OK" pointer is a
non-NULL pointer that is also not a small negative value. NULL is a
bad pointer, -1 (MAP_FAILED) is a bad pointer, and so on. So it's a
pretty universal check for anything pointer-related. Please do use
OK_PTR, it's semantically better in tests

>
> > > +       btf =3D btf__new_split(raw_data, btf_size, base);
> > > +       if (!ASSERT_NEQ(btf, NULL, "parse_btf"))
> >
> > ASSERT_OK_PTR()
>
> Ack.
>
> > Do you intend to add more subtests? if not, why even using a subtest st=
ructure
>
> The original intention was to add kmod support, but that didn't pan
> out, see my discussion with Alexei. I can drop the subtest if you
> want, but I'd probably keep the helper as it is.

yeah, let's drop the subtest, it's a bit easier to work with
non-subtest tests, IMO

