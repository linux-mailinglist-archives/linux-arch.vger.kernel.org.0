Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC65B88C3
	for <lists+linux-arch@lfdr.de>; Wed, 14 Sep 2022 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiINNCE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Sep 2022 09:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiINNCC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Sep 2022 09:02:02 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA95FF68;
        Wed, 14 Sep 2022 06:02:01 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28ED1R4a014976;
        Wed, 14 Sep 2022 22:01:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28ED1R4a014976
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663160488;
        bh=GHK0IfYXttT8oUk7P8LGQ/L+MqLy4KjmkGPRYqdgRGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WKYNzDVf3KqZhgFkD9Y6UYk9SCHF937eL8esdN5TTBJNHhIfcmGH5kM3LuywhJcKw
         Y8bYjthrzs7+QxegaAf+jWoPOobGAECcnwVyQB2C7c9qFZyzaoV5PvAw9R3W1V/sSY
         RPHLZ2lshfolLD5HLO0oVIIs60EKtMH/hG/7Xr+HjWdV3CWkijCMNBL/lk6WYXejdD
         TWtEpCosBegRH2Gf1Aun5i9vHMmFq6aUYZS+wmAfmPi0RL/KMJBYkELafZO/vvlHtY
         k4PltKgIJ6Gx41BWVJQOlAZnp+o3G9iijlmj6ytSZ3CCM5iWHufwUOOFtONP7NGqXT
         F+jlNa3N1TPrw==
X-Nifty-SrcIP: [209.85.210.49]
Received: by mail-ot1-f49.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso10258410otb.6;
        Wed, 14 Sep 2022 06:01:28 -0700 (PDT)
X-Gm-Message-State: ACgBeo25jCg+5AzclDjNBix+LhHt6xeXRdjbuUZcmoFjEkQk7VcpGRCE
        gUgctkv2dzK7BpIaLsyFk558rAuEizVfhv4GKP4=
X-Google-Smtp-Source: AA6agR4cg3jwwz2A4UjnKmkW0MBA79aiJh/S5irfGe0u9ixCJS4JHA0qwPYTgg+9UtO/x8BpQjZlS1xcfY6pcFqLo8c=
X-Received: by 2002:a05:6830:3111:b0:655:bf20:250 with SMTP id
 b17-20020a056830311100b00655bf200250mr8795042ots.225.1663160487192; Wed, 14
 Sep 2022 06:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220828024003.28873-1-masahiroy@kernel.org> <20220828024003.28873-6-masahiroy@kernel.org>
 <YyBAFL9CBsM9gl38@dev-arch.thelio-3990X> <87548726b6cc4f518836db38d45a04f2@AcuMS.aculab.com>
In-Reply-To: <87548726b6cc4f518836db38d45a04f2@AcuMS.aculab.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 14 Sep 2022 22:00:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7uYWKza4ZSHegJjBhvj7ToOg6kUpa3Mf9hRgAg3xtcA@mail.gmail.com>
Message-ID: <CAK7LNAR7uYWKza4ZSHegJjBhvj7ToOg6kUpa3Mf9hRgAg3xtcA@mail.gmail.com>
Subject: Re: [PATCH 05/15] kbuild: build init/built-in.a just once
To:     David Laight <David.Laight@aculab.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 14, 2022 at 6:46 PM David Laight <David.Laight@aculab.com> wrote:
>
> ...
> > > +VERSION=$(cat .version) 2>/dev/null &&
> > > +VERSION=$(expr $VERSION + 1) 2>/dev/null ||
> > > +VERSION=1
>
> What's wrong with:
> VERSION=$(($(cat .version 2>/dev/null) + 1))


One reason was, the original code used 'expr'.



> If you are worried about .version not containing a valid
> number and $((...)) failing then use ${VERSION:-1} later.


Maybe another reason is,
I want to make the behavior deterministic when
the .version file contains a non-integer string.




$ unset FOO
$ echo FOO > .version
$ echo $(($(cat .version 2>/dev/null) + 1))
1


$ export FOO=100
$ echo FOO > .version
$ echo $(($(cat .version 2>/dev/null) + 1))
101




I want the script to consistently return 1
whether or not 'FOO' is available in the user's environment.






>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>


-- 
Best Regards
Masahiro Yamada
