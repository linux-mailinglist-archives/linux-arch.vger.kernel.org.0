Return-Path: <linux-arch+bounces-1746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D408840011
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 09:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A51C20BDB
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92F8537E7;
	Mon, 29 Jan 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G9pgIXwJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA5537ED
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516925; cv=none; b=K3GhX3vDwEJY3lP2Obl6h3MYVZcQBlwTrPbapocZBHMJBfzIUuXB483EOdpOpft106AG3QR3XIsNxwuNDtnOUH4UJEbtQzOHcTTalkIZagb66JEZ3DtNUKcblAK6LCRBBetWAyi9uHsW4qborhgXaaBC6mO3d4BDHIiaXemxxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516925; c=relaxed/simple;
	bh=/pjA2KSaka0lLZ5DWjNHdib5zf0h8Lj0U5/77I1Pkgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHJ35jcnph+tajy9+gTnFabYiQOef/3js1ZbnrCaDDcod31rVS0+kxWKDUovlJYSMdJCmY2MGvJr8995RtchLxeFwtC6ycLLwZ/YKSN617bKgFkLLXNYmhVzkzVvts1iGzY1CO3PAjTWkPpG10g6FBS1+kpMs03//JKPZZOf0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G9pgIXwJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a33735d22fcso198638566b.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 00:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706516922; x=1707121722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd11WU3DwyoDiQmIHC9dAoBbMr9OMPEBjtClwqo3z+E=;
        b=G9pgIXwJapfcPZRGiMp4V9K3NPqm2iQV+Z2eihDPdD80IYPYx4u5A5TonoB3DwxFne
         6zGviSYyfGNENmIVShGCTIJs4yYDpIUnBzgDLbz+7BKBb3TOxCFU2xhPR5n546hfcpZ5
         mxxmMEI/CT2/vc+8RCuRsupeYw+GVhEx2rnR//06fbaMR5ftz5T7h+mLT8s1NGkbtUIw
         o3Z2fi0fASx6kikRpwrex8kxULA4qdTMNEeoinPoi/kdu76t4qaIfa4R2At8rngHP4X4
         MwoK4cZdQoa83Yv9HZhqNaiPS7Xh1MUEBsZhokrg6bNUbTyXEnYbretioueebj/mRVs9
         ENBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706516922; x=1707121722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd11WU3DwyoDiQmIHC9dAoBbMr9OMPEBjtClwqo3z+E=;
        b=pJfCZd5crGx0juuRKlO0BQKjz8DfYulHCWtyOzHsYeoDwFyGbC8RKZgOX3vbo1ERK/
         9iY0sgEwI+6nJYH0zdctbXC7ng8/FEI/WbU+AIpGWOdtc+QBxnkMQU9ArZqyM8hM9Xug
         HioLvpMwxw9Od8pKL1ofSVMjyp3ztmNUiPMjeWOsB5m79jmiR5va+bgBPn4E5WxbRlrm
         T4VpcZ4GO2mCy3bPohA66qwc0Pg75vFB1jvTdUwsMbvI4aQ5N7PYXvN0EvkNjVpOVN65
         pKsBGUV8mh92W3uNM0mvsU3GNtNpBglWTNsLBihI+FnM37dAaveJpWM0qFf29YoqFX68
         Jw9Q==
X-Gm-Message-State: AOJu0Yxhm1/xj+f4dTaHhApMl37AoA4dORPvf0RzzbPmuJ7p5EeCjY8W
	TMZ0yjZsRf1PU4XYXoB4UOqa3kO8pV7WDy4qrfsVpnzATYSe+gC18jMUYZY4QZ7oCY87aYjII4l
	t1CovAUMqynYqZuNX7Lb2XxNH7xmSyG21Icmw9w==
X-Google-Smtp-Source: AGHT+IFacY4fVBAqo3eoUiC3SDYNIryPK6IalhO4mwElYxnAhkKVJG35uT7HJpRO66DjFSDiv+wfUR6R4GBsWpAbKMc=
X-Received: by 2002:a17:906:5fc6:b0:a35:edda:ca88 with SMTP id
 k6-20020a1709065fc600b00a35eddaca88mr192229ejv.66.1706516922072; Mon, 29 Jan
 2024 00:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128120405.25876-1-alexghiti@rivosinc.com> <CAEEQ3wmXvnqdvv39JZhkfUsoLbJr4B2WwdgWnGY=aHgE8A-+0g@mail.gmail.com>
In-Reply-To: <CAEEQ3wmXvnqdvv39JZhkfUsoLbJr4B2WwdgWnGY=aHgE8A-+0g@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 29 Jan 2024 09:28:31 +0100
Message-ID: <CAHVXubgjF9z6-0HpjPewaHsG-6ub1BC=E5sZaqVwcFXj=7R_pw@mail.gmail.com>
Subject: Re: [External] [PATCH -fixes] riscv: Flush the tlb when a page
 directory is freed
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yunhui,

On Mon, Jan 29, 2024 at 4:07=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Alexandre,
>
> On Sun, Jan 28, 2024 at 8:04=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > The riscv privileged specification mandates to flush the TLB whenever a
> > page directory is modified, so add that to tlb_flush().
> >
> > Fixes: c5e9b2c2ae82 ("riscv: Improve tlb_flush()")
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/tlb.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.=
h
> > index 1eb5682b2af6..50b63b5c15bd 100644
> > --- a/arch/riscv/include/asm/tlb.h
> > +++ b/arch/riscv/include/asm/tlb.h
> > @@ -16,7 +16,7 @@ static void tlb_flush(struct mmu_gather *tlb);
> >  static inline void tlb_flush(struct mmu_gather *tlb)
> >  {
> >  #ifdef CONFIG_MMU
> > -       if (tlb->fullmm || tlb->need_flush_all)
> > +       if (tlb->fullmm || tlb->need_flush_all || tlb->freed_tables)
> >                 flush_tlb_mm(tlb->mm);
>
> Why is it necessary to flush all TLB entries of the process?

That's quite heavy but that's the only to flush any "intermediate"
cache that would cache non-leaf PTEs, the specification mentions this:

"If software modifies a non-leaf PTE, it should execute SFENCE.VMA
with rs1=3Dx0. If any PTE along the traversal path had its G bit set,
rs2 must be x0; otherwise, rs2 should be set to the ASID for which the
translation is being modified."

That was the behaviour before commit c5e9b2c2ae82 ("riscv: Improve
tlb_flush()").

>
> Thanks,
> Yunhui

