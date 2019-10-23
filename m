Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707F0E17D4
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 12:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390958AbfJWK0S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 06:26:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40624 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390975AbfJWK0R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 06:26:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id i15so8165182lfo.7
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2019 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRWUNj4J7qgXSXD2PSfXvGDEs07MKcTmNuTdcaVnUGw=;
        b=Slb+IaA7gxUyVr09pbGzJOB54Jv239tGUr7XIcQxfolpIG44u/NoAMOhLnza+Em4WR
         TEPsZuhBtQdRHRD82otLdcY2uJ9E7K4xMc5ZFii1pfI6kkUC5qwEGbYYfYuTwlvtQiDO
         wMOTH/ObIO23qcZyZJ2PI3HvK563JGx6aHaAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRWUNj4J7qgXSXD2PSfXvGDEs07MKcTmNuTdcaVnUGw=;
        b=bFKc9GtSgv6hQrZBpJYAx1DIo6Wv3cGr7B+ex+4XcFMUSLBCD2NHyuJHshqzR54wu9
         VrRzWq0LQGth7sFw+jtBSkgdi38gDjbGGdkAswEhQZUfI0kjIJ3L2jX/feHRtkYmBFjR
         9pvIQYs1njjAfFBx1brdiKEZvysykjElKDGE/8aGRMwMzB89qESUKKT5YEzg7V1WrxnC
         zm3Gsv6NudKjURdGitaa0Z1duNZgLMtapLqiPghaiZjelNwJORmSNbx/i/FWV6V3MEAr
         fAjtiT80vTiPjrRkWV7j9xp7FYVn7lcT2ahId6m0U8ifwDEb31dVdMQpElTmUXcrlVcA
         bqIw==
X-Gm-Message-State: APjAAAXNmWUWLtUDS7dCfcNOWKn4PQtvwTTdM7zm6I09YCR7QHVMt9Wb
        m8mxEKTR3UD30WN8dNB3PBS3ENWlipIVyA==
X-Google-Smtp-Source: APXvYqz1btmdk11ODKqt2SOX7eq0bxCiHtX7uaZiZF3tilJNMrMPH7vw1Jf3Q6ayNMXFOXNupgkPgA==
X-Received: by 2002:ac2:5c4e:: with SMTP id s14mr1584589lfp.23.1571826375422;
        Wed, 23 Oct 2019 03:26:15 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p6sm4055218lfc.35.2019.10.23.03.26.05
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 03:26:11 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id a22so20491670ljd.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2019 03:26:05 -0700 (PDT)
X-Received: by 2002:a2e:29dd:: with SMTP id p90mr21979653ljp.26.1571826364626;
 Wed, 23 Oct 2019 03:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
In-Reply-To: <1571822941-29776-1-git-send-email-rppt@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Oct 2019 06:25:48 -0400
X-Gmail-Original-Message-ID: <CAHk-=whd6wNfx2bq7BmN4ouZgt=NQ5pw+3uqPOTbvz_Qb3itFg@mail.gmail.com>
Message-ID: <CAHk-=whd6wNfx2bq7BmN4ouZgt=NQ5pw+3uqPOTbvz_Qb3itFg@mail.gmail.com>
Subject: Re: [PATCH 00/12] mm: remove __ARCH_HAS_4LEVEL_HACK
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 5:29 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> These patches convert several architectures to use page table folding and
> remove __ARCH_HAS_4LEVEL_HACK along with include/asm-generic/4level-fixup.h.

Thanks for doing this.

The patches look sane from a quick scan, and it's definitely the right
thing to do. So ack on my part, but obviously testing the different
architectures would be a really good thing...

                Linus
