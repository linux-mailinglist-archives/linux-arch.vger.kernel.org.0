Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71662DB137
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 17:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392992AbfJQPiA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Oct 2019 11:38:00 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:37338 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390135AbfJQPiA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 11:38:00 -0400
Received: by mail-lf1-f45.google.com with SMTP id g21so1146096lfh.4
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L6Sd6tzaUEpmEHUxMlmEO1DNlTBEBF+HM7o/OKtIiso=;
        b=uVwXqEiLyeoPV6uZHpQcXNn35K6yFgFBR/7C6tWg5e4KMSuw8l5pAr6+/UU2u8t2Sc
         cRTTvPHVvjveTCcda94TMP3TeMaFxXvJtHSRI9zUzLUSVqSDR7c+s24IO2+BEzRvH2oL
         y1+g98YhgLhrjh3mSthD1nci67iQ2bXxyhGv/Phy3orGPluINaPMUSn8Nt5nyuspHatc
         g7kMpb5JhhVDjBc1DbtpBBUw4F2yLgskUgCQOAa/7CejqYQ/e1cQYfhe75P1YTIkDsXu
         SnnqktnhT8Kr1gNSHB1dwZN4TZHUPsrp58Swj9Hi2PgaefU5NQz/0mV/kpYIvW9Cw3DT
         pszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L6Sd6tzaUEpmEHUxMlmEO1DNlTBEBF+HM7o/OKtIiso=;
        b=hiLRbMEb5jrXmXGsOYB0Qj2h1P7Zezrf3Ch2wJ3sXS6ZkobPzqSICnZwW7AgOW089T
         kNEQcpbNhFWfYOU9N0qMmoa5i1AvEqhuxNdTS0X13WZuxNPH3r9AFXA71pXoJDoXnOgK
         t/463cIKDbk9PoL04b17kJ3gIqyPz/Eh/727xVS7cJTH8z4oiBRYeCGzQZiil4NBgbpk
         0ZDXplFAQUwe8K7XHFQfEcrBE1En2yy9lahczU3wUkMrwF5AyHpgYIi8xHNUXjYHlE4V
         EMT3M/RShqKZ4T9VGqTDAT5E6V0YcU2T2AjcIzU/yShSrIkQ9ziqErW+kXrTokDn4lv7
         MmVQ==
X-Gm-Message-State: APjAAAVAsA/CylbKMQipTfcgO3EaEmHCjZRPR2o7Q/leUOyFl9Xzs9X9
        dcziWJ7IlBCZ2pbglAoKUo7MmQ==
X-Google-Smtp-Source: APXvYqwpbVv+R9kUPWBLcIli63s3aZ3d2a1In8muHbV7ALrRrRLfdtQA7Glo82i1wUWpTV0o1Am34A==
X-Received: by 2002:a19:6917:: with SMTP id e23mr2849739lfc.4.1571326678391;
        Thu, 17 Oct 2019 08:37:58 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b19sm1262933lji.41.2019.10.17.08.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 08:37:57 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D06BA1001A9; Thu, 17 Oct 2019 18:37:55 +0300 (+03)
Date:   Thu, 17 Oct 2019 18:37:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH] [RFC, EXPERIMENTAL] allow building with --std=gnu99
Message-ID: <20191017153755.jh6iherf2ywmwbss@box>
References: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
 <20191017125637.1041949-1-arnd@arndb.de>
 <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 17, 2019 at 08:05:28AM -0700, Linus Torvalds wrote:
> What distros are still stuck on gcc-4?

According to Distowatch:

- Debian 8.0 Jessie has 4.9.2, EOL 2020-05

- Ubuntu 14.04 LTS Trusty has 4.8.2, EOL 2019-04;

- Fedora 21 has 4.9.2, EOL 2015-12;

- OpenSUSE 42.3 has 4.8.5, EOL 2019-06;

- RHEL 7.7 has 4.8.5, EOL 2024-06;

- RHEL 6.9 has 4.4.7, EOL 2020-11;

- SUSE 12-SP4 has 4.8.6, EOL ?;

- Oracle 7.6 has 4.8.5, EOL ?;

Missed somebody?

-- 
 Kirill A. Shutemov
