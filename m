Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3456488845
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 07:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiAIGtS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 01:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiAIGtS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 01:49:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAED5C06173F
        for <linux-arch@vger.kernel.org>; Sat,  8 Jan 2022 22:49:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c71so28682703edf.6
        for <linux-arch@vger.kernel.org>; Sat, 08 Jan 2022 22:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Qe5bfEPRSa8qK/jSdSjDeCU764BYhwj22IPnPyW9vs=;
        b=EZcm14tvQ2pTgwy34oZJOq2kJpxpBRDXnT7iNCcdccnLhGzBufgAhtztl1veAhf1go
         P/NRzFVUIHGptU0ISVbmnPiWEi1qkQqspVHDeITa/jsG8J/fyaHLKADfvZEVhW5AMExn
         cL6kENpOhF/Tm82ClxhGN+zQfHiX1OPVYCcT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Qe5bfEPRSa8qK/jSdSjDeCU764BYhwj22IPnPyW9vs=;
        b=6WRloOSwe1cSx1kGLPEQwEPERXHH/HlRIPPbmyKQ3ZX7zuRXvWWb/SL29Vhv3U4rTH
         bGA9pWNaLj3ZdcKSJ4nx210uK+sf8hcJVaepJkAGMXWpcYhRdSe2mv6W7WvFOHUtX1LO
         GKLCK2C3aHTi7ewxHsf4zv/DBq/26jlPkhUD9A9ny43uowayGgsXTzz5Qg8hrKocyxef
         fXVXnXLGyqfBijKfIvvjYy4mD98WNtoPRRdt6R0kbfieffrea/p5yxtHvWKPwez4jzQm
         yh7zfwqCcGEPESSz6raDkmaYXBX8aP7V5f4ZCcN9a6eaagdiIX3Q+VR5bP7vaIVUP1eC
         p/xw==
X-Gm-Message-State: AOAM532meqGhBIbFPsWbqH7BYnLXDtQ3uxE4WExIhI0/+6+i+CKzpuUM
        lH1y9W51DWsBqB2EuIfbo2bZysglfCbY+cLXyvI=
X-Google-Smtp-Source: ABdhPJwefsI+JMi1QlYtzzK4/o0m893d3MySKGAz954P1DwfB+mVz186bR+yUs8wLGM2t/3SX9dP9g==
X-Received: by 2002:a05:6402:1d4b:: with SMTP id dz11mr68183348edb.15.1641710956142;
        Sat, 08 Jan 2022 22:49:16 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id kz20sm1129439ejc.74.2022.01.08.22.49.15
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jan 2022 22:49:15 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id e5so6735961wmq.1
        for <linux-arch@vger.kernel.org>; Sat, 08 Jan 2022 22:49:15 -0800 (PST)
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr17141316wmq.8.1641710954863;
 Sat, 08 Jan 2022 22:49:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
In-Reply-To: <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jan 2022 22:48:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
Message-ID: <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 8, 2022 at 9:56 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> Just wondering: In a world of ASID/PCID - does the =E2=80=9Clazy TLB=E2=
=80=9D really
> have a worthy advantage?
>
> Considering the fact that with PTI anyhow address spaces are switched
> all the time, can=E2=80=99t we just get rid of it?

Hmm.. That may indeed be the right thing to do.

I think arm64 already hardcodes ASID 0 to init_mm, and that kernel
threads (and the idle threads in particular) might as well just use
that. In that kind of situation, there's likely little advantage to
reusing a user address space ID, and quite possibly any potential
advantage is overshadowed by the costs.

The lazy tlb thing goes back a *looong* way, and lots of things have
changed since. Maybe it's not worth it any more.

Or maybe it's only worth it on platforms where it's free (UP, possibly
other situations - like if you have IPI and it's "free").

If I read the history correctly, it looks like PF_LAZY_TLB was
introduced in 2.3.11-pre4 or something. Back in summer of 1999. The
"active_mm" vs "mm" model came later.

                  Linus
