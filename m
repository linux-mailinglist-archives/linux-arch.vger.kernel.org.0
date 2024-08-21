Return-Path: <linux-arch+bounces-6407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EE8959B84
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4895C1C21283
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E077D166F28;
	Wed, 21 Aug 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J6BzlODx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385EC158D8F
	for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242687; cv=none; b=ML1RYMGwDr2Edrm2m0+IYqbgZ4anpcntWzCyDaz4Ki0NVniqhcX0gkELQM3/f7x9FgVrG7Di/pQwNOMpGOrxhBywQCTTGUqgsOvmU9qTDF6oA1Ne82rgUQdfTystB30t+3lvqKtTvBy4emf1lHPc7eHghTppkqoEo2JZ6xMVsX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242687; c=relaxed/simple;
	bh=Av8PnhltKERJzpvNW1FtpzV51cIQpkw0ZawwnlhrH30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeyMyY0br8tyMNrycxpt7asigVL02SqIF5IdcihAyyGTMZbqbWN1gSHSRZwdG5Pjmofs7lnQjWN66SnorMniqjrDmpXWLeKwsu1lwhKHQtiI9r/adYx9B59ZtMw8KWI04BvZQrmHLcIX3B6k6rerRX+YJbMs0D3qJN4hyh3CKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=J6BzlODx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42808071810so53658705e9.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2024 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724242684; x=1724847484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQMTmLPogZcziJOzZF5KtcmCsv9/KHWQ2nfDgqi45D8=;
        b=J6BzlODxNxguW4utX8ItopwSEzsD+n6hrsGfBji4bB79HT80yXFy/LGr2DyEihgY7O
         5cCyBspHnhai8MCoQI9peJZvoYE8gq2PrSA2FzgGvq//wDq4cjiwgHvWoZbuwqwYfRX1
         LpEVvy8wty5LjNv47FPiAMvAg8untbJNPRkc73kJLMTL+CJjNIjk0YhpGOcRRHAMgNXJ
         y7wUxl1qilZesZMxYoa0SGp/PvTnJtgd/Ie28DLkYO9QkwA60mfbzx4mVDWwODWlLBh3
         p4ScRJUO6JU9engVqi3VEUP+QH1yMSmfSDwb3C96SsByMcsI/JnBPwezQx/e/ZadnSCR
         u+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242684; x=1724847484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQMTmLPogZcziJOzZF5KtcmCsv9/KHWQ2nfDgqi45D8=;
        b=aP92RI447f84g6LuOfAH+IWjhypqQrvPRs54A4F6WuwlA40ZXneBMfsZKUgkQfxDnR
         dSSFwSAXXw3lrFULZ1yJwBE1uv8bSuYeH7zPTJCYdaW1Yi1yNqRAp/+C1SxOgnToZCw9
         iBVKO7/gALmsBdWpqYHRO5NKZzd57lmrB4YvOj8oTuZEMa+yCIFRzcaDRk7cfLRhWKmv
         kAPAZBHp3hde6sTMr+gxcPSwTHZS6dv7ubRXwFjACbAS34oKysMdtNSqyhEq7q1jlsAh
         E6JKklP4pqR9sulgaOfHYlgMJ+rdhqFqLPSX0EDQZsrrEFmXFgy+dgji4e8iOAUMagwF
         H08Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtYgK/lGU/2NjFNTdrgraW1KqaeA4sDcPO2rgKNLx2s1xa4YCMptpZjbRa2TLYqATwibzTPybl59bT@vger.kernel.org
X-Gm-Message-State: AOJu0YzlsMkvE/ffEd7keUQ0k5TDXCF24ZfsRjwWgyKSgAwBssxNKeGN
	ISavUdX3mePa/lkMRhghTFCqgIQV/soLx3XsC1tSufugOWjeJEr2ziw0g+MB0/0=
X-Google-Smtp-Source: AGHT+IEvDLQ9JZtvl3rdFrkdWkXXNhlmpHGUQNicJFbEKranRXP1xwJjc3KOZvUilRQvOAzVR/r8FQ==
X-Received: by 2002:a5d:6349:0:b0:371:a70d:107e with SMTP id ffacd0b85a97d-372fd57f1bcmr1514219f8f.6.1724242683523;
        Wed, 21 Aug 2024 05:18:03 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371a937a694sm11257656f8f.65.2024.08.21.05.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:18:02 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:18:01 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Guo Ren <guoren@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
Message-ID: <20240821-6befd27b90a9e9ff89f4a277@orel>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com>
 <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
 <CAHVXubgtD_nDBL2H-MYb9V+3jLBoszz8HAZ2NTTsiS2wR6aPDQ@mail.gmail.com>
 <6f1bcc9b-1812-4e8c-9050-a750bfadd008@ghiti.fr>
 <CAJF2gTS4L6=HE_-9rgn3L8+6R7C4Jx=QgCkvOBhQHdHVGzr5MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTS4L6=HE_-9rgn3L8+6R7C4Jx=QgCkvOBhQHdHVGzr5MA@mail.gmail.com>

On Sat, Aug 17, 2024 at 01:08:34PM GMT, Guo Ren wrote:
...
> > So I have just checked the size of the jump table section:
> >
> > * defconfig:
> >
> > - ticket: 26928 bytes
> > - combo: 28320 bytes
> >
> > So that's a ~5% increase.
> >
> > * ubuntu config
> >
> > - ticket: 107840 bytes
> > - combo: 174752 bytes
> >
> > And that's a ~62% increase.
> The size of the jump table section has increased from 5% to 62%. I
> think some configuration triggers the jump table's debug code. If it's
> not a debugging configuration, that's a bug of the Ubuntu config.

And I just remembered we wanted to check with CONFIG_CC_OPTIMIZE_FOR_SIZE

Thanks,
drew

> 
> >
> > This is the ELF size difference between ticket and combo spinlocks:
> >
> > * ticket: 776915592 bytes
> > * combo: 786958968 bytes
> >
> > So that's an increase of ~1.3% on the ELF.
> >
> > And the .text section size:
> >
> > * ticket: 12290960 bytes
> > * combo: 12366644 bytes
> >
> > And that's a ~0.6% increase!
> >
> > Finally, I'd say the impact is very limited :)
> >
> > Thanks,
> >
> > Alex
> >
> >

