Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC455746C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 09:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiFWHsx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 03:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiFWHsl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 03:48:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC241274F;
        Thu, 23 Jun 2022 00:48:34 -0700 (PDT)
Received: from mail-ot1-f54.google.com ([209.85.210.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mkn8B-1nONOZ1ds7-00mMNU; Thu, 23 Jun 2022 09:48:32 +0200
Received: by mail-ot1-f54.google.com with SMTP id c3-20020a9d6843000000b0060c2c63c337so14876060oto.5;
        Thu, 23 Jun 2022 00:48:31 -0700 (PDT)
X-Gm-Message-State: AJIora/gvnfOGrSrwEDCwyieKynJHmWnCdWF1oCn/h0sOPAdhXn4Uk3Z
        ZZ5CayhBLw3lG/sYsZgIJejZmLEQOYxor8idRTo=
X-Google-Smtp-Source: AGRyM1uHkBIdCkI9mpCrsEZDA8zvdmE7/Fo1G/+3sQac7LSyKfcZpANe6OOE8iPxe+xA5YpR3xLpoECCt9dTyF/gSRw=
X-Received: by 2002:a9d:4a8:0:b0:60c:76b1:f1be with SMTP id
 37-20020a9d04a8000000b0060c76b1f1bemr3345332otm.347.1655970510870; Thu, 23
 Jun 2022 00:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220621120355.2903-1-chrubis@suse.cz>
In-Reply-To: <20220621120355.2903-1-chrubis@suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jun 2022 09:48:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2J5k2ub6TNu9qDympdWEdQkqpbL_SqAznpwaQa+S9kXQ@mail.gmail.com>
Message-ID: <CAK8P3a2J5k2ub6TNu9qDympdWEdQkqpbL_SqAznpwaQa+S9kXQ@mail.gmail.com>
Subject: Re: [PATCH v3] uapi: Make __{u,s}64 match {u,}int64_t in userspace
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Arnd Bergmann <arnd@arndb.de>, LTP List <ltp@lists.linux.it>,
        David Laight <David.Laight@aculab.com>,
        Zack Weinberg <zack@owlfolio.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0YkVNDOX+L/OqW9IxfeVC4LojecooO6C77iFFbpozHXYPlwVsWH
 +o/qbJpHRnjjmwkLIhTqThaPZpcR8Gx7Kx6Zf9NWRVyKJg6n758aH7T3jYp2CikebyDzZ7V
 9V+ifZhxLIBRV1w1wIGmBcXqIqZHvF8Ni5an5evbn/cSy3Ffq61eh7wWT2gDyg9u9cryE9V
 QxENscWPSVQTPNSFppI7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wBylCmi8U3M=:kl6DPcI8z4JI8lfngq4jge
 bFknkHbJ1j6r84/1gKToOveBYGHynwzCNPsiaQEQ1PjIgzLSgtWJUWaR6dSvn854zEDQkC5o0
 KYhDL11dGd3F6gIcctFbm3CmHfb4+HXng0lsvebaDGXpV40tE4o+rm4RoXezPTWCRQrvIRUQ/
 6WLuooA+ZxqPbvqWDvmaTSYL6FpozKKc7WPxHcsUlTtLEyDU3POzReXpKoZb3vpB8/9nvhBMe
 wo1usFVF1gsKAJViA/eppZSF0cc58vVq764VP5YWTj1KMcN0P4gSkp90oLf/222Gc3AnEi48t
 FxzQikUBHaI6Ud7a+9DgRyOGh1yJX9y+AacPlx1uG8vnZQl6qBEFthyA/nxfKEVWEFJLPBaKk
 MXHonUm403LLQN0vupnLKJjCKg3Wpuy6+9fOAdwz0zCQdPZHj0/J00hKxBmnqz3r7IGboibco
 +BsRYqObopmuS0zAxN0qTOTGV1anCO5I1lnyZjblcPLwXT34C7RKBgb1Cu3jpQjN12L2D/+P5
 PuxdxdRT0dYPIBDsQLauODqnRvIhqJgto2YzchLO9fv8vgZMNEJHwiJjAnAOx0zEKxCzeMlP7
 0VP029uNhMiwPpqfbCly6NK55ub1pMhyZrLraGfcEnGtpQ0fdIO+XwnD/yMJugL+qefX5xp1I
 +Wza0EPnY8sLaLAJH1egiuwAlbscschVA8bG3EPt8hdgbtzEWEZ8ti+18J5qQ+eKxMt3wqOFQ
 Hr1G0I5yE7vJVn0VXfxmVz7/omi4Qv+bVXNWjYOfT3T4QAcktkDIpunq1/GKN6sJPVlhIXqeT
 AdZEDeINMDNJYIIepgERVWtpNAKZfWjhdBYhK7jZjMvFLu+Ef53HaapEYbzFHoIY/PCb5asxb
 jLmZ1zuLMFmoF6NsEqIw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 21, 2022 at 2:03 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> This changes the __u64 and __s64 in userspace on 64bit platforms from
> long long (unsigned) int to just long (unsigned) int in order to match
> the uint64_t and int64_t size in userspace for C code.
>
> We cannot make the change for C++ since that would be non-backwards
> compatible change and may cause possible regressions and even
> compilation failures, e.g. overloaded function may no longer find a
> correct match.
>
> This allows us to use the kernel structure definitions in userspace in C
> code. For example we can use PRIu64 and PRId64 modifiers in printf() to
> print structure membere. Morever with this there would be no need to
> redefine these structures in an libc implementations as it is done now.
>
> Consider for example the newly added statx() syscall. If we use the
> header from uapi we will get warnings when attempting to print it's
> members as:
>
>         printf("%" PRIu64 "\n", stx.stx_size);
>
> We get:
>
>         warning: format '%lu' expects argument of type 'long unsigned int',
>                  but argument 5 has type '__u64' {aka 'long long unsigned int'}
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

I understand the problem you are solving here, but I'm not convinced
that this is actually an overall improvement as you introduce two
similar problems in its place:

- any application that has previously used the correct %ll or %ull format
  strings for members of kernel data structures now gains a new warning

- After your patch, neither the PRIu64 nor the "%ull" format strings are
  portable across old and new kernel headers, so applications are now
  forced to add an explicit cast to 'unsigned long long' or 'uint64_t' to
  every print statement for these members if they want to guarantee a
  clean build.

Do you have an estimate of how many build time warnings in common
packages actually get fixed by your patch, compared to the number
of warnings that get introduced?

        Arnd
