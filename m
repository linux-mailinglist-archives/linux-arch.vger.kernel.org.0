Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48035547757
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jun 2022 21:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiFKTlJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jun 2022 15:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiFKTlI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Jun 2022 15:41:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A314739B
        for <linux-arch@vger.kernel.org>; Sat, 11 Jun 2022 12:41:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g7so2730283eda.3
        for <linux-arch@vger.kernel.org>; Sat, 11 Jun 2022 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kncVDj6qquFvS6ic1L/l+Y1TiHMzNrJRtAoLHiK5c20=;
        b=hj/fyY5tW+Xwr5pt9lLvW4C6JlytlzYIHsrNe6mcDZ4IJ95lVFTyQ7vvas3QOjPxU9
         649bVUtxg7il0B6T5I9vrUGwLqq4Azy+CZGZv5vBe3E4q0Xe1hgW/nVK4MimiRZGrbzr
         bT/jgqkAG4M3Ac/LNUtyyYCC2Fe4/uqkxc4ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kncVDj6qquFvS6ic1L/l+Y1TiHMzNrJRtAoLHiK5c20=;
        b=CVepzocAR4TQ4dxKWpvgDA2MWF880OntDJilKnkBVLWzKyRiClXLJhX6wwN8R3mLcf
         7/ZvVEfsRgtBe7CqySAOlos5U/qkzP0knJ7D4bQIbPnEr/WTtOm17evXqA9I0paMvjMW
         Driaol4il1Sq6kRTqztIPtRAuegu/71CBxrJWk2tTqCA+fFSzB+0ZppRvFlxa2NlQaL+
         DZ93XclQF8UsQVVL6UeEqWkwMD59wozovn7jWvS5Q3UcHRmm61heYJU5/fhZP8D2oMUG
         YinrAfSUQ8MtwTQH7NkQd5mYLBHW8mickd2HiX/4VIt58mYgOMOP/k0qzcbUWl07zTnR
         QRrA==
X-Gm-Message-State: AOAM530gbMXLREJewzPHjbZG+ogYgnJl+0aBCNl3JKCGkknHvUGBo2Zk
        wwXbePuPd4C93mDadMfsOSIIFMwSl0SDfsnu
X-Google-Smtp-Source: ABdhPJxxI8bm4G0iAo1103M6Nr9yudoQEnWllx/LsWd+vAlVV/UqM9MkLhMbhbG+TfmU44Y37+fAtg==
X-Received: by 2002:a05:6402:31fa:b0:42d:cd6d:c8fd with SMTP id dy26-20020a05640231fa00b0042dcd6dc8fdmr56961248edb.347.1654976463151;
        Sat, 11 Jun 2022 12:41:03 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709064f1300b006feb5dc81absm1406811eju.125.2022.06.11.12.41.02
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 12:41:02 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id x17so2500066wrg.6
        for <linux-arch@vger.kernel.org>; Sat, 11 Jun 2022 12:41:02 -0700 (PDT)
X-Received: by 2002:a5d:6da3:0:b0:219:bcdd:97cd with SMTP id
 u3-20020a5d6da3000000b00219bcdd97cdmr12734824wrs.274.1654976462034; Sat, 11
 Jun 2022 12:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220611101714.2623823-1-chenhuacai@loongson.cn>
In-Reply-To: <20220611101714.2623823-1-chenhuacai@loongson.cn>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Jun 2022 12:40:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9K=wHATkEVWyqZWzP_BP1bXDVtyEJacP6Da66HsVV2A@mail.gmail.com>
Message-ID: <CAHk-=wj9K=wHATkEVWyqZWzP_BP1bXDVtyEJacP6Da66HsVV2A@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch fixes for v5.19-rc2
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 11, 2022 at 3:15 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> LoongArch fixes for v5.19-rc2

I've pulled this, but please next time add an actual note on what the fixes are.

Even if it's something simple like "Fix build errors and a stale
comment", which is what I made my merge commit say.

               Linus
