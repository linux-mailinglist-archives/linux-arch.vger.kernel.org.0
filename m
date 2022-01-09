Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C169D488C28
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 20:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbiAITyk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 14:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiAITyj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 14:54:39 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6F3C06173F
        for <linux-arch@vger.kernel.org>; Sun,  9 Jan 2022 11:54:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w16so45278461edc.11
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 11:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmegTu/P1eR6eKyrb2vi4/ySVnMbmjPuoi9oxxllVyw=;
        b=JBUaczY3xgk+JpISS8qCZPfUaIaMAR535Q9AHiDJNlcZhI13qJcgYLz0Cnpz6scl8S
         qIN7fEE0O01FmsMCIJoYcGPAvHgR0ntnyPq8pvbBeC8btcYCX+t3v4xjIigkOZIog7Fd
         7iZihajHhb4LCEpB4JtWgEfI6ndSBSwLb0tyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmegTu/P1eR6eKyrb2vi4/ySVnMbmjPuoi9oxxllVyw=;
        b=1PnB6jJ7w8ic8d1NoN2s0nUOA/zkYyMRA+3eW0YtSFWqtp9IX3lSSWaUqK26W94xl/
         t6rTQO27sjkVs6iZbya0P2f9JrcLgF7DPqXHvMxXckYXvzVTjMwmg4Q3wJJ0l1gCXzpt
         P6aEY03XsnySWVjYGhXv6iTjGNRH5xX6MKMWMKK55PwCvwSCINMss/v9jgX4VN+Wzwcp
         vRhqy4zY2yjUCwYy/SkKndUcS/G/l4RsOIuB0VdKbXeYU69LI3tOc5pAs+ccNycS0Fkv
         cH5kirGsvTIOJjWNTNq8SJ9mk4Wl0hUiABonxEbYLwfAp7SJOsVXvTlT3V3ECVUqfcpx
         //fw==
X-Gm-Message-State: AOAM532mgc+K3b6fuDSCcDUCWNYlK+z3Ynu+tv+t8XXclFGe6e85Lc5U
        PUZTFE2RbWpEW0dB3aniXt1fr2bRuLtIaRCgrAU=
X-Google-Smtp-Source: ABdhPJyP/eDOWuugRxPvquVS8yVUam9yQEuZWwa8TqczBsOnUF8GyDEox6K4Q7VE5e7zVA+TOKmFJA==
X-Received: by 2002:a17:906:e249:: with SMTP id gq9mr56762951ejb.258.1641758077250;
        Sun, 09 Jan 2022 11:54:37 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id d15sm2464595edv.44.2022.01.09.11.54.35
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 11:54:36 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id w26so1600911wmi.0
        for <linux-arch@vger.kernel.org>; Sun, 09 Jan 2022 11:54:35 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr19440706wmq.152.1641758075416;
 Sun, 09 Jan 2022 11:54:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641659630.git.luto@kernel.org> <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
 <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com> <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
 <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com> <ba2522fbabc8a81befd27ef20588f9356f7b885b.camel@surriel.com>
 <1B6896F0-7A51-4936-8B50-0B86551FA3B7@gmail.com> <803a5d61426b149abf08e19759e086893e379382.camel@surriel.com>
 <8C459519-AF2B-457F-8E99-8957BC1FB61F@gmail.com>
In-Reply-To: <8C459519-AF2B-457F-8E99-8957BC1FB61F@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Jan 2022 11:54:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwsS_1BqPAhbwW3x36WgT-x-ENAvNVijw7O0OKf+V02Q@mail.gmail.com>
Message-ID: <CAHk-=whwsS_1BqPAhbwW3x36WgT-x-ENAvNVijw7O0OKf+V02Q@mail.gmail.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab lazy mms
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Rik van Riel <riel@surriel.com>, Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 9, 2022 at 11:51 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> If you already accept PTI, [..]

I really don't think anybody should ever "accept PTI".

It's an absolutely enormous cost, and it should be seen as a
last-choice thing. Only really meant for completely broken hardware
(ie meltdown), and for people who have some very serious issues and
think it's "reasonable" to have the TLB isolation.

No real normal sane setup should ever "accept PTI", and it shouldn't
be used as an argument.

              Linus
