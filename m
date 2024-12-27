Return-Path: <linux-arch+bounces-9521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92E69FD6E0
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 19:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935413A2441
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1351157C93;
	Fri, 27 Dec 2024 18:20:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC61F7545;
	Fri, 27 Dec 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735323636; cv=none; b=TicPwVwwgvDULKjUeyq0fYhAGjMB7VMCulU1fNvCgV3EYyuESY7SnnpGyewTZY0inwO6qOZhgVqPZ57U/z5NSEV+/5aralCq9Tj63qSUR6so/9SGFyH96DS4GB1vFfgR/n8k8CeVFRP5scdSfUT49BeVupgqUkFff2udMFXP6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735323636; c=relaxed/simple;
	bh=BoYwl3PAg/CVdwua9+ZrulqZe05qPFB/T+I6RNN7zdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYrkmXn/9YjXLnX7Oo7KZU65qX7SluceD+oAIjLxbsZjCvk70HXg6D6RAfmLfBiG7B8PAdWhic96pS7zs9K28U6f3Ov/kijDOvEq4c0vSMqTFhVJKogo7a1XRsYxkNph5P18djr8r7moTMGEStDh014cngcMyRuei6vSLKAJVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4aff78a39e1so2082761137.1;
        Fri, 27 Dec 2024 10:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735323631; x=1735928431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkI36hTv8J6OD2NkiHUPr66tKoQy0KNVpENm/5bfu3o=;
        b=livfY5cUI0FvQWHHvfx1hlb6y0CI7UZ598AOfOdu/OXosuj9q+23MziOg0w2lwNeVH
         rvYidFpIZpJsSort+1h3vlRb+6lpMvXedRSHG3mtHARDKpwomcwKvA3dpUZtWkPa6iBv
         SqGvKK8cHEWC0/GSmLId5vpDB8KBbA1UhjJcMBUEvTHeuqwaKa03XB3fKKtSapqnd35W
         /5AI+E0oATGAiK22IU9sucFjW0x339ArCIg2KilZ7AD7BK//HKZsFvMYjGHb7FNZqqK0
         r4lFAG9ugG+jAPQJFuftQtAeF+IexRxZfwZSj2+1BGVfqDEX0WX6NY4l1iyf7Iv24GzV
         WKLg==
X-Forwarded-Encrypted: i=1; AJvYcCWyyYnQj2IRmRdskA7RHbmuXPxllVGnxw8s2g7S8GfJe5Sg4N0PULl0dLag2iTuY31ToV2E6DYV7sXU@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4c6eI1rC/CvapT9LQGEbMa7Np82pY/+kYPpqHXNh7dIqOqud
	bLLBquuGKOhihzM7jd3Zu70XQ7h1yAtvece7mQbv0VXlXhjT4vY7duic6mxr
X-Gm-Gg: ASbGnctz8oEjX/dxAWcMNOOZs2n4BhBnbmqIHd1wjLrzAdIir1PIWrDXiFgfABT7meY
	qiY6kiRv6UPv3tkh9tekpFONEisv3GwI1BtucQQdWWs/lCq2Gj9d08xu2HM/07C0dmMu1PX50Vp
	rZ6ZyG2VwnJxvarNDBF3cmSrctLwia+iyxvB5swm6MX7J1fZiEfDYf9qEjFB9HSg7b1y617jq9m
	X1LOqvxHVrY/HRh8JsINT4FIWJio9T0FrGOuF5n2OnrHmjAONqrfrj/a84ZN6+VdlMUU+QNi0ii
	HurwHK2kear9Kg20oX8=
X-Google-Smtp-Source: AGHT+IEOLY8tpQGAVMJSzwEOo2Dv/9jYbsqP7btSTbrwvYs8FR2F1B8VciNdnQn9I9i2TekAMLV/AQ==
X-Received: by 2002:a05:6102:32cc:b0:4af:4974:a489 with SMTP id ada2fe7eead31-4b2cc46245cmr22745508137.20.1735323631484;
        Fri, 27 Dec 2024 10:20:31 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8610ac1d4bbsm3113178241.2.2024.12.27.10.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 10:20:31 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4aff5b3845eso2557905137.2;
        Fri, 27 Dec 2024 10:20:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHXR1Cu3qgVBxhJCpzft3iJYLz3ztDxwk6YcHmDbUGntjUbeQFINA8Zc1Q8b4DFQICOPyxX/oc2lzC@vger.kernel.org
X-Received: by 2002:a05:6102:6e88:b0:4b2:cc94:1879 with SMTP id
 ada2fe7eead31-4b2cc941e25mr17219826137.22.1735323630915; Fri, 27 Dec 2024
 10:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222222259.GF1977892@ZenIV> <CAMuHMdVpTtcT9LVGNvFLm4cvrNF=fe1dVsi2zo73Yee3oYrJYQ@mail.gmail.com>
 <20241227162222.GX1977892@ZenIV>
In-Reply-To: <20241227162222.GX1977892@ZenIV>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Dec 2024 19:20:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULCsM_ab-Wx8emtiW9_9zFmQ4KtGeNf0-QVWjjxX8SRA@mail.gmail.com>
Message-ID: <CAMuHMdULCsM_ab-Wx8emtiW9_9zFmQ4KtGeNf0-QVWjjxX8SRA@mail.gmail.com>
Subject: Re: [PATCH] sh: exports for delay.h
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Fri, Dec 27, 2024 at 5:22=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
> On Fri, Dec 27, 2024 at 04:58:58PM +0100, Geert Uytterhoeven wrote:
> > Please do not export __delay, as it is an internal implementation detai=
l.
> > Drivers should not call __delay() directly, as it has non-standardized
> > semantics, or may not even exist.
>
> As the matter of fact, it *does* exist and is either exported or a static
> inline with everything used by it exported - on every architecture except=
 sh.

OK, it does exist, because init/calibrate.c needs it. But that should
be the sole user outside architecture-specific code.

Unlike some other architectures, SH does not emit calls to __delay()
from various (static inline) *delay() functions.  Hence there is no
need to export it to modules. Heck, the only reason it cannot be made
static is because init/calibrate.c needs it.

Unfortunately there are still a few drivers that call __delay()
directly (usually with hardcoded constants, how portable, and
cpufreq-unfriendly), which causes people to try once in a while to
"fix the build" by re-adding the export on SH :-(

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

