Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C397E07A0
	for <lists+linux-arch@lfdr.de>; Fri,  3 Nov 2023 18:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjKCRke (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Nov 2023 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKCRkd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Nov 2023 13:40:33 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB146D4D;
        Fri,  3 Nov 2023 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1699033220; x=1699638020; i=frank.scheiner@web.de;
        bh=D1Ff6zuwtY98nJgeBbrqLgsy5DKYVpDPHNBFpmWdWPs=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
         In-Reply-To;
        b=KolMr2RrB0nqjWiWmQFiaqd883LRtbgABaHxnUiibfIMQ02t0eLj83+oolt7UR3+
         sxTQsMd3YccO2b46Jk78FOVQ7IdQaqcbGy2rJVOudP/DxEzSb66Fo9SDL37z71Mto
         p4+N5smPOwIIK9OOJ8CKTWNCDCxnpm1ET1dhkeIF0KEwXQIHKzAA3Qnti3I8YlXLD
         gyEYCeIlFHVbkWTMpIM9xpY+q9oz083ymFDhl/3N4qvGENT8O7YE+P9PBRhAvrqkM
         2bQnox/aunYd+vzRNYH0s2Q51KMmFmAk1PSkUkucsaNB0QRfbR213RO0TYQvYtj7y
         muzgTdqkxlRutbv82Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.30] ([84.152.247.25]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1r7jb20LBY-009ArV; Fri, 03
 Nov 2023 18:40:20 +0100
Message-ID: <6e745433-d7eb-45df-b607-5589f1e04e86@web.de>
Date:   Fri, 3 Nov 2023 18:40:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [GIT PULL] asm-generic updates for v6.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <340fc037-c18f-417f-8aaa-9cf88c9052f4@app.fastmail.com>
 <8ff191a0-41fa-4f36-86e8-3d32ff3fe75c@web.de>
 <CAHk-=whFLZ67ffzt1juryCYcYz6eL_XjQF8WucDzwUR5H65+rA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=whFLZ67ffzt1juryCYcYz6eL_XjQF8WucDzwUR5H65+rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GZLXJonp3/Hn/EMdh3oIDngRhT+fIAlI6by69124eDw2KgQZdjB
 TQZG0qhKzbqBBg8EuK5WfpbPs8P6NULdXxlK8l7Hvk5p+DcEj/8MAH5T8WoIEzseuoMinlG
 y0OIDBrfhTcgem45x2lv+O0wr9cwGuHmyUNd4deY6Y/3SL/ZnvJ+PgTtq3TEQ4k1ICx9xIw
 ftp/HvEN4fD6i0z8T3lJQ==
UI-OutboundReport: notjunk:1;M01:P0:Grrv3FJ4CII=;AFX2EHWMSQ1YGNT3TJPPa6KZdxg
 OCSb9XmRrjtAMOYDqY0Vnc40WiJ/PuOZc+6ZZALmXym+8uGA0sUWuyp8WwR4jTNbXaql1KS8t
 tfTQTZrke5/VrFLTRjfz7shfT79/rssSnxP8BCdoObdCk9etlNYPViqRzN4EJKYqLyUaSFj7f
 4N2Wwtx2LVPbcxXB+gjtJKcDByzkVFaLzvw1aA5wshuqw5rRMQtyebeL1L67/v9QwEKY3emBa
 IEvnwPERBn5+QuMl3vOZI+hEr1KovKk+xKsaU7EU5C1a6pLTfEYeoTmwbCJcPNIPJiJRoBRxq
 fAyBZteRmLTwIrHRoXexMpmGI5PXBJ2eB7nMX8+LVjNwqmKiJFewOVfwlwDhf8UyeaRz41Gpv
 9JRv7mepKeuOzVdxEqF53xtH8wEssD56MPCCrpXekwAjL+1x8WFHYabJ4ZRjpdH4tJ94Uk1f1
 cqjg1W/iDOCAIjIpakV6FBChx8/kW+O9rgTI4mM2URjUhZYlZpKiwQXaaVxq0MaKrcy2ZMUjv
 bu9whMh31dtXmnZHXiCw/6Uuj4vH2GVhj8sKy7AZLFk+VxuIzAOp9YLlVgPrR23v48ZdmL/zD
 Lfh6eheKvzMGC9Mv10pWlHtPgip2VvKfaRwWHH4tGsb0a/E9Avek/TRBhXz9DdS/yjEUaMgDF
 EJuEC3cfOLGd3Xta2GWu8OvZ4+RoQ4xR6CBAqZvo2tmcDwjsyL6LIKN+FRGhsiGW6OC3PwdfS
 MJtE82fow0J5xgzXs9+d1A4pIOkS0gl2Q/ddz+A08ct6D+/Zcleu9c/D4JDE9g1GCkcxn6OzQ
 YBqRvIlHiFiZT7bZYIrEhgl2lHeseuu7v9jIpqJFxTDoerHh+kdPH83Os6ov3oBbswH+SNGB0
 j+HTU6InCVNrPkd+yGXcHjjNwMkgL5AJSHFUyR7Q2gUyQh9h1Psbft1oP3UzpCuia4dM1fakH
 Re7jCQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02.11.23 18:28, Linus Torvalds wrote:
> On Thu, 2 Nov 2023 at 00:24, Frank Scheiner <frank.scheiner@web.de> wrot=
e:
>>
>> so the ia64 removal happened despite the efforts - not only from us - t=
o
>> keep it alive in Linux. That is a - sad - fact now.
>
> Well, I'd have personally been willing to resurrect it, but I was told
> several times that other projects were basically just waiting for the
> kernel support to die.
>
> Has the itanium situation really changed?

Well, we definitely made some progress in this regard. But as you wrote,
this was not a pressing issue as long as ia64 stayed in the kernel.
Which is why I wanted to concentrate on kernel support first and
foremost. My thinking was that a working architecture wouldn't be
dropped*. And with kernel support saved, we could have gone full steam
ahead into the other projects.

Well, we did proceed with tackling the problems in the other projects
anyhow from the start, but now the situation is a little different.

*)
https://lore.kernel.org/linux-ia64/CAHk-=3DwjEmZ19T4XpVb0_Hacm53xJG_w5ygcu=
orwC0xBoT-myUA@mail.gmail.com/

> So I'd be willing to come back to the "can we resurrect it"
> discussion, but not immediately - more along the lines of a "look,
> we've been maintaining it out of tree for a year, the other
> infrastructure is still alive, there is no impact on the rest of the
> kernel, can we please try again"?

That is really something.

We'll see where this goes. I always hope for the best. (-:

If you feel like checking on our status, you know where to look (see my
email to you from 2023-09-23).

Cheers,
Frank
