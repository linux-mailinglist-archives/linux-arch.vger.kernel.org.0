Return-Path: <linux-arch+bounces-8488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A06B9AD2DF
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 19:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B221F20F4B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD771E5731;
	Wed, 23 Oct 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="D9qdrumr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81591CFEA6
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704313; cv=none; b=JBos1zEjNNoU4PbMtPvdtNvj6mfH2ZXB70rShX2VSrNlDhP1QvH2fWBtIDCxmBrlel3g8gdG34K79BEiVwWgwdQZFZSDP2GGIxPg668YYyw5ztCpE+YP0R0mmixj3O34Lnme1oP1XwdFgRdZrtuYGuo02Nf/Ek0j43a+hfHJIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704313; c=relaxed/simple;
	bh=6gR1I1LvwAMsteYigGWYyjEEUkOdE5Bt/RXXDASsatk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZwJHw1x+5Fgb1h4Is2acgMIQNIn9OyFgMa0phpuydcMFtyJ316N0kSOnYFrQ5aR5Qy5k0uhZtbhPF3t4VPXZa80a1bLakISmscYpBLNnSZARL0ST24NNUl3QKg+tAAdzDZQEqYllPO1hJrpIhYAOX3BE45CRxv4FCf3kEeU13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=D9qdrumr; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc0e13d25so1482806eaf.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729704310; x=1730309110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM/akXkdjXuT6ZqXjE8A6PnOFDaDeCP+im+ym1kT218=;
        b=D9qdrumrjypGHIRkdXDAXGf3hyOB/NC3DGA2k/EOwBc0rFWulKjfT9LMfU/9rMDhHG
         lC0u8VZOCxN+gJZqjW9zMNEPihtwAhYDUffnRlxN5y7bsJA0ObZPzkwVO+yafbqlA/z2
         pfBkfDG87lPajf0FztIqLYvvc9nGtVgDnVclScUC/TdbmTj2dLhQa9g07us/Z9ZNgDzU
         O3xe/WVz4EAC1SCWWOMTIL/gPMjY9Us1ubmdFPh2pFFU25wfmUS8fj507t6dE18lVCbr
         e1XBOB5utt2MNVXu7q85kC6kjVYr4VGAzLi2JvcNn5YEfwwj08W6has66P1On5phN5PV
         h5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704310; x=1730309110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zM/akXkdjXuT6ZqXjE8A6PnOFDaDeCP+im+ym1kT218=;
        b=lyvXpFNjr/ooR56dQplDRPVRtfGGh329U2tWEWoePP6zRv0cn7pr6G0W0bIEx9+Aq+
         68qrwIH8GK1wkYWz3GjuWnPeX/uW6udVL+t3c0crfPMJOkrDw3/2/L5jf1D6lB+rn3eX
         5Q41qNpsLHCrD/h735xWc2qnWEJ3QxVtFu9ieYhO6VX1M8tKKALYjfjNZ+6wdNB0GoIR
         0VfStSPxBN/3nL9ocKpfM2jsoHoBe68R48KihD0t7xWnAoHZ3+kMP9KmU9QW9T4z1aB8
         A0/93do/B2OkEF4pq9AzbKbjvl3Zbvhd6TBbaxNLopIc/tj/wr2GSqAoxL7yyU2soNxh
         ftXg==
X-Forwarded-Encrypted: i=1; AJvYcCV9rK77pdTz+frBBikSc3phYIzSUOfnTaZzFMIaBixAeHXyws5HmmfLDZOwdfgHx0tRjLFPLHTV1Mmd@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHlHdYnkSHakoFMiJhayiZyO79KLBjYYDHQbK5Qwt1TqumK5t
	MipqwZ0F4YLQZ8FKGvVEOD2J6Kl0AKfSHkaF5TyLvOeGWCkCu0WH3ByvvparpCEUSsG7/JyBPFN
	Um/y2y+/niYYWiusXTtwz5drcyRWGb1yz4tXRHg==
X-Google-Smtp-Source: AGHT+IHOKeQDqmSvBrYDnsglKy26BaaQQbUE678ST1VqdV3bPBQaK7JOsMSHrB6pAmfeSP2FMHTadEDapACxrqo90YQ=
X-Received: by 2002:a05:6358:7301:b0:1b5:a38c:11d1 with SMTP id
 e5c5f4694b2df-1c3d81b1c55mr235501155d.26.1729704309824; Wed, 23 Oct 2024
 10:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-2-surenb@google.com>
In-Reply-To: <20241023170759.999909-2-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 13:24:31 -0400
Message-ID: <CA+CK2bDgfmwwNReGeCj18aYT-DUabYXugDdBAwQ3d02cCT7S+g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] maple_tree: add mas_for_each_rev() helper
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Add mas_for_each_rev() function to iterate maple tree nodes in reverse
> order.
>
> Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

> ---
>  include/linux/maple_tree.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 61c236850ca8..cbbcd18d4186 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -592,6 +592,20 @@ static __always_inline void mas_reset(struct ma_stat=
e *mas)
>  #define mas_for_each(__mas, __entry, __max) \
>         while (((__entry) =3D mas_find((__mas), (__max))) !=3D NULL)
>
> +/**
> + * mas_for_each_rev() - Iterate over a range of the maple tree in revers=
e order.
> + * @__mas: Maple Tree operation state (maple_state)
> + * @__entry: Entry retrieved from the tree
> + * @__min: minimum index to retrieve from the tree
> + *
> + * When returned, mas->index and mas->last will hold the entire range fo=
r the
> + * entry.
> + *
> + * Note: may return the zero entry.
> + */
> +#define mas_for_each_rev(__mas, __entry, __min) \
> +       while (((__entry) =3D mas_find_rev((__mas), (__min))) !=3D NULL)
> +
>  #ifdef CONFIG_DEBUG_MAPLE_TREE
>  enum mt_dump_format {
>         mt_dump_dec,
> --
> 2.47.0.105.g07ac214952-goog
>

