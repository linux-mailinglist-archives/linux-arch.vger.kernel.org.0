Return-Path: <linux-arch+bounces-12840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A065B08FCF
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 16:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AB6562241
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D972F7CED;
	Thu, 17 Jul 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkTVuPvL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B62F7D0B;
	Thu, 17 Jul 2025 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763754; cv=none; b=dtx6qFOVnEcAi5kTadMKTrSv2sn6+DoqHXOQuYT4GcUQc9m5Ey7K7YjHIRM7WhO7egubdJM3SmO9qjJrIJmt+cHRg2Iwpw54KgVfTf5RL3lta264UCmLSaopI81IU+EHG8cC/Cvo4IABak6c5j7MocKrsPFdL6SIU6cvaPxfwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763754; c=relaxed/simple;
	bh=efekQXQZrme7QsOpedSZsB6fxq6pPsbBEH1ewRwDxdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4rK60MEWZ95iXj3d2iIVz7l5QHMtl/zWuyrcV4ySv/tSz99MjubjHetEA/Bvcmanw/QDKcXxU/6B96vC/D3cu46JiSfsP3ttX3Pya1Xz/FZuRTdp+uDPFQjNGRF2X3BT99rPeKqn5zT51x5e8bf3HsoVg5huPmQNrfeJIKBNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkTVuPvL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so8338085e9.0;
        Thu, 17 Jul 2025 07:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752763751; x=1753368551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efekQXQZrme7QsOpedSZsB6fxq6pPsbBEH1ewRwDxdA=;
        b=DkTVuPvL/WDEaWnS6/dWrODR8hbj5Vp3/KFw6a7xe2QvQRDlgu/K521xWI35K1v6//
         0Wn4UmJlP3onDzm2ejY4NkFRZDpzP+w5ReKMJFEMTGU5hID/anMpwwPlSvRGVUUR7YOo
         76P5iNSpvXVeHmRNK6Ppd4Z1y/rs9UIYxGJ7lFZDNmQG3F0KqQc7o2ANA11YMv29nsVx
         /01qeGmv7Hf1NqAJ4tU8IfgWdVQ1Fjwa7kcIqYolCYaanKZb7xowCldGZgByJSOOzmTO
         qEzXlQT7ItJ4lKRN1ywVeS9fI5rwRBzRmbAQcC4veB36htycNs/NU4Rd6PMD6ZwJPW3Q
         XvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752763751; x=1753368551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efekQXQZrme7QsOpedSZsB6fxq6pPsbBEH1ewRwDxdA=;
        b=NU6Q3M6LTMS8qyTxBmD/W3EfxsHCgnNOIDG11ZG3DPFqyf1bKTFqzkngzNywws0nyE
         f8K7J0irP4jScJERoOe5BcG5zifYL/Vff7XuhOEvRPjzl7aEYq1Q4gDf6esaX8BztpKb
         x3zxFhL2KwodTUhZkmf9q568pqTIZPK9UhoZCCAXwe5zw8WmOUj4io68fPa9B5O/WTKe
         FYiQXI9uW3SPhXQlUdreRChxNMX0VTOdX/5ACqTvBpSpJipK9Ms+5YJ5zQs+KhJv3jMm
         onVf7JN7NlmV9ADFl2OEsEeuJ7ZSbrKObACJ2hbd6m1aNXbz1cPoDXiXe0IrEkvN/HoJ
         uQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCURNM7voZYJzRwCLGDcj1OH1e1oSe9WeDW/HBs1GPTUlFkBZsR7rMAous1O7d/5HlrUprq/YcTlhQNozppM@vger.kernel.org, AJvYcCW6qVNmTxHXEJx04bR/sT/poZ8io2uCo9V7fi6GKE9bRtyWPT0YN+HJk+5v/M+yE0j39igB1UyybaB1kg==@vger.kernel.org, AJvYcCXeon5eyMa4t1pr0ANwTJaBjLu1ZuCtAW7AcrV+9dnyey1uUcezLUu9C2DH3jgzwehAaPLfurHPj0AwRb67/Vcz@vger.kernel.org, AJvYcCXr8hTdVJWrLXduIjUx8GzM79dFcGcF4OH4eV4McjabYlxB1Dfgm3O1/Vfc4K3Jpmqg1zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/3BrwZgSiH990qVeLPzjZfvTD0Nb5g0fCU7VPoqMtJM064MrT
	ChEErgMLdR1Wgf9afWyZjfFJQP0Vp5pYucejlYQK/ks5cR2DJtnDeBPmwDjjSaYNOIvDzMyp8f0
	tbKBnhiljEoh1mQ+3kaiK2HtHQ2064x8=
X-Gm-Gg: ASbGncuKmhV6cuUfOlqQ9Tma4FJXFkHCw1fVtjhVHTN3CUFS3ktTtMMjQaOkO17f0vT
	DLi4EAVipQ5eGe+yxgKpota6xp433KHHcgKJBtSrkW2+ERn8+fwiJoTsXCc6tzVIof6DlDzgUQd
	o1QzMKujHCqnMiJyRk0KgdZ1IUa6T9MfO9V9ZC6GgtG8od0uJzNE9SccQ23E6iwj0vauViLVDdj
	WjNO0qYGS4HnQkvFWZWAdA=
X-Google-Smtp-Source: AGHT+IG4miO/dv212kLZpG/e9v0ljtOerGAGBpNDY1tobNdy2ARDGjlhc1t+cVUf7eDrDA2bneaE9/9c2sJ3VTWdlXU=
X-Received: by 2002:a05:600c:5492:b0:456:207e:fd83 with SMTP id
 5b1f17b1804b1-4562e330ff3mr65892995e9.4.1752763750958; Thu, 17 Jul 2025
 07:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com> <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
 <CAN+4W8hsK6FMBon0-J6mAYk1yVsamYL=cHqFkj3syepxiv16Ug@mail.gmail.com>
In-Reply-To: <CAN+4W8hsK6FMBon0-J6mAYk1yVsamYL=cHqFkj3syepxiv16Ug@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 07:48:59 -0700
X-Gm-Features: Ac12FXxv9eZP3WGHijR1aiMMgitwCgckpKc4CSnltjSp9gY2rQ-YiI071IreGAA
Message-ID: <CAADnVQ+WZsaDS-Vuc9AN7P3=xvX8TG=rY65A8wYdOARLtkt6Mw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
To: Lorenz Bauer <lmb@isovalent.com>
Cc: Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 6:18=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> Hi Breno,
>
> Thanks for reaching out.
>
> On Thu, Jul 17, 2025 at 1:39=E2=80=AFPM Breno Leitao <leitao@debian.org> =
wrote:
>
> > Should __pa_symbol() be used instead of virt_to_phys()?
>
> I'm not really well versed with mm in general. Looking around a bit I
> found some explanation in [1]. Your suggested fix does make sense to
> me based on that.
>
> Let me run the patch against bpf-ci and see what happens.
>
> 1: https://lore.kernel.org/all/90667b2b7f773308318261f96ebefd1a67133c4c.1=
732464395.git.lukas@wunner.de/

Thanks for the link.
Key quote: "arm64 maps the kernel in the vmalloc space."
I think the map shouldn't be destroying linearity of kernel rodata.
__pa_symbol() should work for start_BTF, but would be good
to double check with Ard that the rest stays linear.

