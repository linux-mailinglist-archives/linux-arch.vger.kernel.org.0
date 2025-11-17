Return-Path: <linux-arch+bounces-14827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F83C629D2
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 07:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8A924EA032
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 06:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEEB316905;
	Mon, 17 Nov 2025 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgEn9zes"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196923164BB
	for <linux-arch@vger.kernel.org>; Mon, 17 Nov 2025 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763362670; cv=none; b=SoYHGP0sw/yM/cQTcL3KcOyfxfmeINhCHBiEq1nkuM9z9rB9RDFaWqeAAjKuR196cUwlRpZP3CzkMuUbJ4Vu6hKOSpQN8HTMQ65ZHcoWWAaKa2pRK2VT0fpRMUajWWq+EM12YAr7Mcgpk5lQquZXABdXcF+GbshPqkVDLY9PC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763362670; c=relaxed/simple;
	bh=QFHJjbWXgZ5FLJu59KKPwWK2r2/tZ86nN8Ql1jm9c1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MS43cfDSCcrnSpk/ShZqXyphf1ClG48mzqNx7mZoehbW2FYiIqjwe5AIjEL2E3XxP5ODLl4pkndnyZxk09aYxv7727B7dqz666UDOj9NHQC9bHiA9N/p3YO4YlcY0u16nHL/BX3paZ+6JRKpyOQzUcUyMpDDT1UacRCn8EGt7/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgEn9zes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFAEC19422
	for <linux-arch@vger.kernel.org>; Mon, 17 Nov 2025 06:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763362669;
	bh=QFHJjbWXgZ5FLJu59KKPwWK2r2/tZ86nN8Ql1jm9c1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TgEn9zesgIRCkrmyUN3w5JmDr4gYs1GGuRuGQO48gd4V4EjRN6C5Msq0MIsDUo6Rq
	 2T0q2HNtfFmfieLN040ZdcCSB4+kjAMkf3BfT7kLJM0ij0ZRLTTd0t2LhfRgXhvOTX
	 wUcRiqerY+vy9iUWThAl5jGFg4WLdGNLtkeJfhPgcrg7QanuH9wVDDqgpx+sPiuM4B
	 NP1xZcNj6i/hm/oI70m2A8SVfKRtW2hkYh24UkzuvtIqPyIGW1tt5nLb1JnJbnurn2
	 r3gVqYVpX/Xkq0ye5fGg+mH7BgewPI9K2xfGVaCysRYj+fSoLu6K1b2/YWeOqGRcAp
	 b4D8ocqGafeBw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so6728490a12.1
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2025 22:57:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWr4+pTcDPMWuOiLHCdsUBqUSl5tXzYDpKJCH1SscJNZMCfaxWq6OCSgQ/Vs9zlJ4bOsufy0HQ4eU6j@vger.kernel.org
X-Gm-Message-State: AOJu0Yya936zdZWKb002Zv7uZMK7fwzIyCzMoV8xvBGoqxlRm+I+D8nQ
	EudJzScqKQFwYDa1FL+lEZTHTLL8q5IPlxLSt+QwfULtwtzAZWvYOcKR6wHPSRXOs0FNvGFaz2L
	NXib+6J+kAxB2ansGNp8blqzB8xRY5uk=
X-Google-Smtp-Source: AGHT+IGu0YWlJyZo9sBFqmWx/8Hh3O0yFNJjWzg2iDkfq3nhyb14i7bYZtnnHW6QkMeJqt8H8KA79+YcCaKiwhmN4Fo=
X-Received: by 2002:a17:906:6a08:b0:b72:599:5385 with SMTP id
 a640c23a62f3a-b7367bab9e7mr1170101566b.61.1763362668048; Sun, 16 Nov 2025
 22:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <146b5a0207052b38d04caac6b20756a61c2189b3.1763117269.git.zhengqi.arch@bytedance.com>
 <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com> <8fbeb3e8-7c30-46f6-a0a4-289efbf45ac0@linux.dev>
In-Reply-To: <8fbeb3e8-7c30-46f6-a0a4-289efbf45ac0@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 17 Nov 2025 14:57:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H73vNhjZqsDq0KGJD_PC2LtM39XAG-aZtvE=tphrQ8dJA@mail.gmail.com>
X-Gm-Features: AWmQ_bmXPoa2u3pjJaGT_1E1BSy8DLhNHegRD0EaZ-4w9eHZIwpki4fOuwGYKs4
Message-ID: <CAAhV-H73vNhjZqsDq0KGJD_PC2LtM39XAG-aZtvE=tphrQ8dJA@mail.gmail.com>
Subject: Re: [PATCH 3/7] loongarch: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org, 
	david@redhat.com, ioworker0@gmail.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 2:42=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:
>
> Hi Huacai,
>
> On 11/14/25 10:17 PM, Huacai Chen wrote:
> > Hi, Qi Zheng,
>
> [...]
>
> >>
> >> -#define __pmd_free_tlb(tlb, x, addr)   pmd_free((tlb)->mm, x)
> >> +#define __pmd_free_tlb(tlb, x, addr)   \
> >> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
> > I think we can define it in one line.
>
> Do we need to change __pte_free_tlb() to a single-line format
> as well?
Yes, there is no 80 columns limit now.

Huacai

>
> Thanks,
> Qi
>
>
> >>
>
>

