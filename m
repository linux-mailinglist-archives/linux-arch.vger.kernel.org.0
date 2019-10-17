Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB2DA29B
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2019 02:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfJQAQS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 20:16:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36915 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfJQAQS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 20:16:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id l21so587683lje.4
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 17:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NOhcohWAiInmjTFcW8QzmT2pG077c1YWYQvbWDWdr9g=;
        b=0GVCISF/6wmd5g9e4GmprZEFXv6Bg6OsgM7YClR1pQIfU8nyKG/pmMUZGiYlsifhA5
         GbbzVDw9Q11qzqNoVYT2P1Q7l7RXu0xo7cwvoIU2LOCaQIknAyqkZ4DWCrj+4nnvnI2H
         meoZHNWMwXD7trAfZrRL/axPcjvGAaxjF5NrEteSpCH1lboVczjEp5GGOaXtyudsrQsX
         /oaNxsmLIgjmt4ln2MTXdU5o8xYPIUzRc1vNihzOnOSl7t096b0yH4XG88xHWRrUpdH9
         HjBwjtlT8UBZk3DwJCTXzjPv1n+9YIp1LXvGMpVQu9pL7CikkbPvGjKktE4VCTwMPbeJ
         noAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NOhcohWAiInmjTFcW8QzmT2pG077c1YWYQvbWDWdr9g=;
        b=l8PPS1f/C+QRGupvGenZsBQ/A8zif0OK+dVC4bYyzilcAp915NcUHqxp4wBFW5y0vx
         So+NsyBbavWh2o+HRHuQMrft1t1ri93SatRwgCOZpqj0NkG+ACttneUt8EEm9C06KZbV
         2B83Wl99RkKgG/zPaWv7UeSqfUcri1y4q+mWwl43gj1T3d7IItRJoy20qKPDbPJpT3Cj
         M6lvqk4TnelaGuDwSK8NMDB17WXH1xEb/PoxVV82V/qvpT5D0eO2kkFCOa8LTCQCdgTM
         PWJmov0iZOpUbkianwgvm0MwZyMgvDRUNQ+Hr/vDwOsHo42NurHnjvstv8bzoP9CPtGB
         DJUg==
X-Gm-Message-State: APjAAAUfqVTq4mufK7+o7VgkFdAg8row0hfq8T4C0V5wIdkqSMZ1Xw5V
        wv3CbraFVF5ddlaSmM2BELW67A==
X-Google-Smtp-Source: APXvYqyMspv61yx/Obhk166Fc9R826HgXtuzKXb+x4CLZ4P5bhtWHLMAROwlQdVrUPF2Gm5/wXM9NQ==
X-Received: by 2002:a2e:878a:: with SMTP id n10mr479592lji.229.1571271376254;
        Wed, 16 Oct 2019 17:16:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id a8sm211738ljf.47.2019.10.16.17.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 17:16:14 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 34F07101287; Thu, 17 Oct 2019 03:16:13 +0300 (+03)
Date:   Thu, 17 Oct 2019 03:16:13 +0300
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
Message-ID: <20191017001613.watsu7vhqujufjxv@box.shutemov.name>
References: <57fd50dd./gNBvRBYvu+kYV+l%akpm@linux-foundation.org>
 <CA+55aFxr2uZADh--vtLYXjcLjNGO5t4jmTWEVZWbRuaJwiocug@mail.gmail.com>
 <CA+55aFxQRf+U0z6mrAd5QQLWgB2A_mRjY7g9vpZHCSuyjrdhxQ@mail.gmail.com>
 <CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com>
 <20191016231116.inv5stimz6fg7gof@box.shutemov.name>
 <CAHk-=wh9Jjb6iiU5dNhGTei_jTEoe7eFjxnyQ2DezbtgzdoskQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9Jjb6iiU5dNhGTei_jTEoe7eFjxnyQ2DezbtgzdoskQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 16, 2019 at 04:29:54PM -0700, Linus Torvalds wrote:
> On Wed, Oct 16, 2019 at 4:11 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > Looks like it was fixed soon after the complain:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63567
> 
> Ahh, so there are gcc versions which essentially do this wrong, and
> I'm not seeing it because it was fixed.
> 
> Ho humm. Considering that this was fixed in gcc five years ago, and we
> already require gc-4.6, and did that two years ago, maybe we can just
> raise the requirement a bit further.
> 
> BUT.
> 
> It's not clear which versions are ok with this. In your next email you said:
> 
> > It would mean bumping GCC version requirements to 4.7.
> 
> which I think would be reasonable, but is it actually ok in 4.7?

I think, not. I don't have 4.7 around, but 4.9.3 has the issue if
-std=gnu99 is used.

> The bugzilla entry says "Target Milestone: 5.0", and I'm not sure how
> to check what that "revision=216440" ends up actually meaning.
> 
> I have a git tree of gcc, and in that one 216440 is commit
> d303aeafa9b, but that seems to imply it only made it into 5.1:
> 
>   [torvalds@i7 gcc]$ git name-rev --tags
> d303aeafa9b46e06cd853696acb6345dff51a6b9
>   d303aeafa9b46e06cd853696acb6345dff51a6b9 tags/gcc-5_1_0-release~3943
> 
> so we'd have to jump forward a _lot_.
> 
> That's a bit sad and annoying. I'd be ok with jumping to 4.7, but I'm
> not sure we can jump to 5.1.
>
> Although maybe we should be a _lot_ more aggressive about gcc
> versions, I'm on gcc-9.2.1 right now, and gcc-5.1 is from April 22,
> 2015.

5.4.1 builds kernel fine for me with allmodconfig (minus retpoline which
requires compiler support). Both -std=gnu99 and -std=gnu11.

Note that GCC has changed their version scheme. 5.4.1 is bug-fix release
of GCC-5.

-- 
 Kirill A. Shutemov
