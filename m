Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4306EF528
	for <lists+linux-arch@lfdr.de>; Wed, 26 Apr 2023 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbjDZNKc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Apr 2023 09:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240734AbjDZNKa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Apr 2023 09:10:30 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52DD5B9C
        for <linux-arch@vger.kernel.org>; Wed, 26 Apr 2023 06:10:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2470271d9f9so4971892a91.2
        for <linux-arch@vger.kernel.org>; Wed, 26 Apr 2023 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google; t=1682514626; x=1685106626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFPfcznNavRel3v/2Xb0sNmLucdjhMS4TB31OODj9eQ=;
        b=SXpo9VgkpDl0hHJLrJEN9WNOhkaEetHoZiCXRCTjOT8FFbE8/K9AMAtgrWqcuwp6Tz
         4d9MIWedfBbveT+f+rigCkmTgGFn/ystU/yyLMkn/143no8GS/oeZrb6Ybmg8EFRoZBN
         3gYQJcp3F3A2ymwLp42xXAPX575qOBgLQNRUAhIVyel7ZGn6tPSTAZPz36A4Vd1YqBRA
         V+MK14VNhPwi8zPFMA55zi0XSjUkkBVnEagz17PWp1OM0iafjcj5oruVjOIYF3C+iC6P
         4T+oTc/+9ER3ZqP6XwqbLcc9kqMlPqTD2Q+387mMl93EgVuG9dJc5qLQpjKdgPeQ1pwN
         FbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682514626; x=1685106626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFPfcznNavRel3v/2Xb0sNmLucdjhMS4TB31OODj9eQ=;
        b=T1HOSNbH2U9xuFiOfd0riA4l4jx+wiRZX85umJqyDue1ZFtVlqFXnWT1tIP2rT0z1+
         DVkcmtKBzdKXzjldOcSDRuebYZpt77H+Hm3CrcyQ+xBPoldu1aegPAzplPxQ1Vb0CxWZ
         nYR+GHjtCqCwCExTohasteYqYOfTj4vzqSdn5ef+Mu9p+NQJOM/yRJkK+X/JgCrfSqfW
         /g1mj8TYNV/DOjQjVkb7mOJDXAOnbQvalZrbV0DrRmzngGKUqhOobRDN5bepU1gO9Kso
         Rmp/9iOw1UXT9PGdivdMLVjN+Z/3lNJNwbUDmyUyArY7vf4rHE7hMrcKJhn+4uWPTqi0
         ogXw==
X-Gm-Message-State: AAQBX9cZoWCrE8kvUaqFkJwiLZsYvH3jAw739HG8AeyorG1kDTz00ZaC
        aYMNlzG6Bj6HdFyK2cZY970w7ODgXQNIwNHQ1Sm35A==
X-Google-Smtp-Source: AKy350bGt8dPLv0jDwC73a+QwasYP2hRe8jvOSnGkd5BHaoZ5lFcdtvx8ciHOzJ5UMxa9KFBync7KlvVO5wENcx4hiQ=
X-Received: by 2002:a17:90a:630a:b0:249:748b:a232 with SMTP id
 e10-20020a17090a630a00b00249748ba232mr19303629pjj.25.1682514625952; Wed, 26
 Apr 2023 06:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221228160249.428399-1-ahamza@ixsystems.com> <20230106130651.vxz7pjtu5gvchdgt@wittgenstein>
 <ZD9AsWMnNKJ4dpjm@hamza-pc> <05845c12eab34567ae61466db36a0cef@AcuMS.aculab.com>
In-Reply-To: <05845c12eab34567ae61466db36a0cef@AcuMS.aculab.com>
From:   Andrew Walker <awalker@ixsystems.com>
Date:   Wed, 26 Apr 2023 08:10:15 -0500
Message-ID: <CAB5c7xquuk7-kWZBY7fVmKiGh0_YxR=UhLjMUpdTx=2rF+PuzA@mail.gmail.com>
Subject: Re: [PATCH] Add new open(2) flag - O_EMPTY_PATH
To:     David Laight <David.Laight@aculab.com>
Cc:     Ameer Hamza <ahamza@ixsystems.com>,
        Christian Brauner <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "slark_xiao@163.com" <slark_xiao@163.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 19, 2023 at 4:29=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
> ISTM that reopening a file READ_WRITE shouldn't be unconditionally allowe=
d.
> Checking the inode permissions of the file isn't enough to ensure
> that the process is allowed to open it.
> The 'x' (search) permissions on all the parent directories needs to
> be checked (going back as far as some directory the process has open).
>
> If a full pathname is generated this check is done.
> But the proposed O_EMTPY_PATH won't be doing it.
>
> This all matters if a system is using restricted directory
> permissions to block a process from opening files in some
> part of the filesystem, but is also being passed an open
> fd (for reading) in that part of the filesystem.
> I'm sure there are systems that will be doing this.
>
>         David
>

So to be safe, hypothetically, the caller should be required to have
CAP_DAC_READ_SEARCH like with open_by_handle_at(2)?

Andrew
