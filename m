Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A241DA7C6
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 10:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405268AbfJQIuS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 04:50:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33020 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405250AbfJQIuS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 04:50:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so2504963qtd.0;
        Thu, 17 Oct 2019 01:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJ4RoHO1Os//gNp/BXL0U1ud40EsC0HZWt8dIz/Uq1A=;
        b=aiZRONlqVoqt4dZAetTdoZ3HvnAk2lefkAcP3V4WBm45kKPSGVoWoUgG6uB3UrxApG
         gQ9LjZO6NZqonNce8w9WJdtaPhO1r196PZ4Uj7uIjRn4gJFgguOgsQMIujOTdAt/3LY7
         zj3UKlB5TscbOZNLOI9qqf107HDmIxRfNrOkJGsCrPyQkkP/80fZdmkbZwhiWUK+cCBD
         bUb9MxDrNAdcjn7YX1y0lBqZBRqKkS+w3OvJSsJN8SK0rY6GD7KSaBMsZ1JiOH3/WTJy
         kPBokUgg7bCJsu6y7xVCd21ZkYIXK5r3JGvgc4xifkGRVyIMQiU12f6QzE1TMEU2NYqG
         VB8A==
X-Gm-Message-State: APjAAAWkg9Fa1TAaKtl9dCcEP5bqWruYk8+SqQ11rAmGgMUnb+csragT
        enWDjM2LNmXLFXUBSKE7cTlGh5Mt1ltQar7yGbqM/1cB
X-Google-Smtp-Source: APXvYqxjGzWfuIB85q/hZTRDWvsPaHlLEjeIw6zioCNqT475/A9ElmwaGxDyYGuvF+mkbWwGQTqCysGkkGsU+ao0XKY=
X-Received: by 2002:ad4:408c:: with SMTP id l12mr2582241qvp.210.1571302217240;
 Thu, 17 Oct 2019 01:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
 <20191016231116.inv5stimz6fg7gof@box.shutemov.name> <CAHk-=wh9Jjb6iiU5dNhGTei_jTEoe7eFjxnyQ2DezbtgzdoskQ@mail.gmail.com>
 <20191017001613.watsu7vhqujufjxv@box.shutemov.name> <CAK7LNAT8968tYxePbS_RD0n52dLfs1vx+tdKc_64PwCzwGOgAw@mail.gmail.com>
In-Reply-To: <CAK7LNAT8968tYxePbS_RD0n52dLfs1vx+tdKc_64PwCzwGOgAw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Oct 2019 10:50:00 +0200
Message-ID: <CAK8P3a2UWyNsguPvfCiHjuk1K=iY_8ASUrG3m=gRK+p+bRWysQ@mail.gmail.com>
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Pinski <apinski@cavium.com>,
        Michal Marek <michal.lkml@markovi.net>,
        mm-commits@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Ingo Molnar <mingo@elte.hu>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 17, 2019 at 7:21 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Thu, Oct 17, 2019 at 9:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > On Wed, Oct 16, 2019 at 04:29:54PM -0700, Linus Torvalds wrote:
> I can no longer get the toolchains for hexagon, unicore32.

Guan Xuetao said in 2018 that he'd try to make a new gcc available, but
I don't think anything ever came out of that.

> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> provides hexagon compilers, but only for GCC 4.6.1

For all I know, Qualcomm use clang internally to build hexagon kernels,
it may be a good idea to try again with clang-9. The last I know about it,
clang itself should have all the required patches, but there were still
issues with using llvm as a binutils replacement (as and/or ld). Not sure
if that has been resolved by now.

      Arnd
