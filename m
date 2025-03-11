Return-Path: <linux-arch+bounces-10668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE8A5BB1C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 09:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396FE3AE87C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Mar 2025 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D7226865;
	Tue, 11 Mar 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPihtWYX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B71225A2D;
	Tue, 11 Mar 2025 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682970; cv=none; b=UJx6I83Vw4DRoYoBkU3D/QLk7LEskDH8Vp8/PteAh+GZG3OJBoUUewU3em3cmX97LNU1+ssvwyO3EKkgiRpVbU0bXqemEjKuLb48XioX3jl0fkG3h/eT06gEH7dK/LY4xiB3AtlJFSOWogdN6IllL8HRC+scRTed/w9vmoHVBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682970; c=relaxed/simple;
	bh=LmfmlNfv8EBghYIYwUUYQrDDOcBM3L2YR/qg/xhcj88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtVXVnhyloXFWSfEPSnVglj02xp8JcKuNX4oyMbE+aZmPl78vy9jje+aImrflT42c9O3SZ5ugshF8lNh3+MplJ5zS3Wml2Ubab8XpU7CNnXZ/kuVzzl/6dCnFylwa/xFM+5hV1hqyLLIrT8wtCncNxbWJyRCZWZfIgEZt3AugCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPihtWYX; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e5e7fd051bso5032118a12.0;
        Tue, 11 Mar 2025 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741682967; x=1742287767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=++ArMbZp2/d1UeSQje2LNI+0PmtQnJ5AtRnBL5XuDLQ=;
        b=CPihtWYXI5DU2QH+99Os+I9dosjymVPOgHG51csak8BWeXLkennP+LJKr+iw+U20bp
         D80O8u1eX8xPzBBb9V6VQQyLoqYtfaUhAcEHO9+XMTVO2CUUPg83w/peWUI0xqOPvDwI
         n3oCeNLyWF0ATVCDc80Dshrmrc8GqmvXL8BDdzGs0YhgyXElWMTmE3CA73JpoDEsd+BA
         cf/CCoV7La2oGV9zxRkNuEh+dIcFWA/F9avuPie+ENzlHeNU0RiCX18KwAXcoqhrHUUs
         MGPuwlRaAmduO/8CqfgogT2so1xPcrqxZQ8UJEIDR/kanVUtrMOUC7V3eotbMpLZIzMk
         KqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741682967; x=1742287767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++ArMbZp2/d1UeSQje2LNI+0PmtQnJ5AtRnBL5XuDLQ=;
        b=WuZMd5RVvMkQb3FSMiIuIjhsSWpVCvku2Nb24tyFemdLrTDlHUM9Ovovyg+gIced7l
         7UzC7UYjbzUrBYaT8Xa2hryrh3hUDPHYuBm0Ail2SLMeKITj7K9HjB3r0Ujdg7VoK9W5
         MUwF8o4R3jvohfwYZzIaXX3UyzmEb4Lc1prepdX1T8OXecoNuOJkxQQFcKIhF5Csv/N8
         dyP1JAMcZCK4S6SOyXs3YWzhQVG46JSDHC+gndeCXrPPnhR9tzyekPA00ffQtVHHnd8s
         o69aC6CcNjL2R/tlnzE2+5kSdyHQIub0qnsPbxz6appBZGd0JK8NS/v4RHVwXD796MtH
         mq7g==
X-Forwarded-Encrypted: i=1; AJvYcCUl7doI8qg2dQutowecy3oSjhqJ5RWkFTZwT+jsQr/DyTIal5+aj/n4L4/aizNwgg7WhKOvZo8XlD/O@vger.kernel.org, AJvYcCVYq5yYD8PWzyMN15YndTGjcHcf9h75YLvyO3KcsQ7OTCky96uD0qbufK4lVJGB55hZ+j1cb9UWpRrI/P7t@vger.kernel.org
X-Gm-Message-State: AOJu0YzSazElftGKoalwqLPk/F1likiWsERqSi4Sl3eXVHrWeaCuBBQv
	iYq1/cHVrPAGvLMnLzqgniyqsi/KEMJo7sZsw47k23J/UtR/89xlWPLGFMpa138qVynfqUrM+J4
	Y/yB9XpI4L+WYd0uD9DltAhe5Sjs=
X-Gm-Gg: ASbGncshZn9gsfmFQwxPIXTJNdajpcps2XTro48O9fzyyuZ/NU3dgrPb9NfBdwFa3HQ
	HfFlSZEEBa0ZYWO3ubB1ae1W0o4arm2pwDT6kb+gc+jfqjO7SVhYogu9N/4zs08gL8u6ZYakN9G
	7HQpA9mmM1dWxyrjed4k0RzydS7jXpafuEExEXHlHsDkCZH9g=
X-Google-Smtp-Source: AGHT+IGep4cbVrjWQJvr0mN3/apVTOGtpDu9f6P3w5E+xknHRprszHROkevCtShu3x+t9pcnSMI5YywqEB76R9BU62w=
X-Received: by 2002:a05:6402:3595:b0:5d9:a54:f8b4 with SMTP id
 4fb4d7f45d1cf-5e75df5b635mr3626584a12.11.1741682967313; Tue, 11 Mar 2025
 01:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
 <20250203214911.898276-2-ankur.a.arora@oracle.com> <Z8dRalfxYcJIcLGj@arm.com> <87pliusihc.fsf@oracle.com>
In-Reply-To: <87pliusihc.fsf@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 11 Mar 2025 09:48:51 +0100
X-Gm-Features: AQ5f1Jot1V-VvnJHopJ0Pc5_tyFD4QArR33_q-1sHlVuL6D8A0tNs3txvQgyXFI
Message-ID: <CAP01T76TWAPz4fXh6EoqHLCAxtgbzyvZib72QeFoTSx-0WKPtQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	arnd@arndb.de, will@kernel.org, peterz@infradead.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, zhenglifeng1@huawei.com, 
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 08:53, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>
> Catalin Marinas <catalin.marinas@arm.com> writes:
>
> > On Mon, Feb 03, 2025 at 01:49:08PM -0800, Ankur Arora wrote:
> >> Add smp_cond_load_relaxed_timewait(), a timed variant of
> >> smp_cond_load_relaxed(). This is useful for cases where we want to
> >> wait on a conditional variable but don't want to wait indefinitely.
> >
> > Bikeshedding: why not "timeout" rather than "timewait"?
>
> Well my reasons, such as they are, also involved a fair amount of bikeshedding:
>
>  - timewait and spinwait have same length names which just minimized all
>    the indentation issues.
>  - timeout seems to suggest a timing mechanism of some kind.

I would also be in favor of timewait naming, since this is not a
generic timeout primitive, the alternative naming is useful to
distinguish it.
The wait can be off by 100us or so for arm64 when we need to break out
but that's tolerable for some cases.
I've also taken a copy of the thing in [0] so it can begin using the
in-tree implementation once it's merged.

  [0]: https://lore.kernel.org/bpf/20250303152305.3195648-9-memxor@gmail.com

>
> [...]

