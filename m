Return-Path: <linux-arch+bounces-11153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF2A727E0
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 01:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2626F175C21
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 00:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D63DF42;
	Thu, 27 Mar 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WJxxTZfs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E7DDAD
	for <linux-arch@vger.kernel.org>; Thu, 27 Mar 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743036584; cv=none; b=An3Q5+TuBmH5CFx9Dnw1veRUTbPANfTTF8vSsdDiq18pLCaQeWnaMwTPr3PiYL04iwQS5jUg0Rnig14UxFLEBbmc4ku1Zw2VhNRgeFcVw6tp+uVKXdDAwMfQitj08e89LhmJP5vhC4mcl6/b8UuNWs/Y0hxZMC/ERTdBuvV6Xgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743036584; c=relaxed/simple;
	bh=uTlzJpHa/l39T+5v82eVcl2xNO4vUMg9lTUbP+RWk38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qh5iww/BnwIh565b/PtOA7kgPyfl/d0F98IdC7j1WoUaLqAKRzWjJxlsFjKn7yXPBgciMNr7O6FADBeUCcKIfh2J1ihAxnzVS7xzcV7iKCicnl/H0VSPnEkZBzDkhGge0RNm2+8v5znAZvLHaXc1MI8p31drbftJc8R3VpnU4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WJxxTZfs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac29af3382dso66379466b.2
        for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743036581; x=1743641381; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1EIgK2xuAYOvd8rhnPgSHreHLkjAZKxgBPQFMjmtwY=;
        b=WJxxTZfsAQxWwyUu+J3PPAkM5qokCZDucwh8bl5T6VWCqdUNeLyHpBJV8s4NVl0I/r
         YGBHFygakG46ADcho0qc1aTY8fmd7kABwpZcMt4t+LJ3eAbjXg+GCGrD4vFX50cwH2n/
         8xMe2HFku9ZOebvilpzYWw59Ll+terI4BQMuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743036581; x=1743641381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1EIgK2xuAYOvd8rhnPgSHreHLkjAZKxgBPQFMjmtwY=;
        b=SNyV6RdJ+8pHk0HlkiaPxPe+X8z8G1pXtOMN6jaRl78RDhR2d7pLEPims55uQxf7Cw
         cAFNAidNEp7FvzZ/SB4tJ5JERObGXRQzykc2k+uSASY4NMrOlqtP1KTCwlsEc7+3De48
         CMM+uNRlXy/WNcHitOvF2LFBzZRRlvLsoN60ffps/vY1Ostf3e8u7CLbAuttUrg4TAL5
         d0dQHOGSbtNbh/248NWIEeMaC42zRlYEcRAWuOrQqjbLmW+HdwEFslPJNOQtSEyJAfVy
         Rmts0wqBeEheII25nEjfuGGmMBHN0TV4oS2y2iyHyLoDJECIWCg+FBRCz9UhdphTqHL8
         TCGw==
X-Forwarded-Encrypted: i=1; AJvYcCWYEglt5+0z2bzGp8dMdvyRnO6QaS1PeGRHTu/SxCJTksIAW6HPvVqeahJBQbEmfcWg7S9xVNLnu21K@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSJhKpgb6mVGhrEX5cSHB7J0mKvZkBdQNBRJEQ889o2KcgoFh
	iLSyGWKpUekoyrKvtu/EQlIrpbYVZedIsEa7cQUH60he/WBoJROS3FCIAXgsai6QWdWQSUjcl65
	Y2iM=
X-Gm-Gg: ASbGncvfSMGSPnhhS2kNBFn4EeVvh3C11J91/iNK2i127Uh41nMqxalykufT1NvSI3j
	FRteSlbqkh2OQa+tD0R/WQI2kvVDfu9FRE4ycWh9XwYPY5mzxhvlrWclWzIWzfUOnURpjSAsyJL
	SlVcWwaPYOynDUvLS+7K/rssDObhMmeUsu1tNlm3r0LAP10IRUf+h1WmFUfJmADwLG7nxlI5/jR
	GcGsrgAYKA6V+zxoTR2Mcz8gdzUh6MJE3Yz3ve92yfewKSlgSR9aS0c310BlChjo0v4n0Xk0Kkq
	FZnUXmG5aZUv1K6du3j0dScOmLKmT2F4Mp3rxjR5YgptYqtwFSr7jKlSZnTUqd0ClDKhHUxacqP
	tMX7S12ZPWDiXZMnOLEg=
X-Google-Smtp-Source: AGHT+IEvTaxBuoObMAor6kr3acVv0nrL4MZ9QUFIxQH3jzHzaO7Sgr2uiOoUNg6BFgCF9wKJ1HxLSA==
X-Received: by 2002:a17:907:1c27:b0:ac2:cf0b:b809 with SMTP id a640c23a62f3a-ac6faefb3c6mr117007066b.31.1743036580681;
        Wed, 26 Mar 2025 17:49:40 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb6483fsm1123490266b.112.2025.03.26.17.49.40
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 17:49:40 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso61471466b.1
        for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 17:49:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAg/wbu4T7GHDeFGxVaPxZB2NOBkHP81X8OIcsLFwNJjS64o2+vpyeS5bLxMLfiKtVFlZ1PRlP6nGR@vger.kernel.org
X-Received: by 2002:a17:907:2d9f:b0:ac6:d9fa:46c8 with SMTP id
 a640c23a62f3a-ac6fb100915mr152491666b.39.1743036579668; Wed, 26 Mar 2025
 17:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-rwaat-fix-v1-1-600f411eaf23@google.com>
 <4b412238-b20a-4346-bf67-f31df0a9f259@app.fastmail.com> <CAHk-=wikuhxhdSEgqb-Lkb2ibQM_hAHR1Cu7yxg-gHZu1NF+ug@mail.gmail.com>
 <20250326225444.GA1743548@ax162>
In-Reply-To: <20250326225444.GA1743548@ax162>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 17:49:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJRECUF-7yt9pNxW_bc=4nJcxn5H3duW_HefY3pKwZag@mail.gmail.com>
X-Gm-Features: AQ5f1Jq0NfJ4NCA_LPq0S7Om_u6cJNLASqmiOGbxN64ioDsS5u1gJskOkebSHUs
Message-ID: <CAHk-=wgJRECUF-7yt9pNxW_bc=4nJcxn5H3duW_HefY3pKwZag@mail.gmail.com>
Subject: Re: [PATCH] rwonce: fix crash by removing READ_ONCE() for unaligned read
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 15:54, Nathan Chancellor <nathan@kernel.org> wrote:
>
> > Put another way: I wonder what other cases may lurk around this all...
>
> That change has caused only one issue that I know of, which was fixed by
> commit d3f450533bbc ("efi: tpm: Avoid READ_ONCE() for accessing the
> event log"). I have not seen any since then until this point and I do
> daily boots of -next with LTO enabled on both of my arm64 test machines.

Ahh, ok. That makes me happier.

I guess unaligned READ_ONCE() code really shouldn't exist in generic
code anyway, since some architectures will fail any unaligned access.

But those architectures tend to not get a lot of testing (they are a
dying breed - good riddance), so "shouldn't exist" doesn't necessarily
equate to really not existing.

          Linus

