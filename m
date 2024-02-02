Return-Path: <linux-arch+bounces-2009-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6798477CE
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 19:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EFF1F23448
	for <lists+linux-arch@lfdr.de>; Fri,  2 Feb 2024 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71520153BED;
	Fri,  2 Feb 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IHeB54CF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAC152E07
	for <linux-arch@vger.kernel.org>; Fri,  2 Feb 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899175; cv=none; b=jETZ2AQiIW2JYI+64TFrEd/5UT0kORHOufOi1ewMaPFiA3XgGi4k36Gh26MVGQaLnVguEnrdWBV3IXnThR1TU9i/wWBNO5j3I4WtnTflM+WGyNLtkeqzA7DceNRr9sOayHYzEh/BwNrRtxcbJCmibPFPeRcnhpTCJI/+xGQ+VM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899175; c=relaxed/simple;
	bh=6vtu3x2Y1jccAeEZW/cOuVCyNA6GUN7mxte5g1lUOrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLKrwcO7RXxdyQ6nl+Ao7jQIAb54EIaFtuDiNLirkAu1kK8j2DcnTK7uUloz2lPNMAfHh1E6c9zulODxke/yWaxv1lIHi/mchunFj4BZIONeK0g2fc8Vb5fBj1dfQNhS4zpTrg8CtIri0n4yJVxoiDt6i472FaZy+OSNu77HXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IHeB54CF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d090c83d45so4368881fa.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Feb 2024 10:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706899171; x=1707503971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EK/oD0i1K4QS8LEPg1LGpWmJwJIYuOve/SpbccIVK8M=;
        b=IHeB54CFUk2Pu6lD2GAj8loMeIw5OHB3CUVpXRt/zRmhwMpktRKIlzjd0TGGAQWQCQ
         Lys1/NvYHNrxHr/aZc2m9O3yaQERM66FEpZEHbGHLGv08Q+OTc1a3JnBUak8NXPz8o2O
         EhC2n2Bt+Kf0bkekEtuOGGOMSb0/k+M0stkGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706899171; x=1707503971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EK/oD0i1K4QS8LEPg1LGpWmJwJIYuOve/SpbccIVK8M=;
        b=TzAzQ0aR4fUxd2d5LtnI/zMadnDm89cRkfnba2LujpG0qW3vYCphAxaeQXxqwXEHva
         V1X7/mH2cglnl1YKJXYTzWlCjgCgRh7rHx/niTOK19hFMZ3m5xGcswm4euXfCdyr1MSF
         U1uM/k95Y/1e5NtF5Ty1Hm4pOmMsIf9cguWeBKYnnbfOnUJwRJKObZ6jdAfY9BDJRPhp
         WTwmggtHdkULY2B/SmW4rq/vWZ1xuNqr1gsGLeBD2UzUpBFhreHMfWtM4YtZlyLwWe05
         PbZ1Xsc2g1k4xlui7p4uKKP+UxgbztILgMPqUM0KYK0R4UIdRd6gP/qsl87Vg6O2WS/M
         3USQ==
X-Gm-Message-State: AOJu0YwJVWcVxxjhk5xy59PP0XTuaIm0o46WrIlOtT71dDhYdKAqRuhx
	cAr1NpcknUoCxfj0TDtW1AGMiXH+GRco1iBp4Bbh4XoDPTHdrzKS/vSzPDz7mjFlT+NesfhJTHY
	wIB4xzA==
X-Google-Smtp-Source: AGHT+IH+jHLtSg0V1xfiZoMBny/2P1jMLSDXGTfE/MlUyPER+KYAQUjadCb1QzcoviHjGsaE8KnMdA==
X-Received: by 2002:a2e:86d8:0:b0:2d0:7d91:9627 with SMTP id n24-20020a2e86d8000000b002d07d919627mr1920386ljj.30.1706899171213;
        Fri, 02 Feb 2024 10:39:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVV1S+BN+Nz2y5NGs1bQoRc7DQQW/+BKMOyaWgryJnm2o5OkOcHhVMhl4huGm1FU/TxyUkYDY8fDhNZUgzM66j56NicYJEs9xYUxA==
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id f3-20020a2e9183000000b002cfe1f356cesm337292ljg.37.2024.02.02.10.39.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 10:39:30 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d04c0b1cacso29963311fa.0
        for <linux-arch@vger.kernel.org>; Fri, 02 Feb 2024 10:39:30 -0800 (PST)
X-Received: by 2002:a2e:8882:0:b0:2d0:8225:919d with SMTP id
 k2-20020a2e8882000000b002d08225919dmr1794857lji.21.1706899169784; Fri, 02 Feb
 2024 10:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
In-Reply-To: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 10:39:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
Message-ID: <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 04:30, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>       ptrace: Introduce exception_ip arch hook
>       MIPS: Clear Cause.BD in instruction_pointer_set
>       mm/memory: Use exception ip to search exception tables

Just to clarify: does that second patch fix the problem that
__isa_exception_epc() does a __get_user()?

Because that mm/memory.c use of "exception_ip()" most definitely
cannot take a page fault.

So if MIPS cannot do that whole exception IP thing without potentially
touching user space, I do worry that we might just have to add a

   #ifndef __MIPS__

around this all.

Possibly somehow limited to just the microMIPS/MIPS16e case in Kconfig instead?

            Linus

