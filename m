Return-Path: <linux-arch+bounces-10152-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289EDA36EC2
	for <lists+linux-arch@lfdr.de>; Sat, 15 Feb 2025 15:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FC8170E08
	for <lists+linux-arch@lfdr.de>; Sat, 15 Feb 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E71C84B5;
	Sat, 15 Feb 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEGS9Kir"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1E19CC06;
	Sat, 15 Feb 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739629311; cv=none; b=fyd5DuR67Sh0kVP5T9ortGu+tMpt4INs/qEKp+racsTtzp5U8A95C7u0HBf+3zC93l/TRqpoOwtkDmT+4jqVOxn4x4rki4Oa0z90XXJY6Sf4m239L/NZ58cqpUP5Fwu+lQHooAgCf2D5NOK3YMizRUzuQkiPzfzfdrpHqXn5yWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739629311; c=relaxed/simple;
	bh=O3b2JU3w/ODuxO3MLy1UzoyGGGaXmBwx1eEl4Fz+mQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfEq7dqFwFUy/4Fwms5iZa4E4tzyYYcvH5OvKGKNaaYjJIu48she1vgxrtSnJ15VJxc5urCGh12XGz7dqF4lzx7RJtMO9miaRGNu8Wdhss1DFfF/Z0JYabyyy3ZLvTcyv6/m/vRHjuUuynxNqsT2Ct3g1e6cjSt9XEUkGHDoeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEGS9Kir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862E6C4CEEB;
	Sat, 15 Feb 2025 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739629310;
	bh=O3b2JU3w/ODuxO3MLy1UzoyGGGaXmBwx1eEl4Fz+mQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hEGS9Kir7L5VKuSvVoS3WRtvXngeEsvB3GpV/9fjCOCrhy9sYWKacXw8hfRSBUh7K
	 pQZuyRLi1IsaXGh5mqgZF5yxp82d1nSThvgFxU/3GtN0sZ0D+XmFoeMJGfKfeR0RHa
	 7UPYmkg7WVu8yxQcGHqTxN7kaaADW1ft3LFhoi82R3muUtYgP4rFVGadux8Ws4CURt
	 bzfGrVEMPNYAJd+uQmsYUqD6yKPcm8MFiy76nPuP+mdpOoXzwxCaBVLF+sOiJJvhqD
	 nvgZ5j2uO2rYTsGSomJLxTGBORrHL/rXl9k5ceasmIC1swXfsCfsIAz0jRm5ZnQA7i
	 ofKhDMDYRJOKA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3072f8dc069so30378011fa.3;
        Sat, 15 Feb 2025 06:21:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEQa72l7iNrUozyP8ZgDz0DNRQ4PT6+Y1o4wlcQaZFWnCjeQ0MyOKfy8w/RnfMWAE1yDWB4Ed+59Fnk4Cu@vger.kernel.org, AJvYcCVWmcbJcwQJWYqHlSlyGGPSLsJvWTmxMqXfoUIkao1N0orAPWpkdGKYnsRILzTJ2iW/muM=@vger.kernel.org, AJvYcCVhPIneuuIiFaQDmaNRoa3IaGJ7a7xeHTweFxLuencKtPQN1TCi8E5S+lPZcqTNCT9VbDwWLYXFnLJIaUcR2ecn@vger.kernel.org, AJvYcCX3kQWokwX97aythkIvSL6Bj0GZgDOJxfWJKRWfAQTUN+B0dvhmzD1IlmKHxMwI43luUoj8wZ/YzWMYe5oj@vger.kernel.org, AJvYcCXuislqfI/BpS19OwxajBEHBci2Bl4m9TUAKntEqMxCohs3XcxsbiNdSsK5OElbKJJNSJdpKC4WFGv64g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgdQAi1vqYReQ5xCYtJB2X/7ZBOGMldOxf3uuZe1H/uid81Mub
	QNVqFZt+8gkgXoVTzZd1HL0gw11bAQ0IOOKwBT3RVivGcn9uwG0KtB4+79gkrvBTAPIMOSeBA2W
	YCfWSYlJsMIHI5l6uD2KSfqphrhA=
X-Google-Smtp-Source: AGHT+IHJAH2llTK/8FUeOa/uyjvPOa+oEZ4jzkPOcw5/nJJ+S7w8Kd3yArGdplvM1hiKKoy+jgbSokUCpMby5X/HYDE=
X-Received: by 2002:a2e:99d6:0:b0:308:fa1d:1fed with SMTP id
 38308e7fff4ca-30927afee15mr9904211fa.34.1739629309211; Sat, 15 Feb 2025
 06:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com> <20250207012045.2129841-2-stephen.s.brennan@oracle.com>
In-Reply-To: <20250207012045.2129841-2-stephen.s.brennan@oracle.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 15 Feb 2025 23:21:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQokoST0FnByeWywaghTMP2aG7hQaV1T=TcQ=1v4ZLQrg@mail.gmail.com>
X-Gm-Features: AWEUYZk8XrdR9lJozRpCY9QyaANy91FqaGQymPUxQ0WR6PL3n7MJiW1ZBtl7LX4
Message-ID: <CAK7LNAQokoST0FnByeWywaghTMP2aG7hQaV1T=TcQ=1v4ZLQrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kallsyms: output rodata to ".kallsyms_rodata"
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Kees Cook <kees@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Sami Tolvanen <samitolvanen@google.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, linux-arch@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jann Horn <jannh@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kbuild@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Nathan Chancellor <nathan@kernel.org>, 
	linux-debuggers@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 10:21=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> When vmlinux is linked, the rodata from kallsyms is placed arbitrarily
> within the .rodata section. The linking process is repeated several
> times, since the kallsyms data size changes, which shifts symbols,
> requiring re-generating the data and re-linking.
>
> BTF is generated during the first link only. For variables, BTF includes
> a BTF_K_DATASEC for each data section that may contain a variable, which
> includes the variable's name, type, and offset within the data section.
> Because the size of kallsyms data changes during later links, the
> offsets of variables placed after it in .rodata will change. This means
> that BTF_K_DATASEC information for those variables becomes inaccurate.
>
> This is not currently a problem, because BTF currently only generates
> variable data for percpu variables. However, the next commit will add
> support for generating BTF for all global variables, including for the
> .rodata section.
>
> We could re-generate BTF each time vmlinux is linked, but this is quite
> expensive, and should be avoided at all costs. Further as each chunk of
> data (BTF and kallsyms) are re-generated, there's no guarantee that
> their sizes will converge anyway.
>
> Instead, we can take advantage of the fact that BTF only cares to store
> the offset of variables from the start of their section. Therefore, so
> long as the kallsyms data is stored last in the .rodata section, no
> offsets will be affected. Adjust kallsyms to output to .rodata.kallsyms,
> and update the linker script to include this at the end of .rodata.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---

I am fine if this is helpful for BTF.



--=20
Best Regards
Masahiro Yamada

