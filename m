Return-Path: <linux-arch+bounces-11279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF8FA7BB82
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 13:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C2F3B9009
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6911DB34C;
	Fri,  4 Apr 2025 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfZ63/hE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332211B0F0B
	for <linux-arch@vger.kernel.org>; Fri,  4 Apr 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743766328; cv=none; b=Y3Gx0e/K8pzHlqXZ+WT+LJkmVhizA04lksewZoG+Py/p/Xh7/T3s6plkbUWnuu8hypUdSoBZoA+B8G1p05leKaAcUksf1CRK+v8cwoPYVUDPUwwqEUaQUikpFv/EBm2PObGbuUh++Xiobm2wGGeHW+MAD4SM+F9mQYVe6SuiQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743766328; c=relaxed/simple;
	bh=iV79T4TIS7cOv4/u7k4BmVbPmDbodUmpjPt2TauwF2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boaQZ4j46j20xe+UdsP+wHDVV0Q1fT2jhe83lb3ZYFpMYMpelUsZYqnLz+AUX9Ei4szP1GeaRc5kmlBZCbedyatiudCsSdZ5wq6NhUIJUEZ4DXzRR+UxAfI0ALeG03O+EMG1u8+XIlS23dz9IF4yXTsRCokdW+weD/fFt2hfviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfZ63/hE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2263428c8baso130915ad.1
        for <linux-arch@vger.kernel.org>; Fri, 04 Apr 2025 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743766326; x=1744371126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RijjZDsaeeNTq2WmlBYu7uyZvjnvz4x85cSTWjzFszM=;
        b=vfZ63/hEXHj1I6z1+YLdnqHyzVFfw4pCfTjXAH6miewywX5AVqINblYv8jdkgUoQpd
         jwwJ/wxiT57YMt3O2oXjY4kCjoiL5+072FuNJeCVtLXJ35Jqx842wtkQC9V70Bh0BRa+
         XLB/AJczzqvbgTxQ7CuIQNRUss2MQmp1zkfFB2aktc+6T0tPkslasEVAKWFnmJfzas7m
         VSl3OgzoVmbt2xU48r9IyVPJu123i20SN+zHWmLrKebiR25ddjDVLffwLuaSfsBG41co
         Zust2wct2BB/saH27jy/vSnOJnsK2CE9VaMkYeuG+xkhUYzk+JtULl/bjH6AUnXeBHwN
         eEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743766326; x=1744371126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RijjZDsaeeNTq2WmlBYu7uyZvjnvz4x85cSTWjzFszM=;
        b=uhwdjqVXSUHc2t5nIFVlu6c+Kyq7UhbW3T8ngDsSx/3nS+VgWXfL6KRumNqVZ1gT7R
         fi5Moe3pmF50coETiasOhsWlBsZGoBfgUCT7disDy7AIWWwpm2Oe7TKb36KjS4Mw3qVS
         J/+SwXrEe3NDVGBTqnZwYbkQcmOz1T3bZqByM4N7fDpcjyVph58UtFDsERgP4Gg6MUUT
         UjCL9+8rGRxDaq5qbJtE7AXDvrc4DZkpaISraLA7BJK5cQbgJ46/es8YBO+xIQsfjbXF
         yXGJXqUELGo3NbYmnbpT5E36ALTQeW5jzy5pSB7/KnPdv6F2PU6aKpcrW/dkoo6VLQLb
         5grA==
X-Forwarded-Encrypted: i=1; AJvYcCVL2iga3sTuFzTK2WEbLpMdPeEzel+37GnbUIVmeNcVnvaq/MVyiTTOPMD02jWhQb+rViF236cVBjMU@vger.kernel.org
X-Gm-Message-State: AOJu0YwnizqEKp7OZX6RG8TqbW+WkbQi3qtkgGA8tFcZG+W1ToKlSOzm
	W+/UOgKSXiYMyxsSiFsK7U5h6r8aOgmcnXir6Dmo7imWVDNxyx67QYip1I+7+R/H1+hq+TuaCjJ
	U8VJddC8FYVfdASi0UwW4PloNlmy8ulYiQuhC
X-Gm-Gg: ASbGncu2w2R0R6Q8cSnidwVp42RhKHzxEMmeM3vdaI59hshHHxfwUFSaBKGp+PcK3XZ
	/UbGt/8scVRmFDDx7DKoKe8WJGMj+xhxWtRMIaZBjZ2mKiG9F4uQy+quUh1cyHvkbtdTbTWIJ2y
	W3cxp3RgpGLbk5WNP+uCNCyqus2ko=
X-Google-Smtp-Source: AGHT+IGtSJ5SCCsYoTUAusjQhkTtvCXxx/icdtTSnyDn15jZiHl4dIt2xptyi2fH7qclCUKpPalNWXHp8B5uMQxIc1Q=
X-Received: by 2002:a17:903:41cf:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-22a89ec5649mr2603845ad.14.1743766325853; Fri, 04 Apr 2025
 04:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403165702.396388-1-irogers@google.com> <20250403165702.396388-3-irogers@google.com>
 <dbba94f1-27ee-4344-b4b2-d8dffe6b7d33@app.fastmail.com>
In-Reply-To: <dbba94f1-27ee-4344-b4b2-d8dffe6b7d33@app.fastmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 4 Apr 2025 04:31:54 -0700
X-Gm-Features: AQ5f1JqEV-6ruf3kqDyuUQ7sb3lFX7gx5YYcyalfhzJL9r3U6Z0Ij2NtKCDx8-c
Message-ID: <CAP-5=fWAiLe8=zXvh2vtyhSAh+R-E89fYkdsVbb6PDALurW97A@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] bitmap: Silence a clang -Wshorten-64-to-32 warning
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:49=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Apr 3, 2025, at 18:56, Ian Rogers wrote:
> > The clang warning -Wshorten-64-to-32 can be useful to catch
> > inadvertent truncation. In some instances this truncation can lead to
> > changing the sign of a result, for example, truncation to return an
> > int to fit a sort routine. Silence the warning by making the implicit
> > truncation explicit.
>
>
> >  unsigned int bitmap_weight(const unsigned long *src, unsigned int nbit=
s)
> >  {
> >       if (small_const_nbits(nbits))
> > -             return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
> > +             return (int)hweight_long(*src & BITMAP_LAST_WORD_MASK(nbi=
ts));
> >       return __bitmap_weight(src, nbits);
> >  }
>
> I don't understand this one. hweight_long() and bitmap_weight()
> both return unsigned value, so why do you need to cast this to
> a signed value to avoid a signedness problem?
>
> hweight_long() should never return anything larger than 64ul
> anyway, which is way outside of the range where it would get
> sign-extended.
>
> A more logical change to me would be to make hweight_long()
> and bitmap_weight() have the same return type, either
> 'unsigned long' or 'unsigned int'.

I don't disagree but the scope of that change would be much larger.
Yury has expressed concern over needing to update printf modifiers. I
was aiming for the minimal change that silences clang's
-Wshorten-64-to-32 warning.

Thanks,
Ian

>       Arnd

