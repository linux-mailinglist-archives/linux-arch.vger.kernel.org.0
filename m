Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0876142D78
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 15:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgATOZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 09:25:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36861 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgATOZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:25:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so29799095wru.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/e5dg21LEzYYUw3GLX+eh4t5Ki915Hi9I2m5nwm1oQ=;
        b=WIaInGW1/YxWU+FMNX6Iq+apLMpk1qMvrKrpuCVYR7gF8m5cysUPa+7JtkGEGoDkcF
         4p34U6amoJJ5gWmLCY/VlsGZ2U0palDNCFJrSx9GGfncovXSa6btP7njUfMmBHw7o0lR
         gut1ORxfLanximKRdXh0vfGW/MwT6GXE6i3NmqztmGvZs970er4sU64ChQ8B+YutIQDv
         FZA5Ib0jaa6l5W2jRAmHWGakpr9YjR/RwU3l67kndt7SFfYMRXAMnz5JP6tJLKu/0Frd
         C00vLssT2gS+wcMi+84wVcXig+Oe8dTvyrci/lBFkX/b7wV9ZZEatZElyuzbRuww5QbN
         fykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/e5dg21LEzYYUw3GLX+eh4t5Ki915Hi9I2m5nwm1oQ=;
        b=mqWPLgABSzMavtCBNRsJk1zOxHKsHju/mHL3BS13mqKTJZPEbr2TgbQ1A+UAWo1uy3
         AQSvP8Blrw4H+9Lgx33ZMSW1KWbaY5Qwann3/diyHcau575LObv6T8QQEzvnRZ/APtn5
         2PqaQ3KC7gOY+YVSDFps/6SeZGlbFvgAnfDPQO5c9tOBiGVskSuUDViuA1jTWZHvQovU
         nZ/DthQYVPPsdlN/+875bugEWg5ZG1o6Cr6Z0bTNRFTazEoy2AJq6EJ4b5j02J6592po
         1t3zdpii7dEgwWwDitfP7IMeuA2kHbxBcA2lY1enaqQ73xGaSlsJaKEE9HVcVMiSQyWv
         Jr/Q==
X-Gm-Message-State: APjAAAWSRFlQFJLgsax4Hy1Li5qz5CPum3NT6f79EoxTu7q4w57ZJND7
        yylZeFAS6kOmC+2rR2ZZULCv1BQ7jahciQ5Q5H/mRQ==
X-Google-Smtp-Source: APXvYqwKz3415rtQk6sMnniIRBrA9/wL6CnUrN2n5iQOicJlTjqQi5LvMPRLcboyhgam00gmvqJMkOTx2iaiKQTmSNk=
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr19036917wrm.345.1579530334844;
 Mon, 20 Jan 2020 06:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com>
In-Reply-To: <20200120141927.114373-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 20 Jan 2020 15:25:23 +0100
Message-ID: <CAG_fn=VyL3t0L-ZhRtc41+fcipmSWrhwb+QFkRZ+ZeZQ=X_dLg@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, will@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>, christophe.leroy@c-s.fr,
        Daniel Axtens <dja@axtens.net>, mpe@ellerman.id.au,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, christian.brauner@ubuntu.com,
        daniel@iogearbox.net, cyphar@cyphar.com,
        Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
>
> This adds instrumented.h, which provides generic wrappers for memory
> access instrumentation that the compiler cannot emit for various
> sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> future this will also include KMSAN instrumentation.
>
> Note that, copy_{to,from}_user require special instrumentation,
> providing hooks before and after the access, since we may need to know
> the actual bytes accessed (currently this is relevant for KCSAN, and is
> also relevant in future for KMSAN).
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
