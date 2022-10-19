Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5906604E96
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJSR0a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJSR03 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 13:26:29 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE51BF229
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 10:26:27 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id n130so20012371oia.6
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cupPL1neXJFDi/CczZUnnSksrOf8QPniSG3CPoyTvwk=;
        b=Gac78J9i90UOUBCVrylc5ZrTgnCY15Gnsk7zaNO8hbQdMniRSpKeWxkTTG5TuRyEZB
         UDik7FL9jFr1ZdlcLkLkZx9hlXsSPXv05eXESmVQoWZJDrDoiml8TtqDCjSsxyMM3DcH
         ByvbBAe5KO9N+pJ+tA8JESSDV1WDzdBhegWb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cupPL1neXJFDi/CczZUnnSksrOf8QPniSG3CPoyTvwk=;
        b=gHvhwrL0W9NRzg8xs0hEZkDvV9BfGYKJIoRl1VJKHLX+eV8M4X+ilvpDv+agQP4Wx8
         476b7ZG+6BHNK1YZABycw70OwBxhiK/tzRPeWbo7ApjIpw5JWI/rMbXUuJyxrXQrKO7n
         8RyuaNnxD4HwE8SF1OzxIC0IhaAysLMwELYl0WnTtxtzB/lLW0m1+/DF+2/BKs5neRXN
         bF7Z48IkzUvj7+uQwmXAHa8OLQtUB91qwrnheugCGBx5/yg5RDR67sM+8DwDHOKLDZp4
         0iU2Jj2RPEJYCedqmffcU6hqHFUfRzc3fHjLa6c/wIUGzcncot5Ex5ru55qojVbTHPkd
         HgPQ==
X-Gm-Message-State: ACrzQf3FGOq2YB7IR18K+xvU3wHFQxcy7O9XFVlYtw8kZdvcVwlkMWbv
        4eMM/Cu3vdKuR1pPdK39ou53tZs16lZD5g==
X-Google-Smtp-Source: AMsMyM5dEd49d4PeVvaPncvETAWoEgXVeDoUvUXvqabDT5DaNr7P9y2+Q0eY1LGltrp2T0Ns9X2gJQ==
X-Received: by 2002:a05:6808:11cb:b0:353:f841:e390 with SMTP id p11-20020a05680811cb00b00353f841e390mr4804859oiv.149.1666200386637;
        Wed, 19 Oct 2022 10:26:26 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id n132-20020aca408a000000b00342eade43d4sm6900726oia.13.2022.10.19.10.26.25
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 10:26:25 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id o64so19992895oib.12
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 10:26:25 -0700 (PDT)
X-Received: by 2002:a54:4899:0:b0:354:add8:52ab with SMTP id
 r25-20020a544899000000b00354add852abmr5135777oic.229.1666200385369; Wed, 19
 Oct 2022 10:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 10:26:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whggBoH78ojE0wttyHKwuf48hrSS_X7s3D3Qd_516ayzQ@mail.gmail.com>
Message-ID: <CAHk-=whggBoH78ojE0wttyHKwuf48hrSS_X7s3D3Qd_516ayzQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 10:14 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The pointer-sign thing doesn't actually help (ie it won't find places
> where you actually compare a char), and it causes untold damage in
> doing completely insane things.

Side note: several years ago I tried to make up some sane rules to
have 'sparse' actually be able to warn when a 'char' was used in a
context where the sign mattered.

I failed miserably.

You actually can see some signs (heh) of that in the sparse sources,
in that the type system actually has a bit for explicitly signed types
("MOD_EXPLICITLY_SIGNED"), but it ends up being almost entirely
unused.

That bit does still have one particular use: the "bitfield is
dubiously signed" thing where sparse will complain about bitfields
that are implicitly (but not explicitly) signed. Because people really
expect 'int a:1' to have values 0/1, not 0/-1.

But the original intent was to find code where people used a 'char'
that wasn't explicitly signed, and that then had architecture-defined
behavior.

I just could not come up with any even remotely sane warning
heuristics that didn't have a metric buttload of false positives.

I still have this feeling that it *should* be possible to warn about
the situation where you end up doing an implicit type widening (ie the
normal C "arithmetic is always done in at least 'int'") that then does
not get narrowed down again without the upper bits ever mattering.

But it needs somebody smarter than me, I'm afraid.

And the fact that I don't think any other compiler has that warning
either makes me just wonder if my feeling that it should be possible
is just wrong.

                   Linus
