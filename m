Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC34C1CFA
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 21:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbiBWUPr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 15:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbiBWUPq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 15:15:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3504CD54;
        Wed, 23 Feb 2022 12:15:14 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h15so28987940edv.7;
        Wed, 23 Feb 2022 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GCG4Tajtlfm6lqB8z4yTsWXnSPzReunwgVsQMmPAzk0=;
        b=n3eQUXGJPIjIjmq/Zn6XbAiz7Lce/MiL8bAA/WXRpOzi75KqQE21PCn86Z79tntlzG
         jIlL9KeTs/GIxZL23A4g48ZRFxL1gkHUAfcX0zzSA9T9BDr6wFnVZyGYN6iUrYrInknM
         8veUXieT3IL4mfNhSfmSW1F4RftgS3c77d4tRODI63PlFFfp5aYKBpuc7H6FghZjVCza
         Eb+Sc1t4LpgaPy5ypcoiK4lHzBB9UXh+QQq7ZuE50fxQmaAj05Of9xjoNbHEFb/BvuTj
         FLlQB2mfmjYLxZrdYLXEXi/DXHJtpsluXy7IksmreDBQLf8zq+1Lq4m8i50kbrNGFUIO
         sTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GCG4Tajtlfm6lqB8z4yTsWXnSPzReunwgVsQMmPAzk0=;
        b=4A4hwueS7ehAmspYc7m7oPeVxuPKYswLSbI8vnjOZDnWiOKwZxtvcKEAAsOXgiGyES
         48i10fjN6HyIkIFAAePFr15k4eWSIEoXhBf4g9bWo7IKpRSZd7yF5Nu+E4UfixlLEGlH
         6j9vpw5ztQVYik45wazRiszapf0ho8FcvHL+Ev4WbQPV5Y7N5pKjMIZDttOBIX9DQjxM
         XwIMpV1dny1czF18QrTkyjpskUvqTn+kO/EN/EA37lEpmDzMmpqPZmevqHgQ18dLhulc
         y2IIG04Nip+t6BO6OLscD9QiZLdzmyJxDjV0hPGE00yuV9LvhOH+A48RzHoKxehYlgow
         +T9Q==
X-Gm-Message-State: AOAM532hfzOrHtGXmmZsFjixE5zeoCNzLCDyE+EjU1sN0Lq9z9vYhUgk
        BOgzvJkOqqHwT1Q8mDD3e4g=
X-Google-Smtp-Source: ABdhPJzIXXkOsszzXG59avOtu+kLSR4OUCFW8jVfwirjW9mZUI1WgnsTkZVMXNugAKVTSJNIyXOedA==
X-Received: by 2002:a50:8e44:0:b0:40f:d71f:bdf5 with SMTP id 4-20020a508e44000000b0040fd71fbdf5mr1103359edx.166.1645647313319;
        Wed, 23 Feb 2022 12:15:13 -0800 (PST)
Received: from smtpclient.apple (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.gmail.com with ESMTPSA id z11sm279075ejr.99.2022.02.23.12.15.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:15:12 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
From:   Jakob <jakobkoschel@gmail.com>
In-Reply-To: <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
Date:   Wed, 23 Feb 2022 21:15:11 +0100
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9A66F89-66C2-4322-808B-275384C4CC9D@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com>
 <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com>
 <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
 <20220223191222.GC10361@ziepe.ca>
 <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On 23. Feb 2022, at 20:31, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Wed, Feb 23, 2022 at 11:12 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>=20
>> Yes, this is what I had put together as well about this patch, and I
>> think it is OK as-is. In this case the list head is in the .bss of a
>> module so I don't think it is very likely that the type confused
>> container_of() will alias a kalloc result, but it is certainly
>> technically wrong as-is.
>=20
> I think that the pattern we should strive to use is not top use a
> 'bool' with the
>=20
> - initialize to false, and then in loop: do 'found =3D true;' if found
>=20
> - use the iterator variable if 'found'.
>=20
> but instead strive to
>=20
> - either only use the iterator variable inside the loop
>=20
> - if you want to use it after the loop, have a externally visible
> separate pointer initialized to NULL, and set it to the iterator
> variable inside the loop

in such a case you would still have to set the iterator value to
NULL when reaching the terminating condition or am I missing something?

Since the iterator value will always be set to *something* when
calling list_for_each_entry().

>=20
> IOW, instead of having a variable that is a 'bool', just make that
> variable _be_ the pointer you want. It's clearer, and it avoids using
> the iterator variable outside the loop.

I completely agree and was intending to do it in such a way.
However I couldn't find a way to do that without breaking the kernel
between commits.=20

Either you need to first set the iterator to NULL when terminating
which breaks the current code here

or

patch the code location first to do if(iterator), which does not
work with the current list_for_each_entry().


>=20
> It also is likely to generate better code, because there are fewer
> live variables - outside the loop now only uses that one variable,
> rather than using the 'bool' variable _and_ the iterator variable.
>=20
>               Linus

