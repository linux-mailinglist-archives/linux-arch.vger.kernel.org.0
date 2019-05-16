Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062E0210B5
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2019 00:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfEPWtC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 May 2019 18:49:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44817 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEPWtC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2019 18:49:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id f24so5900320qtk.11;
        Thu, 16 May 2019 15:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HCSHfWWQoOMU9IYPEECn6c5bcFnN/huF1hZpjyeGtc=;
        b=EJaPzb4USVq63WRMWbQAoJVj3iza2U49b6w7vFva3xwCjGb+cyTRe9yFKT/wgLiUAj
         4PfVkfZ6JqmGuO6KP0ce1tpJv5qh5lKZbB8852TLPfb7ggdibxjlmyV3vxkNpVYjx6mk
         D/P3UxU/vvJUk8qrJbPYT0W+xxINoOs/7YmHIESOwppaHz0G4trIvvPQXWT+XmDtuTFP
         JFygFkzNGX010EBb1mhcoKsswJ+CtNwa4qOiDM3nCIgKmyGIusPbHUNfdti4v6+yQ1TF
         W0I8TTAN1wOKIrzzAQTnu7h/RFOtsjFTG3MN1XxlHBiSJN4y0bX3EBBTaOzqgkkDHCj+
         iyPQ==
X-Gm-Message-State: APjAAAUH4iat+JZ41fpHInZj5zuMpwm9AS02++q8arosVuEMn4wM11Kq
        6GKk3W+tc6X6T/LVgCG/OP8Yw2OrOW/y1VWnC3o=
X-Google-Smtp-Source: APXvYqzuJv0swkCZ9YDJNYDFgYTnD0BTmGh9QBNFwePpoN3V/fGbw6KJlz3gLIuDNdfa5/lPPkxazRL9tvT8iIpUFKo=
X-Received: by 2002:a0c:b78a:: with SMTP id l10mr21490193qve.62.1558046940896;
 Thu, 16 May 2019 15:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2+RHAReOZdo8nEvqDeC1EPj83L2Ug4JuVRiUh943AuNw@mail.gmail.com>
 <CAHk-=wgiv5ftb+dq7N8cN4n2YX3VkyzeQccywn07Xu9xhOLTSw@mail.gmail.com>
 <CAK8P3a2EEuxh3uhsqauEC_vROZ7tQHhFwxgiLUnrgtpMdb3kuA@mail.gmail.com>
 <CAHk-=wiH=vGjsW9MdWFGsgto2W+71sA4XJ7CSubpXkbpC_bGKA@mail.gmail.com> <1558043623.29359.44.camel@HansenPartnership.com>
In-Reply-To: <1558043623.29359.44.camel@HansenPartnership.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 May 2019 00:48:44 +0200
Message-ID: <CAK8P3a0QsURY+QrkvBh5zS12cCLYD=ssVtus_6Q_DSnB1=1y3A@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic: kill <asm/segment.h> and improve nommu
 generic uaccess helpers
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 16, 2019 at 11:53 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2019-05-16 at 13:59 -0700, Linus Torvalds wrote:
> > On Thu, May 16, 2019 at 1:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > >
> > > I have reconfigured it locally now and pushed an identical tag with
> > > a
> > > new signature. Can you see if that gives you the same warning if
> > > you
> > > try to pull that?
> >
> > No, same issue:
>
> The problem seems to be this:
>
> jejb@jarvis:~> gpg --list-keys 60AB47FFC9095227
> pub   rsa4096 2011-10-27 [C]
>       88AFCD206B1611957187F16B60AB47FFC9095227
> sub   rsa4096 2011-10-27 [E]
>
> Your key is a "Certification key" and you have an encryption subkey but
> no signing key at all.  Usually you either have a signing subkey or
> your master key is both certification and signing ([CS] flags).
> Certification keys can only be used to certify other keys, they can't
> be used for signing, but I bet gpg is assuming that it can sign with
> the master key even if it doesn't possess the signing flag.

Strangely, the copy I have on my local machine does have the 'S'
flag. I sent it back to the server now.

> You can make your master key a signing key by doing
>
> gpg --expert --edit-key 60AB47FFC9095227
>
> Then doing
>
> gpg> change-usage
>
> and selecting "toggle sign"
>
> Or you could just add a signing subkey.

I had some problems with creating a subkey, probably because of
some misconfiguration. It seems to work now, so I created a new
signing subkey now for future use.

Thanks a lot!

     Arnd
