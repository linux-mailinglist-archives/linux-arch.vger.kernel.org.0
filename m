Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A73DB16F
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 17:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfJQPrU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 11:47:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46552 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732271AbfJQPrU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 11:47:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so4200925qtq.13;
        Thu, 17 Oct 2019 08:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xh/YtO4lc4822tGQfg0jyom/15306rpLZqLRiRvMj/U=;
        b=ewol8vHRJ4ni5UdWSj/4d4It+m28HLTl08zYtlS5oAb2HYR+HWgZu9hWowIK0y0ngp
         3QqsOnQ5Mzw9REqFST5N6eGWm91iU6oyhBH6p+CUN0ThucOGMbdxuoBAYRVVDzEixra3
         m6P4OU+K4QT+QurZeMBuoVzGg3TP2lrjaQhOFh2AuombHNx6XtpUtlIJ4xLvD0mwMSNM
         iptbb2bhNxy0iyQCULXw8eaYaVCtM1WiUSYUTMhuVeyr1kPS5lEhHfGa17awU1MiJ7O9
         8Xj9GdMOspq2+1idUjshXKNrRlBJRoiiGfEUyuufxNjL94qRky0abdQDBA9HDceK1/b/
         sVDg==
X-Gm-Message-State: APjAAAWuWAp/VOKdXYXItFdxSQl/Zc5whuGo6BOkq/GZmlX27qVSLXOh
        4rNosItBi97FGX+ZOP1RhiYzOCpDyvRl3F785Sw=
X-Google-Smtp-Source: APXvYqzDZ7K1hzzzhiVdKtQS9vbJpfbE5+/6cpoz5a4pZp5xMRqGtZEUS87ijCYVUt1E0RYv6BMGs2qdWVnsUzc3KcU=
X-Received: by 2002:aed:3c67:: with SMTP id u36mr4508055qte.142.1571327237988;
 Thu, 17 Oct 2019 08:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
 <20191017125637.1041949-1-arnd@arndb.de> <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
 <20191017153755.jh6iherf2ywmwbss@box>
In-Reply-To: <20191017153755.jh6iherf2ywmwbss@box>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Oct 2019 17:47:01 +0200
Message-ID: <CAK8P3a1TrOippPUh6Fc_McHcp2LOerdD6ifmcieuy0bAFPvs8g@mail.gmail.com>
Subject: Re: [PATCH] [RFC, EXPERIMENTAL] allow building with --std=gnu99
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Pinski <apinski@cavium.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Thu, Oct 17, 2019 at 5:37 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Thu, Oct 17, 2019 at 08:05:28AM -0700, Linus Torvalds wrote:
> > What distros are still stuck on gcc-4?
>
> According to Distowatch:
>
> - Debian 8.0 Jessie has 4.9.2, EOL 2020-05
>
> - Ubuntu 14.04 LTS Trusty has 4.8.2, EOL 2019-04;
>
> - Fedora 21 has 4.9.2, EOL 2015-12;
>
> - OpenSUSE 42.3 has 4.8.5, EOL 2019-06;
>
> - RHEL 7.7 has 4.8.5, EOL 2024-06;
>
> - RHEL 6.9 has 4.4.7, EOL 2020-11;
>
> - SUSE 12-SP4 has 4.8.6, EOL ?;

EOL 2024 as well, extended support 2027

> - Oracle 7.6 has 4.8.5, EOL ?;
>
> Missed somebody?

I started a similar list, the only other one I found was

Slackware 14.1 (no EOL announced): gcc-4.8

For the record, that seems to mean that moving to gcc-4.8
would likely not cause a lot of problems and would let us do
some other cleanups, but unfortunately would not help with
the compound literals.

     Arnd
