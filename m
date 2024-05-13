Return-Path: <linux-arch+bounces-4361-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE818C4511
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C81282906
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD615534C;
	Mon, 13 May 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FNZ1pN5h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB9155352
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617666; cv=none; b=iQNs5YYrcNqenIE388VmXSqdlVQti3R2m6eNQ6x5inQoXAYiDCmxsLOZq90fUAvA1MQSzgVh5Q2EcF5bIqnytPc4jXXG7/XCKqpYKjncgn29oGEHZ5wQ134LK5us5O5Tdm2WsewuafG+xCAGMvZv7Ph0atf4uJdEHFS7o+ZdSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617666; c=relaxed/simple;
	bh=indKPqo7wgjPODxZ3n6dtvDts7VXZJSCW/Fui71Wi8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQvhbY4XERf/6yGmhJJc4Sh49GNGTHedxudq23vKHsi71Hyx10olW/ClN6JfJIqiLjSHQ0JH86u5IoWwtXtiKLEQ/tb2MZUtlyWj9wNYHR7/Jb0Kr/T1o46tKzGeKpVfENsV7ifit/r6PxVi24dsiBK7vD0keX8uBiblXgVW9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FNZ1pN5h; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a64db066so1151203866b.3
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715617662; x=1716222462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AW+bcvxmWZZxt4c3Dh0r2wINUf+borweQyDfSngaYos=;
        b=FNZ1pN5hNtC7xzOiicOPSaFeez0mu9wjN1ksyFhRVxok5UaO3DYJ2n7/5fsUqKHxHE
         CTr7LpRdjBTJXII+YDLyeHzxYOla8U6oP0Cd7f98aGfT2wp37Ieep0E4evp2MDGjGlmX
         PEJND0QbpR9xQlPvs763oesM2bbAQRAKZ2jIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617662; x=1716222462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AW+bcvxmWZZxt4c3Dh0r2wINUf+borweQyDfSngaYos=;
        b=D5XrLrZ46W/lJnjYeRWnm0Sz80MyKQM565DRofCScDD0rr/INqvE1tCd5tZjwwWh+R
         pbzLNQRoJJAKeuWpIcxd7Gvwcs3yaHIbeSfcXOm67+PWSlOq5C0fRDkGGoVVnF8Gq8UT
         3T3xVNps70tmxM62HFszk0SXOm0oiX36UXvm2texWe3BmAtEKLzgwih++24HHgIRFpZc
         h4mHdOSPqiHR63L2xMkylFKbmcSooAxIlIrfhh3MG38Fl58Ws9uO1/NebJI4cz+cjlED
         1dm0RoyH6ZyAVGeQFkE0Y14YEMk5ECwTtK/N3RGEd8x6IRwh/bAYSXd1RkrcjjRxrVK0
         XABA==
X-Forwarded-Encrypted: i=1; AJvYcCX3xMkmJeu3hPy/kU3fGXbLElA+NGmWnJ3WY36Xo1ef0X3B2C8wtqxTUNQ5C1H20ZkqYGFyMRJXcWW3QYmsVStfIIcNOektWtmjLA==
X-Gm-Message-State: AOJu0YxMJJN6rLZptEO/CN2WOm5yhiJaw4saaDI/+l0+RQEEbb8nJKgg
	CvdGOMEowIh0zbLvQdF7/rTHCq1FEuUpsGlcKYLwo+ndRuqaNBLh7Z03idPXcsMphctlW8FEreq
	unII=
X-Google-Smtp-Source: AGHT+IFmKbZVcfbW/txHTUDwICB+64haw8q4GmBRncEYvddbUuWZHkFM98/hfXJZWnoJ5ZAvo2YC5A==
X-Received: by 2002:a17:906:5a5a:b0:a5a:34ae:10ea with SMTP id a640c23a62f3a-a5a34ae118emr552838566b.76.1715617662387;
        Mon, 13 May 2024 09:27:42 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01797sm623795466b.176.2024.05.13.09.27.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:27:41 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a9d66a51so1061701566b.2
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 09:27:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEd71Ruuu147ZN0akneM0Is26A5oyJu1lMz3IMgeT8eGezWk6nzuQhHL+cxFzUptnNQ+orH3Y2p+Tkek4OT3enRvkfKO5GlG404A==
X-Received: by 2002:a17:906:f88c:b0:a59:c52b:9938 with SMTP id
 a640c23a62f3a-a5a2d6653bamr696929366b.55.1715617661402; Mon, 13 May 2024
 09:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com> <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
In-Reply-To: <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:27:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ_fCwC5iGri1KOEwdV90H-myv1gSfjHfCwt82ZXaCWQ@mail.gmail.com>
Message-ID: <CAHk-=wgZ_fCwC5iGri1KOEwdV90H-myv1gSfjHfCwt82ZXaCWQ@mail.gmail.com>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-alpha@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 14:20, Arnd Bergmann <arnd@arndb.de> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-alpha

Well, despite the discussion about timing of this, I have pulled this.
I still have a fond spot for alpha, even if it has the worst memory
ordering ever devised, but the lack of byte operations was an
inexcusable "we can deal with that in the compiler" senior moment in
the design. So good riddance.

            Linus

