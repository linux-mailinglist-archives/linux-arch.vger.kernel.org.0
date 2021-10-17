Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0475430BB8
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 21:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbhJQT0l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 15:26:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344499AbhJQT0k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Oct 2021 15:26:40 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MsI0K-1msCU32rKk-00thw7; Sun, 17 Oct 2021 21:24:29 +0200
Received: by mail-wr1-f51.google.com with SMTP id g25so37059573wrb.2;
        Sun, 17 Oct 2021 12:24:29 -0700 (PDT)
X-Gm-Message-State: AOAM5336Tz9o74sjNpDAp6mRdV0FzD0aWJ9xw3kwkMfQgd7vato6F+be
        6laaBO+8B7ou4ILx8rmL3o63tA+6s/ovexuuCkI=
X-Google-Smtp-Source: ABdhPJz06nWeDGDSfJUWmNphkeTeXDInpz4LYmoGZirzU57U59ghhTBygkSOEku0/gJMZVtNDsuBy6/HCoHLpUDvyQU=
X-Received: by 2002:adf:ab46:: with SMTP id r6mr30191680wrc.71.1634498669396;
 Sun, 17 Oct 2021 12:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211017174905.18943-1-rdunlap@infradead.org> <CAK8P3a3XDY5gMUA3h3tVmQuxSHn_J3qOw_rDurzBx-KFdGhCKA@mail.gmail.com>
 <8aad5fd2-6850-800a-3c56-199bb5d4f4ae@infradead.org>
In-Reply-To: <8aad5fd2-6850-800a-3c56-199bb5d4f4ae@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 17 Oct 2021 21:24:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a21-mu=eN7qu+1C11Rwp_S3T0iJ+ronmMGyeYcw=Ym61A@mail.gmail.com>
Message-ID: <CAK8P3a21-mu=eN7qu+1C11Rwp_S3T0iJ+ronmMGyeYcw=Ym61A@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: bug.h: add unreachable() in BUG() for
 CONFIG_BUG not set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:haBaBs10gVyAquHzKBKqLBoRJ/LeMskfs+11vs4S/8Inz0bAkcM
 sHoFQEL+SURAxrKffPnhiPEU/mTIJYo4XLjOaBC2rEzmRmaKz5FhbNX0LMkLhSotuEyy3Nb
 eNHtl7R++MHmJiuy5890LQcfSsz3TojO407pDt4jN1l91iBtqOMP4t5wBylbZKd4pcvLfN+
 6EzvEcLoJZY70wCqALUJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jKTiu5EzBPk=:em/msWDVN5hdGZbjeFCtsj
 3RABjNWctOOWButhUc5r1I36oIUSiqa6SeJGJCXv8D9lgxaWSebp4mTYwkByRZ9sAtN++3+s/
 cw8+wuA5MRY+AzEtcX9kcgLbKFnoLPUjMmaWURSXQcgWyyAubLYKo8CyOXSmF+UqDEi6UWfTV
 nfZ9D/MtYNXrgUZ4GHDb8tVEnmjnnvnN2NlMyJfHj9D2qnyiEzwq0XTQj7tsnHSlM1voDmRyK
 aj+8FW4zu6Ahfc1zk49P0iXSe61a6rv6Kh91OzwtYiRtvSFfodKTxu7GAnL0/uVFGnFOJeU6S
 yw4k/5oYF7greRQRp5hgi0QzYKMKdkG3s4OCGqp2AIrwJRhIGKp67/dNhMNvnvc6QUH1L5VJk
 /nFAMxjswdBa+wbj1gVcmCzph2+Q1+shWCxAbx+Zfwe4ZR/PUrNhWltwyxIvDZZDCE3Pjv0n5
 4tVGTKyx4peQz6y1IGj3JiS+JhOFYRPxdhJVFgjVdgmj3Bacbv/MArT5/WVpEg36LZQUkebgc
 BOruDlHl2Im5jg8KCP/UL167D+e+HW2ujWikNF9ncnqgc3Q3aGB0E9KLQ/n3bHlTW5eZFGcVq
 M9jN6aoFj8x0ChQcScTfxSkHkO+ZmrIezFeQk5RkEk8mcLJjui3JA0RhCJbtPkY88BhX8d3E9
 Xz1TaC4N3yKnk+EeQYiruZRctkzvnu1h7Fey84Bqq56OvwWor5T1JhW4W8c0AJDUGdqjkgAlP
 LfmMA1MUmWlZJQnD8fri+iVUPGck6NLuUMdNXRZy8hlJo/gMrlEvtB8Ownhh/2Kgm7v4DZXd+
 zyT3V3efGz9yh9+/GVD/wJgM3ioOIrsEczuBfvt+S69W/tg2AM2xhIH+kcDOg/v/cCi0EbS7O
 veBTe+exRveeSRiaWpRw==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 17, 2021 at 9:17 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 10/17/21 12:09 PM, Arnd Bergmann wrote:
> > On Sun, Oct 17, 2021 at 7:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> > Did you see any other issues like this one on m68k, or the
> > same one on another architecture?
>
> No and no.

Ok, maybe before we waste too much time on it, just add an extra
return statement to afs_dir_set_page_dirty()?

       Arnd
