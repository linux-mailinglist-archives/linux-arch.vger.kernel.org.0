Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0201430BAB
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 21:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbhJQTLe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 15:11:34 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbhJQTLd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Oct 2021 15:11:33 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MmU1H-1n2xhD1PLl-00iR2e; Sun, 17 Oct 2021 21:09:22 +0200
Received: by mail-wr1-f44.google.com with SMTP id v17so37060051wrv.9;
        Sun, 17 Oct 2021 12:09:22 -0700 (PDT)
X-Gm-Message-State: AOAM531IY61lCtEEZ1bTsYBQCf3bZ3blcMIviTm78i3DpBeOtSIYXXbj
        893BsAF/imR0W1XlZodN7vz9KCq8ZvquafYyw7g=
X-Google-Smtp-Source: ABdhPJyDj5QI06EOMNONdAE5GwD/ut/fii1dX06b8JHCA0YPirHmFsCDgxXb4szkdoWo0z9BllmdVI49vaK35YUrk8s=
X-Received: by 2002:adf:f481:: with SMTP id l1mr29223902wro.411.1634497761955;
 Sun, 17 Oct 2021 12:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211017174905.18943-1-rdunlap@infradead.org>
In-Reply-To: <20211017174905.18943-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 17 Oct 2021 21:09:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3XDY5gMUA3h3tVmQuxSHn_J3qOw_rDurzBx-KFdGhCKA@mail.gmail.com>
Message-ID: <CAK8P3a3XDY5gMUA3h3tVmQuxSHn_J3qOw_rDurzBx-KFdGhCKA@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: bug.h: add unreachable() in BUG() for
 CONFIG_BUG not set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zGN4sBC/1RH8EFAOfkdOdJQmT5npD9tEpTMumWQlb+0qxZqz3rh
 Da037rsHRmqxPIsfS4pePB+LzDlhqCngZ+wScR/23OoFfu6/rIKE9+z7muiF50ji8aj6ubI
 R3xlhBbADMwYR4LyPznoJaGQ2DMmFrvatRKVUyFrDZFnplA1nOh5EVgFxYzKJI/xVwhDEdw
 tvGszfJgRO/w71tNFko4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:09/jv+oewuU=:OdXyuaQoEPw5k0YXxrRtP6
 S4E2JV2NOTvmLytInJ5rHL6mls/LvI0DiBc59ab/XxcAhcWtguDoz2CGh+lJCiZxgmOX0rG3b
 Qj0uCrCZhvWBx3aBCko1GHkUozI+M9tYXCRoE4ZzAxE0X6uoog/BTHR3SwobFvKcHJdvh7RGG
 EQ+N2PfwzeInIpQHs5/DoH4hWKiiGmj61taNPmob4u8j7JCA4yNaIQtuWwViZQjvGDcFz5oqy
 MFSUg17PvZH8YsetgTvScAf7O//eHJh4ZP+e+W5fe2nHTtdHXcMqlg0coMSPsIV62y2NcU9vs
 gvQrAXm6oraCAoM0zE5Ndvb7kxRx2OALogG8ExGrz/TwkMullm03j4PQCTmvcMz9qU+rfMeWj
 iHLVTTMVNqjHCk0JJJU6qVn2CKDD1IuPCpCsDJpNBNLjPfldL3pfsCSXE9ZpABYFspm/hi3TY
 K3XZTeGqw91r7VpnIRKYooOErf9WgiYFcoBRrZhWMxbamKP6BHbVdaSKemx8UyCGgCoWldgzd
 YVFvz7PfVml+b/RAEfdeoDF51AY8+mOrq6bmm8tj7CmnkyYWQgOgVo6Pf1mo6qT+K2fGuzpcO
 a53q34zmkwCteMJNqeo6SCnGmawRBiE6llyHGDYpZwmkkehfVbcgcS7OOKFpKWtQ07cEqIxfQ
 4dAVlo+kDU/lVvRH6t/6p4Wz13d4icJ/8jUyIHsVijWu8tp8QN2hzbRkDUrJudSgf6u0o41FP
 xNgombAx9mNIdAq2J3s8AF6H6qLVYY0ithQSvw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 17, 2021 at 7:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> When CONFIG_BUG is not set/enabled, there is a warning
> on ARCH=m68k, gcc version 11.1.0-nolibc from Arnd's crosstools:
>
> ../fs/afs/dir.c: In function 'afs_dir_set_page_dirty':
> ../fs/afs/dir.c:51:1: error: no return statement in function returning non-void [-Werror=return-type]
>
> Adding "unreachable()" in the BUG() macro silences the warning.

No, I don't think this is the right solution:

> -#define BUG() do {} while (1)
> +#define BUG() do {unreachable();} while (1)

Marking this code unreachable() means the compiler is free
to assume any code path leading here will never be entered,
which leads to additional undefined behavior and other warnings
rather than just hanging reproducibly.

The endless loop here should normally be sufficient to tell the
compiler that the function never returns, so it sounds like a
problem in gcc for m68k.

Did you see any other issues like this one on m68k, or the
same one on another architecture?

        Arnd
