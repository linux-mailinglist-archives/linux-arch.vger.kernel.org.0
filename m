Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD7ED825D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 23:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfJOVqs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 17:46:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39547 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfJOVqs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2019 17:46:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so21830482ljj.6
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ob5N5ZzOYqwWJlWtRK/QQr9teH3dlSPsAVI1F8bPf38=;
        b=Ls2Ydx/1fiuQCKLYCr6mZfYT53ylM0bwO8QLfmOr29RVIEWsNQvXoEyD7/28atloUG
         w+SNF88R+eUaHbdCKU6U17DXhOsSyLQK+W93/BhVqc1MTwofrvdbxA3OX0BP8484yWP6
         rquduhuB1DQ9TVPZMjcMgJRO4GQPDwTo2bq84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ob5N5ZzOYqwWJlWtRK/QQr9teH3dlSPsAVI1F8bPf38=;
        b=T1KJKUWOon8dhSz+wDPYZbKAkrVm0/qg33OsPUJ1iMOAWvsnqxfHoVW3MtU7qkjJ0l
         ry3Nlw6jGUQmlGDli3y3YkbPTDfZIxH/99P2i9/u9UwuYqY1fVS7gF0zYGu4yH7biOYE
         OpPAXMFkg1hrz+qBz9TGSNeV8uihg13jLH6VNZJe1e1Qa6PMpTnVyQmXaO3QKTYyauul
         rNZ7bLmDe4rMKlsON9WRbPGFWia9EFOdsxQLTjAucZ5vDE3t+MKAXjCzCIio5ZaqJfPg
         9B9MMBBDgU8q2wJbNhGCc5oTs2wodADgl2seNyl+hEOhYsu1K5wTPOVFrUA00gC5qTjx
         f30Q==
X-Gm-Message-State: APjAAAUxVBMb2cUF5fET7ysqQ15s8aI9GPHSdl1/lFR+4zlYX5SK6P9l
        8kB2IKGM4hq7YxmviRX83uUgC2LwAdU=
X-Google-Smtp-Source: APXvYqzyQ97CZq8zhhXfVM+DWhHhV9nLmZW1ttykEo79UOeprUGONRc4zQ8ZJ3mT7JFHmcZrQL2+5A==
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr20906730ljo.167.1571176006126;
        Tue, 15 Oct 2019 14:46:46 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d26sm5265287ljc.64.2019.10.15.14.46.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 14:46:43 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id q12so15644167lfc.11
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2019 14:46:43 -0700 (PDT)
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr22630003lfo.61.1571176002727;
 Tue, 15 Oct 2019 14:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191926.9281-1-vgupta@synopsys.com> <20191015191926.9281-3-vgupta@synopsys.com>
In-Reply-To: <20191015191926.9281-3-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 14:46:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtRuGdsm0BR50vpwJBRJgP3u6Suz0LNa6WzR9RMtJjbw@mail.gmail.com>
Message-ID: <CAHk-=whtRuGdsm0BR50vpwJBRJgP3u6Suz0LNa6WzR9RMtJjbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] asm-generic/tlb: stub out pud_free_tlb() if nopud ...
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
> from this routine which is not required in a 2-level paging setup

Ack, looks good.

           Linus
