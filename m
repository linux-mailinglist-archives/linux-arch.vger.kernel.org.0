Return-Path: <linux-arch+bounces-14270-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD2BFD554
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 18:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 824CF358B77
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229AA34D4C0;
	Wed, 22 Oct 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcCo87Yq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CF34C9B1
	for <linux-arch@vger.kernel.org>; Wed, 22 Oct 2025 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151315; cv=none; b=Ppb1zGN6hPwkafh3NNA3xxihrXynff6mb0uTTDNX/EGeY4y6ZBaCrjZ6XtddLMcEveZgsItm3lpSRGCXdH3mLDVl+3WPIaE/hWLo8XoDO0cWHRwSYRTunnBuW/yY5RjdARPfUGELt5Exue6O0vn2Ht/Aiz1cY7YqNHFCWvnImpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151315; c=relaxed/simple;
	bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U46eKiSVVEWpyQFRYXGtK2W564c35M3ubmfgVNAQGgnwWzw/7Kccb6Bby1tE5Gqplrah4m21749TJwAC7nXXRoHY+jBIVkTihnfh43F64ewBFlu4W+ZLb0iAdJklGjb/uaKPm+DgYkrxxI+0Lpb+9bR8MfscOsyMmxZ9qOVwrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcCo87Yq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b50645ecfbbso1388902566b.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Oct 2025 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151312; x=1761756112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
        b=TcCo87Yq/iqTvWnBnXr1s/sb405+ysTLf/84TAuBDnKBBDUXPhVcnrRzwWKSmvJPHM
         sHvLDJy4H+au5p0MkDVRxE9dBRvvR5TXtEajr8oGykSgG9bDfoNc0SlJdAn0+tOvZfUF
         nDkYKnfeNYvxMDaPVIu7RTFhe+JFog3XitWtISUFtnLJq8yv/Ie79MJmif4ot1haGFCd
         eahrAgwlG3DgFuB8g1YM9qlrtpgocKryspGEc8RduAwwVtt+k5wKIBMXCj03ujxrfucx
         vvNSnbdMyBfFKGJkyK/ZXqMenwgzukXmQnWfk2h2YtnVuv+LJSuNRCoU/aN8C5Nys+E1
         YxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151312; x=1761756112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcYgA1Dp2f8fgnuyFgD78VApES3CVJQ6ODo7jPzfgGI=;
        b=j2JKplAH4FTMz81xLClmIUmabOyMWP9vdMXTVXN/FQer/U504VVWFGj/IsPtPZUt+5
         dRBjRSj9+OASM3XqsYiVosevixg13n9QhMZRNZClaDjxsWo3/PWksN7uhB+sTeOfrF4r
         ReSpIsygWsu9fE91k/2202qqeM5HI5n29pYlj1DZXiuUjpSrAzM8yuE4XoYeusbtxdM2
         sTtFzTQkGVaAtD+9UckRj43KmWy246gZ6iMGC18sDuwRRS97hiBkqxb+Cq5H7jt/J7Pb
         qVsZFv2migbFM7Cs01mXKJ2ver6YxzOZZQg+X9wUIWmgyRMZxcBwd8NjFc04klalD3J2
         cujA==
X-Forwarded-Encrypted: i=1; AJvYcCVA9Dae8LdrznUw/qlcwCFkpAUYxkMY8+AC7bgdosvWKaCr1cEPf5LAd7IbT1TkXJMuD9CSnD+Oi5Cu@vger.kernel.org
X-Gm-Message-State: AOJu0YwgewY2zGP4zqhPlJvvmtf4Ap1ymxq819xFziIciz8n10ioPuxQ
	7l11SJbcAL5v339OaV8ZxCoqYddT/TYwwdvi272ZA1ZNdR23z52/s4WiAsatj/ELsSOqyPkFDFH
	N38RJA+Hq0RaYCeXo3FLfrQfa08Ah4vk=
X-Gm-Gg: ASbGncsfbUbsq2m3tP3rmbm5pCPFZnnrK6R+tuKm0yNJqCmFKrXUK9KQ1jFFnxJ+ZmH
	eUIHtTcaHK2sV3NPZTph48PMe7XKhZUhjy9HHGKvVi7AaF9ykQqgwF/O+11L5uZXKt6fduMeNZo
	NajfffE2BiL0D+G+EL/ePyG9bVUJ2DilvxpIT8OLcpFs48pxswCF0kRZpjEpCviQxOPgTvLdTj/
	cCZnHHhcFFLgy5qe8WxMxoa+wWwTDXNR/RLuNmO2zzgjGhRE8WOVGXcqDt6skw7lXeX71r/
X-Google-Smtp-Source: AGHT+IHkWGnG06JOtYFwx6WKEecUCCr1fs/y3xfoAi4lziINz4JBVkxPbzc5Y9qrcmqbPId7dzqQXzuYY7OGWY5xDrg=
X-Received: by 2002:a17:907:c11:b0:b32:8943:7884 with SMTP id
 a640c23a62f3a-b647500ee9amr2300275766b.45.1761151311555; Wed, 22 Oct 2025
 09:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPg-YF2pcyI-HusN@archie.me> <20251022080626.24446-1-safinaskar@gmail.com>
In-Reply-To: <20251022080626.24446-1-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Oct 2025 19:41:15 +0300
X-Gm-Features: AS18NWAouNqJg7toJrl3zFJYl4AxgHZN6-E0xEGlNVrmOGgNKVxnzpVBWI-jPi8
Message-ID: <CAHp75Vfb5J9P1vhSWkGy_j+ter_774ThBJHZuSp=r583xGP8Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] initrd: remove deprecated code path (linuxrc)
To: Askar Safin <safinaskar@gmail.com>
Cc: bagasdotme@gmail.com, akpm@linux-foundation.org, arnd@arndb.de, 
	axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, 
	christophe.leroy@csgroup.eu, cyphar@cyphar.com, ddiss@suse.de, 
	dyoung@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	jrtc27@jrtc27.com, julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	krzk@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, monstr@monstr.eu, mzxreary@0pointer.de, 
	nschichan@freebox.fr, patches@lists.linux.dev, rob@landley.net, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:06=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
> Bagas Sanjaya <bagasdotme@gmail.com>:

...

> > Do you mean that initrd support will be removed in LTS kernel release o=
f 2026?
>
> I meant September 2026. But okay, if there is v4, then I will change this=
 to
> "after LTS release in the end of 2026".

No need to mention "ater LTS release", we all know that this is the
last release that made the year in question.

--=20
With Best Regards,
Andy Shevchenko

