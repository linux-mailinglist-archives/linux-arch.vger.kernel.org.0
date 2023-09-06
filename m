Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B097932D7
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 02:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjIFAQ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Sep 2023 20:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjIFAQ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Sep 2023 20:16:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EDA1B4
        for <linux-arch@vger.kernel.org>; Tue,  5 Sep 2023 17:16:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4c0so847167a12.0
        for <linux-arch@vger.kernel.org>; Tue, 05 Sep 2023 17:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693959379; x=1694564179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D917AWho7Feua99GqojIXSmDzbaIdD3bTXf4gib3fXk=;
        b=UN2q0DE+eJ60Kl5EVeOPq5OnnsaUavoYnH/N614VpTPmJOAQ/uQdNRavJnOZv+aKOr
         VmSAHzDgXVA98qidC7E5DivGouh9hxgTV4W4nOdDnQJowaBbUbPUCR/vVLvXORyNyepP
         eB08fNn+y/74xeZuhtdH7iB23tSdFqZrlsbdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693959379; x=1694564179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D917AWho7Feua99GqojIXSmDzbaIdD3bTXf4gib3fXk=;
        b=CfQXPVszmaOllhFeMyBS2gln9YxgCd0He7cEdvE3vqg9mjANJqizlrSpilYY3nL1ee
         vjnTCOF931lROSzXUvep496hWm6UNRS8/k+tRZ6g7FbJQaOWkgB+lQtmJXMwrggKMkFf
         uC1+RX8Xd7pQafohyplY0XSYtCi+9BrgHgBiAw0w7KdQveXyyfN9j3A8RaRCZIyo7fUd
         xDCpg7+QsuHzE8v5wBwsrDPQ5t1rsoRym+w3VLiqt3GKQ2Vvn7xiim1S0CxB9yNK4wy7
         03De/GJF2XMDQRZ0RnXML1qe7DfB2gF/iYy3x9jqJ9hZbz//IHqELwMjXrBg0UpBN2Nm
         PUaA==
X-Gm-Message-State: AOJu0Yxnb7RcqhxoNhInslwk2YRiCgjr/Kf0aJ7ITHEqx4utn3cAlNmG
        pRhaMndGPW3eVB8kQI8gifvfgDZzSxMhxQgkHGER5Q==
X-Google-Smtp-Source: AGHT+IHCfkTwj/xG3yImB880dRb1rjjQpcO4voSJY8NBMSmBU1/ZeYAn2qm9uCpM1MhvftsUULFVCw==
X-Received: by 2002:a05:6402:524d:b0:521:ef0f:8ef9 with SMTP id t13-20020a056402524d00b00521ef0f8ef9mr1149499edd.19.1693959379683;
        Tue, 05 Sep 2023 17:16:19 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id v18-20020a056402349200b0052e1783ab25sm3694318edc.70.2023.09.05.17.16.18
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 17:16:19 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9a1de3417acso84839666b.0
        for <linux-arch@vger.kernel.org>; Tue, 05 Sep 2023 17:16:18 -0700 (PDT)
X-Received: by 2002:a17:907:2d14:b0:9a1:c69c:9388 with SMTP id
 gs20-20020a1709072d1400b009a1c69c9388mr1222628ejc.37.1693959378665; Tue, 05
 Sep 2023 17:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
 <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com>
 <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
 <CAGudoHENT1yPBD=+xAUTzWxL+iro8CE3+hHLtYiU6j3cCv7PPA@mail.gmail.com>
 <CAHk-=wgjyGX3OVDtzJW6Oh2ukviXtJYi9+7eJW75DgX+d673iw@mail.gmail.com> <CAGudoHEXyYSZj-7=3Xss=65jGyX4Lq=R-BdbnmGKJwSS8QznSw@mail.gmail.com>
In-Reply-To: <CAGudoHEXyYSZj-7=3Xss=65jGyX4Lq=R-BdbnmGKJwSS8QznSw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Sep 2023 17:16:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0J7HotWcjP5nL4pZZLZN31SMid5rpf3pvmv-7Yi2W1A@mail.gmail.com>
Message-ID: <CAHk-=wh0J7HotWcjP5nL4pZZLZN31SMid5rpf3pvmv-7Yi2W1A@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 5 Sept 2023 at 13:41, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> @@ -312,7 +314,15 @@ int vfs_fstatat(int dfd, const char __user *filename,
>         struct filename *name;
>
>         name = getname_flags(filename,
> getname_statx_lookup_flags(statx_flags), NULL);
> -       ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
> +       /*
> +        * Hack: ugliness below damage controls glibc which reimplemented fstat
> +        * on top of newfstatat(fd, "", buf, AT_EMPTY_PATH). We still pay for
> +        * kmalloc and user access, but elide lockref.
> +        */
> +       if (name->name[0] == '\0' && flags == AT_EMPTY_PATH && dfd >= 0)
> +               ret = vfs_fstat(dfd, stat);
> +       else
> +               ret = vfs_statx(dfd, name, statx_flags, stat,
> STATX_BASIC_STATS);
>         putname(name);

I actually think I might prefer the earlier hacky thing, because it
avoids the whole nasty pathname allocation thing (ie the __getname()
dance in getname_flags(), and the addition of the pathname to the
audit records etc).

I suspect your "there are no real loads that combine AT_EMPTY_PATH
with a path" comment is true.

So if we have this short-circuit of the code, let's go all hog on it,
and avoid not just the RCU lookup (with lockref etc), but the pathname
allocation too.

                  Linus
