Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9062F203095
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 09:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbgFVHXL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 03:23:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731310AbgFVHXK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 03:23:10 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N5mOZ-1imNbr3LRr-017G92; Mon, 22 Jun 2020 09:23:09 +0200
Received: by mail-qk1-f173.google.com with SMTP id z63so2571176qkb.8;
        Mon, 22 Jun 2020 00:23:08 -0700 (PDT)
X-Gm-Message-State: AOAM533FtBijGcTrtOkJi3oTOfrIFaN3Ii0dNUCTWz6GpY9qJR0aCuWl
        BipsJ1TETOks0TyoHmJZTZOH/btYjUhKaArJRL4=
X-Google-Smtp-Source: ABdhPJy4+PG/jO7wVUsFSfIpF5R/bWJiNgbXn/vFcnnPY0kXyJxZGx5a7B+H4vd/jRet/Oxk0DIvf3Vxob5pyRclbeM=
X-Received: by 2002:a37:b484:: with SMTP id d126mr6037318qkf.394.1592810587540;
 Mon, 22 Jun 2020 00:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200617092614.7897ccb2@canb.auug.org.au> <20200617092747.0cadb2de@canb.auug.org.au>
 <20200617055843.GB25631@kroah.com> <20200617161810.256ff93f@canb.auug.org.au> <20200622142512.702bdc68@canb.auug.org.au>
In-Reply-To: <20200622142512.702bdc68@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jun 2020 09:22:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2UVN_p0JFj6mCRR8oig2dyeBF1-WVo_hCdy879Oup9yQ@mail.gmail.com>
Message-ID: <CAK8P3a2UVN_p0JFj6mCRR8oig2dyeBF1-WVo_hCdy879Oup9yQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Explicitly include linux/major.h where it is needed
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fBwBo+t219rjGe+/E/Yy9L/qyDafIPU4CkHSJGF/y5sGmq4h1L6
 Oya/7JKMbDeHdy1j2+ShVeX1U5d1IS7gvcij2xlVkMvd9o5byULTJMT385qAMmuTZC0un/4
 cb7wXh1InsUSNm0sg2MFBXxx/kRtnkJfvrDGFHTUyBwSmmA0f3Ynq2xCCPKGqy3kAHlS4Gi
 GZGYZKMsoFAPYU18jGfCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0+EXIFOA4Zk=:/DZlNc7lkgAx3su1tGXLfH
 SqS/kGgNFxhK3y6Gi8VufyRifA41wG2wCJ0+5S2IU8ekEtBLkk9dYocyvtlmC6OpswNzjJ7Vj
 grYpMFmk6B7d1n0ACf1EFyL/8btXZU4ixu7jzTpzeixnV/y9WlDelrv5u1Xqyqa+/dbC4TeUB
 cCSCg74UMYMd6UY2FINokCw8kBExsoZOBMVBZFH9X1p3kIfVYk9j8aXoZze6qVOaM7mmlpPr6
 KyDtjuvf46uDZNKP8AJ44C0NKXQySetq6JiDTNbawZYVrf1+ur9sooq22csGyFTDxEUrgQUZM
 BDQY1rMGBG95mBIC5OVvxkwrr797Tfp0LMWhDUxQHJnmM3BNsvtRUjz4v4I4jx7bzx1Qcksdx
 BCIqk3tv6oxVsg6lJU5UOg97oseji6xKbyp6dWNS+iVZaVZrrqZ8nQ2m5q9r5WpT/J+uCyEWK
 jHaCVaZ1KY2hEPARe+eLrrDi+EiVD7GG0Jfjnpk1tUuSH3gNNlL9MNPTUEvIcMq+ADV5QZ8st
 KwO7TVgYT+IqdexTArnd4CABdTTe7m+4ilAJXcThPqvWdg1aNtQak+Rj0VQ55O4i4e2aQSstH
 XZkMMDOWkdgII46Xncr5eOws4u52+PCVyo8cFCBypA+QKbQr/4iIRfgO6aAkgIiL5hQlO30xm
 Cu1eeXXGScuipiJA7tOyXDOe7pvoGF671MOJAzSHvALGfhBwgaLVfUipkr+RtDAh/L7UTHx9x
 Vrug4OqyvEFBZOAf/nt2gI3KPtjYZzZTmxVCZ2i6aq0JbAQM+qlUBi8TRV7P2KAnpVl3Empxt
 LBZiQXpPUttuys3Wt+7UCOywtAuFXqYMSziR1j8RNjTW2LvIAc=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 6:25 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Wed, 17 Jun 2020 16:18:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > On Wed, 17 Jun 2020 07:58:43 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Wed, Jun 17, 2020 at 09:27:47AM +1000, Stephen Rothwell wrote:
> > > > This is in preparation for removing the include of major.h where it is
> > > > not needed.
> > > >
> > > > These files were found using
> > > >
> > > >   grep -E -L '[<"](uapi/)?linux/major\.h' $(git grep -l -w -f /tmp/xx)
> > > >
> > > > where /tmp/xx contains all the symbols defined in major.h.  There were
> > > > a couple of files in that list that did not need the include since the
> > > > references are in comments.
> > > >
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > >
> > > Any reason this had an RFC, but patch 2/2 did not?
> >
> > I forgot :-)  I added RFC just to hopefully get some attention as this
> > is just the start of a long slow use of my "spare" time.
> >
> > > They look good to me, I will be glad to take these, but do you still
> > > want reviews from others for this?  It seems simple enough to me...
> >
> > Yeah, well, we all know the simplest patches usually cause the most pain :-)
> >
> > However, I have been fairly careful and it is an easy include file to
> > work with.  And I have done my usual build checks, so the linux-next
> > maintainer won't complain about build problems :-)
> >
> > I would like to hear from Arnd, at least, as I don't want to step on
> > his toes (he is having a larger look at our include files).
>
> Any comment?

I now have a set of regex/header file pairs and a script that automatically
adds the #include statements to any source file that needs them as a
preparation for a larger-scale cleanup. Your change is going in the
same direction, and linux/major.h is a header that was not on my list
yet, so I'm completely happy with this.

One thing that I did differently in my script is to insert the new #include
statement in a way that retains alphabetical ordering of the other inclusions
rather than adding it at the end.

If the headers were not sorted before, it just tries a trivial nearest match,
adding it somewhat randomly, but it would still avoid some clashes with
patches that add different headers at the end or that add the same header
using the same method.

      Arnd
