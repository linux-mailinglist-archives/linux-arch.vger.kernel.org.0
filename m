Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1855DC230
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633268AbfJRKKP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 06:10:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46418 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633269AbfJRKKP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 06:10:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so4234455lfc.13
        for <linux-arch@vger.kernel.org>; Fri, 18 Oct 2019 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BqeI5DeNMdhdwedpm6lmI9dRfIV9F8YrxnBKCMM8m3Y=;
        b=zXEnEGHfaU5g2ztRoFtRrHviCjdzjSA3orQrEKMtgMUbZ40rdHp0lUMCWFQH8Mxmvz
         M/xoYXi3Pp1Ryy+zpQjax5qAXB7THyQZNOuuIgnO5olekQa31L8fSelI5wCzFxvFVzIq
         WwnAO8HfGoJCOsqWyKC3OEvZN+bPLaZuod6tAeT4iIPX4VtYuJslM9V8XYuHSnG32zIJ
         GljH7oddq7KBgUE2AaXs1LQyh7fjk1LoYtIW5NeyvF57Bm2SOFuqsWz2QlRhlWQwcego
         JFMAq3nVqeZt9OKC26dYMsuxCTIDvPblKY59Eq4ogG6dKzEtQAI6WlulDjZF3Ylti985
         bJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqeI5DeNMdhdwedpm6lmI9dRfIV9F8YrxnBKCMM8m3Y=;
        b=BODBuruHJyhAQCPfTe+EOi89/YahFRFoDPKI1aDAc0t2Z8P8AsSSGoMkzYqv27m0KS
         y0ad+1fkp+iG+joA4ag5e+7h7gTBIvnx5eZUZdB3PA88/aCJWwifHSvMeKNoP8761EVI
         x53dBTzA9zw52MsqkZsP9Db298xlOf+sMDtI/0HaaX/VQB/tw2eO8T1CWrlO1attZF1q
         K67Sd7EU+ljj3tOcJPHce2yzI2ufjyeaQkDLxqKDa12j2AtutrC2y7imOftxa2y1cN9C
         FTR7Uo068EG+00TH3BIVsQQm2Thb0DDjV7KqNe4dV/qjBvexTaO99rYEC7bNcullG7FW
         CmgQ==
X-Gm-Message-State: APjAAAVQelBPsXJMFZoIaBFOC1p2AKA9t+Gx7cAns8ahgdmR7ezBXB2X
        vYLTkLlGF0vrQtr4bqKLDdVsFw==
X-Google-Smtp-Source: APXvYqz8xDacNK9rUSaoBqBEQBnBWZOLMY1jfrC1yke9d4d0EH78EKFcXDQwVAPJbUlX3ZWkpNZgHQ==
X-Received: by 2002:ac2:420a:: with SMTP id y10mr5434605lfh.65.1571393411645;
        Fri, 18 Oct 2019 03:10:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q88sm2453626lje.57.2019.10.18.03.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 03:10:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 13B08100589; Fri, 18 Oct 2019 13:10:09 +0300 (+03)
Date:   Fri, 18 Oct 2019 13:10:09 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20191018101009.s6yonyxlcevtifiq@box.shutemov.name>
References: <CAK8P3a3uiTSaruN7x5iMaDowYziqMFxKWjDyS1c8pYFJgPJ5Dg@mail.gmail.com>
 <20191017125637.1041949-1-arnd@arndb.de>
 <CAHk-=wiH7Ej9x3RqJkUEW4hDCisgWdi6wai6E0tvo4omF_FbeQ@mail.gmail.com>
 <20191017153755.jh6iherf2ywmwbss@box>
 <CAK8P3a1TrOippPUh6Fc_McHcp2LOerdD6ifmcieuy0bAFPvs8g@mail.gmail.com>
 <CAHk-=wh8MsquobFL5TC0yUkG-9yFUZZnikMPA8QHLc7fcyND6w@mail.gmail.com>
 <20191017161617.zj7u6p642mytpzts@box>
 <CAK8P3a0YLeqm71TNzTwJ0FwQKW4Ji0etA+6U=08Exk7fibyBQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0YLeqm71TNzTwJ0FwQKW4Ji0etA+6U=08Exk7fibyBQw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 18, 2019 at 09:56:01AM +0200, Arnd Bergmann wrote:
> On Thu, Oct 17, 2019 at 6:16 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > On Thu, Oct 17, 2019 at 08:56:50AM -0700, Linus Torvalds wrote:
> > > Yeah, that's certainly less than wonderful.
> > >
> > > That said, there's no way in hell we'll support gcc-4 for another 7
> > > years (eg Suse 12-sp4), so at _some_ point the EOL dates aren't even
> > > relevant any more.
> > >
> > > But it does look like we can't just say "gcc-5.1 is ok". Darn.
> >
> > I don't read the picture the same way. All distributions have at least one
> > major release with GCC >= 5.
> >
> > The first release with gcc >= 5:
> >
> > - Debian 9 stretch has 6.3.0, released 2017-06-18;
> >
> > - Ubuntu 15.10 wily has 5.2.1, released 2015-10-22;
> >
> > - Fedora 24 has 6.1.1, released 2016-06-21;
> >
> > - OpenSUSE 15 has 7.4.1, released 2018-05-25;
> >
> > - RHEL 8.0 has 8.2.1, released 2019-05-06;
> >
> > - SUSE 15 has 7.3.1, released 2018-06-25;
> >
> > - Oracle 7.6.4 has 7.6.4, release 2019-07-18;
>                ^^^ Oracle 8
> >
> > - Slackware 14.2 has 5.3.0, released 2016-07-01;
> 
> For /most/ of these I see no problem, but RHEL 7 / Centos 7 /
> Oracle 7 and (to a lesser degree) SUSE 12 must have users
> that want to build new kernels for some reason without a trivial
> way to install new compilers.

Isn't crosstool the trivial enough? We can directly suggest using it if
compiler is too old.

BTW, we already require much newer compiler for some features. See
retpoline.

-- 
 Kirill A. Shutemov
