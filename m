Return-Path: <linux-arch+bounces-11789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 236FDAA6F5E
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 12:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1702217DD78
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A791DB546;
	Fri,  2 May 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="DzoasPK4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8223AE83
	for <linux-arch@vger.kernel.org>; Fri,  2 May 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181186; cv=none; b=pdG1R2REFXHlrdjsc44htuKTY8z9xI97h0E6TkEQL/0n3MsA4zR6Vs5uPJTaCIwsYlFTDkTIqXyrmPeSCVSvQRTmrMgQo3iEBp3EZ1RajQ51Wp8nbEKNdkaCMmuSPcQM8ycmkvsMLsFcVBtBJVcE0Z1G/5tg/PPur57Nw1euMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181186; c=relaxed/simple;
	bh=rf1UbGG3UspPN/9brMtSukZGCz7Qty1bFnxHg1aKkvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lijnk7rOmBs7sii8mHRhZZHaSy8ht+GjMPbvY/eI6+HO7SHbJJCNdAD9VRiPXOu87FxCZvv6ldQrHeFOCEIzDnMAIHQy82XY72I3vf6OHUcLA0otVySO6O0nRvFTbmKnfBovS98UkJjRpTp9jzwDKP0mbcgjRyWmhd/XjIO7OBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=DzoasPK4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso7187565e9.0
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2025 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746181182; x=1746785982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pFP7994sk6Z7ncZJREiDv0qbX6NYWjwXGSgYC1s9l8=;
        b=DzoasPK4sV7RwQNpK7n6mfIw5GhfzsJPvep7nqPwRSRHak2AZlHO9AEPAc2Sut1Gr/
         yLHHKZbRfVwUZZCHX740pkKXAchJS0/Vo6Tz5PtPbm36bNeF5TF+36KcPTuSbzg/vklo
         mZbEekfpVMElKZ99aw4ZH5UF+SZUN9psS6t5RqaABcBFtjSpaBRI5EaDiRVpTET85TK9
         MPlxSBq0cLLyMYpkRuWB2vuGN8XosL8RT17WV8xHzBZuB1+6pzZscnnQckxafjld9ZjC
         LxJ5hUIPEEZOrXiDL67b+ys88MVNwFunTJ+sF8fW7CN0jm6HuUz5sec7r+3+hngk+4qk
         HeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181182; x=1746785982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pFP7994sk6Z7ncZJREiDv0qbX6NYWjwXGSgYC1s9l8=;
        b=xMLTcBXOJ5MU0BoiVMZ+xASuVfTvXdH63BYCFWn0ZNqzonYIaNCharLmoYqAgul2Mw
         3joH5g/EMmpRqR3vdJZFMVumEPnTf1kKNl5AVxCa5NDsW2Yudph9IJFgQ40egr9ZEZMS
         3GnxCNG8TbV+fd7V2VTofwEg+6gUHHdjNnvf0NkuMfQ0s8lYfjGYp9O6grfiqRDjRo6q
         VwqTYNa3NN7hnpG3YRWtDMQdYgiqW5NXVyJ6OjAYmEFGWFjeEv2PLxD/w659yOpreslT
         cENAQtD4Id9ZsaiRAWdMyMUxTXmVXcRrh7lpfLXM40zRz3CcwS4ZM4ZBOoar72Stg19k
         Q1PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyvd0AuBs/8n5RadW45nfCN0SN+ZZSRJEDiEsvTuNhd0KA6WURiXLxsTPVz8pJ+ESOtgTdAFfKJd5q@vger.kernel.org
X-Gm-Message-State: AOJu0Yza7zLk9YPQnRjZCYze0DWo3xS6IqHLK4CUGuvZ/SiYiYmZVatV
	nyOa/DQOU7EEKdekvkIDD4HhC99o3ADzM48J1+bE22sxWFiVw6VmQUiN36lRQy3pNDxwmxVJf31
	1E9W4lxWkgqxYF0Fpd/zp0IzMsTcghcSGyfmsVg==
X-Gm-Gg: ASbGncsWUiQqarV0dHL6+JFO90BLBsOjwf1MiQ6MKi4KcZSuUy1myiicLcThi7u8SF2
	U/VQmfuGFRn4fn14Pt9SSc+pM00d8KBholrMdw8xRRJpODqkrDgOVavdk/iULkDOG1dQpXnChVG
	BBPiJnmDZmqwj0sxmHj9Bc95FdP5ejQSc1yKc=
X-Google-Smtp-Source: AGHT+IGc7/7ZFHGC09Y6oPlxiiiAyWXOIhQLSULd58hpmnRmxebelvil7hczjMUB00Kr9zZDZNhsc+5+jzgD4fz6cfI=
X-Received: by 2002:a05:6000:1a8b:b0:39c:1f04:bb4a with SMTP id
 ffacd0b85a97d-3a099ad1b70mr1701591f8f.10.1746181182606; Fri, 02 May 2025
 03:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
 <20250501-vmlinux-mmap-v1-1-aa2724572598@isovalent.com> <CAADnVQK3hSgs_hic2Yuo84vR=2GZNtryki+TDNkNGY_7URsLiw@mail.gmail.com>
In-Reply-To: <CAADnVQK3hSgs_hic2Yuo84vR=2GZNtryki+TDNkNGY_7URsLiw@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 2 May 2025 11:19:31 +0100
X-Gm-Features: ATxdqUFBpdbdrog4Z53_JyxwTJC7G2efSJ-kkbIOit1-1PBgRel5uCzelrycCew
Message-ID: <CAN+4W8hqyi+MFS3975stXPWOxfMtdWQXPFnuvSieFzReDcV0rA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] btf: allow mmap of vmlinux btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 9:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > +
> > +       return vm_iomap_memory(vma, virt_to_phys(__start_BTF), btf_size=
);
>
> and this one should probably be vm_insert_pages().
> Since it's not an IO area.

FYI I went with open coding with remap_pfn_range since that allows me
to avoid struct page.

Lorenz

