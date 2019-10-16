Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800E0DA1FB
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 01:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfJPXLV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 19:11:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40283 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfJPXLV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 19:11:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id f23so269480lfk.7
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 16:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGKtZ/zw77SVmwWAmi2W2qbaG2CuisyYfyjtCue+A+4=;
        b=J+x43ZuuP6oW4LgSz5GgRglUir/a9W55AO5TScArhufGqXsk5DSUW4YQVGd9WWaAbf
         8YsfrLhxL4LKnbZbP2hAUFQqgixvndPoglPW3Tv3yJ6FyVg39EKhskSE0ZDlPZMgot2f
         b3oPE2GyepAnrz8h0ibhFpnkS3t9VCOSghlaFfChToxS21Z/sEpqm6/fF45jqgB/UrTC
         kQwI3Dgm2CHfO9MpivkTFkuXXeu0DpSjm8GpLDozi7AdT9EJK8omewSJxqO7b6Bt1cUa
         E8eQzcsDRdXKm2iqmR7ythG63YgnjErg5pjMe968m8LHncu2vlsmj0LDDcAECBK7UZYI
         y1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGKtZ/zw77SVmwWAmi2W2qbaG2CuisyYfyjtCue+A+4=;
        b=JEp78fc7515FSIdwU4HRFg/MBDFzP5l5eiWufT6oIYNsVAuCUod1FUFvWdgpidNldS
         LF75/c8Ncb44D2hkYt69vSty8gfFgO/7cmG3vFHvaY5tF+Jn9v4rMRRnY6MSedHC1BVE
         zhePYnj3wxGD6qyMsNcyupzavjvzXD8mXc9/G74NZ5c/TGEsFd977WZ0Gm3uKTvDG/R3
         Tu2gZrsJM07Z4DmYz7ip4DqEZhMyP18t6BEa57OBlWre4sJZNcVfXbjVNvXWGdNbyFMM
         UdDKRAAEQc+yyIxJy2QmG9M3GMcTggjSCeplSkGvQim1SHflm8doOH9eYMsxUcG6Wv6y
         cufQ==
X-Gm-Message-State: APjAAAUQhBbwQx/oWC+Beo681gy2whxqBBiSCovZ/qdrnhFImhnz4AG9
        +xNrix6wtWTvOGA9A+OrXcmxEA==
X-Google-Smtp-Source: APXvYqy0UgONmpSaR+4m5izxGJwNl4tg+Z38plmGJ5jsQ0CIAYGKw48uJzmou8ImGmI6Lr3+UjT6gw==
X-Received: by 2002:a19:655b:: with SMTP id c27mr148514lfj.122.1571267479442;
        Wed, 16 Oct 2019 16:11:19 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r5sm83652lfc.85.2019.10.16.16.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 16:11:18 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 97333101175; Thu, 17 Oct 2019 02:11:16 +0300 (+03)
Date:   Thu, 17 Oct 2019 02:11:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Pinski <apinski@cavium.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
Message-ID: <20191016231116.inv5stimz6fg7gof@box.shutemov.name>
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 16, 2019 at 03:23:42PM -0700, Linus Torvalds wrote:
> [ Coming back to this, because it was annoying me ]
> 
> On Tue, Oct 11, 2016 at 4:06 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > HOWEVER - and this is really annoying - we'd need to use "-std=gnu99/gnu11"
> 
> Hmm.
> 
> I just tried it again after a long time, and "-std=gnu99" seems to
> work fine for me on the kernel these days. The old "compound literal"
> issues we had at some point seem gone.
> 
> Maybe we've cleaned everything up that used to cause problems. Or
> maybe I just mis-remembered and we should have done this long ago?

Looks like it was fixed soon after the complain:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63567

-- 
 Kirill A. Shutemov
