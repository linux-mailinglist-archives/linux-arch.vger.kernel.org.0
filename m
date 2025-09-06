Return-Path: <linux-arch+bounces-13398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704CB47073
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF7A40403
	for <lists+linux-arch@lfdr.de>; Sat,  6 Sep 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9C1E1E00;
	Sat,  6 Sep 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJDVKDbr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC791D5CD9
	for <linux-arch@vger.kernel.org>; Sat,  6 Sep 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169273; cv=none; b=fYpsLqEbT6T0pLaVGvAT0j3lvA5DQirCItYPX5vQWJCSRbxQjUqJbBjpaQ5blvSeBsDXJ7gt1SrlehEEFraqHWVjEZtcsLJo549oYiuEpGC8kH6o/Eb171ASPoyMlTpJAtS9Go8OFdusUZ9IO2MsUAuj1KqaIAIYz6CIzo2+SWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169273; c=relaxed/simple;
	bh=z1/hDxQU9TeetDwz3smJ2nlGZaS1m09HT1KJDwHiW28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLEdvQtkbTdi09uu9w7l5KJ5GLvSmzqZpdIzVBt4U7H1eM0HkNCw6yWUMhtxXZtAz+IJo7gJUZob1b+cod7neIV1fibG4SuZvqmxAGSG/d0Pf7BOl12UJihHf4PUODx90tiMx9xwkR1IFaP+37xGEtdkSfGq12VKD5IEMR7iy0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJDVKDbr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5f75c17aeso8204331cf.2
        for <linux-arch@vger.kernel.org>; Sat, 06 Sep 2025 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757169270; x=1757774070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt7wFRSPB7KeMkKKORdkXgliieNDZG4Yik4/oa8YHmA=;
        b=aJDVKDbrniQc1tJ/lDsAA2ZyiiUEMzstovTwauezEY5ep37DRVnbiNxfCjW1pemaSt
         4AylbxWVA2iPMNHsVr4cQreyOOr2UDZrgI8zh0GInN79taJG99nUapsrGR81DB1QZDua
         r3ZyEFqsSVZnI4Ad0jEU6W+wZteX8ZTXj6h7dZsYQ14pcdolCqIVe1iiBSnZzwbxE4cq
         cK4b1n94PIn/ugGfosdv/sqKRUtcpnNc5mpkL6c9BgeFBbZEfXUw8RwpJdxXgZ1X/Z6m
         0O1wM+DoUykJgCR+nYA+ilZoZXd+q7PjDkMkQUtejv8zbjWx4U7lw25wy8iLQ1IjHSIk
         ZWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757169270; x=1757774070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt7wFRSPB7KeMkKKORdkXgliieNDZG4Yik4/oa8YHmA=;
        b=byGLp3TcGZdKb8nw1tTIynR43oJY1OFyYg+YESU7MYEv6qU6qp7vuBBWacHLunnSWL
         UO8NTLWjUgJxTN/kEnReYWu/v8u3XY0dJaz8eotp0nM0ncNLMyAGfvtO1tea1OKpic9J
         ELKGQJ7vrMEDNUbPqPiLUGa/lm/i7HVExjNIqC3FUQs/pCL9pvpD9MMEKo+cuX/t0x5J
         LOodia6frHanGksdeBQgJkl2v1fRqNfMiHKPh1xLHlusTXBIBUq+w0YNIzD8M+e6WXnm
         +l5cctJvixWsTjxT8a/H6SZAsU1QdMkC1w+sTzpnDYf4rEC6oWemK2pyx5ho18oFYAwG
         2nMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGigy14sAWdhzxQwBJuHoSvupRWDQdyNINcRkpzoiBDtFFF/hR9vlZ+Vz5QB5E8mRfsrn/BxNFtBtU@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8UKozxGieDfX1IkPw+Tg8BbFOxnTnfOX7PeiGJk1UeL2DVPj
	gNElMTXR3LLJHGv74EuFTAyGwp4Lzk/BoXLAaM8TyxO5m3VVSA1HINO2o5eqOVxNdIVkASkH5w2
	cDpvqvaQYWcwWc0KXfwrwPxKRiDBUzX/0PW7I2f6Y
X-Gm-Gg: ASbGncseFbSzQbDLHrsQ8Ybze6FBUG4myb3G2kynU5rkiqyICLXh7AZq0em9ti89qky
	yk8CahCvEhqN9mT4bRnu2j3+6Ys1GwifrLsq2YUvFBHO9of085lOwA3Kihqlmy8IqZ5lPmmJd4W
	Pu8MtU054xnEzRnbV5Lo4togDwNOvU03GVC6nFgSgU5DYIY9hH4fQzLZp+tOO0MiCHLSoDGfl/c
	DtU9Di2EGmt0m/e
X-Google-Smtp-Source: AGHT+IHO3bXz5ygJkkb9Cjy4uYf9/lctlCTfBalrOMcgjNGe/xS1Xq17rb70hGH2ABLueaD46/y/jEA7F85RAc1pmto=
X-Received: by 2002:ac8:574d:0:b0:4b4:9679:da7f with SMTP id
 d75a77b69052e-4b5f8485257mr25068341cf.64.1757169270092; Sat, 06 Sep 2025
 07:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906134934.1739528-1-xiqi2@huawei.com>
In-Reply-To: <20250906134934.1739528-1-xiqi2@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Sep 2025 07:34:19 -0700
X-Gm-Features: Ac12FXxdwnS_xL6nfQG_FckU-3OLD5KdJuf5GD974NI0GdSm8rVVaI-5rBHeiL4
Message-ID: <CANn89iLi4CQZhAw7DKVauk0+cC+nBjoVuHgAan=cOsCP07Jh=w@mail.gmail.com>
Subject: Re: [PATCH] once: fix race by moving DO_ONCE to separate section
To: Qi Xi <xiqi2@huawei.com>
Cc: bobo.shaobowang@huawei.com, xiexiuqi@huawei.com, arnd@arndb.de, 
	masahiroy@kernel.org, kuba@kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 6:58=E2=80=AFAM Qi Xi <xiqi2@huawei.com> wrote:
>
> The commit c2c60ea37e5b ("once: use __section(".data.once")") moved
> DO_ONCE's ___done variable to .data.once section, which conflicts with
> WARN_ONCE series macros that also use the same section.
>
> This creates a race condition when clear_warn_once is used:
>
> Thread 1 (DO_ONCE)             Thread 2 (DO_ONCE)
> __do_once_start
>     read ___done (false)
>     acquire once_lock
> execute func
> __do_once_done
>     write ___done (true)      __do_once_start
>     release once_lock             // Thread 3 clear_warn_once reset ___do=
ne
>                                   read ___done (false)
>                                   acquire once_lock
>                               execute func
> schedule once_work            __do_once_done
> once_deferred: OK                 write ___done (true)
> static_branch_disable             release once_lock
>                               schedule once_work
>                               once_deferred:
>                                   BUG_ON(!static_key_enabled)

Should we  use this section as well in include/linux/once_lite.h ?

Or add a comment there explaining that there is a difference
between the two variants, I am not sure this was explicitly mentioned
in the past.

