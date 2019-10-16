Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3023FDA1A2
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 00:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391929AbfJPWk0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 18:40:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43514 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfJPWk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 18:40:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so382743ljj.10
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04dJb9Nazr1VJFQ3H66lxKHMdWvTkJpJ9XeZFuHXJpY=;
        b=Y6FXKxmvNk+SLSy8K1d8iyVTicj84WbDRknyfjwv/0dEjng3n+gui83MkLy/POww6I
         IMiehB/IGPDe1KtWH9SiVdUWEkMntj3gNmyrct47Rf3lWJ0XoTln8pEYhIce5pbKMgAP
         cQwkdbd4zrNR84FnQGKl1y+P6KVdwD+HPFdns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04dJb9Nazr1VJFQ3H66lxKHMdWvTkJpJ9XeZFuHXJpY=;
        b=BIR8y+tRw5l1+1UFuEIvOaDP0qEZG/ktkDEvC27Ej59OqLY67/ax65IOTVLAyCmkPX
         V0EBMiOuJPrE395s6Q/Ia26qf6yWNEnPIAcP7i98ZwC3g5w4r+pf9wkSOYFc92X2wfjo
         fv0Oug2Boey3k9fWiV8Rl/MoU7dNtmo/9bGhYScaD845b4kU761EVIYhiXTvLK70nKJR
         UomPjI5bKp7rNMxC2R5Q2i8LEMVM6vb2jzk9nrLTq6K2N12YfVVdbMDOPykTDHJVEBc8
         F91DJ4WOVkcXgHD/UFTko/L8SX3X/MiN3yKjHbjhbwHQ8OGCnjT1aO8IIPsl+t2gkiGH
         nfNw==
X-Gm-Message-State: APjAAAVhKgFg1EfJhwTOrdExgjEUOOIbMyKN3WaS5AlzZxvnX+61kNdI
        WY2/by8+IyYfS9MmToUa3Jf8rQ0Y96Y=
X-Google-Smtp-Source: APXvYqym4dF+d9sgS+FkXJUEqb3xuwXi1kH1r3z57dUPpdJo321dmgoXT8HqbGQJo4QLy/bppY5pWA==
X-Received: by 2002:a2e:2407:: with SMTP id k7mr296813ljk.73.1571265622964;
        Wed, 16 Oct 2019 15:40:22 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z26sm99365lji.79.2019.10.16.15.40.20
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 15:40:20 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id a22so434536ljd.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 15:40:20 -0700 (PDT)
X-Received: by 2002:a2e:2b91:: with SMTP id r17mr311891ljr.1.1571265619954;
 Wed, 16 Oct 2019 15:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com> <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
In-Reply-To: <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Oct 2019 15:40:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaSMp_MOKgAa=AwLDAY0Rtjdrw-AFKuLXbFsTJSevosA@mail.gmail.com>
Message-ID: <CAHk-=whaSMp_MOKgAa=AwLDAY0Rtjdrw-AFKuLXbFsTJSevosA@mail.gmail.com>
Subject: Re: [patch 014/102] llist: introduce llist_entry_safe()
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Pinski <apinski@cavium.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     mm-commits@vger.kernel.org,
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

On Wed, Oct 16, 2019 at 3:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I only tested gnu99 - which is sufficient for the above - and didn't
> see if gnu11 ends up causing more issues..

I see at least no obvious issues with gnu11, so if this works for
other architectures too, we should just switch over.

              Linus
