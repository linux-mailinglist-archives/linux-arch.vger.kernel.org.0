Return-Path: <linux-arch+bounces-902-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F417D80DDF6
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 23:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5521F21A90
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 22:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3E95577C;
	Mon, 11 Dec 2023 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmleqSyA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4D7A1
	for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 14:08:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso5815e9.1
        for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 14:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702332518; x=1702937318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlYlHCXGFU5KZ74rv5ll10Sv9Er2/TqtV7SmAS1Ie5U=;
        b=fmleqSyAoJZqKuOxvTFhOA72jJdQb1AodQZBs7Isl+mYKM2JAp+t/WS7sNwTgrC7f6
         PvzJ84i3Ehl2rZtYUIquiqD0yt0BnyokdTCq613WvfAhYZ/I+KeJYsfFztW+o0pFISym
         MTnwHdfk3l+mTsASlFujN0Ga3bMl9gn265etgTGWuZskylOJB96pvBDI6W8EfzKm4evc
         Rq4+s8ZApP0TLCE52ZZekDQfh4S1NmeKTTMOAuC6Aiw9TohCoI5LohgNJs9DXtqm8G5a
         UPpQrUXd1PyrNOv+ZYj+hCqrsc02r1yLkQye6yKzNgYZBm52NthWo2HPsxu4G+3wm5v7
         2FCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332518; x=1702937318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlYlHCXGFU5KZ74rv5ll10Sv9Er2/TqtV7SmAS1Ie5U=;
        b=te4BKh1dToyxPDbKY1gf7D/JfKd57jel0em9WOX0grNWW2O7MqAKerr9DLw27XgnEz
         S78HbAqDPKUQWxBogfS9A+eAXxpyK24lmLk7sgZyGPPri4v7F9/lEU2SrQOMhRGXCGdq
         rlKDjym2s/XefHm+W7IfGMbRRf/5oid8VXg9cKMIFVkG51YtU9kPnGA8kIzC8E3VRI2c
         /7K3HXaF2/qPYrqvfvtqQLPcDqew5rTOaSGo97N73bGccgHLUxdQQ+I5ovy1J6ZwPret
         ZYKXwbcX498HESMLrX5+qkhvwAZO16BoDKVdLWBtY7PWB7oZUV80fgICYx859dthFxZQ
         BN9g==
X-Gm-Message-State: AOJu0YxznHhz/ybB7WWoxbvNgBe2s6Mfd9mLrb82o4kBecCd4pBAqWdV
	ddBzmJKHSa/a2wUCXjDk2wtP4DE2+QClD/qZy2NJfw==
X-Google-Smtp-Source: AGHT+IFuAyP9/JaBzGe8rYcHm/Q0KPYoxSvmWT8WuQnqhqw+DqOV8MCYwzViQ3hUogw+SsUQ69z4RZeaHd1XvbCJjYE=
X-Received: by 2002:a05:600c:2941:b0:405:320a:44f9 with SMTP id
 n1-20020a05600c294100b00405320a44f9mr243192wmd.5.1702332518004; Mon, 11 Dec
 2023 14:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com> <CABVgOS=5Y_CrTZ4hs57UGdR_p1aK2+1w2-aZ9EVELsbRdVvqTg@mail.gmail.com>
In-Reply-To: <CABVgOS=5Y_CrTZ4hs57UGdR_p1aK2+1w2-aZ9EVELsbRdVvqTg@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Mon, 11 Dec 2023 17:08:26 -0500
Message-ID: <CA+GJov5qipT2EV2+UjtRzvjjtTA_OOtOgZKbRiitmYpbrXrE9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
To: David Gow <davidgow@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de, 
	linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 2:48=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Tue, 5 Dec 2023 at 06:19, Rae Moar <rmoar@google.com> wrote:
> >
> > Alter the linker section of KUNIT_TABLE to move it out of INIT_DATA and
> > into DATA_DATA.
> >
> > Data for KUnit tests does not need to be in the init section.
> >
> > In order to run tests again after boot the KUnit data cannot be labeled=
 as
> > init data as the kernel could write over it.
> >
> > Add a KUNIT_INIT_TABLE in the next patch for KUnit tests that test init
> > data/functions.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> I think this actually fixes a potential bug, as we loop through the
> list of suites after init has ended in the debugfs logic.
>
> So maybe this is:
> Fixes: 90a025a859a3 ("vmlinux.lds.h: add linker section for KUnit test su=
ites")
>
> Regardless, I'd love to get this in, even if we don't manage to get
> the rest of the series in soon.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David

Hello!

Thanks for reviewing! I will be adding this fixes tag. Should I make
this a separate patch for the next version?

Thanks!
-Rae

>
> >  include/asm-generic/vmlinux.lds.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index bae0fe4d499b..1107905d37fc 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -370,7 +370,8 @@
> >         BRANCH_PROFILE()                                               =
 \
> >         TRACE_PRINTKS()                                                =
 \
> >         BPF_RAW_TP()                                                   =
 \
> > -       TRACEPOINT_STR()
> > +       TRACEPOINT_STR()                                               =
 \
> > +       KUNIT_TABLE()
> >
> >  /*
> >   * Data section helpers
> > @@ -699,8 +700,7 @@
> >         THERMAL_TABLE(governor)                                        =
 \
> >         EARLYCON_TABLE()                                               =
 \
> >         LSM_TABLE()                                                    =
 \
> > -       EARLY_LSM_TABLE()                                              =
 \
> > -       KUNIT_TABLE()
> > +       EARLY_LSM_TABLE()
> >
> >  #define INIT_TEXT                                                     =
 \
> >         *(.init.text .init.text.*)                                     =
 \
> >
> > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >

