Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69E619CC22
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 22:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389956AbgDBUz2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 16:55:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42939 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389630AbgDBUz1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 16:55:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id q19so4715528ljp.9
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 13:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YR/nUD2Z88aJr6Pg6Jbj/uRmXq5/iJdtBPPDjhYxa08=;
        b=dq1Xt42zOdAJ9Qswqhw3DC5ZWJPx708kVOLPio6Z4i5kSkx4SK5PaEo/6koIh9QTi0
         yfOTVpLmbl4n8jtyb/2WcDEO7fuXO+AAVPX7mMUJ0v/+lRQnPhNsNuau5SsaccYONsWw
         LhoxKSxXEV20XpXwx2ctLh7uQXRBDSE3iznhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YR/nUD2Z88aJr6Pg6Jbj/uRmXq5/iJdtBPPDjhYxa08=;
        b=YxKY43P9bUWOVW5QG3G8nX2j22z7iEopa0fiCZ6sV7nZi5ZDQzwaemVPpJh3sJk5Kz
         AJCQYfnEQ4gyzMYi0Uo8swiIRoPZkvIEQZ3p/Fn/NlhK8wBn/e9PgjHGfdokBFWkKyAZ
         hbFRCA0hUSadn/Y22ku9HCian+ERdMYIMOJ8X6dEuu4eHkUKLHq3X0ZOe+D9AFZjEHD2
         PvWR94/hw7XzxfodDy2dp2+rIGozfwn130jUZzhA440woo1F8Kih5hidGI8bXNq+OQ2j
         mFul/Zk1yhAkVAEgcd2tVAdh6R/kfI29TWtuu8cVCqVkjP+IxQ686GKRWujAqlLVRLYt
         iaLA==
X-Gm-Message-State: AGi0PubIMPUpmoYqV7YmglD74Ccqc+D3DUZHrCU+jr2bqRoiffWGLtOX
        vjfRqnp6GgHXdkTAh1vol4WNKi1ML0U=
X-Google-Smtp-Source: APiQypJw4K/gSlUi80EVah6cUQCKipabyIiJ5IcOJgyE8gaLfZy09IbpLsDmGg3/DRZySx/A55Opzw==
X-Received: by 2002:a05:651c:102f:: with SMTP id w15mr2946427ljm.5.1585860925490;
        Thu, 02 Apr 2020 13:55:25 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id p14sm2071463lfe.87.2020.04.02.13.55.25
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 13:55:25 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id r24so4773346ljd.4
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 13:55:25 -0700 (PDT)
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr3290368lfr.152.1585860460299;
 Thu, 02 Apr 2020 13:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk> <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk> <202004021132.813F8E88@keescook>
 <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com> <202004021322.5F80467@keescook>
In-Reply-To: <202004021322.5F80467@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 13:47:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUfAsepavvy2vsnyOv06yeYBMumSeb+dzDSnJXkX7qPQ@mail.gmail.com>
Message-ID: <CAHk-=wjUfAsepavvy2vsnyOv06yeYBMumSeb+dzDSnJXkX7qPQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and user_write_access_begin/end
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 2, 2020 at 1:27 PM Kees Cook <keescook@chromium.org> wrote:
>
> I was just speaking to design principles in this area: if the "enable"
> is called when already enabled, Something Is Wrong. :)

Well, the "something is wrong" could easily be "the hardware does not
support this".

I'm not at all interested in the crazy code to do this in software.
Nobody sane should ever do that.

Yes, I realize that PaX did software emulation of things like that,
and it was one of the reasons why it was never useful to any normal
use.

Security is not an end goal in itself, it's always secondary to "can I
use this".

Security that means "normal people can't use this, it's only for the
special l33t users" is not security, it's garbage. That "do page
tables in software" was a prime example of garbage.

               Linus
