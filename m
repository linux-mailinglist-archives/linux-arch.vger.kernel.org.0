Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC28B33F273
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCQOUH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 10:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhCQOUA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 10:20:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130CFC06174A
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 07:20:00 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id t18so1626093iln.3
        for <linux-arch@vger.kernel.org>; Wed, 17 Mar 2021 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2PWXoD7KT3esSQNrycMbsgcjlNio2xDcr7h5B3nFMo=;
        b=CyJrp8QmWw38fXXaQQbAiVc4gTJ5+73ajA/nVonV59EFO0RV5PmCHToix9hen8din9
         lYVgU8olW+HimAD/S7VUAOzYoAuAeWLaoV2t7I1x5gIzvTsKGS7bnOMKjDyt0lIL5HfL
         hRHfhm+41EjCXUNLhYKXwWiIGMaYR4L4zKBi7h/iveaBA+SxiKQ1y0ZdRpnvkNhJbeKP
         9YpiNtuqQys7fR050hzOuA6KnCdGFxGcGBfVycFQspeyj6z0p1imPEH5VqWNxk5sBYhx
         no+58iPPE7af+IigrgbLrhjo/jTNB8Ww9x8hkFZM67+gD2pQvV45BYVTakJNy2MEtQ8O
         DFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2PWXoD7KT3esSQNrycMbsgcjlNio2xDcr7h5B3nFMo=;
        b=MQIWdiqZ2cYjPxUPOiprU0c13/PSIpC2ipQEzmNE6vNeFiENxVKLPK1Q72SdWhudru
         gMbfx+MvYjSYOV/FVgFMA2tpHsEm0AEeJ3BtHhppe6gqeCatnzpjxL3e0mQALUbd6B7f
         ziu9WAkG6fMNXVA5GwduVbQI6m/u2xVqSbOOe1LDb9nVEnXabmDRzZ6aHrPsAiRP39we
         7izEaMScFa1RbTQCsUN4mluoQsaAfatBGel8g9/NFU9kNxPEyLJW/sYay/Wbb0n58jN/
         ecoJS79o1fd2cquPs85Rtz6w5q6a8MIj3XL3uvIl9sFbF/2/O4M+ueieRrzrnETPWI+P
         NkZg==
X-Gm-Message-State: AOAM531+ZYza1aRW5/Pol4hBfO4D2h/Ftma2eR0K+oO1lIrcf2Yva+EI
        O5BhzKrNNPgx/SeBfKRy+D6aE0AmimYJXATnddM=
X-Google-Smtp-Source: ABdhPJw0gCKxbHLDivCExtmdvFwaAZf6MC0Rkm/gkWUeSCY+jMP2FDqJHII8Y0IwNhiP3lPeeD7yuqNCFv2I7sJV3zg=
X-Received: by 2002:a92:7311:: with SMTP id o17mr7785695ilc.231.1615990799579;
 Wed, 17 Mar 2021 07:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1611103406.git.thehajime@gmail.com> <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
 <2b649bc5165c7ff4547abd72f7e03e7491980138.camel@sipsolutions.net>
 <m25z1rc2ux.wl-thehajime@gmail.com> <56af0e44c846f4b079256ec997c56119964be402.camel@sipsolutions.net>
In-Reply-To: <56af0e44c846f4b079256ec997c56119964be402.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Wed, 17 Mar 2021 16:19:48 +0200
Message-ID: <CAMoF9u2phDz5nmFFSW-9VKs2gTK0exHaPxrOf4nM5gAQnQhcRQ@mail.gmail.com>
Subject: Re: [RFC v8 19/20] um: lkl: add block device support of UML
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 11:32 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Tue, 2021-03-16 at 10:19 +0900, Hajime Tazaki wrote:
> >
> > > > --- a/arch/um/Kconfig
> > > > +++ b/arch/um/Kconfig
> > > > @@ -29,6 +29,10 @@ config UMMODE_LIB
> > > >   select UACCESS_MEMCPY
> > > >   select ARCH_THREAD_STACK_ALLOCATOR
> > > >   select ARCH_HAS_SYSCALL_WRAPPER
> > > > + select VFAT_FS
> > > > + select NLS_CODEPAGE_437
> > > > + select NLS_ISO8859_1
> > > > + select BTRFS_FS
> > >
> > > That doesn't really seem to make sense - the sample might need it, but
> > > generally LKL doesn't/shouldn't?
> >
> > I'm trying to understand your comment;
> > Do you mean that enabling those options in Kconfig doesn't make sense ?
>
> I mean *always* enabling them doesn't make sense. Why shouldn't somebody
> be allowed to build UMMODE_LIB *without* btrfs? If they have no need for
> btrfs, why should it select it?
>
> I can understand that your sample code wants btrfs just to show what it
> can do, but IMHO it doesn't make sense to *always* enable it.
>

I agree. I think these can stay in defconfigs but here is where a
library introduces complications which I don't know how is best to
handle. Should we have the defconfig in arch/um or should we have it
in tools/testing/selftests/um? Or perhaps both places, one being a
generic config that would be used by most applications and one
customized?
