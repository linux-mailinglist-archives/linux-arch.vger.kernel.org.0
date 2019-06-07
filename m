Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2C394FD
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 20:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfFGS4k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 14:56:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37488 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732071AbfFGS4g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 14:56:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so2646432ljf.4
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldUxE0mi4WaCkQbvj9tDP1Y3dc9QMW/mTJhHqgLzTEc=;
        b=RKAsnvIg7cohPa9ftFN/RAF3uODOQevDuoFKHSPc0Xl7WdRdmcZdyGnMNLHluRHbqx
         u1w+QeICOks1DEl+AX3rcan7uhfcKxu3t+qYGPITFJ/CPSgD+SwNUDgnEQevDh4687CE
         28hm9HoLaAqEQO2OQjx2RFtlsWUqCO4SqrVko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldUxE0mi4WaCkQbvj9tDP1Y3dc9QMW/mTJhHqgLzTEc=;
        b=p/OjFhMiAY3U+CpcdpZJ+R/Hyq7CbfRixyGYF3tEOcJ0KcG0ye3hBmWOwEHxPKphJQ
         nrFIVywoq0xFDGSsKGgXIilGucVe8G/P7iMUR3AHXb1EnrQKjGTdBg6fQWUj/hMi7dSG
         0U6Fg/CwPe4kOjgeDZrbmIH/AE6ZoOAeyx5KT8SCK3gAn+yps0fnAhcDDXGlswPX4iW0
         gyteLHi6b0GHBke63wBdjU4FYIAU69FJZYGZdze1NAmaw11OQtMxgRUvjRfCeWQCep0w
         EN4Wqau6MevoFjV80qz/z5lTrV239hKDjW+XQlqU1dsKzZqGkMoSchF6Gqw5Ycv3C0yQ
         z/2A==
X-Gm-Message-State: APjAAAV5YzB6tb8FaBbbFoSESYcwhRLyLrSKqb45ganY0/ei7kKj7EYX
        UEDoJToPNsEA+nF3sdSoY08gc5a63wU=
X-Google-Smtp-Source: APXvYqwUKY/qVwd1wxob2ZaoPa74GLwAhiYiNMUE4ZCDf4DavFSVoYNzIn78EHzU92x7t3ibSuS+Yg==
X-Received: by 2002:a2e:6545:: with SMTP id z66mr29397124ljb.146.1559933793585;
        Fri, 07 Jun 2019 11:56:33 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id q2sm539861lfj.25.2019.06.07.11.56.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:56:33 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id o13so2633290lji.5
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 11:56:32 -0700 (PDT)
X-Received: by 2002:a2e:635d:: with SMTP id x90mr19091410ljb.140.1559933792458;
 Fri, 07 Jun 2019 11:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com> <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
 <871s05fd8o.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <871s05fd8o.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 11:56:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
Message-ID: <CAHk-=wg4ijSoPq-w7ct_VuZvgHx+tUv_QX-We-62dEwK+AOf2w@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 7, 2019 at 11:43 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> On the glibc side, we nowadays deal with this by splitting headers
> further.  (We used to suppress definitions with macros, but that tended
> to become convoluted.)  In this case, moving the definition of
> __kernel_long_t to its own header, so that
> include/uapi/asm-generic/socket.h can include that should fix it.

I think we should strive to do that on the kernel side too, since
clearly we shouldn't expose that "val[]" thing in the core posix types
due to namespace rules, but at the same time I think the patch to
rename val[] is fundamentally broken too.

Can you describe how you split things (perhaps even with a patch ;)?
Is this literally the only issue you currently have? Because I'd
expect similar issues to show up elsewhere too, but who knows.. You
presumably do.

                Linus
