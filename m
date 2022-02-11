Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733974B2C03
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 18:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352263AbiBKRqZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 12:46:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbiBKRqY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 12:46:24 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F738D
        for <linux-arch@vger.kernel.org>; Fri, 11 Feb 2022 09:46:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id u20so20139848ejx.3
        for <linux-arch@vger.kernel.org>; Fri, 11 Feb 2022 09:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MA9z/nAeEAqw03l/kdUwd44agJ7PPHF1efYwVNLWeSs=;
        b=N7i2fk2zHkfW0E6UKnO6Wo/Imf/u3S8xkzP3Yc7yfmEvKZ55/UBpbB0BGzwdoZLLoL
         LFRA1QHQEkob4dV4TmcGOBlPgteITlzuVBQtBvnc+zpgvda3Dg2/r+Sjs/vxwlEMXyvO
         OzLGDDdjEUGfehlgywVSMxpodGt90Z9SUiN+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MA9z/nAeEAqw03l/kdUwd44agJ7PPHF1efYwVNLWeSs=;
        b=dnp/Gr7zPqrI/HU/THFcZMgCt/VMptidxL5bAyEyakPxjhQCumZyzU9RFD/pLV41wR
         rrrzpSNwJrMlkvXRyH9q3JSHBJ+MMWrOI6DRzE/dkUkfYhB3JgRnDpBOewTKLWClqHb2
         WD5sWwbtrtd7faFvdDPE/CxFF2tstZD6UKa3jqRVRlJncvqSjNoi7uul7k9mGP2005vI
         P2qD7Upp3KfOW7gqGNz/yGABwAAR/d5I1pQyr2sUyxqRsetM/IZy2Id0FnqTeumbVVWO
         isULnX8f9lj9RVgzU9wlPKXG+k3a2vXFSTGY04ey7xbA9xDRuLOKRsLcdwpvfNMdhRVh
         XOjA==
X-Gm-Message-State: AOAM533IvxODHmdKNXUeznHrD7e7JzTPKcrbkvyjJbsNaEcyX0Di1QWu
        yNEuI+Yy+Ja0RJ0/V2dTwRHvEFZrA8YkH4x9MSA=
X-Google-Smtp-Source: ABdhPJx9DKr7kDrmtuDgE09RKU+GvjHI8W/yPydC3BrUo4QXflvuCyCSIrC9uZnNuLMdiRvgenYSZQ==
X-Received: by 2002:a17:907:1a55:: with SMTP id mf21mr411680ejc.235.1644601581550;
        Fri, 11 Feb 2022 09:46:21 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id z13sm438188ejl.78.2022.02.11.09.46.20
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:46:20 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id c192so5917897wma.4
        for <linux-arch@vger.kernel.org>; Fri, 11 Feb 2022 09:46:20 -0800 (PST)
X-Received: by 2002:a05:600c:15ca:: with SMTP id v10mr1224526wmf.26.1644601580144;
 Fri, 11 Feb 2022 09:46:20 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org> <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
 <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com> <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
 <YgROuYDWfWYlTUKD@antec> <YgWrFnoOOn/B3X4k@antec> <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
In-Reply-To: <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Feb 2022 09:46:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7kOxDg+2Ym1EQsTZaZqU-p7aFHiNVOmtEhNS8jjapLQ@mail.gmail.com>
Message-ID: <CAHk-=wj7kOxDg+2Ym1EQsTZaZqU-p7aFHiNVOmtEhNS8jjapLQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 11, 2022 at 9:00 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> I have now uploaded a cleanup series to
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=set_fs
>
> This uses the same access_ok() function across almost all
> architectures, with the exception of those that need something else,
> and I then I went further and killed off set_fs for everything other
> than ia64.

Thanks, looks good to me.

Can you say why you didn't convert ia64? I don't see any set_fs() use
there, except for the unaligned handler, which looks trivial to
remove. It looks like the only reason for it is kernel-mode unaligned
exceptions, which we should just turn fatal, I suspect (they already
get logged).

And ia64 people could make the unaligned handling do the kernel mode
case in emulate_load/store_int() - it doesn't look *that* painful.

But maybe you noticed something else?

It would be really good to just be able to say that set_fs() no longer
exists at all.

                Linus
