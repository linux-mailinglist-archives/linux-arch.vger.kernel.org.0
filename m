Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F640B056
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhINOQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Sep 2021 10:16:34 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhINOQe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Sep 2021 10:16:34 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3lkT-1mQyIK1IeJ-000x5k; Tue, 14 Sep 2021 16:15:15 +0200
Received: by mail-wr1-f43.google.com with SMTP id i23so20508236wrb.2;
        Tue, 14 Sep 2021 07:15:15 -0700 (PDT)
X-Gm-Message-State: AOAM533qTKsGTJ6FKavk2tX23ZQoFgfnTryW+WLEj9e+cVmZCEgwjo9Z
        oBpeqJG50HlITnS9H4EGto49L6RNj1+jSWQbXd0=
X-Google-Smtp-Source: ABdhPJyfE0LbNtbA9C1iEKp/h5+2GS0/mfmh9lX9kOSpOJ6ksc8CWeOUCyKxHnCiSVKgJxTP3lLoEFMBpF6CWjOTPgc=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr19111975wrs.71.1631628914576;
 Tue, 14 Sep 2021 07:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210913222447.4112-1-pcc@google.com>
In-Reply-To: <20210913222447.4112-1-pcc@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Sep 2021 16:14:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3gKeZhvYv9CyVQS4d2=XhOQPQH8Jvjki_FzLZexa4oVA@mail.gmail.com>
Message-ID: <CAK8P3a3gKeZhvYv9CyVQS4d2=XhOQPQH8Jvjki_FzLZexa4oVA@mail.gmail.com>
Subject: Re: [PATCH] arch: remove unused function syscall_set_arguments()
To:     Peter Collingbourne <pcc@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+aevzmhEXGktP2WN7rlv6/v5Atdf6lSqsBA1lJ4+rZ/jWzz4ia6
 MZPKqJbLP5HVK/fS5s/PRq5wrB59ArdrD/0vYJ2SYy4rLMpYd5BP5rAGCZ7nyBCZmysTmQk
 591o6SU/AUNu+yLo+RLxzuWX6b3xl5SQIRTg6xeIZsPLMghS60/BV/kfdZXkJQ5qI9CLRRO
 oBntEVOpUcLBoocdpQyUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rh+rX4rhOFE=:kaAttO3IU06jG5bP0w2XoA
 E9+a5viA0Fg+jJxy7XtGKALrT96AJfAHZu/cTsdYOIyC8LcBb+9OASqrnCV36uW/KGRWzrThW
 9MnQkFKn7Jp5Jl10mpQg3K3KY+D9F73IOJHyTVmwF+Jw2twAqskViETf7/qb2GKurRCRJBhPC
 L/TQg8pGp8KtMF6+942ngEx60EdUoKVYy2/DPixP7+NU5rZceYsH2XfBQE2KHiWS75nrRgjph
 snMAT43v+t56/EQsdIbXkhr0KSMUudeGSiGvOKSf1LifhlXKhr9/6/i4+4V4uhe24QFM3iiX+
 8iZFRZRMOH8wv5V9SrnqwVtQvA8eT9XBMnYarrRoaqiRNdNzMhBw2AeVi4C/OBqVfoiiSJza+
 8RwoOmaoPHL+AGrlzw8CewVbdkitJdfvMD9/KxWDcoX657JC79Bgav0z3HTgSmAK9HqjZO6EE
 9q2J8XXXzkk2nLj6z5G6WwvFm7Wl+FN//ROqwgdKyT2Pr0pjJYkQeghVU9zUAAdSiTIXV8zcT
 Ioc7p4cGn+y7T/g7PDPTEwdKM7JwOYH+A+Mjgl4ALZ8s5HaXOQ7GYFRAFdCGyE2o8xDFRxDia
 uEKdpqQtl/hfjDysN60EUrKbodfrYuHv4XMCurxmuz6vPOAFQ7NjJq1qjVIFpULTOKwbquPF3
 dP6G4WsOYnRVkijREkN1BojgEcGOE+EahmdoVQhrVyMtwn+ZyCnM+kZJ0dE2fzywTZiuyBmnc
 UVJKFwF5oS107mD+dPX5I847qRtY/Kcq3QTLVxRSwF0YzSfe1pBtVW3heG07j8Aj2e/90nFkx
 juTGxAAO8VKDvJcX5N1im4rnbLcl+XnBqF2fa+iQIfb/sf9oZy+3060jxsiyrGJqxq616jbzR
 LPgqRrkDc0XuisNZQ/4w==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 14, 2021 at 12:24 AM Peter Collingbourne <pcc@google.com> wrote:
>
> This function appears to have been unused since it was first introduced in
> commit 828c365cc8b8 ("tracehook: asm/syscall.h").
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I8ce04f002903a37c0b6c1d16e9b2a3afa716c097

Looks good to me, applied to the asm-generic tree.

        Arnd
