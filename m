Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D1834B980
	for <lists+linux-arch@lfdr.de>; Sat, 27 Mar 2021 22:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhC0VZ6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Mar 2021 17:25:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47085 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhC0VZb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Mar 2021 17:25:31 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MadGG-1lwa2s3ODS-00c9Tm; Sat, 27 Mar 2021 22:25:29 +0100
Received: by mail-ot1-f53.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so8630852otr.4;
        Sat, 27 Mar 2021 14:25:28 -0700 (PDT)
X-Gm-Message-State: AOAM531N3hezseYPihghKyTUNAp/DKWstgZHN+W6rhlId/6Lw0VMOnM6
        8CiQFJlgahi/o2Ar1AJEO4J5jGC81DQ9a0ovG10=
X-Google-Smtp-Source: ABdhPJy4CJI13L5GI975TAxtN4pti2VMXOxlXdOQo1NAx9KR+JA78towyxq+aLKG36YpX7GoRqVGNCLpoFxBUatRMqE=
X-Received: by 2002:a9d:316:: with SMTP id 22mr17117443otv.210.1616880327372;
 Sat, 27 Mar 2021 14:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org> <1616868399-82848-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1616868399-82848-3-git-send-email-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 27 Mar 2021 22:25:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0FG3cpqBNUP7kXj3713cMUqV1WcEh-vcRnGKM00WXqxw@mail.gmail.com>
Message-ID: <CAK8P3a0FG3cpqBNUP7kXj3713cMUqV1WcEh-vcRnGKM00WXqxw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] riscv: cmpxchg.h: Merge macros
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Clark <michaeljclark@mac.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TiYln5qFCOjdYjLSSooDgnD1CnhaEYM4hRCyz0I+t6bEWNBHqFN
 Naw0TyLHp+5giR3FFzr8E+okwipr5J38scviWbYwZYAC3PyyftZlORE+DySKinvLH28BoiC
 TLiMml9cyrVrupiHC5vAJQDQ9OnFFokPsAdaMq/aPflF42aPVVbXCiPe+lAYHn+OyBIWWNV
 MtmRKHOQLFaWd5ZbUfbsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c5QrygU0lWE=:tLSca2w+CRbY0qN+pZQbb7
 TUTIwmfs3/TKFavbq5pPI5zmoInvl9pgxFS0FwgCsipUtGDEbnCF45hpo5Smyp+ZCbg7VC8Q8
 2ApFumPqegqHlg65NPONJn4Imtxrg0CDtAYXzlAtrspK473NW0Kwi166ej8jXUBRj9+qQKEjw
 cRAaBt7VBdrD+98gtRl7wyqxWzESWuenmzuzCZyn0v3dQ98IkMm1aZ5Kn8IsBa00z3ZstUUc6
 78P7zyvPgLINHrSad5z8jWae3LTaV2UfnRUpRnyseRY6wgDskzv/jAY6zKuqxKVHY4DGdoUSr
 Gelt4+4+74iwbnFgdMD8HOXJVoBJCnnvr+EVZiH4IL1hkK8IDWTAymOCq93x3J/XNJ82JiuF2
 4Et38SBDKbmbzW61Reh2VSQVh0tm3HB1CUUOoLUGLMwTEgx/+O+D+c9zQiYa6Z7LT+ObkW9u0
 6ESzrzYz699KG5ibfgICCEGNqYaodJo=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 27, 2021 at 7:06 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> To reduce assembly codes, let's merge duplicate codes into one
> (xchg_acquire, xchg_release, cmpxchg_release).
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>

This is a nice cleanup, but I wonder if you can go even further by using
the definitions from atomic-arch-fallback.h like arm64 and x86 do.

        Arnd
