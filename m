Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15B14C1E39
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 23:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiBWWJb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 17:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiBWWJa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 17:09:30 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832F94A927;
        Wed, 23 Feb 2022 14:09:00 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vz16so412010ejb.0;
        Wed, 23 Feb 2022 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Heow4hDDMSZ2DF+IFY7uzO/bwjvFxqCGzwmmOWLjSLo=;
        b=aqNZfy51Zoj3GU0fSlQHALzjGJHEntuIJ9qOIf0wqhxeHCmhk2IVi2giP2LbjJUL/o
         pxUKWShoqp2O4G5gGgDaXqjCO4xFxrAnQJ4GgSk+hFyqAE+doGi1BXte0NDdNwyq/E0S
         5oIKRWV0htuhNqkiQ8SS8r4PtK+BClJQTYfYDS2TfY9ZoHySIMpSwd8ONoNi3PaXkbBU
         oPVMDCZXlCHD2vin5ljlJ4s4j9F7fvge82e8Ei523Epj0j+I7Vbw0KhztDSjPvCMh6Px
         yb2Jw4dcRjn8tKJWL3bWTnNmZ99EGJAOrFAAKqrXIe3ggPcAbqRdhsLVq0tHfxZIB4l8
         MC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Heow4hDDMSZ2DF+IFY7uzO/bwjvFxqCGzwmmOWLjSLo=;
        b=Wd+7SYimqb+lEuASOI/BeXJt/5nOj+GzfIqU0msaNDrAi8K8FN1O50GR9GJVyumMEA
         /mkad1r86xp2HWSTjYYzpbSkLdQ3KkPyIiW2W100tvOKTRDYcfBxwBWa1arVti18Q9R+
         cKeeKD8E8Rf1ju3CrWFVDxr5G8Ik3wU/QdyPTiNHThSVYw1mYlGWp4mbaUCunnwH/Kjg
         K6RREKJAueDrLnFTYlMHl0HMCyJlPZYUPMB8vWTu/QPlarQcDfHntosVMaO8LxNAmwte
         VuxSQpieBEe3HEDVr4xgHww2g30u77qyemZ7qcrBpu2K/DDnhfvv4NBng9W9CEXsL5Bg
         AqPw==
X-Gm-Message-State: AOAM531vzp5wN9Z16NSJpVvdFAM1EfaGlkhYbJBfzF29lckh8boaHcAH
        P4ZheY4NzNFBxdW2NRLQAwU=
X-Google-Smtp-Source: ABdhPJxlxKQQ9SzoGatPnAkqSs0iogZ5UgztBq0GRpEKEKwyLD4K7L/8YRQjTtXRA5+qcYNVQVn68Q==
X-Received: by 2002:a17:906:abca:b0:6d0:9ebc:b9cf with SMTP id kq10-20020a170906abca00b006d09ebcb9cfmr1301096ejb.288.1645654138940;
        Wed, 23 Feb 2022 14:08:58 -0800 (PST)
Received: from smtpclient.apple (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.gmail.com with ESMTPSA id w4sm469075edc.73.2022.02.23.14.08.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 14:08:58 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
From:   Jakob <jakobkoschel@gmail.com>
In-Reply-To: <CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com>
Date:   Wed, 23 Feb 2022 23:08:53 +0100
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
Message-Id: <BA4ACA21-2368-4BEB-ACF0-F4C2042880F4@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com>
 <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com>
 <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
 <20220223191222.GC10361@ziepe.ca>
 <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
 <F9A66F89-66C2-4322-808B-275384C4CC9D@gmail.com>
 <CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com>
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



> On 23. Feb 2022, at 21:22, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Wed, Feb 23, 2022 at 12:15 PM Jakob <jakobkoschel@gmail.com> wrote:
>>=20
>> in such a case you would still have to set the iterator value to
>> NULL when reaching the terminating condition or am I missing =
something?
>=20
> No.
>=20
> Make the rule be "you never use the iterator outside the loop".
>=20
> IOW, the code sequence is
>=20
>        some_struct *ptr, *iter;

with C99 iter would be defined within the loop instead right?

>=20
>        ptr =3D NULL;
>        list_for_each_entry(iter, ...) {
>                if (iter_matches_condition(iter)) {
>                        ptr =3D iter;
>                        break;
>                }
>        }
>=20
>        .. never use 'iter' here - you use 'ptr' and check it for NULL =
..
>=20
> See? Same number of variables as using a separate 'bool found' flag,
> but simpler code, and it matches the rule of 'don't use iter outside
> the loop'.

ah yes this does make sense. I missed the part of using a separate
'ptr' variable. Thanks for clarifying.
I think this is a great idea.

There are cases where pos->member is used (the only legitimate way to
use it right now). I suppose those turn into something like this
(this example is inspired by dev_add_offload() (net/core/gro.c:38)):

       some_struct *ptr, *iter;
       list_head *list_ptr;

       ptr =3D NULL;
       list_for_each_entry(iter, head, list) {
               if (iter_matches_condition(iter)) {
                       ptr =3D iter;
                       break;
               }
       }
      =20

       if (ptr)
               list_ptr =3D head->prev;
       else
               list_ptr =3D iter->list.prev;
       list_add(..., list_ptr);

before it was simply
       list_add(..., iter->list.prev);


The other possibility I suppose would be:

       if (!ptr)
               ptr =3D container_of(head, typeof(*ptr), list)
       list_add(..., ptr->list.prev);

which leaves you with the same type confusion as before, being far from
ideal.

> This is how you'd have to do it anyway if we start using a C99 style
> 'declare iter _in_ the loop' model.
>=20
> And as mentioned, it actually tends to lead to better code, since the
> code outside the loop only has one variable live, not two.
>=20
> Of course, compilers can do a lot of optimizations, so a 'found'
> variable can be made to generate good code too - if the compiler just
> tracks it and notices, and turns the 'break' into a 'goto found', and
> the fallthrough into the 'goto not_found'.
>=20
> So 'better code generation' is debatable, but even if the compiler can
> do as good a job with a separate 'bool' variable and some cleverness,
> I think we should strive for code where we make it easy for the
> compiler to DTRT - and where the generated code is easier to match up
> with what we wrote.
>=20
>                  Linus

If there is interest, I'm happy to send a new patch set once the fixes =
are clear.

	Jakob

