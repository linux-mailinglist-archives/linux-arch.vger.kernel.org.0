Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD1791137
	for <lists+linux-arch@lfdr.de>; Mon,  4 Sep 2023 08:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjIDGDk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Sep 2023 02:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjIDGDk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2023 02:03:40 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E840DE;
        Sun,  3 Sep 2023 23:03:36 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5733d431209so708499eaf.0;
        Sun, 03 Sep 2023 23:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693807415; x=1694412215; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5NEE0gxqnoeOZjv0T50x54n3sgHDhEJypJ5XwUuKe6M=;
        b=fz1rGjRsUeFR0gKtk4jUUcZcwnflA8Tj0vwTxyOXxaW4vmtKH6K5evwn0IcMDcQmjC
         WUy1SdQNhhKnfBwLKjGs/zgb4SBjd0P4oNK2XXUiwnGXlWqxRQPOjBLrwC64gvkP1eC9
         YAP31HY4XsZJiZq17I3aijXpwNxOtxS+SvPw1HR6JeHq8sMtWyN1UukghBYK7VNTlCyy
         Fdm00XteuRVyOQcTBZEatxEvgTO4m4Fctqs1oss2g85QP93sQId4Y+MwsXVIKQ+PJ8oC
         v3onv/SWP+5XOoaB3V7u064yn97qO+mbwL1bNDcJKXk21LbFM4QrV1sCBKpNfwJnz/8H
         xXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693807415; x=1694412215;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NEE0gxqnoeOZjv0T50x54n3sgHDhEJypJ5XwUuKe6M=;
        b=XxuICqCkJqQQGaIveME3gxk7C9n2pUIfn/wsMjlCYnW5ag26aWNH8F5jxe5O9y5Qdz
         TyxU78da0R2Ky25faNboBUo0uSJprgimQJrknh/+lTYrodKFIj1GpUhVdkccl0CgDPhv
         irrpqzC7paUSvVkFBi3BugzQCP7HenHwFnPr0eCdjo0HE+M3gZZTZBjLJ+D6idI72cAI
         KpnTU8oonO/+nE1Uk/XOt+NjhWJFZaMB4++d7b9W/FT85FCJOQNKEFfka+sSXuuwVTYc
         QgxPKGnHxBESQVFOahgEw1G3E6bEw3XCfBg/WhLrq1VQLoIcRqsXwRquUAvkRsikXCeX
         lNXA==
X-Gm-Message-State: AOJu0YxyHCwkYaQb715CpJavC208Zbw2qAKkDot5LEOzjuxGN0E0mq2C
        UwlNKjDUl5ihcBQo1WKlzet/jPeypXl/68r8HlA=
X-Google-Smtp-Source: AGHT+IHzRToA6/kS0AxdI3BVPu+s47OfOeohQ5UXCrOjKxmneWhd4wNOtDlf34aw10kzHGEaxzKNKxbK8xkFqp8h0cA=
X-Received: by 2002:a4a:764d:0:b0:56d:10bb:c2d4 with SMTP id
 w13-20020a4a764d000000b0056d10bbc2d4mr8416013ooe.1.1693807415379; Sun, 03 Sep
 2023 23:03:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:60c:0:b0:4f0:1250:dd51 with HTTP; Sun, 3 Sep 2023
 23:03:34 -0700 (PDT)
In-Reply-To: <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com> <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
 <CAGudoHG1_r1B0pz6-HUqb6AfbAgWHxBy+TnimvQtwLLqkKtchA@mail.gmail.com>
 <CAHk-=wjM6KwAvC9+sCAm9BgBSspZm60VBLzHcuonGcHrPKJrbw@mail.gmail.com> <CAHk-=whnEF7-+DL+71wVgnJG1xjeHAQjzqMAULgQq_uhWfP0ZA@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 4 Sep 2023 08:03:34 +0200
Message-ID: <CAGudoHENT1yPBD=+xAUTzWxL+iro8CE3+hHLtYiU6j3cCv7PPA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/4/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 3 Sept 2023 at 20:07, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Try it and you'll see it is not even *remotely* as easy as you claim.
>> Not when you have to deal with random sizes and padding of 20+
>> different architectures.
>
> Perhaps more importantly, nobody actually seems to have the energy to care.
>

Perhaps in this context I should have explicitly mentioned that only
64-bit archs would be considered, as in placing the func you wrote in
fs/stat.c and it is explicitly 64-bit. This should whack all archs
which would never bother with their implementation anyway.

Worst case if the 64 bit structs differ one can settle for
user-accessing INIT_STRUCT_STAT_PADDING.

My point though was that code filling the struct escaping to
arch-dependent file is rather regrettable, even if x86-64 would be the
only case. And it definitely can be avoided, even if would require
tolerating that some of the stores are reordered. They are already
reordered for dodging memset.

-- 
Mateusz Guzik <mjguzik gmail.com>
