Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37CDA200
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 01:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391277AbfJPXNd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 19:13:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35360 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbfJPXNc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 19:13:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so486510lji.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VMVQM/5RBXXWAWdLKnypPrNKNebX0iMsDA9CQ6RDq6Q=;
        b=AkTEAANDC17hIiWyleOH0SesuyEacz2dZsW1L+EwVRPIenuo4VUN1pvLy5+obDrOSB
         1vJft9cuooOlIwTmAZK/TVW3X6SoDCi5wrGw0aFxNlGSOEkhjJvyBI/6O/YNwp11IcQ1
         eiEITxC7Fp9iI2coC+o5M6xEOP2BYJwx9BJ4RQ3oAlzy+L/iexZuKYfs/PjWlFUafQ75
         7otstRqGMnRfcGtF/TYdyNMcQY6p9kMeHA4+HP9xhtq42BEfswoqYGmppWTs3otj/HtP
         v6eq4CuyBVvIO0/zII7xPLhWEP3O50eOz9IA3gYrJQ9YKg1i52IgLBsRGl9IpoTNWPEv
         WvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VMVQM/5RBXXWAWdLKnypPrNKNebX0iMsDA9CQ6RDq6Q=;
        b=gXLqxH43lIxy9Qi0g8zPD/gZB5AY31bPoe0Ok+3/tV0mh7yJ3ezMwtvbaE4BV1VPob
         iQFZMaymtsf5CAcPJ4k2ymIzaa63+IHZMbyulH6rOCUUy2V7rDDNGD0EzE7Uec4zTiBy
         SB6rR2aNjn330nS71LFaIrdwpDY1XBUsf7K3a6pEBaLemEj+g7/vHYc9pG7BZXqW+28r
         0lQvC3hKkTG68hf/jweTPVclqbIV0klTC+GJELE9IYKPrjsQSLyv9G68/hA+8wkwjHmB
         V4AXmWYIYM03lKOb77vsfukX0ilo2pRE7nczzPwt1vl00TM40KdE3+lGU8UNEYcVR+Ro
         npvQ==
X-Gm-Message-State: APjAAAWxF92QqICbCQKzk8bmdoJZZ1Hse8Lg+JSvR2NP6s82jhT6fOLA
        Ya4Z7+F+LAtSPocTO317CyDN+A==
X-Google-Smtp-Source: APXvYqzL2Q3bsiXSUM/DFGY/M0DymlcprtrMLXXof8i1HlGv2tvpqtot2zjNii+fZ+Al86rt/1Vkpg==
X-Received: by 2002:a2e:978e:: with SMTP id y14mr351300lji.206.1571267610731;
        Wed, 16 Oct 2019 16:13:30 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r5sm85285lfc.85.2019.10.16.16.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 16:13:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 89CB7101175; Thu, 17 Oct 2019 02:13:28 +0300 (+03)
Date:   Thu, 17 Oct 2019 02:13:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20191016231328.bthzvze62epthymd@box.shutemov.name>
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
 <CAHk-=whaSMp_MOKgAa=AwLDAY0Rtjdrw-AFKuLXbFsTJSevosA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whaSMp_MOKgAa=AwLDAY0Rtjdrw-AFKuLXbFsTJSevosA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 16, 2019 at 03:40:03PM -0700, Linus Torvalds wrote:
> On Wed, Oct 16, 2019 at 3:23 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I only tested gnu99 - which is sufficient for the above - and didn't
> > see if gnu11 ends up causing more issues..
> 
> I see at least no obvious issues with gnu11, so if this works for
> other architectures too, we should just switch over.

It would mean bumping GCC version requirements to 4.7. But no objections
on my side.

-- 
 Kirill A. Shutemov
