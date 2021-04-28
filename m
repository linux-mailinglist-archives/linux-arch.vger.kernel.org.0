Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1536D806
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 15:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbhD1NIJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 09:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239600AbhD1NIH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 09:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ADA96141B;
        Wed, 28 Apr 2021 13:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619615242;
        bh=8/STA7bGiSjXSDV4A6R9tGC/6aPDB16dVaxkyZxGoGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bf0T+ByNax+99vYSpD7zdcAHPg6qYJIjVDlIa0VUKkYfcD00MV93+sLjI7YBVpGpF
         aurg7sg9/TKYUP8avmnZgAaZEfSaH3F+No5GmAzP7LbVEv/Txf+ltjVnh0jD7gBBtH
         ZZpWCMaYvsSRcgS3HvMxvPthb5pminu0Y0375XEaoeZzCNNI3Sp0DG0QJ8C7brAlp5
         lRY9D3SuWLq3Ln86AfiJnXRUW2IJKWl7IG1NucxGPfki9ppYkTSnSWD9EHU/zH7TjG
         MyjMIt4gBC+bBvRUn2QikPGX9FkpvbD1lTPl5i7gYHzw/23QsrDRnNK49uhTW2XfHB
         htCwdOx1BR9/A==
Received: by mail-lf1-f50.google.com with SMTP id y4so58907967lfl.10;
        Wed, 28 Apr 2021 06:07:22 -0700 (PDT)
X-Gm-Message-State: AOAM531W7s41rREuysoQU3dWOKuDkKZZceHhbippIA/pP3VgTQcPAmgN
        u2lrhQgDv3cqFvUtebKAmzYM4BSJ6/MTGZkqBDo=
X-Google-Smtp-Source: ABdhPJzg7CZ/H+IwoHlzbqtk1Ck8bLUOLPuNwWOnqjfXDfp7yV+ahc6SMkQr2DK1tVW6xM14eIkU3IQ3WgMytns6Ios=
X-Received: by 2002:a19:711b:: with SMTP id m27mr21117190lfc.346.1619615240721;
 Wed, 28 Apr 2021 06:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <1618995255-91499-1-git-send-email-guoren@kernel.org>
 <20210428031807.GA27619@roeck-us.net> <CAJF2gTTSMC947zisNs+j_2rMoBqoOy-j1jvVBk2DNrf0Xt6sWA@mail.gmail.com>
 <CAK8P3a1DvsXSEDoovLk11hzNHyJi7vqNoToU+n5aFi2viZO_Uw@mail.gmail.com> <20210428124946.GA1976154@infradead.org>
In-Reply-To: <20210428124946.GA1976154@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 28 Apr 2021 21:07:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTQysMLESzoGsUgGy=sgFkkocmCiv-vAV9a6U2m6bRC2g@mail.gmail.com>
Message-ID: <CAJF2gTTQysMLESzoGsUgGy=sgFkkocmCiv-vAV9a6U2m6bRC2g@mail.gmail.com>
Subject: Re: [PATCH] csky: uaccess.h: Coding convention with asm generic
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 8:50 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Apr 28, 2021 at 11:25:29AM +0200, Arnd Bergmann wrote:
> > Actually, please don't use the asm-generic __put_user version based
> > on copy_to_user, we probably have killed it off long ago.
>
> Yes, they are horrible.
>
> > We might want to come up with a new version of asm-generic/uaccess.h
> > that actually makes it easier to have a sane per-architecture
> > implementation of the low-level accessors without set_fs().
> >
> > I've added Christoph to Cc here, he probably has some ideas
> > on where we should be heading.
>
> I think asm-generic/uaccess.h pretty much only makes sense for
> nommu.  For that case we can just kill the __{get,put}_user_fn
> indirection.  I actually have work for that in an old branch.
>
> Trying to use any of asm-generic/uaccess.h for MMU based kernel is
> just asking for trouble.
I still think the arch should base on asm-generic/uaccess.h, not abandon it.

Thx for reviewing.

>
> > One noteworthy aspect is that almost nothing users the low-level
> > __get_user()/__put_user() helpers any more outside of architecture
> > specific code, so we may not need to have separate versions
> > for much longer.
>
> Al has been trying to kill them off entirely for a while, and I hope
> he'll eventually succeed.  That being said the difference should be
> that the __ versions just skip the access_ok, so having both is
> fairly trivial to implement.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
