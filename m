Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F22790E07
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 22:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjICU6X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240975AbjICU6X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 16:58:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804CA103
        for <linux-arch@vger.kernel.org>; Sun,  3 Sep 2023 13:58:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a5dff9d2d9so123529066b.3
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693774698; x=1694379498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ES+nP5YI4ojciRGg08Ds7F16RLNJw7ES3Qm1BqAAXxs=;
        b=KCaHE8Ui8dQb+x9E1yUrHL6PtZQtHI+z3oio+KHjwDpeW3S6UBtA7BUBrcfAwte0lA
         0uTWqdY4FXmcSD+I58/VM7l1MA9FUTKzzZzzLqKw14/txLSgksNnnwDLxuwFV8ZrUCrO
         GebuMfAVJXUNYSG9otcujhtdtU3IWdCUh/KjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693774698; x=1694379498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ES+nP5YI4ojciRGg08Ds7F16RLNJw7ES3Qm1BqAAXxs=;
        b=CwJbNIwwcFvXhfBAkGF1nGfbtV5tOE2LVUocn006GGm5br7hHES585Uetk730kx6cR
         GSlbzG9YzpYMp1g7m8nStzwbVSAIvVrHAKAE4ZwDHmj7yDVX0yrjxdBVv8IC/ORJfWbH
         03vMzjsiMtXpoaEBMgS5j67G+V2kqbQb1rAot16+CrMpKpYGdab/Pa9TZjTmN1aPrV7b
         IhXNoq55w2hDiv6U/9N2hSnGKfBlUR+aXjGOX+zzHYIM+6VBTwvG5e+qZbg8tC0aYxQQ
         RwRDCX9/VDlDc4SHoy/lF+ig/YKnep7qw8BXka5IyNq5JTAqhntcUUPFm6OjGW2zsjRF
         Q+Uw==
X-Gm-Message-State: AOJu0YwqO4VKhglSgSaFvSbazrzZHL6bYMLHBRj9Pv52Vphe0/5zqIZ0
        jNiVGXMVuszEYlEdW/czzLTLq5ZJq3vc2yZDLUmfwJfz
X-Google-Smtp-Source: AGHT+IEaBdtlfmP2DFGOmJfIHeP/Cw/DeH+Cir57Pa8KWgqLMq+a7J6/wSj7auczXvG/XWKdgw82qw==
X-Received: by 2002:a17:906:53d8:b0:9a5:a247:5bbc with SMTP id p24-20020a17090653d800b009a5a2475bbcmr5552669ejo.28.1693774697846;
        Sun, 03 Sep 2023 13:58:17 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709066c8600b00989828a42e8sm5200445ejr.154.2023.09.03.13.58.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 13:58:17 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4013454fa93so8200105e9.0
        for <linux-arch@vger.kernel.org>; Sun, 03 Sep 2023 13:58:16 -0700 (PDT)
X-Received: by 2002:a05:6000:10f:b0:31d:d48f:12a3 with SMTP id
 o15-20020a056000010f00b0031dd48f12a3mr6091707wrx.43.1693774696650; Sun, 03
 Sep 2023 13:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com> <20230903204858.lv7i3kqvw6eamhgz@f>
In-Reply-To: <20230903204858.lv7i3kqvw6eamhgz@f>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 13:57:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
Message-ID: <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 3 Sept 2023 at 13:49, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> It dodges lockref et al, but it does not dodge SMAP which accounts for
> the difference.

Yeah, just doing that "check if the name is empty" is not free. The
CLAC/STAC overhead is real.

I see no way of avoiding that cost, though - the only true fix is to
fix the glibc braindamage.

In fact, I suspect that my stupid patch is unacceptable exactly
because it actually makes a *real* fstatat() with a real path much
worse due to the "check if the path is empty".

We could possibly move that check into the getname() path, and at
least avoid the extra overhead.

           Linus
